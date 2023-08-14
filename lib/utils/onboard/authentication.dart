import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/analytics_props.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/auth_actions.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/cash_wallet_actions.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/onboard/firebase.dart'
    show LoggedInToVegiResult;
import 'package:vegan_liverpool/utils/onboard/fuseAuthUtils.dart';

abstract class iLoginDetails {}

class PhoneLoginDetails implements iLoginDetails {
  PhoneLoginDetails({
    required this.countryCode,
    required this.phoneNumber,
  });

  final CountryCode countryCode;
  final PhoneNumber phoneNumber;
}

class EmailLoginDetails implements iLoginDetails {
  EmailLoginDetails({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

abstract class iVerificationCodeDetails {}

class SMSVerificationCodeDetails implements iVerificationCodeDetails {
  SMSVerificationCodeDetails({
    required this.verificationCode,
  });

  final String verificationCode;
}

class EmailVerificationLinkDetails implements iVerificationCodeDetails {
  EmailVerificationLinkDetails({
    required this.linkId,
  });

  final String linkId;
}

// T logFunctionCall<T>(
//   T funcCalled, {
//   required String funcName,
//   String className = 'Authentication',
//   String logMessage = '',
// }) {
//   log.info(
//     '$funcName called in $className class. $logMessage',
//     stackTrace: StackTrace.current,
//     sentry: true,
//   );
//   return funcCalled;
// }

class Authentication {
  Future<bool> appIsAuthenticated() async =>
      (await reduxStore).state.userState.isLoggedIn;

  Future<void> initFuse({
    void Function()? onWalletInitialised,
  }) async {
    (await reduxStore).dispatch(SignupLoading(isLoading: true));
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'initFuse',
    );
    return _loginToFuse(
      onWalletInitialised: onWalletInitialised,
    );
  }

  Future<void> restoreFuseFromMnemonic({
    required List<String> mnemonicWords,
    void Function()? onWalletInitialised,
  }) async {
    (await reduxStore).dispatch(SignupLoading(isLoading: true));
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'restoreFuseFromMnemonic',
    );
    return _loginToFuse(
      onWalletInitialised: onWalletInitialised,
      useMnemonicWords: mnemonicWords,
    );
  }

  Future<void> signUpFirebaseEmail({
    // required iLoginDetails loginDetails,
    required EmailLoginDetails loginDetails,
  }) async {
    final store = await reduxStore;
    store
      ..dispatch(SignupLoading(isLoading: true))
      ..dispatch(
        SetUserAuthenticationStatus(
          firebaseStatus: FirebaseAuthenticationStatus.unauthenticated,
          vegiStatus: VegiAuthenticationStatus.unauthenticated,
        ),
      );
    // TODO Change signup to require email and register password, then add a phone number and verify code
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'signUpFirebaseEmail',
    );
    if (store.state.userState.email.trim().toLowerCase() !=
        loginDetails.email.trim().toLowerCase()) {
      store.dispatch(ResetPhoneNumber());
    }
    await _signUpFirebaseEmail(
      loginDetails: loginDetails,
      onCompleteFlow: () {
        store
          ..dispatch(SignupLoading(isLoading: false))
          ..dispatch(SignUpLoadingMessage(message: ''));
      },
    );
  }

  Future<void> reauthenticate() async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'reauthenticate',
    );
    final store = await reduxStore;
    store.dispatch(SignupLoading(isLoading: true));
    final firebaseReauthenticationSucceeded =
        await _signupFirebaseTryReauthenticate();
    if (firebaseReauthenticationSucceeded) {
      // * vegi Auth
      await _signupVegiTryReauthenticate();
    }
    if (store.state.userState.vegiAuthenticationStatus !=
        VegiAuthenticationStatus.authenticated) {
      log.error(
        'Unable to call authentcator.reauthenticate and authentiate vegi. So stopping auth flow here',
      );
      return;
    }
    // check fuse
    // * Fuse part
    await _loginToFuse(
        // onWalletInitialised: () async {
        //   // * Firebase part
        //   final firebaseReauthenticationSucceeded =
        //       await _signupFirebaseTryReauthenticate();
        //   if (firebaseReauthenticationSucceeded) {
        //     // * vegi Auth
        //     await _signupVegiTryReauthenticate();
        //   }
        // },
        );
  }

  /// to be called from loginHandler on Sign_up_screen via MainScreenViewModel
  /// & for reauthentication calls
  Future<void> login({
    required iLoginDetails loginDetails,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'login',
    );
    final store = await reduxStore;
    store
      ..dispatch(SignupLoading(isLoading: true))
      ..dispatch(
        SetUserAuthenticationStatus(
          firebaseStatus: FirebaseAuthenticationStatus.unauthenticated,
          vegiStatus: VegiAuthenticationStatus.unauthenticated,
        ),
      );
    if (loginDetails is PhoneLoginDetails) {
      if (store.state.userState.phoneNumberE164 !=
          loginDetails.phoneNumber.e164) {
        store.dispatch(SetEmail(''));
      }
      store.dispatch(
        SetPhoneNumberSuccess(
          countryCode: loginDetails.countryCode,
          phoneNumber: loginDetails.phoneNumber,
        ),
      );
    } else if (loginDetails is EmailLoginDetails) {
      if (store.state.userState.email.trim().toLowerCase() !=
          loginDetails.email.trim().toLowerCase()) {
        store.dispatch(ResetPhoneNumber());
      }
    }
    await _logInFirebaseRequestVerificationCodeStep2(
      loginDetails: loginDetails,
      onCompleteFlow: () {
        store
          ..dispatch(SignupLoading(isLoading: false))
          ..dispatch(SignUpLoadingMessage(message: ''));
      },
    );
  }

  // Future<bool> verify({
  //   required iVerificationCodeDetails verificationCodeDetails,
  // }) async {
  //   logFunctionCall<void>(
  //     () {},
  //     className: 'Authentication', funcName: 'verify',
  //   );
  //   final store = await reduxStore;
  //   // check fuse authenticated even though should only be calling this function if it is
  //   if (store.state.userState.fuseAuthenticationStatus !=
  //       FuseAuthenticationStatus.authenticated) {}

  //   // call onboarding.verify
  //   if (verificationCodeDetails is SMSVerificationCodeDetails) {
  //     // check phone number has already been sent and set on in memeory firebase onboarding class instance
  //     if (!onBoardStrategy.expectingSMSVerificationCode) {
  //       log.warn(
  //           'Onboarding service is not expecting an SMS Verification code! We will try to verify anyways with code: ${verificationCodeDetails.verificationCode}');
  //     }
  //     await firebaseOnboarding.verify(
  //       store,
  //       verificationCodeDetails.verificationCode,
  //     );
  //     return true;
  //   } else if (verificationCodeDetails is EmailVerificationLinkDetails) {
  //     log.error('Verification emails not implemented yet!');
  //     return false;
  //   } else {
  //     log.error(
  //         'Unknown verification code type passed [$verificationCodeDetails]!');
  //     return false;
  //   }
  // }

  Future<void> verifySMSVerificationCode(
    String verificationCode,
  ) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'verifySMSVerificationCode',
    );
    final store = await reduxStore;
    store.dispatch(SignupLoading(isLoading: true));
    // * TEST MODE ONLY
    if (verificationCode ==
        Secrets.testFirebaseSMSVerificationCodesByNumber[
            store.state.userState.phoneNumberNoCountry]) {
      log.warn(
        'Faking accept test auth code from firebase authenticator.verifySMSVerificationCode call using test details',
      );
      store
        ..dispatch(
          SetUserAuthenticationStatus(
            firebaseStatus: FirebaseAuthenticationStatus.authenticated,
            // todo: mock login to vegi too by passing none firebaseSessionToken secret to backend with a process.env check in the local.js
          ),
        )
        ..dispatch(
          SetFirebaseSessionToken(
            firebaseSessionToken: Secrets.testFirebaseSessionToken,
          ),
        );
      await _loginToVegiWithPhone(
        store: store,
        phoneNoCountry: store.state.userState.phoneNumberNoCountry,
        phoneCountryCode: int.tryParse(store.state.userState.countryCode),
        firebaseSessionToken: Secrets.testFirebaseSessionToken,
      );
      // initFuse
      if (store.state.userState.vegiAuthenticationStatus ==
          VegiAuthenticationStatus.authenticated) {
        await _loginToFuse();
      } else {
        log.error(
          'Unable to initFuse at end of authenticator.verifySMSVericationCode as failed to auth vegi USING TEST PHONE CREDENTIALS with status: [${store.state.userState.vegiAuthenticationStatus}] and firebaseStatus: ["${store.state.userState.firebaseAuthenticationStatus}"]',
        );
      }
      return;
    }

    // * NORMAL - NOT TEST NUMBER CONTINUE HERE
    store.dispatch(SignUpLoadingMessage(message: 'Verifying phone 🚀...'));
    final userCredential = await firebaseOnboarding.verify(
      store,
      verificationCode,
    );
    if (userCredential == null) {
      await _captureAuthenticationError(
        title: 'Invalid firebase credentials',
        message: 'Error with getIdToken for a firebase user',
        methodName: 'verifySMSVerificationCode',
        signUpErrCode: SignUpErrCode.invalidCredentials,
      );
      store.dispatch(SignupLoading(isLoading: false));
      return;
    }
    log.info(
      'Successfully authenticated with firebase',
      sentry: true,
    );
    await authVegiAndFuseWithFbUserCred(userCredential);
  }

  Future<void> authVegiAndFuseWithFbUserCred(
    UserCredential userCredential,
  ) async {
    final store = await reduxStore;
    final firebaseSessionToken = await _getFirebaseSessionToken(
      userCredential: userCredential,
    );
    await _loginToVegiWithPhone(
      store: store,
      phoneNoCountry: store.state.userState.phoneNumberNoCountry,
      phoneCountryCode: int.tryParse(store.state.userState.countryCode),
      firebaseSessionToken: firebaseSessionToken!,
    );
    if (store.state.userState.vegiAuthenticationStatus ==
        VegiAuthenticationStatus.authenticated) {
      await _loginToFuse();
    } else {
      log.error(
        'Unable to initFuse at end of authenticator.verifySMSVericationCode as failed to auth vegi with status: [${store.state.userState.vegiAuthenticationStatus}] and firebaseStatus: ["${store.state.userState.firebaseAuthenticationStatus}"]',
      );
    }
  }

  Future<bool> verifyEmailLinkCallback({
    required String emailAddress,
    required String emailLink,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'verifyEmailLinkCallback',
    );
    final store = await reduxStore;
    store.dispatch(SignupLoading(isLoading: true));
    final userCredential = await onBoardStrategy.signInUserFromVerificationLink(
      email: emailAddress,
      emailLinkFromVerificationEmail: emailLink,
    );
    if (userCredential == null) {
      await _captureAuthenticationError(
        message: 'Failed to authenticate onboarding via email',
        methodName: 'login',
      );
      return false;
    }
    //vegi login
    final firebaseSessionToken =
        await _getFirebaseSessionToken(userCredential: userCredential);
    await _loginToVegiWithEmail(
      store: store,
      email: emailAddress,
      firebaseSessionToken: firebaseSessionToken!,
    );
    // * login to fuse
    if (store.state.userState.vegiAuthenticationStatus ==
        VegiAuthenticationStatus.authenticated) {
      await _loginToFuse();
    } else {
      log.error(
        'Unable to initFuse at end of authenticator.verifySMSVericationCode as failed to auth vegi with status: [${store.state.userState.vegiAuthenticationStatus}] and firebaseStatus: ["${store.state.userState.firebaseAuthenticationStatus}"]',
      );
      store.dispatch(SignupLoading(isLoading: false));
      return false;
    }
    return true;
  }

  Future<bool> isLoggedIn() async {
    final store = await reduxStore;
    final us = store.state.userState;
    return !store.state.userState.hasNotOnboarded &&
        us.fuseAuthenticationStatus == FuseAuthenticationStatus.authenticated &&
        us.firebaseAuthenticationStatus ==
            FirebaseAuthenticationStatus.authenticated &&
        us.vegiAuthenticationStatus == VegiAuthenticationStatus.authenticated;
  }

  Future<void> logout({
    bool bypassSeedPhraseCheck = false,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'logout',
    );
    final store = await reduxStore;
    store.dispatch(SignupLoading(isLoading: true));
    if (store.state.userState.hasSavedSeedPhrase || bypassSeedPhraseCheck) {
      try {
        await firebaseOnboarding.signout();
      } on Exception catch (e, s) {
        log.error(
          e,
          stackTrace: s,
          sentryHint: 'Error signing out of firebase from authenticator',
        );
      }
      try {
        await peeplEatsService.logOut();
      } on Exception catch (e, s) {
        log.error(
          e,
          stackTrace: s,
          sentryHint: 'Error signing out of vegi from authenticator',
        );
      }
      await Analytics.track(eventName: AnalyticsEvents.logout);
      store
        ..dispatch(LogoutRequestSuccess())
        ..dispatch(SignupLoading(isLoading: false));
      return;
    }
    if (rootRouter.current.name.toLowerCase().contains('dialog')) {
      await rootRouter.pop();
    }
    await rootRouter.push(const ShowUserMnemonic());
    store.dispatch(SignupLoading(isLoading: false));
    return;
  }

  Future<void> deregisterUser() async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'deregisterUser',
    );
    final store = await reduxStore;
    store
      ..dispatch(SignupLoading(isLoading: true))
      ..dispatch(SignUpLoadingMessage(
          message:
              'Deleting users can take up to 30s, please bare with us... 🥵'));
    // no need to save seed phrase in this option as user wants all details to be deleted.
    try {
      await peeplEatsService.deleteAllUserDetails();
    } on Exception catch (e, s) {
      // TODO
      log.error(
        'Error trying delete user details from vegi: $e',
        error: e,
        stackTrace: s,
      );
    }
    store.dispatch(
      SignUpLoadingMessage(
        message: 'Almost there now...',
      ),
    );
    try {
      await peeplEatsService.deleteWalletAddressDetailsFromAccountsList();
    } on Exception catch (e, s) {
      // TODO
      log.error(
        "Error trying delete user's wallet details from vegi: $e",
        error: e,
        stackTrace: s,
      );
    }
    await logout(
      bypassSeedPhraseCheck: true,
    );
    await Analytics.track(eventName: AnalyticsEvents.deleteAccountSuccess);
    await rootRouter.replaceAll([const ResetApp(), const OnBoardScreen()]);
    store
      ..dispatch(SignUpLoadingMessage(message: ''))
      ..dispatch(SignupLoading(isLoading: false));
  }

  /// Wrapper function around the firebase.signInUserBySendingEmailLink method
  Future<bool> requestEmailLinkForEmailAddress({
    required String email,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'requestEmailLinkForEmailAddress',
    );
    final store = await reduxStore;
    store.dispatch(
      SignupLoading(
        isLoading: true,
      ),
    );
    final emailSent = await onBoardStrategy.signInUserBySendingEmailLink(
      email: email,
    );
    if (!emailSent) {
      log.warn(
        'Authentication.requestEmailLinkForEmailAddresss("$email") - Email link failed to send',
      );
    } else {
      log.info(
        'Authentication.requestEmailLinkForEmailAddresss("$email") - Email link sent successfully',
        sentry: true,
      );
    }
    store.dispatch(SignupLoading(isLoading: false));
    return true;
  }

  Future<String?> _getFirebaseSessionToken({
    required UserCredential userCredential,
  }) async {
    late final User? user;
    late final String? firebaseSessionToken;
    try {
      user = userCredential.user;
      firebaseSessionToken = await user?.getIdToken();
    } on FirebaseAuthException catch (e, s) {
      await _captureAuthenticationError(
        title: 'Invalid firebase credentials',
        message: 'Error with getIdToken for a firebase user',
        methodName: '_loginToVegiWithEmail',
        e: e,
        s: s,
        signUpErrCode: SignUpErrCode.invalidCredentials,
      );
    } on Exception catch (e, s) {
      await _captureAuthenticationError(
        title: 'Invalid firebase credentials',
        message: 'Error with getIdToken for a firebase user: $e',
        methodName: '_loginToVegiWithEmail',
        e: e,
        s: s,
        signUpErrCode: SignUpErrCode.invalidCredentials,
      );
    }
    return firebaseSessionToken;
  }

  Future<bool> _signUpFirebaseEmail({
    // required iLoginDetails loginDetails,
    required EmailLoginDetails loginDetails,
    required void Function() onCompleteFlow,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_signUpFirebaseEmail',
    );
    log.warn(
      "vegi doesn't currently support registering using an email, only a phone number.",
    );
    // final store = await reduxStore;
    return false;
  }

  Future<bool> _logInFirebaseRequestVerificationCodeStep2({
    required iLoginDetails loginDetails,
    required void Function() onCompleteFlow,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_logInFirebaseRequestVerificationCodeStep2',
    );
    if (loginDetails is PhoneLoginDetails) {
      return _requestSMSCodeForPhoneNumber(
        countryCode: loginDetails.countryCode,
        phoneNumber: loginDetails.phoneNumber,
        onCompleteFlow: onCompleteFlow,
      );
    } else if (loginDetails is EmailLoginDetails) {
      final store = await reduxStore;
      final userCredential = await _signInToOnboardingProviderWithEmail(
        email: loginDetails.email,
        password: loginDetails.password,
      );
      if (userCredential == null) {
        await _captureAuthenticationError(
          message: 'Failed to authenticate onboarding via email',
          methodName: '_logInFirebaseRequestVerificationCodeStep2',
        );
        return false;
      }
      //vegi login
      final firebaseSessionToken =
          await _getFirebaseSessionToken(userCredential: userCredential);
      await _loginToVegiWithEmail(
        store: store,
        email: loginDetails.email,
        firebaseSessionToken: firebaseSessionToken!,
      );
      // * login to fuse
      if (store.state.userState.vegiAuthenticationStatus ==
          VegiAuthenticationStatus.authenticated) {
        await _loginToFuse();
      } else {
        log.error(
          'Unable to initFuse at end of authenticator.verifySMSVericationCode as failed to auth vegi with status: [${store.state.userState.vegiAuthenticationStatus}] and firebaseStatus: ["${store.state.userState.firebaseAuthenticationStatus}"]',
        );
        return false;
      }
      return true;
    } else {
      log.error('Unknown loginDetails passed');
      return false;
    }
  }

  Future<bool> _signupFirebaseTryReauthenticate() async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_signupFirebaseTryReauthenticate',
    );
    final store = await reduxStore;
    if (store.state.userState.firebaseCredentialIsValid) {
      final reauthSucceeded = await onBoardStrategy.reauthenticateUser();

      if (!reauthSucceeded) {
        store.dispatch(
          SetUserAuthenticationStatus(
            firebaseStatus: FirebaseAuthenticationStatus.beginAuthentication,
          ),
        );
        await routeToLoginScreen();
        return false;
      }
    } else {
      // unable to reauth firebase so nav to SignUpScreen and return;
      store.dispatch(
        SetUserAuthenticationStatus(
          firebaseStatus: FirebaseAuthenticationStatus.beginAuthentication,
        ),
      );
      await routeToLoginScreen();
      return false;
    }
    return true;
  }

  Future<void> _signupVegiTryReauthenticate() async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_signupVegiTryReauthenticate',
    );
    final store = await reduxStore;
    // use firebaseAuth SessionToken to authenticate vegi. From here we are sure that firebaseSessionToken is live.

    final sessionIsValid = await _checkIfVegiSessionIsValid(store);
    if (!sessionIsValid) {
      if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.phone) {
        final vegiAuthResult = await _loginToVegiWithPhone(
          store: store,
          phoneNoCountry: store.state.userState.phoneNumberNoCountry,
          phoneCountryCode: int.tryParse(store.state.userState.countryCode),
          firebaseSessionToken: store.state.userState.firebaseSessionToken!,
        );
        if (vegiAuthResult != LoggedInToVegiResult.success) {
          log.warn(
            'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]',
          );
          // finish by navigating to MainScreen regardless
        }
      } else if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.phone) {
        final vegiAuthResult = await _loginToVegiWithPhone(
          store: store,
          phoneNoCountry: store.state.userState.phoneNumberNoCountry,
          phoneCountryCode: int.tryParse(store.state.userState.countryCode),
          firebaseSessionToken: store.state.userState.firebaseSessionToken!,
        );
        if (vegiAuthResult != LoggedInToVegiResult.success) {
          log.warn(
            'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]',
          );
          // finish by navigating to MainScreen regardless
        }
      } else if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.emailAndPassword) {
        final vegiAuthResult = await _loginToVegiWithEmail(
          store: store,
          email: store.state.userState.email,
          firebaseSessionToken: store.state.userState.firebaseSessionToken!,
        );
        if (vegiAuthResult != LoggedInToVegiResult.success) {
          log.warn(
            'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]',
          );
          // finish by navigating to MainScreen regardless
        }
      } else if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.emailLink) {
        final vegiAuthResult = await _loginToVegiWithEmail(
          store: store,
          email: store.state.userState.email,
          firebaseSessionToken: store.state.userState.firebaseSessionToken!,
        );
        if (vegiAuthResult != LoggedInToVegiResult.success) {
          log.warn(
            'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]',
          );
          // finish by navigating to MainScreen regardless
        }
      } else {
        final errMessage =
            'Unable to signin with firebaseSignOn method of: PreferredSignonMethod.[${store.state.userState.preferredSignonMethod.name}]';
        log.error(errMessage, stackTrace: StackTrace.current);
        store.dispatch(
          SignUpFailed(
            error: SignUpErrorDetails(
              title: 'Sign-in failed',
              message: 'Please try a different sign-on method',
              code: SignUpErrCode.signonMethodNotImplemented,
            ),
          ),
        );
        throw Exception(errMessage);
      }
    }
  }

  Future<void> _captureAuthenticationError({
    required String message,
    required String methodName,
    String className = 'Authentication',
    String title = '',
    SignUpErrCode? signUpErrCode,
    Exception? e,
    StackTrace? s,
  }) async {
    final store = await reduxStore;
    var title0 = title;
    if (title0.isEmpty) {
      title0 = 'Authentication error';
    }
    final codeStr = signUpErrCode == null ? '' : '[Code=$signUpErrCode]';
    log.error(
      '*$title0* $codeStr $message (in $className.$methodName())',
      error: e,
      stackTrace: s,
    );
    store.dispatch(
      SignUpErrorDetails(
        title: title0,
        message: message,
        code: signUpErrCode,
      ),
    );
  }

  Future<bool> _checkMnemonicMatchesPrivateKey({
    required List<String> mnemonic,
    required String privateKey,
  }) async {
    if (mnemonic.isEmpty || mnemonic.first.isEmpty) {
      return false;
    }
    final String mnemonicStr = mnemonic.join(' ');
    final derivedPrivateKey = Mnemonic.privateKeyFromMnemonic(mnemonicStr);
    return derivedPrivateKey == privateKey;
  }

  Future<String?> _getFusePrivateKeyForPhoneInStore({
    List<String>? useMnemonicWords,
  }) async {
    final store = await reduxStore;
    final phoneNumber = store.state.userState.phoneNumberE164;
    if (store.state.authState.phoneNumberToPrivateKeyMap
        .containsKey(phoneNumber)) {
      final privateKeyForPhone =
          store.state.authState.phoneNumberToPrivateKeyMap[phoneNumber];
      if (useMnemonicWords != null &&
          useMnemonicWords.isNotEmpty &&
          privateKeyForPhone != null &&
          privateKeyForPhone.isNotEmpty) {
        final isMatch = await _checkMnemonicMatchesPrivateKey(
          mnemonic: useMnemonicWords,
          privateKey: privateKeyForPhone,
        );
        if (!isMatch) {
          return null;
        }
      }
      return privateKeyForPhone;
    } else {
      return null;
    }
  }

  Future<void> _loginToFuse({
    void Function()? onWalletInitialised,
    List<String>? useMnemonicWords,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_loginToFuse',
    );
    final store = await reduxStore;
    store.dispatch(SignUpLoadingMessage(message: 'Fetching wallet 👾...'));
    final privateKeyForPhone = await _getFusePrivateKeyForPhoneInStore(
      useMnemonicWords: useMnemonicWords,
    );
    if (privateKeyForPhone != store.state.userState.privateKey) {
      store.dispatch(
        ResetFuseCredentials(
          privateKeyForPhone: privateKeyForPhone,
        ),
      );
    }

    await _initFuseWallet(
      store,
      onWalletInitialised: onWalletInitialised,
      useMnemonicWords: useMnemonicWords,
      privateKey: privateKeyForPhone,
    );
  }

  Future<UserCredential?> _signInToOnboardingProviderWithEmail({
    required String email,
    required String password,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_signInToOnboardingProviderWithEmail',
    );
    final store = await reduxStore;
    store.dispatch(
      SignUpLoadingMessage(message: 'Authenticating Email & Password 🚀...'),
    );
    // final store = await reduxStore;
    return onBoardStrategy.signInUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<bool> _requestSMSCodeForPhoneNumber({
    required CountryCode countryCode,
    required PhoneNumber phoneNumber,
    required void Function() onCompleteFlow,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_requestSMSCodeForPhoneNumber',
    );
    const bool useWeb3Auth = false;
    final store = await reduxStore;
    try {
      store.dispatch(setDevicePhoneNumberForId(phoneNumber.e164));
      await Analytics.setUserId(phoneNumber.e164);
      // * Firebase login -> will route to verify_screen
      store.dispatch(
        SignUpLoadingMessage(message: 'Sending SMS code to phone 🚀...'),
      );
      await firebaseOnboarding.login(
        countryCode: countryCode,
        phoneNumber: phoneNumber,
        onCompleteFlow: onCompleteFlow,
        // phoneNumber.e164,
      );
      return true;
      // if (store.state.userState.firebaseCredentialIsValid) {
      //   // try reauthentication first?...
      //   // checks the firebase credential is live and then calls the loginWithVegi from fireabsae, call from here instead?
      //   final reauthSucceeded = await onBoardStrategy.reauthenticateUser();
      //   if (reauthSucceeded) {
      //     if (store.state.userState.firebaseSessionToken != null) {
      //       final result = await loginToVegiWithPhone(
      //         store: store,
      //         phoneNumber: store.state.userState.phoneNumber,
      //         firebaseSessionToken: store.state.userState.firebaseSessionToken!,
      //       );
      //       if (result == LoggedInToVegiResult.success) {
      //         await _complete(
      //           vegiStatus: VegiAuthenticationStatus.authenticated,
      //         );
      //         store.dispatch(isBetaWhitelistedAddress());
      //         await onBoardStrategy.login(
      //           store,
      //           phoneNumber.e164,
      //         );
      //         return true;
      //       } else {
      //         log.error('Could not login to vegi...');
      //         await _complete(
      //           firebaseStatus: FirebaseAuthenticationStatus.authenticated,
      //           vegiStatus: VegiAuthenticationStatus.failed,
      //         );
      //         return false;
      //       }
      //     } else {
      //       return false;
      //     }
      //   } else {
      //     await onBoardStrategy.login(
      //       store,
      //       phoneNumber.e164,
      //     );
      //   }
      // }
      // return false;
    } catch (e, s) {
      log.error(
        'Error in login with phone number: $e',
        error: e,
        stackTrace: s,
      );
      store
        ..dispatch(
          SignUpFailed(
            error: SignUpErrorDetails(
              title:
                  e.toString().contains('blocked all requests from this device')
                      ? 'Verification error'
                      : 'Something went wrong',
              message: store.state.userState.isVegiSuperAdmin
                  ? 'Firebase error: $e'
                  : '$e',
            ),
          ),
        )
        ..dispatch(
          SetUserAuthenticationStatus(
            firebaseStatus: FirebaseAuthenticationStatus.phoneAuthFailed,
            vegiStatus: VegiAuthenticationStatus.failed,
          ),
        );
      onCompleteFlow();
      store.dispatch(
        SignUpLoadingMessage(message: 'vegi authentication failed'),
      );
      await Analytics.track(
        eventName: AnalyticsEvents.loginWithPhone,
        properties: {
          AnalyticsProps.status: AnalyticsProps.failed,
          'error': e.toString(),
        },
      );
      return false;
    }
  }

  // @override
  Future<LoggedInToVegiResult> _loginToVegiWithPhone({
    required Store<AppState> store,
    required String phoneNoCountry,
    required int? phoneCountryCode,
    required String firebaseSessionToken,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_loginToVegiWithPhone',
    );
    try {
      store
        ..dispatch(
          SetUserAuthenticationStatus(
            vegiStatus: VegiAuthenticationStatus.loading,
          ),
        )
        ..dispatch(SignUpLoadingMessage(message: 'Authenticating vegi 🥑...'));

      // * sets the session cookie on the service class instance.
      final vegiSession = await peeplEatsService.loginWithPhone(
        phoneCountryCode: phoneCountryCode,
        phoneNoCountry: phoneNoCountry,
        firebaseSessionToken: firebaseSessionToken,
      );
      final userDetails = vegiSession.user;
      if (vegiSession.sessionCookie.isNotEmpty) {
        await _complete(
          vegiStatus: VegiAuthenticationStatus.authenticated,
        );
        if (DebugHelpers.inDebugMode) {
          log.info(userDetails);
        }
        if (userDetails != null) {
          store.dispatch(
            setUserDetails(
              vegiUser: userDetails,
            ),
          );
        } else {
          log.error(
            'Signed into vegi but failed to receive user details in result',
            stackTrace: StackTrace.current,
          );
        }
        if (store.state.userState.vegiAuthenticationStatus !=
            VegiAuthenticationStatus.authenticated) {
          log.wtf(
            'vegi should be authenticated, not [${store.state.userState.vegiAuthenticationStatus}]. What the fuck has happened: stackTrace: ${StackTrace.current.filterCallStack().pretty()}',
          );
        }
        store.dispatch(
          SignUpFailed(
            error: null,
          ),
        );
        unawaited(
          Analytics.track(
            eventName: AnalyticsEvents.loginWithPhone,
            properties: {
              AnalyticsProps.status: AnalyticsProps.success,
            },
          ),
        );
      } else {
        log.error('Could not login to vegi...');
        await _complete(
          vegiStatus: VegiAuthenticationStatus.failed,
        );
      }
      return vegiSession.sessionCookie.isNotEmpty
          ? LoggedInToVegiResult.success
          : LoggedInToVegiResult.failedEmptySessionCookie;
    } catch (err, s) {
      await _complete(
        firebaseStatus: FirebaseAuthenticationStatus.authenticated,
        vegiStatus: VegiAuthenticationStatus.failed,
      );
      log
        ..error(
          err,
          stackTrace: s,
        )
        ..error(
          err.toString(),
          stackTrace: s,
        );
      store.dispatch(
        SetFirebaseSessionToken(
          firebaseSessionToken: null,
        ),
      );
      return LoggedInToVegiResult.failed;
    }
  }

  // @override
  Future<LoggedInToVegiResult> _loginToVegiWithEmail({
    required Store<AppState> store,
    required String email,
    required String firebaseSessionToken,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_loginToVegiWithEmail',
    );
    try {
      store
        ..dispatch(
          SetUserAuthenticationStatus(
            vegiStatus: VegiAuthenticationStatus.loading,
          ),
        )
        ..dispatch(
          SignUpLoadingMessage(
            message: 'Authenticating Email & Password on vegi 🥑...',
          ),
        );

      // * sets the session cookie on the service class instance.
      final vegiSession = await peeplEatsService.loginWithEmail(
        emailAddress: email,
        firebaseSessionToken: firebaseSessionToken,
      );
      final userDetails = vegiSession.user;
      if (vegiSession.sessionCookie.isNotEmpty) {
        await _complete(
          vegiStatus: VegiAuthenticationStatus.authenticated,
        );
        if (DebugHelpers.inDebugMode) {
          log.info(userDetails);
        }
        if (userDetails != null) {
          store.dispatch(
            setUserDetails(
              vegiUser: userDetails,
            ),
          );
        } else {
          log.error(
            'Signed into vegi but failed to receive user details in result',
            stackTrace: StackTrace.current,
          );
        }
        store.dispatch(
          SignUpFailed(
            error: null,
          ),
        );
        store.dispatch(getVegiWalletAccountDetails());
        unawaited(
          Analytics.track(
            eventName: AnalyticsEvents.loginWithPhone,
            properties: {
              AnalyticsProps.status: AnalyticsProps.success,
            },
          ),
        );
      } else {
        log.error('Could not login to vegi...');
        await _complete(
          vegiStatus: VegiAuthenticationStatus.failed,
        );
        store.dispatch(
          SignUpLoadingMessage(
            message: 'Failed to authenticate email credentials with vegi',
          ),
        );
      }
      store.dispatch(SignUpLoadingMessage(message: ''));
      return vegiSession.sessionCookie.isNotEmpty
          ? LoggedInToVegiResult.success
          : LoggedInToVegiResult.failedEmptySessionCookie;
    } catch (err, s) {
      await _complete(
        firebaseStatus: FirebaseAuthenticationStatus.authenticated,
        vegiStatus: VegiAuthenticationStatus.failed,
      );
      store.dispatch(
        SignUpLoadingMessage(
          message: 'Failed to authenticate email credentials with vegi',
        ),
      );
      log
        ..error(
          err,
          stackTrace: s,
        )
        ..error(
          err.toString(),
          stackTrace: s,
        );
      store.dispatch(
        SetFirebaseSessionToken(
          firebaseSessionToken: null,
        ),
      );
      return LoggedInToVegiResult.failed;
    }
  }

  Future<void> _complete({
    FirebaseAuthenticationStatus? firebaseStatus,
    VegiAuthenticationStatus? vegiStatus,
    FuseAuthenticationStatus? fuseStatus,
  }) async =>
      (await reduxStore).dispatch(
        SetUserAuthenticationStatus(
          firebaseStatus: firebaseStatus,
          vegiStatus: vegiStatus,
          fuseStatus: fuseStatus,
        ),
      );

  /// Function to create the single External Owner Account that can have at most
  /// ONE smart wallet linked with it.
  Future<void> _initFuseWallet(
    Store<AppState> store, {
    required String? privateKey,
    void Function()? onWalletInitialised,
    List<String>? useMnemonicWords,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_initFuseWallet',
    );
    store.dispatch(
      SetUserAuthenticationStatus(
        fuseStatus: FuseAuthenticationStatus.loading,
      ),
    );
    late final EthPrivateKey credentials;
    final mnemonicInState = store.state.userState.mnemonic;
    final mnemonic = useMnemonicWords ?? store.state.userState.mnemonic;
    // * Fuse - Create PrivateKey if no privateKey in state or no mnemonic in state
    if (privateKey == null ||
        privateKey.isEmpty ||
        mnemonicInState.isEmpty ||
        mnemonicInState.first.isEmpty) {
      if (mnemonic.isEmpty ||
          mnemonic.first.isEmpty &&
              (privateKey != null || (privateKey?.isNotEmpty ?? false))) {
        log.warn(
          'Creating a new wallet even though have already created one for this phone number as have lost the mnemonic in the state',
        );
      }
      log.info(
        'Creating a new FuseSDK private key for phoneNumber: ${store.state.userState.phoneNumber}${useMnemonicWords != null ? " using recovery mnemonic" : ""}',
        sentry: true,
      );
      final String mnemonicStr = useMnemonicWords != null
          ? useMnemonicWords.join(' ')
          : mnemonicInState.isNotEmpty && mnemonicInState.first.isNotEmpty
              ? mnemonicInState.join(' ')
              : Mnemonic.generate();
      final newPrivateKey = Mnemonic.privateKeyFromMnemonic(mnemonicStr);
      credentials = EthPrivateKey.fromHex(newPrivateKey);
      final EthereumAddress accountAddress = credentials.address;
      store
        ..dispatch(
          CreateLocalAccountSuccess(
            mnemonicStr.split(' '),
            newPrivateKey,
            credentials,
            // accountAddress.toString(),
          ),
        )
        ..dispatch(
          RegisterNewFusePrivateKey(
            fusePrivateKey: newPrivateKey,
            phoneNumberCountryCode: store.state.userState.countryCode,
            phoneNumberNoCountry: store.state.userState.phoneNumberNoCountry,
          ),
        );
      log.info(
        'Created a new FuseSDK private key for phoneNumber: ${store.state.userState.phoneNumber} succesfully',
        sentry: true,
      );
      await Analytics.track(
        eventName: AnalyticsEvents.createWallet,
      );
    } else {
      log.info(
        'reauthenticating fuseSDK using existing private key stored against phoneNumber: ${store.state.userState.phoneNumber}',
      );
      credentials = EthPrivateKey.fromHex(privateKey);
      if (store.state.userState.mnemonic.isEmpty ||
          store.state.userState.mnemonic.first.isEmpty) {
        // we need to get the user mnemonic or not delete it...
        log.error('No mnemonic set for user, we need to generate a new wallet');
      }
    }

    final authSucceeded = await authenticateSDK(
      store,
      credentials: credentials,
    );
    if (!authSucceeded) {
      // return FuseAuthenticationStatus.failedAuthentication;
      return;
    }

    if (store.state.userState.fuseAuthenticationStatus ==
            FuseAuthenticationStatus.authenticated &&
        (privateKey?.isNotEmpty ?? false)) {
      // return true;
      onWalletInitialised?.call();

      try {
        await _emitWallet(fuseWalletSDK.smartWallet);
        return;
      } on Exception catch (e, s) {
        log.warn(
          'Unable to return smartWallet even though loaded and sdk not initialised yet.',
          error: e,
          stackTrace: s,
        );
      }
    }

    // * FUSE - Fetch/Create Wallet from FuseSDK
    try {
      await _fetchCreateWallet(
        onWalletInitialised: onWalletInitialised,
        newPrivateKeyUsed: privateKey?.isEmpty ?? true,
      );
      return;
    } catch (e, s) {
      log.error(
        'ERROR - fetchFuseSmartWallet',
        error: e,
        stackTrace: s,
      );
      store.dispatch(
        SetUserAuthenticationStatus(
          fuseStatus: FuseAuthenticationStatus.failedFetch,
        ),
      );
      // return FuseAuthenticationStatus.failedFetch;
      return;
    }
  }

  // bool _fuseSDKNeedsAuthenticationFirst({
  //   required DC<Exception, SmartWallet> walletData,
  // }) {
  //   return walletData.hasError &&
  //       walletData.error.toString().contains('LateInit');
  // }

  Future<void> _emitWallet(SmartWallet userWallet) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_emitWallet',
    );
    await saveSmartWallet(
      smartWallet: userWallet,
    );
    final store = await reduxStore;
    store
      ..dispatch(
        SetSmartWalletInMemory(
          smartWallet: userWallet,
        ),
      )
      ..dispatch(
        SetUserAuthenticationStatus(
          fuseStatus: FuseAuthenticationStatus.authenticated,
        ),
      )
      ..dispatch(
        SignUpFailed(
          error: null,
        ),
      )
      ..dispatch(
        SignUpLoadingMessage(
          message: '',
        ),
      )
      ..dispatch(SignupLoading(isLoading: false))
      ..dispatch(setRandomUserAvatarIfNone());

    await firebaseOnboarding.nextOnboardingPage();
  }

  Future<void> _oldFetchCreateWallet() async {
    final store = await reduxStore;
    final walletData = await fuseWalletSDK.fetchWallet();
    if (walletData.hasData) {
      final smartWallet = walletData.data!;
      log.info(
        'Successfully refetched smart wallet address ${smartWallet.smartWalletAddress}',
      );
      store
        ..dispatch(
          saveSmartWallet(
            smartWallet: fuseWalletSDK.smartWallet,
          ),
        )
        ..dispatch(
          SetUserAuthenticationStatus(
            fuseStatus: FuseAuthenticationStatus.authenticated,
          ),
        );
      // return FuseAuthenticationStatus.authenticated;
      return;
    } else if (walletData.hasError) {
      // } else if (fuseSDKNeedsAuthenticationFirst(walletData: walletData)) {
      final exception = walletData.error!;
      final wasLateInitJwtIssue = exception.toString().contains('LateInit');
      if (wasLateInitJwtIssue) {
        // * FUSE - Authenticate SDK
        final authSucceeded = await authenticateSDK(
          store,
          credentials: EthPrivateKey.fromHex(
            store.state.userState.privateKey,
          ),
        );
        if (!authSucceeded) {
          return;
        }
      }
      final tryCreateWalletStatus = await _tryCreateWallet(store);
      if (tryCreateWalletStatus == FuseAuthenticationStatus.authenticated) {
        return;
      }
      // Try to REfetch wallet for the EOA, if it doesn't exist create one

      final walletDataReFetched = await fuseWalletSDK.fetchWallet();
      if (walletDataReFetched.hasData) {
        final smartWallet = walletDataReFetched.data!;
        log.info(
          'Successfully refetched smart wallet address ${smartWallet.smartWalletAddress}',
        );
        await _emitWallet(fuseWalletSDK.smartWallet);
      } else if (walletDataReFetched.hasError) {
        final exception = walletDataReFetched.error!;
        if (exception.toString().contains('LateInit')) {
          store.dispatch(
            SetUserAuthenticationStatus(
              fuseStatus: FuseAuthenticationStatus
                  .failedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt,
            ),
          );
          // return FuseAuthenticationStatus
          //     .failedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt;
          return;
        } else {
          await _tryCreateWallet(store);
        }
      }
    }
    // return store.state.userState.fuseAuthenticationStatus;
    return;
  }

  /// Method to fetch wallet if exists else create taken from
  /// ~ https://docs.fuse.io/docs/developers/fuse-sdk/flutter-sdk/features#fetch-or-create-a-smart-wallet
  Future<void> _fetchCreateWallet({
    void Function()? onWalletInitialised,
    bool newPrivateKeyUsed = false,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_fetchCreateWallet',
    );
    final store = await reduxStore;
    // Try to fetch a wallet for the EOA, if it doesn't exist create one
    final walletData = await fuseWalletSDK.fetchWallet();
    walletData.pick(
      onData: (SmartWallet smartWallet) async {
        if (newPrivateKeyUsed) {
          log.warn(
            'fuseWalletSDK.fetchWallet succeeded despite using a new privateKey for phone: "${store.state.userState.phoneNumber}" with Smart wallet address "${smartWallet.smartWalletAddress}"',
          );
        } else {
          log.info(
            'fuseWalletSDK.fetchWallet succeeded for phone: "${store.state.userState.phoneNumber}" with Smart wallet address "${smartWallet.smartWalletAddress}"',
            sentry: true,
          );
        }
        // set the smart wallet on the store on an ignore propetrty of the state (i.e. not serialized, just memory & set fuse auth to true)
        // then write a helper method next that listens for exactly that store update with signature (newStore, oldStore?) that can be called by each viewmodel...
        await _emitWallet(smartWallet);
        onWalletInitialised?.call();
      },
      onError: (Exception exception) async {
        if (newPrivateKeyUsed) {
          log.info(
            'Authenticator._fetchCreateWallet - creating a new fuse smart wallet with new private key (expected) for phone: "${store.state.userState.phoneNumber}"...',
            sentry: true,
          );
        } else {
          log
              // ..error(
              //     'fuseWalletSDK.fetchWallet failed to fetch fuse smart wallet with error: "$exception"')
              .warn(
            'Authenticator._fetchCreateWallet - UNEXPECTED - create a new fuse smart wallet as failed to fetch despite using an existing private key for phone: "${store.state.userState.phoneNumber}"...',
          );
        }
        store.dispatch(
          SetUserAuthenticationStatus(
            fuseStatus: FuseAuthenticationStatus.loading,
          ),
        );
        final exceptionOrStream = await fuseWalletSDK.createWallet();
        if (exceptionOrStream.hasError) {
          log.error(
            'fuseWalletSDK.createWallet failed with error: "${exceptionOrStream.error}"',
            error: exceptionOrStream.error,
            stackTrace: StackTrace.current,
          );
          store.dispatch(
            SignUpLoadingMessage(
              message: 'Failed to create vegi wallet 👾 👎',
            ),
          );
        } else if (exceptionOrStream.hasData) {
          final smartWalletEventStream = exceptionOrStream.data!
            ..listen(
              (SmartWalletEvent event) {
                switch (event.name) {
                  case 'smartWalletCreationStarted':
                    log.info(
                      'Authenticator._fetchCreateFuseWallet fuseWalletSDK.createWallet - smartWalletCreationStarted',
                      sentry: true,
                    );
                    break;
                  case 'transactionHash':
                    log.info(
                      'Authenticator._fetchCreateFuseWallet fuseWalletSDK.createWallet - transactionHash "${event.data}"',
                    );
                    break;
                  case 'smartWalletCreationSucceeded':
                    log.info(
                      'Authenticator._fetchCreateFuseWallet fuseWalletSDK.createWallet - smartWalletCreationSucceeded ${event.data}',
                      sentry: true,
                    );
                    _emitWallet(SmartWallet.fromJson(event.data));
                    onWalletInitialised?.call();
                    break;
                  case 'smartWalletCreationFailed':
                    log.error(
                      'Authenticator._fetchCreateFuseWallet fuseWalletSDK.createWallet - transaction stream failed on chain with error ${event.data}',
                    );
                    store.dispatch(
                      SignUpLoadingMessage(
                        message: 'Failed to create vegi wallet 👾 👎',
                      ),
                    );
                    store.dispatch(
                      SetUserAuthenticationStatus(
                        fuseStatus: FuseAuthenticationStatus.failedCreate,
                      ),
                    );
                    break;
                }
              },
              onError: (dynamic error) {
                log.error(
                  'Authentication._fetchCreateWallet fuseWalletSDK.createWallet Error occurred: $error',
                );
                store.dispatch(
                  SetUserAuthenticationStatus(
                    fuseStatus: FuseAuthenticationStatus.failedCreate,
                  ),
                );
                store.dispatch(
                  SignUpLoadingMessage(
                    message: 'Failed to create vegi wallet 👾 👎',
                  ),
                );
              },
            );
        }
      },
    );
  }

  Future<FuseAuthenticationStatus> _tryCreateWallet(
    Store<AppState> store, {
    bool forceCreateNew = false,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_tryCreateWallet',
    );
    if (forceCreateNew != true) {
      final walletDataReFetched = await fuseWalletSDK.fetchWallet();
      if (walletDataReFetched.hasData) {
        final smartWallet = walletDataReFetched.data!;
        log.info(
          'Successfully refetched smart wallet address ${smartWallet.smartWalletAddress} so no need to create a new wallet as requested',
          sentry: true,
        );
        store
          ..dispatch(
            saveSmartWallet(
              smartWallet: smartWallet,
            ),
          )
          ..dispatch(
            SetUserAuthenticationStatus(
              fuseStatus: FuseAuthenticationStatus.authenticated,
            ),
          );
        return FuseAuthenticationStatus.authenticated;
      }
    } else {
      log.info(
        'Failed to fetch wallet from fuseWalletSDK so will attempt to create a new wallet',
        stackTrace: StackTrace.current,
        sentry: true,
      );
    }
    // we move to createWallet call below
    store.dispatch(
      SetUserAuthenticationStatus(
        fuseStatus: FuseAuthenticationStatus.createWalletForEOA,
      ),
    );

    try {
      final smartWallet0 = fuseWalletSDK.smartWallet;
      store
        ..dispatch(
          saveSmartWallet(
            smartWallet: smartWallet0,
          ),
        )
        ..dispatch(
          SetUserAuthenticationStatus(
            fuseStatus: FuseAuthenticationStatus.authenticated,
          ),
        );
      return FuseAuthenticationStatus.authenticated;
    } catch (e) {
      // TODO
      // do nothing
    }

    final walletCreationResult = await fuseWalletSDK.createWallet();
    if (walletCreationResult.hasData) {
      store.dispatch(
        SetUserAuthenticationStatus(
          fuseStatus: FuseAuthenticationStatus.created,
        ),
      );
      walletCreationResult.data!.listen(
        (SmartWalletEvent event) {
          if (event.name == 'smartWalletCreationStarted') {
            log.info('smartWalletCreationStarted ${event.data}');
            store.dispatch(
              SetUserAuthenticationStatus(
                fuseStatus: FuseAuthenticationStatus.creationStarted,
              ),
            );
          } else if (event.name == 'transactionHash') {
            log.info(
              'transactionHash ${event.data}',
              sentry: true,
            );
            store.dispatch(
              SetUserAuthenticationStatus(
                fuseStatus: FuseAuthenticationStatus.creationTransactionHash,
              ),
            );
          } else if (event.name == 'smartWalletCreationSucceeded') {
            final smartWalletAddress =
                event.data['smartWalletAddress'] as String?;
            final EOA = event.data['ownerAddress'] as String?;
            WalletModules? walletModules;
            if (event.data.containsKey('walletModules')) {
              walletModules = WalletModules.fromJson(
                event.data['walletModules'] as Map<String, dynamic>,
              );
            }
            List<String> networks = <String>[];
            if (event.data.containsKey('networks')) {
              networks = List<String>.from(
                event.data['networks'] as Iterable<dynamic>,
              );
            }
            final fuseSDKVersion = event.data['version'];
            log.info(
              'smartWalletCreationSucceeded with smartwalletaddress: "$smartWalletAddress"',
              sentry: true,
            );

            if (smartWalletAddress != null && walletModules != null) {
              store
                ..dispatch(
                  GotWalletDataSuccess(
                    walletAddress: smartWalletAddress,
                    networks: networks,
                    walletModules: walletModules,
                  ),
                )
                ..dispatch(
                  SetUserAuthenticationStatus(
                    fuseStatus: FuseAuthenticationStatus.authenticated,
                  ),
                );
              return;
            }
            store.dispatch(
              SetUserAuthenticationStatus(
                fuseStatus: FuseAuthenticationStatus.creationSucceeded,
              ),
            );

            fuseWalletSDK.fetchWallet().then((walletDataFetchPostCreate) {
              if (walletDataFetchPostCreate.hasData) {
                final smartWallet = walletDataFetchPostCreate.data!;
                log.info(
                  'Successfully refetched smart wallet address ${smartWallet.smartWalletAddress}',
                  sentry: true,
                );
                store
                  ..dispatch(
                    saveSmartWallet(
                      smartWallet: fuseWalletSDK.smartWallet,
                    ),
                  )
                  ..dispatch(
                    SetUserAuthenticationStatus(
                      fuseStatus: FuseAuthenticationStatus.authenticated,
                    ),
                  );
              } else if (walletDataFetchPostCreate.hasError) {
                final exception = walletDataFetchPostCreate.error!;
                if (exception.toString().contains('LateInit')) {
                  store.dispatch(
                    SetUserAuthenticationStatus(
                      fuseStatus: FuseAuthenticationStatus
                          .failedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt,
                    ),
                  );
                  return null;
                } else {
                  // we move to createWallet call below
                  store.dispatch(
                    SetUserAuthenticationStatus(
                      fuseStatus: FuseAuthenticationStatus.createWalletForEOA,
                    ),
                  );
                }
              }
            });
          } else if (event.name == 'smartWalletCreationFailed') {
            log.error(
              'smartWalletCreationFailed ${event.data}',
              stackTrace: StackTrace.current,
            );
            store.dispatch(
              SetUserAuthenticationStatus(
                fuseStatus: FuseAuthenticationStatus.failedCreate,
              ),
            );
          } else {
            log.warn('No event handler for fuseWalletSDK.fetchWallet event: '
                '"${event.name}"');
          }
        },
        cancelOnError: true,
        onError: (dynamic error) {
          log.error(
            error,
            stackTrace: StackTrace.current,
            sentryHint:
                'ERROR - user_actions.dart.createLocalAccountCall[createWalletStream] $error',
          );
        },
      );
      return FuseAuthenticationStatus.created;
    } else if (walletCreationResult.hasError) {
      final errStr = walletCreationResult.error is DioError
          ? 'FuseSDK failed to create a new wallet... Message: "${(walletCreationResult.error as DioError?)?.message}", Err: ${(walletCreationResult.error as DioError?)?.error}'
          : '${walletCreationResult.error}';
      log.error(
        errStr,
        error: walletCreationResult.error,
        sentryHint: errStr,
      );
      store.dispatch(
        SetUserAuthenticationStatus(
          fuseStatus: FuseAuthenticationStatus.failedCreate,
        ),
      );
      return FuseAuthenticationStatus.failedCreate;
    } else {
      //cant get here as either of hasError or hasData on walletCreationResult will always be true.
      return FuseAuthenticationStatus.failedCreate;
    }
  }

  Future<void> saveSmartWallet({
    required SmartWallet smartWallet,
  }) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'saveSmartWallet',
    );
    final store = await reduxStore;
    try {
      store.dispatch(
        GotWalletDataSuccess(
          walletAddress: smartWallet.smartWalletAddress,
          networks: smartWallet.networks,
          walletModules: smartWallet.walletModules,
        ),
      );
    } catch (e, s) {
      log.error(
        'ERROR - setupWalletCall',
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<void> routeToLoginScreen() async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: 'routeToLoginScreen',
    );
    final store = await reduxStore;
    try {
      if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.emailAndPassword) {
        log.info(
          'ReplaceAll with SignUpWithEmailAndPasswordScreen() from ${rootRouter.current.name} in authenticate thunk.',
          sentry: true,
        );
        await rootRouter.replaceAll(
          [const SignUpWithEmailAndPasswordScreen()],
        );
      } else if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.emailLink) {
        log.info(
          'ReplaceAll with SignUpEmailLinkScreen() from ${rootRouter.current.name} in authenticate thunk.',
          sentry: true,
        );
        await rootRouter.replaceAll(
          [const SignUpEmailLinkScreen()],
        );
      } else {
        log.info(
          'ReplaceAll with SignUpScreen() from ${rootRouter.current.name} in authenticate thunk.',
          sentry: true,
        );
        await rootRouter.replaceAll(
          [const SignUpScreen()],
        ); // ~ https://stackoverflow.com/a/46713257
      }
      return;
    } catch (e, s) {
      log.error('ERROR - routeToLoginScreen $e', stackTrace: s);
    }
  }

  // checkIfVegiSessionIsValid() {
  //   return (Store<AppState> store) async {
  //     await _checkIfVegiSessionIsValid(store);
  //   };
  // }

  Future<bool> _checkIfVegiSessionIsValid(Store<AppState> store) async {
    logFunctionCall<void>(
      className: 'Authentication',
      funcName: '_checkIfVegiSessionIsValid',
    );
    try {
      final sessionStillValid =
          await peeplEatsService.checkVegiSessionIsStillValid();
      if (sessionStillValid) {
        store
          ..dispatch(
            SetUserAuthenticationStatus(
              firebaseStatus: FirebaseAuthenticationStatus.authenticated,
              vegiStatus: VegiAuthenticationStatus.authenticated,
            ),
          )
          ..dispatch(
            SignUpFailed(
              error: null,
            ),
          );
        return sessionStillValid;
      } else {
        store.dispatch(
          SetUserAuthenticationStatus(
            vegiStatus: VegiAuthenticationStatus.unauthenticated,
          ),
        );
        return sessionStillValid;
      }
    } on Exception catch (error, s) {
      log.error(
        'Error checking if vegi session is valid',
        stackTrace: s,
      );
      store.dispatch(
        SetUserAuthenticationStatus(
          firebaseStatus:
              FirebaseAuthenticationStatus.phoneAuthReauthenticationFailed,
        ),
      );
      await Analytics.track(
        eventName: AnalyticsEvents.verify,
        properties: {
          AnalyticsProps.status: AnalyticsProps.failed,
          'error': error.toString(),
        },
      );
    }
    return false;
  }
}
