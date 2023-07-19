import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/analytics_props.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/cash_wallet_actions.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
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

class Authentication {
  Future<void> initFuse({
    void Function()? onWalletInitialised,
  }) =>
      _loginToFuse(
        onWalletInitialised: onWalletInitialised,
      );

  Future<void> restoreFuseFromMnemonic({
    required List<String> mnemonicWords,
    void Function()? onWalletInitialised,
  }) =>
      _loginToFuse(
        onWalletInitialised: onWalletInitialised,
        useMnemonicWords: mnemonicWords,
      );

  Future<void> signUp({
    // required iLoginDetails loginDetails,
    required PhoneLoginDetails loginDetails,
  }) async {
    // TODO Change signup to require email and register password, then add a phone number and verify code
    await _loginToFuse(
      onWalletInitialised: () => _signUpFirebaseRequestVerificationCodeStep2(
        loginDetails: loginDetails,
      ),
    );
  }

  Future<bool> _signUpFirebaseRequestVerificationCodeStep2({
    // required iLoginDetails loginDetails,
    required PhoneLoginDetails loginDetails,
  }) async {
    if (loginDetails is PhoneLoginDetails) {
      return _requestSMSCodeForPhoneNumber(
        countryCode: loginDetails.countryCode,
        phoneNumber: loginDetails.phoneNumber,
      );
    } else if (loginDetails is EmailLoginDetails) {
      log.warn(
        "vegi doesn't currently support registering using an email, only a phone number.",
      );
      final store = await reduxStore;
      // store.dispatch(
      //   SignupLoading(
      //     isLoading: true,
      //   ),
      // );
      //// return _signupWithEmailDetails(
      ////   email: loginDetails.email,
      //// );
      // final userCredential = await _signInToOnboardingProviderWithEmail(
      //   email: loginDetails.email,
      //   password: loginDetails.password,
      // );
      // if (userCredential == null) {
      //   await _captureAuthenticationError(
      //     message: 'Failed to authenticate onboarding via email',
      //     methodName: 'login',
      //   );
      //   return false;
      // }
      // //vegi login
      // late final User? user;
      // late final String? firebaseSessionToken;
      // try {
      //   user = userCredential.user;
      //   firebaseSessionToken = await user?.getIdToken();
      // } on FirebaseAuthException catch (e, s) {
      //   await _captureAuthenticationError(
      //     title: 'Invalid firebase credentials',
      //     message: 'Error with getIdToken for a firebase user',
      //     methodName: '_loginToVegiWithEmail',
      //     e: e,
      //     s: s,
      //     signUpErrCode: SignUpErrCode.invalidCredentials,
      //   );
      //   return false;
      // } on Exception catch (e, s) {
      //   await _captureAuthenticationError(
      //     title: 'Invalid firebase credentials',
      //     message: 'Error with getIdToken for a firebase user: $e',
      //     methodName: '_loginToVegiWithEmail',
      //     e: e,
      //     s: s,
      //     signUpErrCode: SignUpErrCode.invalidCredentials,
      //   );
      //   return false;
      // }
      // await _loginToVegiWithEmail(
      //   store: store,
      //   email: loginDetails.email,
      //   firebaseSessionToken: firebaseSessionToken!,
      // );
      store.dispatch(
        SignupLoading(
          isLoading: false,
        ),
      );
      return false;
    } else {
      log.error('Unknown loginDetails passed');
      return false;
    }
  }

  Future<bool> _signInFirebaseRequestVerificationCodeStep2({
    required iLoginDetails loginDetails,
  }) async {
    if (loginDetails is PhoneLoginDetails) {
      return _requestSMSCodeForPhoneNumber(
        countryCode: loginDetails.countryCode,
        phoneNumber: loginDetails.phoneNumber,
      );
    } else if (loginDetails is EmailLoginDetails) {
      final store = await reduxStore;
      store.dispatch(
        SignupLoading(
          isLoading: true,
        ),
      );
      final userCredential = await _signInToOnboardingProviderWithEmail(
        email: loginDetails.email,
        password: loginDetails.password,
      );
      if (userCredential == null) {
        await _captureAuthenticationError(
          message: 'Failed to authenticate onboarding via email',
          methodName: 'login',
        );
        return false;
      }
      //vegi login
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
        return false;
      } on Exception catch (e, s) {
        await _captureAuthenticationError(
          title: 'Invalid firebase credentials',
          message: 'Error with getIdToken for a firebase user: $e',
          methodName: '_loginToVegiWithEmail',
          e: e,
          s: s,
          signUpErrCode: SignUpErrCode.invalidCredentials,
        );
        return false;
      }
      await _loginToVegiWithEmail(
        store: store,
        email: loginDetails.email,
        firebaseSessionToken: firebaseSessionToken!,
      );
      store.dispatch(
        SignupLoading(
          isLoading: false,
        ),
      );
      return false;
      // return _signupWithEmailDetails(
      //   email: loginDetails.email,
      // );
    } else {
      log.error('Unknown loginDetails passed');
      return false;
    }
  }

  Future<bool> _signupFirebaseTryReauthenticate() async {
    final store = await reduxStore;
    if (store.state.userState.firebaseCredentialIsValid) {
      store.dispatch(SignupLoading(isLoading: true));
      final reauthSucceeded = await onBoardStrategy.reauthenticateUser();
      store.dispatch(SignupLoading(isLoading: false));
      if (!reauthSucceeded) {
        store
          ..dispatch(
            SetUserAuthenticationStatus(
              firebaseStatus: FirebaseAuthenticationStatus.beginAuthentication,
            ),
          )
          ..dispatch(SignupLoading(isLoading: false));
        await routeToLoginScreen();
        return false;
      }
    } else {
      // unable to reauth firebase so nav to SignUpScreen and return;
      store
        ..dispatch(
          SetUserAuthenticationStatus(
            firebaseStatus: FirebaseAuthenticationStatus.beginAuthentication,
          ),
        )
        ..dispatch(SignupLoading(isLoading: false));
      await routeToLoginScreen();
      return false;
    }
    return true;
  }

  Future<void> _signupVegiTryReauthenticate() async {
    final store = await reduxStore;
    // use firebaseAuth SessionToken to authenticate vegi. From here we are sure that firebaseSessionToken is live.
    store.dispatch(SignupLoading(isLoading: true));
    final sessionIsValid = await _checkIfVegiSessionIsValid(store);
    if (!sessionIsValid) {
      if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.phone) {
        final vegiAuthResult = await _loginToVegiWithPhone(
          store: store,
          phoneNumber: store.state.userState.phoneNumber,
          firebaseSessionToken: store.state.userState.firebaseSessionToken!,
        );
        store.dispatch(SignupLoading(isLoading: false));
        if (vegiAuthResult != LoggedInToVegiResult.success) {
          log.warn(
              'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]');
          // finish by navigating to MainScreen regardless
        }
      } else if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.phone) {
        final vegiAuthResult = await _loginToVegiWithPhone(
          store: store,
          phoneNumber: store.state.userState.phoneNumber,
          firebaseSessionToken: store.state.userState.firebaseSessionToken!,
        );
        store.dispatch(SignupLoading(isLoading: false));
        if (vegiAuthResult != LoggedInToVegiResult.success) {
          log.warn(
              'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]');
          // finish by navigating to MainScreen regardless
        }
      } else if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.emailAndPassword) {
        final vegiAuthResult = await _loginToVegiWithEmail(
          store: store,
          email: store.state.userState.email,
          firebaseSessionToken: store.state.userState.firebaseSessionToken!,
        );
        store.dispatch(SignupLoading(isLoading: false));
        if (vegiAuthResult != LoggedInToVegiResult.success) {
          log.warn(
              'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]');
          // finish by navigating to MainScreen regardless
        }
      } else if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.emailLink) {
        final vegiAuthResult = await _loginToVegiWithEmail(
          store: store,
          email: store.state.userState.email,
          firebaseSessionToken: store.state.userState.firebaseSessionToken!,
        );
        store.dispatch(SignupLoading(isLoading: false));
        if (vegiAuthResult != LoggedInToVegiResult.success) {
          log.warn(
              'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]');
          // finish by navigating to MainScreen regardless
        }
      } else {
        final errMessage =
            'Unable to signin with firebaseSignOn method of: PreferredSignonMethod.[${store.state.userState.preferredSignonMethod.name}]';
        log.error(errMessage, stackTrace: StackTrace.current);
        store
          ..dispatch(SignupLoading(isLoading: false))
          ..dispatch(
            SignupFailed(
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

    if (store.state.userState.isLoggedOut) {
      store.dispatch(SetReLoggedin());
    }
    store.dispatch(SignupLoading(isLoading: false));
  }

  Future<void> reauthenticate() async {
    final store = await reduxStore;
    // check fuse
    // * Fuse part
    await _loginToFuse(
      onWalletInitialised: () async {
        // * Firebase part
        final firebaseReauthenticationSucceeded =
            await _signupFirebaseTryReauthenticate();
        if (firebaseReauthenticationSucceeded) {
          // * vegi Auth
          await _signupVegiTryReauthenticate();
        }
      },
    );
  }

  /// to be called from loginHandler on Sign_up_screen via MainScreenViewModel
  /// & for reauthentication calls
  Future<void> login({
    required iLoginDetails loginDetails,
  }) async {
    // TODO Change signup to require email and register password, then add a phone number and verify code
    await _loginToFuse(
      onWalletInitialised: () => _signInFirebaseRequestVerificationCodeStep2(
        loginDetails: loginDetails,
      ),
    );
  }

  Future<bool> verify({
    required iVerificationCodeDetails verificationCodeDetails,
  }) async {
    final store = await reduxStore;
    // check fuse authenticated even though should only be calling this function if it is
    if (store.state.userState.fuseAuthenticationStatus !=
        FuseAuthenticationStatus.authenticated) {}

    // call onboarding.verify
    if (verificationCodeDetails is SMSVerificationCodeDetails) {
      // check phone number has already been sent and set on in memeory firebase onboarding class instance
      if (!onBoardStrategy.expectingSMSVerificationCode) {
        log.warn(
            'Onboarding service is not expecting an SMS Verification code! We will try to verify anyways with code: ${verificationCodeDetails.verificationCode}');
      }
      await onBoardStrategy.verify(
        store,
        verificationCodeDetails.verificationCode,
      );
      return true;
    } else if (verificationCodeDetails is EmailVerificationLinkDetails) {
      log.error('Verification emails not implemented yet!');
      return false;
    } else {
      log.error(
          'Unknown verification code type passed [$verificationCodeDetails]!');
      return false;
    }
  }

  Future<bool> verifyEmailLinkCallback({
    required String emailAddress,
    required String emailLink,
  }) async {
    final store = await reduxStore;
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
      return false;
    } on Exception catch (e, s) {
      await _captureAuthenticationError(
        title: 'Invalid firebase credentials',
        message: 'Error with getIdToken for a firebase user: $e',
        methodName: '_loginToVegiWithEmail',
        e: e,
        s: s,
        signUpErrCode: SignUpErrCode.invalidCredentials,
      );
      return false;
    }
    await _loginToVegiWithEmail(
      store: store,
      email: emailAddress,
      firebaseSessionToken: firebaseSessionToken!,
    );
    store.dispatch(
      SignupLoading(
        isLoading: false,
      ),
    );
    return true;
  }

  Future<bool> isLoggedIn() async {
    final store = await reduxStore;
    final us = store.state.userState;
    return !store.state.userState.isLoggedOut &&
        us.fuseAuthenticationStatus == FuseAuthenticationStatus.authenticated &&
        us.firebaseAuthenticationStatus ==
            FirebaseAuthenticationStatus.authenticated &&
        us.vegiAuthenticationStatus == VegiAuthenticationStatus.authenticated;
  }

  Future<void> logout({
    bool bypassSeedPhraseCheck = false,
  }) async {
    final store = await reduxStore;
    if (store.state.userState.hasSavedSeedPhrase || bypassSeedPhraseCheck) {
      store.dispatch(LogoutRequestSuccess());
      await rootRouter.replace(const OnBoardScreen());
      await Analytics.track(eventName: AnalyticsEvents.logout);
      return;
    }
    await rootRouter.pop();
    await rootRouter.push(const ShowUserMnemonic());
    return;
  }

  Future<void> deregisterUser() async {
    await peeplEatsService.deleteAllUserDetails();
    await logout();
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
    var _title = title;
    if (_title.isEmpty) {
      _title = 'Authentication error';
    }
    final codeStr = signUpErrCode == null ? '' : '[Code=$signUpErrCode]';
    log.error(
      '*$_title* $codeStr $message (in $className.$methodName())',
      error: e,
      stackTrace: s,
    );
    store
      ..dispatch(
        SignupLoading(
          isLoading: false,
        ),
      )
      ..dispatch(
        SignUpErrorDetails(
          title: _title,
          message: message,
          code: signUpErrCode,
        ),
      );
  }

  Future<void> _loginToFuse({
    void Function()? onWalletInitialised,
    List<String>? useMnemonicWords,
  }) async {
    final store = await reduxStore;
    if (store.state.userState.fuseAuthenticationStatus ==
        FuseAuthenticationStatus.authenticated) {
      // return true;
      onWalletInitialised?.call();
      return;
    }
    await _initFuseWallet(
      store,
      onWalletInitialised: onWalletInitialised,
      useMnemonicWords: useMnemonicWords,
    );
  }
  // Future<bool> _loginToFuse({
  //   void Function()? onWalletInitialised,
  // }) async {
  //   final store = await reduxStore;
  //   if (store.state.userState.fuseAuthenticationStatus ==
  //       FuseAuthenticationStatus.authenticated) {
  //     return true;
  //   }
  //   final newFuseAuthStatus = await _initFuseWallet(
  //     store,
  //     onWalletInitialised: onWalletInitialised,
  //   );
  //   if (store.state.userState.fuseAuthenticationStatus ==
  //       FuseAuthenticationStatus.loading) {
  //     log.warn(
  //         'user_actions._initFuseWallet didnt finish, still loading...; the _initFuseWallet returned -> FuseAuthenticationStatus.[${newFuseAuthStatus.name}] and store has state: FuseAuthenticationStatus.[${store.state.userState.fuseAuthenticationStatus.name}]');
  //     return false;
  //   } else if (![
  //     FuseAuthenticationStatus.authenticated,
  //     FuseAuthenticationStatus.created,
  //     FuseAuthenticationStatus.creationStarted,
  //     FuseAuthenticationStatus.creationSucceeded,
  //   ].contains(store.state.userState.fuseAuthenticationStatus)) {
  //     log.warn(
  //         'Fuse init pipeline did not work... the _initFuseWallet returned -> FuseAuthenticationStatus.[${newFuseAuthStatus.name}] and store has state: FuseAuthenticationStatus.[${store.state.userState.fuseAuthenticationStatus.name}]');
  //     await _captureAuthenticationError(
  //       title: 'Wallet not created',
  //       message: 'Failed to create / fetch fuse wallet in Authentication flow',
  //       methodName: '_loginToFuse',
  //       signUpErrCode: SignUpErrCodeHelpers.fromFuseErrCode(
  //         store.state.userState.fuseAuthenticationStatus,
  //       ),
  //     );
  //     return false;
  //   }
  //   return true;
  // }

  Future<UserCredential?> _signInToOnboardingProviderWithEmail({
    required String email,
    required String password,
  }) async {
    // final store = await reduxStore;
    return onBoardStrategy.signInUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Wrapper function around the firebase.signInUserBySendingEmailLink method
  Future<bool> requestEmailLinkForEmailAddress({
    required String email,
  }) async {
    final store = await reduxStore;
    store.dispatch(
      SignupLoading(
        isLoading: true,
      ),
    );
    final emailSent = await onBoardStrategy.signInUserBySendingEmailLink(
      email: email,
    );
    if (emailSent) {
      store.dispatch(
        SignupLoading(
          isLoading: false,
        ),
      );
    } else {
      store.dispatch(
        SignupLoading(
          isLoading: false,
        ),
      );
    }
    return true;
  }

  Future<bool> _requestSMSCodeForPhoneNumber({
    required CountryCode countryCode,
    required PhoneNumber phoneNumber,
  }) async {
    bool _useWeb3Auth = false;
    final store = await reduxStore;
    try {
      store.dispatch(setDevicePhoneNumberForId(phoneNumber.e164));
      await Analytics.setUserId(phoneNumber.e164);
      // TODO: Replace this with a dispatch to this._authenticate and integrate test this method
      // return _authenticate()
      // * Firebase login -> will route to verify_screen
      await onBoardStrategy.login(
        store,
        phoneNumber.e164,
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
      //         _complete(
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
      //         _complete(
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
          SignupFailed(
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

  Future<void> verifySMSVerificationCode(
    String verificationCode,
  ) async {
    final store = await reduxStore;
    await onBoardStrategy.verify(
      store,
      verificationCode,
    );
    // todo: add loginToVegiCall
  }

  // @override
  Future<LoggedInToVegiResult> _loginToVegiWithPhone({
    required Store<AppState> store,
    required String phoneNumber,
    required String firebaseSessionToken,
  }) async {
    try {
      store.dispatch(
        SetUserAuthenticationStatus(
          vegiStatus: VegiAuthenticationStatus.loading,
        ),
      );
      // * sets the session cookie on the service class instance.
      final vegiSession = await peeplEatsService.loginWithPhone(
        phoneNumber: phoneNumber,
        firebaseSessionToken: firebaseSessionToken,
        rememberMe: true,
      );
      final userDetails = vegiSession.user;
      if (vegiSession.sessionCookie.isNotEmpty) {
        _complete(
          vegiStatus: VegiAuthenticationStatus.authenticated,
        );
        store.dispatch(isBetaWhitelistedAddress());
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
        _complete(
          vegiStatus: VegiAuthenticationStatus.failed,
        );
      }
      return vegiSession.sessionCookie.isNotEmpty
          ? LoggedInToVegiResult.success
          : LoggedInToVegiResult.failedEmptySessionCookie;
    } catch (err) {
      _complete(
        firebaseStatus: FirebaseAuthenticationStatus.authenticated,
        vegiStatus: VegiAuthenticationStatus.failed,
      );
      log
        ..error(
          err,
          stackTrace: StackTrace.current,
        )
        ..error(err.toString());
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
    try {
      store.dispatch(
        SetUserAuthenticationStatus(
          vegiStatus: VegiAuthenticationStatus.loading,
        ),
      );

      // * sets the session cookie on the service class instance.
      final vegiSession = await peeplEatsService.loginWithEmail(
        emailAddress: email,
        firebaseSessionToken: firebaseSessionToken,
        rememberMe: true,
      );
      final userDetails = vegiSession.user;
      if (vegiSession.sessionCookie.isNotEmpty) {
        _complete(
          vegiStatus: VegiAuthenticationStatus.authenticated,
        );
        store.dispatch(isBetaWhitelistedAddress());
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
        _complete(
          vegiStatus: VegiAuthenticationStatus.failed,
        );
      }
      return vegiSession.sessionCookie.isNotEmpty
          ? LoggedInToVegiResult.success
          : LoggedInToVegiResult.failedEmptySessionCookie;
    } catch (err) {
      _complete(
        firebaseStatus: FirebaseAuthenticationStatus.authenticated,
        vegiStatus: VegiAuthenticationStatus.failed,
      );
      log
        ..error(
          err,
          stackTrace: StackTrace.current,
        )
        ..error(err.toString());
      store.dispatch(
        SetFirebaseSessionToken(
          firebaseSessionToken: null,
        ),
      );
      return LoggedInToVegiResult.failed;
    }
  }

  void _complete({
    FirebaseAuthenticationStatus? firebaseStatus,
    VegiAuthenticationStatus? vegiStatus,
    FuseAuthenticationStatus? fuseStatus,
  }) async =>
      (await reduxStore)
        ..dispatch(
          SignupLoading(isLoading: false),
        )
        ..dispatch(
          SetUserAuthenticationStatus(
            firebaseStatus: firebaseStatus,
            vegiStatus: vegiStatus,
            fuseStatus: fuseStatus,
          ),
        );

  Future<void> _loginToVegi({
    PageRouteInfo<dynamic>? routeOnSuccessArg,
    bool shouldReplaceAllRouteStack = true,
  }) async {
    final store = await reduxStore;
    PageRouteInfo<dynamic> routeOnSuccess;
    if (store.state.userState.displayName.isEmpty) {
      routeOnSuccess = UserNameScreen();
    } else if (store.state.userState.authType == BiometricAuth.none) {
      routeOnSuccess = const ChooseSecurityOption();
    } else {
      routeOnSuccess = routeOnSuccessArg ?? const MainScreen();
    }
    if (store.state.onboardingState.signupIsInFlux) {
      log.warn(
        'Authentication already in flux, ignoring subsequent request',
        stackTrace: StackTrace.current,
      );
      return;
    }
    store.dispatch(SignupLoading(isLoading: true));

    try {
      final sessionIsValid = await _checkIfVegiSessionIsValid(store);
      if (!sessionIsValid) {
        if (store.state.userState.preferredSignonMethod ==
            PreferredSignonMethod.phone) {
          final vegiAuthResult = await _loginToVegiWithPhone(
            store: store,
            phoneNumber: store.state.userState.phoneNumber,
            firebaseSessionToken: store.state.userState.firebaseSessionToken!,
          );
          if (vegiAuthResult != LoggedInToVegiResult.success) {
            log.warn(
                'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]');
            // finish by navigating to MainScreen regardless
          }
        } else if (store.state.userState.preferredSignonMethod ==
            PreferredSignonMethod.phone) {
          final vegiAuthResult = await _loginToVegiWithPhone(
            store: store,
            phoneNumber: store.state.userState.phoneNumber,
            firebaseSessionToken: store.state.userState.firebaseSessionToken!,
          );
          if (vegiAuthResult != LoggedInToVegiResult.success) {
            log.warn(
                'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]');
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
                'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]');
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
                'Failed to authenticate with vegi: LoggedInToVegiResult.[${vegiAuthResult.name}]');
            // finish by navigating to MainScreen regardless
          }
        } else {
          final errMessage =
              'Unable to signin with firebaseSignOn method of: PreferredSignonMethod.[${store.state.userState.preferredSignonMethod.name}]';
          log.error(errMessage, stackTrace: StackTrace.current);
          store
            ..dispatch(SignupLoading(isLoading: false))
            ..dispatch(
              SignupFailed(
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

      if (store.state.userState.isLoggedOut) {
        store.dispatch(SetReLoggedin());
      }
      store.dispatch(SignupLoading(isLoading: false));
      if (shouldReplaceAllRouteStack) {
        await rootRouter.replaceAll([routeOnSuccess]);
      } else {
        await rootRouter.push(routeOnSuccess);
      }
      return;
    } catch (e, s) {
      log.error(
        'ERROR - authenticate $e',
        stackTrace: s,
      );
      store.dispatch(SignupLoading(isLoading: false));
    }
  }

  /// Function to first create the single External Owner Account that can have at most
  /// ONE smart wallet linked with it.
  ///
  /// Then init Firebase Credentials if needed (they cannot be serialized and not persisted, therefore needs to be done on ever recreation of persisted store)
  ///
  /// Then authenticate with vegi if not already signed in with persistent sessionCookie that is still active.
  Future<void> _authenticate({
    PageRouteInfo<dynamic>? routeOnSuccessArg,
    bool shouldReplaceAllRouteStack = true,
  }) async {
    final store = await reduxStore;
    PageRouteInfo<dynamic> routeOnSuccess;
    if (store.state.userState.displayName.isEmpty) {
      routeOnSuccess = UserNameScreen();
    } else if (store.state.userState.authType == BiometricAuth.none) {
      routeOnSuccess = const ChooseSecurityOption();
    } else {
      routeOnSuccess = routeOnSuccessArg ?? const MainScreen();
    }
    if (store.state.onboardingState.signupIsInFlux) {
      log.warn(
        'Authentication already in flux, ignoring subsequent request',
        stackTrace: StackTrace.current,
      );
      return;
    }
    store.dispatch(SignupLoading(isLoading: true));

    // * Fuse Auth & Fetch
    try {
      await initFuse();
    } on Exception catch (e, s) {
      log.error(
        'Failed to login to Fuse SDK with error: $e',
        stackTrace: s,
      );
      store.dispatch(SignupLoading(isLoading: false));
      return;
    }

    try {
      // * Firebase Auth Router / Reauthentication
      // reauth if not already authenticated with firebase / navigate to sign+up screen if no credentials present
      if (store.state.userState.firebaseSessionToken?.isEmpty ?? true) {
        // TODO: Ensure that the onboarding.verify function sets this
        if (store.state.userState.firebaseCredentialIsValid) {
          store.dispatch(SignupLoading(isLoading: true));
          final reauthSucceeded = await onBoardStrategy.reauthenticateUser();
          store.dispatch(SignupLoading(isLoading: false));
          if (!reauthSucceeded) {
            store
              ..dispatch(
                SetUserAuthenticationStatus(
                  firebaseStatus:
                      FirebaseAuthenticationStatus.beginAuthentication,
                ),
              )
              ..dispatch(SignupLoading(isLoading: false));
            return routeToLoginScreen();
          }
        } else {
          // unable to reauth firebase so nav to SignUpScreen and return;
          store
            ..dispatch(
              SetUserAuthenticationStatus(
                firebaseStatus:
                    FirebaseAuthenticationStatus.beginAuthentication,
              ),
            )
            ..dispatch(SignupLoading(isLoading: false));
          return routeToLoginScreen();
        }
      }
    } catch (e, s) {
      log.error(
        'Failed to authenticate with firebase from Authentication._authenticate',
        stackTrace: s,
      );
      store.dispatch(SignupLoading(isLoading: false));
      return;
    }

    // * vegi Auth
    // use firebaseAuth SessionToken to authenticate vegi. From here we are sure that firebaseSessionToken is live.
    await _loginToVegi(
      routeOnSuccessArg: routeOnSuccessArg,
      shouldReplaceAllRouteStack: shouldReplaceAllRouteStack,
    );
  }

  /// Function to create the single External Owner Account that can have at most
  /// ONE smart wallet linked with it.
  Future<void> _initFuseWallet(
    Store<AppState> store, {
    void Function()? onWalletInitialised,
    List<String>? useMnemonicWords,
  }) async {
    store
      ..dispatch(
        SetUserAuthenticationStatus(
          fuseStatus: FuseAuthenticationStatus.loading,
        ),
      )
      ..dispatch(SignupLoading(isLoading: true));
    late final EthPrivateKey credentials;
    // * Fuse - Create PrivateKey
    if (store.state.userState.privateKey.isEmpty) {
      final String mnemonic = useMnemonicWords != null
          ? useMnemonicWords.join(' ')
          : Mnemonic.generate();
      final privateKey = Mnemonic.privateKeyFromMnemonic(mnemonic);
      //! await peeplEatsService.backupUserSK(privateKey);
      credentials = EthPrivateKey.fromHex(privateKey);
      final EthereumAddress accountAddress = credentials.address;
      store.dispatch(
        CreateLocalAccountSuccess(
          mnemonic.split(' '),
          privateKey,
          credentials,
          // accountAddress.toString(),
        ),
      );
      await Analytics.track(
        eventName: AnalyticsEvents.createWallet,
      );
    } else {
      credentials = EthPrivateKey.fromHex(store.state.userState.privateKey);
    }

    final authSucceeded = await authenticateSDK(
      store,
      credentials: credentials,
    );
    if (!authSucceeded) {
      // return FuseAuthenticationStatus.failedAuthentication;
      store.dispatch(SignupLoading(isLoading: false));
      return;
    }

    // * FUSE - Fetch/Create Wallet from FuseSDK
    try {
      // if (store.state.userState.jwtToken.isEmpty) {
      // }

      // Try to fetch a wallet for the EOA, if it doesn't exist create one
      // ! BUG when fetching wallet, are we trying to fetch the wallet too quickly?
      // ! _Exception (Exception: DioError [bad response]: The request returned an invalid status code of 500.)
      await _fetchCreateWallet(onWalletInitialised: onWalletInitialised);
      // _oldFetchCreateWallet();
      // return store.state.userState.fuseAuthenticationStatus;
      store.dispatch(SignupLoading(isLoading: false));
      return;
    } catch (e, s) {
      log.error(
        'ERROR - fetchFuseSmartWallet',
        error: e,
        stackTrace: s,
      );
      store
        ..dispatch(
          SetUserAuthenticationStatus(
            fuseStatus: FuseAuthenticationStatus.failedFetch,
          ),
        )
        ..dispatch(
          SignupLoading(
            isLoading: false,
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

  void _emitWallet(SmartWallet userWallet) async {
    final store = await reduxStore;
    store
      ..dispatch(
        saveSmartWallet(
          smartWallet: userWallet,
        ),
      )
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
        SignupLoading(
          isLoading: false,
        ),
      );
  }

  Future<void> _oldFetchCreateWallet() async {
    final store = await reduxStore;
    final walletData = await fuseWalletSDK.fetchWallet();
    if (walletData.hasData) {
      final smartWallet = walletData.data!;
      log.info(
          'Successfully refetched smart wallet address ${smartWallet.smartWalletAddress}');
      store
        ..dispatch(
          saveSmartWallet(
            smartWallet: fuseWalletSDK.smartWallet,
          ),
        )
        ..dispatch(
          SignupLoading(
            isLoading: false,
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
          store.dispatch(
            SignupLoading(
              isLoading: false,
            ),
          );
          // return FuseAuthenticationStatus.failedAuthentication;
          return;
        }
      }
      final tryCreateWalletStatus = await _tryCreateWallet(store);
      if (tryCreateWalletStatus == FuseAuthenticationStatus.authenticated) {
        store.dispatch(
          SignupLoading(
            isLoading: false,
          ),
        );
        // return tryCreateWalletStatus;
        return;
      }
      // Try to REfetch wallet for the EOA, if it doesn't exist create one

      final walletDataReFetched = await fuseWalletSDK.fetchWallet();
      if (walletDataReFetched.hasData) {
        final smartWallet = walletDataReFetched.data!;
        log.info(
            'Successfully refetched smart wallet address ${smartWallet.smartWalletAddress}');
        _emitWallet(fuseWalletSDK.smartWallet);
      } else if (walletDataReFetched.hasError) {
        final exception = walletDataReFetched.error!;
        if (exception.toString().contains('LateInit')) {
          store
            ..dispatch(
              SetUserAuthenticationStatus(
                fuseStatus: FuseAuthenticationStatus
                    .failedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt,
              ),
            )
            ..dispatch(
              SignupLoading(
                isLoading: false,
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
  }) async {
    final store = await reduxStore;
    // Try to fetch a wallet for the EOA, if it doesn't exist create one
    final walletData = await fuseWalletSDK.fetchWallet();
    walletData.pick(
      onData: (SmartWallet smartWallet) async {
        log.info(
            'fuseWalletSDK.fetchWallet succeeded with Smart wallet address "${smartWallet.smartWalletAddress}"');
        // set the smart wallet on the store on an ignore propetrty of the state (i.e. not serialized, just memory & set fuse auth to true)
        // then write a helper method next that listens for exactly that store update with signature (newStore, oldStore?) that can be called by each viewmodel...
        _emitWallet(smartWallet);
        onWalletInitialised?.call();
      },
      onError: (Exception exception) async {
        log
            // ..error(
            //     'fuseWalletSDK.fetchWallet failed to fetch fuse smart wallet with error: "$exception"')
            .info(
                'Authenticator._fetchCreateWallet trying to create a new fuse smart wallet as failed to fetch...');
        store
          ..dispatch(
            SetUserAuthenticationStatus(
              fuseStatus: FuseAuthenticationStatus.loading,
            ),
          )
          ..dispatch(
            SignupLoading(
              isLoading: true,
            ),
          );
        final exceptionOrStream = await fuseWalletSDK.createWallet();
        if (exceptionOrStream.hasError) {
          log.error(
            'fuseWalletSDK.createWallet failed with error: "${exceptionOrStream.error}"',
            error: exceptionOrStream.error,
            stackTrace: StackTrace.current,
          );
        } else if (exceptionOrStream.hasData) {
          final smartWalletEventStream = exceptionOrStream.data!;
          smartWalletEventStream.listen(
            (SmartWalletEvent event) {
              switch (event.name) {
                case "smartWalletCreationStarted":
                  log.info('smartWalletCreationStarted');
                  break;
                case "transactionHash":
                  log.info(
                      'smartWallet.Create.transactionHash "${event.data}"');
                  break;
                case "smartWalletCreationSucceeded":
                  log.info('smartWalletCreationSucceeded ${event.data}');
                  _emitWallet(SmartWallet.fromJson(event.data));
                  onWalletInitialised?.call();
                  break;
                case "smartWalletCreationFailed":
                  log.error(
                      'fuseWalletSDK.createWallet transaction stream failed on chain with error ${event.data}');
                  store
                    ..dispatch(
                      SetUserAuthenticationStatus(
                        fuseStatus: FuseAuthenticationStatus.failedCreate,
                      ),
                    )
                    ..dispatch(
                      SignupLoading(
                        isLoading: false,
                      ),
                    );
                  break;
              }
            },
            onError: (error) {
              log.error(
                  'Authentication._fetchCreateWallet fuseWalletSDK.createWallet Error occurred: $error');
              store
                ..dispatch(
                  SetUserAuthenticationStatus(
                    fuseStatus: FuseAuthenticationStatus.failedCreate,
                  ),
                )
                ..dispatch(
                  SignupLoading(
                    isLoading: false,
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
    if (forceCreateNew != true) {
      final walletDataReFetched = await fuseWalletSDK.fetchWallet();
      if (walletDataReFetched.hasData) {
        final smartWallet = walletDataReFetched.data!;
        log.info(
            'Successfully refetched smart wallet address ${smartWallet.smartWalletAddress} so no need to create a new wallet as requested');
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
      );
    }
    // we move to createWallet call below
    store.dispatch(
      SetUserAuthenticationStatus(
        fuseStatus: FuseAuthenticationStatus.createWalletForEOA,
      ),
    );

    try {
      final _smartWallet = fuseWalletSDK.smartWallet;
      store
        ..dispatch(
          saveSmartWallet(
            smartWallet: _smartWallet,
          ),
        )
        ..dispatch(
          SetUserAuthenticationStatus(
            fuseStatus: FuseAuthenticationStatus.authenticated,
          ),
        );
      return FuseAuthenticationStatus.authenticated;
    } catch (e, s) {
      // TODO
      // do nothing
    }

    final walletCreationResult = await fuseWalletSDK.createWallet();
    if (walletCreationResult.hasData) {
      store
        ..dispatch(
          SetUserAuthenticationStatus(
            fuseStatus: FuseAuthenticationStatus.created,
          ),
        )
        ..dispatch(
          SignupLoading(
            isLoading: false,
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
            log.info('transactionHash ${event.data}');
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
                  event.data['networks'] as Iterable<dynamic>);
            }
            final fuseSDKVersion = event.data['version'];
            log.info(
                'smartWalletCreationSucceeded with smartwalletaddress: "$smartWalletAddress"');

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
                    'Successfully refetched smart wallet address ${smartWallet.smartWalletAddress}');
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
        sentry: true,
        sentryHint: errStr,
      );
      store
        ..dispatch(
          SetUserAuthenticationStatus(
            fuseStatus: FuseAuthenticationStatus.failedCreate,
          ),
        )
        ..dispatch(
          SignupLoading(
            isLoading: false,
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
    final store = await reduxStore;
    try {
      if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.emailAndPassword) {
        log.info(
            'ReplaceAll with SignUpWithEmailAndPasswordScreen() from ${rootRouter.current.name} in authenticate thunk.');
        await rootRouter.replaceAll(
          [const SignUpWithEmailAndPasswordScreen()],
        );
      } else if (store.state.userState.preferredSignonMethod ==
          PreferredSignonMethod.emailLink) {
        log.info(
            'ReplaceAll with SignUpEmailLinkScreen() from ${rootRouter.current.name} in authenticate thunk.');
        await rootRouter.replaceAll(
          [const SignUpEmailLinkScreen()],
        );
      } else {
        log.info(
            'ReplaceAll with SignUpScreen() from ${rootRouter.current.name} in authenticate thunk.');
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
    try {
      store.dispatch(
        SignupLoading(
          isLoading: true,
        ),
      );
      final sessionStillValid =
          await peeplEatsService.checkVegiSessionIsStillValid();
      if (sessionStillValid) {
        store
          ..dispatch(
            SignupLoading(
              isLoading: false,
            ),
          )
          ..dispatch(
            SetUserAuthenticationStatus(
              firebaseStatus: FirebaseAuthenticationStatus.authenticated,
              vegiStatus: VegiAuthenticationStatus.authenticated,
            ),
          );
        return sessionStillValid;
      } else {
        store
          ..dispatch(
            SignupLoading(
              isLoading: false,
            ),
          )
          ..dispatch(
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
