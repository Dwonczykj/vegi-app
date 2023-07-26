import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:auto_route/src/route/page_route_info.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/common/network/web3auth.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/analytics_props.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/onboard/Istrategy.dart';

import 'package:google_sign_in/google_sign_in.dart';

class FirebaseStrategy implements IOnBoardStrategy {
  FirebaseStrategy({this.strategy = OnboardStrategy.firebase});

  @override
  OnboardStrategy strategy;

  void _complete({
    required Store<AppState> store,
    FirebaseAuthenticationStatus? firebaseStatus,
    VegiAuthenticationStatus? vegiStatus,
    FuseAuthenticationStatus? fuseStatus,
  }) =>
      store
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

  bool expectingSMSVerificationCode = false;

  @override
  Future<void> login({
    required CountryCode countryCode,
    required PhoneNumber phoneNumber,
  }) async {
    final store = await reduxStore;
    store
      ..dispatch(
        SignupLoading(
          isLoading: true,
        ),
      )
      ..dispatch(
        SetPreferredSignOnMethod(
          preferredSignonMethod: PreferredSignonMethod.phone,
        ),
      )
      ..dispatch(
        SetUserAuthenticationStatus(
          firebaseStatus: FirebaseAuthenticationStatus.loading,
        ),
      );

    void codeSent(
      String verificationId, [
      int? forceResendingToken,
    ]) {
      log.info('PhoneCodeSent verificationId: $verificationId');
      store
        ..dispatch(SetFirebaseCredentials(null))
        ..dispatch(SignupLoading(isLoading: false))
        ..dispatch(SetVerificationId(verificationId));
      rootRouter.push(VerifyPhoneNumber(verificationId: verificationId));
    }

    /// * This handler will only be called on Android devices which support automatic SMS code resolution.
    /// ~ https://firebase.google.com/docs/auth/flutter/phone-auth#verificationcompleted
    Future<void> automaticPlayAPIVerificationCompleted(
      AuthCredential credentials,
    ) async {
      await _completeVerification(
        store,
        credentials,
      );
    }

    Future<void> verificationFailed(FirebaseAuthException authException) async {
      log
        ..info('Phone number verification failed.')
        ..info('Code: ${authException.code}.')
        ..info('Message: ${authException.message}');

      unawaited(
        Analytics.track(
          eventName: AnalyticsEvents.loginWithPhone,
          properties: {
            AnalyticsProps.status: AnalyticsProps.failed,
            'error': authException.message,
          },
        ),
      );
      await Sentry.captureException(
        authException,
        stackTrace: StackTrace.current, // from catch (e, s)
        hint: 'ERROR - verificationFailed ${authException.message}',
      );

      if (authException.code == 'too-many-requests') {
        store.dispatch(
          SignupFailed(
            error: SignUpErrorDetails(
              title: 'Authentication Issue',
              message:
                  'Too many signin requests made from this device. Please try again later.',
            ),
          ),
        );
        return _complete(
          store: store,
          firebaseStatus:
              FirebaseAuthenticationStatus.phoneAuthFailedTooManyRequests,
        );
      }
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: 'Authentication Issue',
            message: authException.message ?? '',
          ),
        ),
      );
      return _complete(
        store: store,
        firebaseStatus:
            FirebaseAuthenticationStatus.phoneAuthReauthenticationFailed,
      );
    }

    // final confirmationResult = await firebaseAuth.signInWithPhoneNumber(
    //   phoneNumber!,
    // );

    // if(confirmationResult.confirm(verificationCode))
    store.dispatch(
      SetPhoneNumberSuccess(
        countryCode: countryCode,
        phoneNumber: phoneNumber,
      ),
    );
    expectingSMSVerificationCode = true;
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber.e164,
      codeSent: codeSent,
      verificationFailed: verificationFailed,
      verificationCompleted:
          automaticPlayAPIVerificationCompleted, // * This handler will only be called on Android devices which support automatic SMS code resolution.
      codeAutoRetrievalTimeout: (String verificationId) {
        return _complete(
          store: store,
          firebaseStatus: FirebaseAuthenticationStatus.phoneAuthTimedOut,
        );
      },
    );
    // if (phoneNumber != null) {
    // } else {
    //   // return _complete(
    //   //   store: store,
    //   //   firebaseStatus: FirebaseAuthenticationStatus.invalidPhoneNumber,
    //   // );
    // }
  }

  @override
  Future<void> signout() async {
    return firebaseAuth.signOut();
  }

  @override
  Future<UserCredential?> verify(
    Store<AppState> store,
    String verificationCode,
  ) async {
    store
      ..dispatch(
        SignupLoading(isLoading: true),
      )
      ..dispatch(
        SetUserAuthenticationStatus(
          firebaseStatus: FirebaseAuthenticationStatus.loading,
        ),
      );
    AuthCredential? credentials;
    try {
      credentials = store.state.userState.firebaseCredentials;
      final String verificationId = store.state.userState.verificationId ?? '';
      credentials ??= PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );
    } on FirebaseAuthException catch (e, s) {
      await _catchFirebaseException(
        e,
        s,
        additionalMessage:
            'Error fetching phone auth credentials from phone verification id and smsCode tfa pair',
        firebaseStatusIfNotHandled:
            FirebaseAuthenticationStatus.phoneAuthVerificationFailed,
      );
      return null;
    } on Exception catch (e, s) {
      await _catchUnknownException(
        e,
        s,
        additionalMessage:
            'Error fetching phone auth credentials from phone verification id and smsCode tfa pair',
        firebaseStatusIfNotHandled:
            FirebaseAuthenticationStatus.phoneAuthVerificationFailed,
      );
      return null;
    }

    return _completeVerification(
      store,
      credentials,
    );
  }

  @override
  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final store = await reduxStore;
    store.dispatch(
      SignupLoading(
        isLoading: true,
      ),
    );
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _processSigninEmailAndPassword(
        store,
        credential,
      );
      return credential;
    } on FirebaseAuthException catch (e, s) {
      await _catchFirebaseException(e, s);
    } on Exception catch (e, s) {
      log.error(
        e,
        stackTrace: s,
      );
      await _catchUnknownException(e, s);
    }
    return null;
  }

  @override
  Future<UserCredential?> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final store = await reduxStore;
    store
      ..dispatch(
        SignupLoading(
          isLoading: true,
        ),
      )
      ..dispatch(
        SetPreferredSignOnMethod(
          preferredSignonMethod: PreferredSignonMethod.emailAndPassword,
        ),
      );
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      store.dispatch(
        SetEmailPassword(
          email: email,
          password: password,
        ),
      );
      await _processSigninEmailAndPassword(
        store,
        credential,
      );
      return credential;
    } on FirebaseAuthException catch (e, s) {
      await _catchFirebaseException(e, s);
    }
    return null;
  }

  @override
  Future<bool> signInUserBySendingEmailLink({
    required String email,
  }) async {
    final store = await reduxStore;
    store
      ..dispatch(
        SignupLoading(
          isLoading: true,
        ),
      )
      ..dispatch(
        SetPreferredSignOnMethod(
          preferredSignonMethod: PreferredSignonMethod.emailLink,
        ),
      );
    try {
      await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: await _getActionCodeSettingsForEmailLink(
          email: email,
        ),
      );
    } on FirebaseAuthException catch (e, s) {
      await _catchFirebaseException(e, s);
      return false;
    } on Exception catch (e, s) {
      await _catchUnknownException(e, s);
      return false;
    }
    return true;
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    final store = await reduxStore;
    store
      ..dispatch(
        SignupLoading(
          isLoading: true,
        ),
      )
      ..dispatch(
        SetPreferredSignOnMethod(
          preferredSignonMethod: PreferredSignonMethod.google,
        ),
      );
    try {
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider()
          // ..addScope('https://www.googleapis.com/auth/contacts.readonly')
          ..setCustomParameters({'login_hint': 'user@example.com'});

        // Once signed in, return the UserCredential
        final userCredential =
            await FirebaseAuth.instance.signInWithPopup(googleProvider);

        // Or use signInWithRedirect
        // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);

        await _processSigninEmailAndPassword(store, userCredential);

        return userCredential;
      }

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return _completeVerification(
        store,
        credential,
      );
    } on FirebaseAuthException catch (e, s) {
      await _catchFirebaseException(e, s);
      return null;
    } on Exception catch (e, s) {
      log.error(
        e,
        stackTrace: s,
      );
      await Sentry.captureException(
        e,
        stackTrace: s, // from catch (err, s)
        hint: 'ERROR - firebase.dart.signInWithGoogle $e',
      );
      return null;
    }
  }

  @override
  Future<UserCredential?> signInWithApple() async {
    final store = await reduxStore;
    store
      ..dispatch(
        SignupLoading(
          isLoading: true,
        ),
      )
      ..dispatch(
        SetPreferredSignOnMethod(
          preferredSignonMethod: PreferredSignonMethod.apple,
        ),
      );
    try {
      final appleProvider = AppleAuthProvider();
      late final UserCredential userCredential;
      if (kIsWeb) {
        userCredential =
            await FirebaseAuth.instance.signInWithPopup(appleProvider);
      } else {
        userCredential =
            await FirebaseAuth.instance.signInWithProvider(appleProvider);
      }
      await _processSigninEmailAndPassword(store, userCredential);
      return userCredential;
    } on FirebaseAuthException catch (e, s) {
      await _catchFirebaseException(e, s);
      return null;
    } on Exception catch (e, s) {
      log.error(
        e,
        stackTrace: s,
      );
      await Sentry.captureException(
        e,
        stackTrace: s, // from catch (err, s)
        hint: 'ERROR - firebase.dart.signInWithApple $e',
      );
      return null;
    }
  }

  Future<UserCredential?> _completeVerification(
    Store<AppState> store,
    AuthCredential credentials,
  ) async {
    store.dispatch(SetFirebaseCredentials(credentials));
    late final UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.signInWithCredential(
        credentials,
      );
    } on FirebaseAuthException catch (e, s) {
      log.error(e, stackTrace: s);
      await Analytics.track(
        eventName: AnalyticsEvents.verify,
        properties: {
          AnalyticsProps.status: AnalyticsProps.failed,
          'error': e.toString(),
        },
      );
      await Sentry.captureException(
        Exception('Error in verify phone number: ${e.toString()}'),
        stackTrace: s,
        hint: 'Error while phone number verification',
      );
      await _catchFirebaseException(
        e,
        s,
        additionalMessage:
            'Error signing into firebase with provided credentials',
        firebaseStatusIfNotHandled:
            FirebaseAuthenticationStatus.phoneAuthReauthenticationFailed,
      );
      return null;
    } on Exception catch (e, s) {
      await Analytics.track(
        eventName: AnalyticsEvents.verify,
        properties: {
          AnalyticsProps.status: AnalyticsProps.failed,
          'error': e.toString(),
        },
      );
      await Sentry.captureException(
        Exception('Error in verify phone number: $e'),
        stackTrace: s,
        hint: 'Error while phone number verification',
      );
      await _catchUnknownException(
        e,
        s,
        additionalMessage:
            'Error signing into firebase with provided credentials',
        firebaseStatusIfNotHandled:
            FirebaseAuthenticationStatus.phoneAuthReauthenticationFailed,
      );
      return null;
    }
    await _processSigninPhoneNumber(store, userCredential);
    return userCredential;
  }

  Future<String?> _processFirebaseSignin(
    Store<AppState> store,
    UserCredential userCredential,
  ) async {
    late final User? user;
    late final String? firebaseSessionToken;
    try {
      user = userCredential.user;
      firebaseSessionToken = await user?.getIdToken();
    } on FirebaseAuthException catch (e, s) {
      log.error(e, stackTrace: s);
      await _catchFirebaseException(
        e,
        s,
        additionalMessage: 'Error with getIdToken for a firebase user',
        firebaseStatusIfNotHandled:
            FirebaseAuthenticationStatus.userGetIdTokenFailed,
      );
      store.dispatch(
        SignupLoading(
          isLoading: false,
        ),
      );
      return null;
    } on Exception catch (e, s) {
      await _catchUnknownException(
        e,
        s,
        additionalMessage: 'Error with getIdToken for a firebase user',
        firebaseStatusIfNotHandled:
            FirebaseAuthenticationStatus.userGetIdTokenFailed,
      );
      store.dispatch(
        SignupLoading(
          isLoading: false,
        ),
      );
      return null;
    }
    store.dispatch(
      SetFirebaseSessionToken(
        firebaseSessionToken: firebaseSessionToken,
      ),
    );

    if (firebaseSessionToken == null) {
      log.error(
        'Firebase did not authenticate user using phone auth credentials in onboarding',
        stackTrace: StackTrace.current,
      );
      _complete(
        store: store,
        firebaseStatus:
            FirebaseAuthenticationStatus.phoneAuthVerificationFailed,
      );
      store.dispatch(
        SignupLoading(
          isLoading: false,
        ),
      );
      return null;
    } else {
      store.dispatch(
        SetUserAuthenticationStatus(
          firebaseStatus: FirebaseAuthenticationStatus.authenticated,
        ),
      );
      log.info('Firebase Authentication Succeeded!');
      unawaited(
        Analytics.track(
          eventName: AnalyticsEvents.verify,
          properties: {
            AnalyticsProps.status: AnalyticsProps.success,
          },
        ),
      ); //! Bug one of these lines is killing my state
    }
    final User currentUser = firebaseAuth.currentUser!;
    assert(user?.uid == currentUser.uid, 'User IDs not same.');

    if (store.state.userState.email.isNotEmpty &&
        currentUser.email != null &&
        currentUser.email?.toLowerCase().trim() !=
            store.state.userState.email.toLowerCase().trim()) {
      try {
        await updateEmail(
          email: store.state.userState.email.toLowerCase().trim(),
          dontComplete: true,
        );
      } on FirebaseAuthException catch (e, s) {
        //TODO: What to do if email in state from old login is linked to a different firebase account?
        // Try and link the accounts in future?...
        log.error(e, stackTrace: s);
        await _catchFirebaseException(
          e,
          s,
          additionalMessage:
              'Error updating user email with verifyBeforeUpdateEmail()',
          firebaseStatusIfNotHandled:
              FirebaseAuthenticationStatus.updateEmailUsingVerificationFailed,
        );
        return firebaseSessionToken;
      } on Exception catch (e, s) {
        await _catchUnknownException(
          e,
          s,
          additionalMessage:
              'Error updating user email with verifyBeforeUpdateEmail()',
          firebaseStatusIfNotHandled:
              FirebaseAuthenticationStatus.updateEmailUsingVerificationFailed,
        );
        store.dispatch(
          SignupLoading(
            isLoading: false,
          ),
        );
        return firebaseSessionToken;
      }
    }
    return firebaseSessionToken;
  }

  @override
  bool registeredEmailIs(String email) {
    final currentUserEmail =
        firebaseAuth.currentUser?.email?.toLowerCase().trim();
    return currentUserEmail != null &&
        currentUserEmail == email.toLowerCase().trim();
  }

  Future<void> _processSigninPhoneNumber(
    Store<AppState> store,
    UserCredential userCredential,
  ) async {
    final firebaseSessionToken =
        await _processFirebaseSignin(store, userCredential);

    if (firebaseSessionToken == null) {
      return;
    }

    // should we move this to user_actions?
    //TODO: GET rid of this code and in authenticator, call loginToVegiWithPhone code
    // Use same code as in Authentication._signInFirebaseRequestVerificationCodeStep2
    // final result = await loginToVegiWithPhone(
    //   store: store,
    //   phoneNumber: store.state.userState.phoneNumber,
    //   firebaseSessionToken: firebaseSessionToken,
    // );
    // if (result != LoggedInToVegiResult.success) {
    //   _complete(
    //     store: store,
    //     firebaseStatus: result == LoggedInToVegiResult.firebaseTokenExpired
    //         ? FirebaseAuthenticationStatus.expired
    //         : FirebaseAuthenticationStatus.authenticated,
    //     vegiStatus: VegiAuthenticationStatus.failed,
    //   );
    // }
    // store.dispatch(
    //   SignupLoading(
    //     isLoading: false,
    //   ),
    // );
    return;
  }

  Future<void> _processSigninEmailAndPassword(
    Store<AppState> store,
    UserCredential userCredential,
  ) async {
    final firebaseSessionToken =
        await _processFirebaseSignin(store, userCredential);

    if (firebaseSessionToken == null) {
      return;
    }

    // final result = await loginToVegiWithEmail(
    //   store: store,
    //   email: store.state.userState.email.toLowerCase().trim(),
    //   firebaseSessionToken: firebaseSessionToken,
    // );
    // if (result != LoggedInToVegiResult.success) {
    //   _complete(
    //     store: store,
    //     firebaseStatus: result == LoggedInToVegiResult.firebaseTokenExpired
    //         ? FirebaseAuthenticationStatus.expired
    //         : FirebaseAuthenticationStatus.authenticated,
    //     vegiStatus: VegiAuthenticationStatus.failed,
    //   );
    // }
    store.dispatch(
      SignupLoading(
        isLoading: false,
      ),
    );
    return;
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    await firebaseAuth.sendPasswordResetEmail(
        email: email.toLowerCase().trim());
  }

  @override
  Future<bool> updateEmail({
    required String email,
    bool dontComplete = false,
  }) async {
    email = email.toLowerCase().trim();
    final store = await reduxStore;
    store.dispatch(
      SignupLoading(
        isLoading: true,
      ),
    );
    if (firebaseAuth.currentUser == null) {
      log.info(
          'Not able to update email to "$email" on firebase as no firebase user exists yet.');
      return true;
    }
    final existingEmail =
        (firebaseAuth.currentUser?.email ?? '').toLowerCase().trim();
    try {
      // we are seeing an issue here where we already have 2 different firebase accounts set up for jdwonczyk@gmail.com and joey@vegiapp.co.uk and therefore when we try to update form jdwnoczyk to joey@vegi, we get an error as the email already has a different account registered to it.
      // we need to first check if joey@vegiapp already has a firebase account and if it does, we need to get the user to login with it first to link the account.
      final dummySigninMethods = existingEmail.isNotEmpty
          ? await FirebaseAuth.instance.fetchSignInMethodsForEmail(email)
          : <String>[];
      if (dummySigninMethods.isNotEmpty) {
        log.warn(
            'Unable to change current user with email: $existingEmail to new email: $email because there is already another user registered to this email: $email');
        return false;
      }
      // !BUG this line just through as had unsuccesffuly tried to set email on previous attempt so store was out of sync with firebase...
      if (existingEmail.isEmpty || USE_FIREBASE_EMULATOR) {
        await firebaseAuth.currentUser?.updateEmail(email);
      } else {
        await firebaseAuth.currentUser?.verifyBeforeUpdateEmail(
          email,
        ); //TODO: THis method is failling to allow us to update the users email?...
      }
      if (!dontComplete) {
        _complete(
          store: store,
        );
      }
      return true;
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'email-already-in-use') {
        // FirebaseAuth.instance.currentUser?.linkWithCredential(credential)
        log.warn(
            'Unable to change current user with email: $existingEmail to new email: $email because there is already another user registered to this email: $email');
        if (!dontComplete) {
          store.dispatch(
            SignupFailed(
              error: SignUpErrorDetails(
                message:
                    'Email registered to this account is $existingEmail and can\'t be updated to $email as another account already exists with that email.',
                title: '$email already registered',
                code: SignUpErrCode.emailAlreadyInUse,
              ),
            ),
          );
        }
        return false;
      }
      await _catchFirebaseException(
        e,
        s,
        additionalMessage:
            'Error whilst firebaseOnBoarding.updateEmail to email "$email" using firebaseAuth?.currentUser?.verifyBeforeUpdateEmail("$email") $e',
        firebaseStatusIfNotHandled:
            FirebaseAuthenticationStatus.updateEmailUsingVerificationFailed,
        dontComplete: dontComplete,
      );
      return false;
    } on Exception catch (e, s) {
      await _catchUnknownException(
        e,
        s,
        additionalMessage:
            'Error whilst firebaseOnBoarding.updateEmail using firebaseAuth?.currentUser?.verifyBeforeUpdateEmail(email) $e',
        firebaseStatusIfNotHandled:
            FirebaseAuthenticationStatus.emailAlreadyInUseWithOtherAccount,
        dontComplete: dontComplete,
      );
      return false;
    }
  }

  Future<bool> _reauthenticateUser({
    required AuthCredential credential,
  }) async {
    final store = await reduxStore;
    if (credential is PhoneAuthCredential &&
        (credential.verificationId?.isEmpty ?? true)) {
      _complete(
        store: store,
        firebaseStatus:
            FirebaseAuthenticationStatus.phoneAuthCredentialHasNoVerificationId,
        vegiStatus: VegiAuthenticationStatus.unauthenticated,
      );
      return false;
    }
    try {
      await firebaseAuth.currentUser?.reauthenticateWithCredential(credential);
      final firebaseSessionToken = await firebaseAuth.currentUser?.getIdToken();
      store.dispatch(
        SetFirebaseSessionToken(
          firebaseSessionToken: firebaseSessionToken,
        ),
      );
      return true;
    } on FirebaseAuthException catch (e, s) {
      await _catchFirebaseException(
        e,
        s,
        additionalMessage:
            'Error updating user email with getIdToken for a firebase user',
        dontComplete: true,
      );
      _complete(
        store: store,
        firebaseStatus:
            FirebaseAuthenticationStatus.phoneAuthReauthenticationFailed,
        vegiStatus: VegiAuthenticationStatus.unauthenticated,
      );
      return false;
    } on Exception catch (e, s) {
      await _catchUnknownException(
        e,
        s,
        additionalMessage:
            'Error updating user email with getIdToken for a firebase user',
        dontComplete: true,
      );
      _complete(
        store: store,
        firebaseStatus:
            FirebaseAuthenticationStatus.phoneAuthReauthenticationFailed,
        vegiStatus: VegiAuthenticationStatus.unauthenticated,
      );
      return false;
    }
  }

  @override
  Future<bool> reauthenticateUser() async {
    final store = await reduxStore;

    // if (store.state.userState.firebaseAuthenticationStatus ==
    //     FirebaseAuthenticationStatus.expired || store.state.userState.firebaseSessionToken == null) {
    //   final creds = store.state.userState.firebaseCredentials;
    //   if (creds != null) {
    //     return _reauthenticateUser(
    //       credential: creds,
    //     );
    //   }
    //   return false;
    // } else
    if (store.state.userState.firebaseCredentials == null) {
      return false;
    }

    final reauthSucceeded = await _reauthenticateUser(
      credential: store.state.userState.firebaseCredentials!,
    );

    if (!reauthSucceeded ||
        store.state.userState.firebaseAuthenticationStatus
            .isNewFailureStatus(FirebaseAuthenticationStatus.unauthenticated)) {
      log.warn(
          'Failed to reauthenticate firebase as status: FirebaseAuthenticationStatus.[${store.state.userState.firebaseAuthenticationStatus.name}]');
      return false;
    }

    if (store.state.userState.firebaseSessionToken != null) {
      // final result = await loginToVegiWithPhone(
      //   store: store,
      //   phoneNumber: store.state.userState.phoneNumber,
      //   firebaseSessionToken: store.state.userState.firebaseSessionToken!,
      // );
      // if (result == LoggedInToVegiResult.success) {
      //   _complete(
      //     store: store,
      //     vegiStatus: VegiAuthenticationStatus.authenticated,
      //   );
      //   store.dispatch(isBetaWhitelistedAddress());
      //   return true;
      //   // } else if (store.state.userState.firebaseAuthenticationStatus ==
      //   //     FirebaseAuthenticationStatus.expired) {
      //   //   final creds = store.state.userState.firebaseCredentials;
      //   //   if (creds != null) {
      //   //     await _reauthenticateUser(
      //   //       credential: creds,
      //   //     );
      //   //   }
      //   //   return false;
      // } else {
      //   log.error('Could not login to vegi...');
      //   _complete(
      //     store: store,
      //     firebaseStatus: FirebaseAuthenticationStatus.authenticated,
      //     vegiStatus: VegiAuthenticationStatus.failed,
      //   );
      //   return false;
      // }
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> verifyRecaptchaToken({
    String? recaptchaToken,
    String? deepLinkId,
  }) async {
    throw Exception('Not implemented onboardStrategy.verifyRecaptchaToken()');
  }

  @override
  Future<LoggedInToVegiResult> loginToVegiWithPhone({
    required Store<AppState> store,
    required String phoneNumber,
    required String firebaseSessionToken,
  }) async {
    try {
      if (USE_FIREBASE_EMULATOR) {
        log.warn(
            'Will not attempt to login to vegi for now as we are using the firebase emulator and the ${Env.activeEnv} vegi backend server cannot sign verification codes. See https://github.com/firebase/firebase-tools/issues/2764');
        store.dispatch(
          SetUserAuthenticationStatus(
            vegiStatus: VegiAuthenticationStatus.failed,
          ),
        );
        return LoggedInToVegiResult.failed;
      }
      if (store.state.userState.fuseAuthenticationStatus !=
          FuseAuthenticationStatus.authenticated) {
        log.warn(
            'Should not be logging into vegi as fuse is not authenticated');
        return LoggedInToVegiResult.failed;
      }
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
          store: store,
          vegiStatus: VegiAuthenticationStatus.authenticated,
        );
        store.dispatch(
          SignupFailed(
            error: null,
          ),
        );
        if (store.state.userState.hasNotOnboarded) {
          log.error(
              'Should never have userState.hasNotOnboarded here. Please refactor');
        }
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
          store: store,
          vegiStatus: VegiAuthenticationStatus.failed,
        );
      }
      return vegiSession.sessionCookie.isNotEmpty
          ? LoggedInToVegiResult.success
          : LoggedInToVegiResult.failedEmptySessionCookie;
    } catch (err) {
      _complete(
        store: store,
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
  // Future<LoggedInToVegiResult> loginToVegiWithEmail({
  //   required Store<AppState> store,
  //   required String email,
  //   required String firebaseSessionToken,
  // }) async {
  //   try {
  //     store.dispatch(
  //       SetUserAuthenticationStatus(
  //         vegiStatus: VegiAuthenticationStatus.loading,
  //       ),
  //     );
  //     // * sets the session cookie on the service class instance.
  //     final vegiSession = await peeplEatsService.loginWithEmail(
  //       emailAddress: email,
  //       firebaseSessionToken: firebaseSessionToken,
  //       rememberMe: true,
  //     );
  //     final userDetails = vegiSession.user;
  //     if (vegiSession.sessionCookie.isNotEmpty) {
  //       _complete(
  //         store: store,
  //         vegiStatus: VegiAuthenticationStatus.authenticated,
  //       );
  //       store.dispatch(isBetaWhitelistedAddress());
  //       unawaited(
  //         Analytics.track(
  //           eventName: AnalyticsEvents.loginWithPhone,
  //           properties: {
  //             AnalyticsProps.status: AnalyticsProps.success,
  //           },
  //         ),
  //       );
  //     } else {
  //       log.error('Could not login to vegi...');
  //       _complete(
  //         store: store,
  //         vegiStatus: VegiAuthenticationStatus.failed,
  //       );
  //     }
  //     return vegiSession.sessionCookie.isNotEmpty
  //         ? LoggedInToVegiResult.success
  //         : LoggedInToVegiResult.failedEmptySessionCookie;
  //   } catch (err) {
  //     _complete(
  //       store: store,
  //       firebaseStatus: FirebaseAuthenticationStatus.authenticated,
  //       vegiStatus: VegiAuthenticationStatus.failed,
  //     );
  //     log
  //       ..error(
  //         err,
  //         stackTrace: StackTrace.current,
  //       )
  //       ..error(err.toString());
  //     store.dispatch(
  //       SetFirebaseSessionToken(
  //         firebaseSessionToken: null,
  //       ),
  //     );
  //     return LoggedInToVegiResult.failed;
  //   }
  // }

  @override
  Future<UserCredential?> signInUserFromVerificationLink({
    required String email,
    required String emailLinkFromVerificationEmail,
  }) async {
    final store = await reduxStore;
    store.dispatch(SignupLoading(isLoading: true));
    try {
      final userCredential = await firebaseAuth.signInWithEmailLink(
        email: email,
        emailLink: emailLinkFromVerificationEmail,
      );
      store.dispatch(SetFirebaseCredentials(userCredential.credential));
      _complete(store: store);
      return userCredential;
    } catch (err, s) {
      log.error(err);
      await Sentry.captureException(
        err,
        stackTrace: s, // from catch (err, s)
        hint: 'ERROR - firebaseStrat.signInUserFromVerificationLink $err',
      );
      return null;
    }
  }

  Future<void> linkAccountsFromEmailLinkCallbackFromVerificationEmail({
    required String email,
    required AuthCredential pendingCredential,
    required String emailLinkFromVerificationEmail,
    bool dontComplete = false,
  }) async {
    final store = await reduxStore;
    store.dispatch(SignupLoading(isLoading: true));
    try {
      final userCredential = await firebaseAuth.signInWithEmailLink(
        email: email,
        emailLink: emailLinkFromVerificationEmail,
      );
      // Link the pending credential with the existing account
      await userCredential.user?.linkWithCredential(pendingCredential);
    } catch (err, s) {
      log.error(err);
      await Sentry.captureException(
        err,
        stackTrace: s, // from catch (err, s)
        hint:
            'ERROR - firebaseStrat.emailLinkCallbackFromVerificationEmail $err',
      );
    }

    // Success! Go back to your application flow
    if (dontComplete) {
      return;
    }
    return _complete(
      store: store,
    );
  }

  Future<ActionCodeSettings> _getActionCodeSettingsForEmailLink({
    required String email,
  }) async {
    // ~ https://firebase.google.com/docs/auth/flutter/email-link-auth?hl=en&authuser=0
    final PackageInfo info = await PackageInfo.fromPlatform();
    return ActionCodeSettings(
      // URL you want to redirect back to. The domain (www.example.com) for this
      // URL must be whitelisted in the Firebase Console.
      // url: 'https://www.example.com/finishSignUp?cartId=1234',
      url: '${Secrets.VEGI_EATS_BACKEND}verify-email-link',
      dynamicLinkDomain: '$VEGI_DYNAMIC_APP_URL/',
      // url: '${Secrets.VEGI_EATS_BACKEND}verify-email-link?emailAddress=$email',
      // url: '$VEGI_DYNAMIC_APP_URL/verify-email-link?emailAddress=$email',

      // This must be true
      handleCodeInApp: true,

      iOSBundleId: info.packageName, // ?? PackageConstants.iosBundleIdentifier,
      androidPackageName:
          info.packageName, // ?? PackageConstants.iosBundleIdentifier,
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12',
    );
  }

  Future<void> _linkAccountWithDifferentEmail({
    required FirebaseAuthException e,
  }) async {
    final store = await reduxStore;
    try {
      // The account already exists with a different credential
      final email = e.email;
      final pendingCredential = e.credential;

      if (email != null && pendingCredential != null) {
        // store conflicting account details for callbacks later on such as in email_link.
        store
          ..dispatch(SignupLoading(isLoading: true))
          ..dispatch(
            SetConflictingFirebaseCredentials(
              conflictingEmail: email,
              conflictingCredentials: pendingCredential,
            ),
          );

        // Fetch a list of what sign-in methods exist for the conflicting user
        final userSignInMethods =
            await firebaseAuth.fetchSignInMethodsForEmail(email);

        // If the user has several sign-in methods,
        // the first method in the list will be the "recommended" method to use.
        if (userSignInMethods.first == 'email_link') {
          // Sign the user in to their account with the email link

          // called as callback [emailLinkCallbackFromVerificationEmail] when the app link is received from user clicking the OTP link in the email.
          // return emailLinkCallbackFromVerificationEmail()
          try {
            final userCredential = await firebaseAuth.sendSignInLinkToEmail(
              email: email,
              actionCodeSettings: await _getActionCodeSettingsForEmailLink(
                email: email,
              ),
            );
          } on Exception catch (e, s) {
            log.error(
              e,
              stackTrace: s,
            );
            await Sentry.captureException(
              e,
              stackTrace: StackTrace.current, // from catch (err, s)
              hint: 'ERROR - firebaseStrategy.linkAccountWithDifferentEmail $e',
            );
          }
        }
        // if (userSignInMethods.first == 'password') {
        //   // Prompt the user to enter their password
        //   final password = '...';

        //   // Sign the user in to their account with the password
        //   final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        //     email: email,
        //     password: password,
        //   );

        //   // Link the pending credential with the existing account
        //   await userCredential.user?.linkWithCredential(pendingCredential);

        //   // Success! Go back to your application flow
        //   if (dontComplete) {
        //     return;
        //   }
        //   return _complete(
        //     store: store,
        //     firebaseStatus:
        //         FirebaseAuthenticationStatus.emailAlreadyInUseWithOtherAccount,
        //   );
        // }
        // Since other providers are now external, you must now sign the user in with another
        // auth provider, such as Facebook.
        // if (userSignInMethods.first == 'facebook.com') {
        //   // Create a new Facebook credential
        //   String accessToken = await triggerFacebookAuthentication();
        //   final facebookAuthCredential =
        //       FacebookAuthProvider.credential(accessToken);

        //   // Sign the user in with the credential
        //   UserCredential userCredential =
        //       await auth.signInWithCredential(facebookAuthCredential);

        //   // Link the pending credential with the existing account
        //   await userCredential.user.linkWithCredential(pendingCredential);

        //   // Success! Go back to your application flow
        //   return _complete(
        //     store: store,
        //   );
        // }
      }

      // Handle other OAuth providers...
      return _complete(
        store: store,
      );
    } on Exception catch (err, s) {
      log.error('Error: $err', stackTrace: s);
      return _complete(store: store);
    }
  }

  Future<void> _catchFirebaseException(
    FirebaseAuthException e,
    StackTrace s, {
    String? additionalMessage,
    FirebaseAuthenticationStatus? firebaseStatusIfNotHandled,
    bool dontComplete = false,
  }) async {
    log
      ..error(
        'FirebaseAuth Exception caught:',
        stackTrace: s,
      )
      ..info('Code: ${e.code}.')
      ..info('Message: ${e.message}')
      ..info('with additional message: $additionalMessage');
    final store = await reduxStore;
    final message = e.code
        .split('-')
        .mapIndexed(
          (index, element) => index == 0 ? element.capitalize() : element,
        )
        .join(' ');

    if (e.code == 'invalid-credential') {
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: message,
            message: additionalMessage ?? '',
            code: SignUpErrCode.invalidCredentials,
          ),
        ),
      );
      return _complete(
        store: store,
        firebaseStatus: FirebaseAuthenticationStatus.invalidCredentials,
      );
    } else if (e.code == 'invalid-email') {
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: message,
            message: additionalMessage ?? '',
            code: SignUpErrCode.invalidEmail,
          ),
        ),
      );
      return _complete(
        store: store,
        firebaseStatus: FirebaseAuthenticationStatus.invalidCredentials,
      );
    } else if (e.code == 'expired-action-code') {
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: message,
            message: additionalMessage ?? '',
            code: SignUpErrCode.emailLinkExpired,
          ),
        ),
      );
      return _complete(
        store: store,
        firebaseStatus: FirebaseAuthenticationStatus.invalidCredentials,
      );
    } else if (e.code == 'invalid-verification-id') {
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: message,
            message:
                'The verification id ["${store.state.userState.verificationId}"] passed to verify handler is stale. $additionalMessage',
            code: SignUpErrCode.invalidVerificationId,
          ),
        ),
      );
      return _complete(
        store: store,
        firebaseStatus: FirebaseAuthenticationStatus.invalidVerificationId,
      );
    } else if (e.code == 'unauthorized-domain') {
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: message,
            message: e.message ?? '',
            code: SignUpErrCode.unauthorizedDomain,
          ),
        ),
      );
      return _complete(
        store: store,
        firebaseStatus: FirebaseAuthenticationStatus.invalidCredentials,
      );
    } else if (e.code == 'user-disable') {
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: message,
            message: additionalMessage ?? '',
            code: SignUpErrCode.userDisabled,
          ),
        ),
      );
      return _complete(
        store: store,
        firebaseStatus: FirebaseAuthenticationStatus.invalidCredentials,
      );
    } else if (e.code == 'email-already-in-use' ||
        e.code == 'account-exists-with-different-credential') {
      log.error(
        'Try to catch this before coming into this handler?...',
        stackTrace: s,
      );
      // try and link the 2 accounts?
      log.error(
        'RESEARCH HOW TO TRY AND LINK 2 differing firebase accounts for email: "${e.email}" using link:\n https://firebase.google.com/docs/auth/flutter/errors#handling_account-exists-with-different-credential_errors',
      );

      await Sentry.captureException(
        e,
        stackTrace: StackTrace.current, // from catch (err, s)
        hint: 'ERROR - firebase.verify.updateEmailWithVerify: $e',
      );
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: 'Email already in use',
            message: 'The account already exists for that email.',
            code: SignUpErrCode.emailAlreadyInUse,
          ),
        ),
      );
      return _linkAccountWithDifferentEmail(e: e);
    } else if (e.code == 'session-expired') {
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: message,
            message: additionalMessage ?? '',
            code: SignUpErrCode.sessionExpired,
          ),
        ),
      );
      return _complete(
        store: store,
        firebaseStatus: FirebaseAuthenticationStatus.expired,
      );
    } else if (e.code == 'user-not-found') {
      log.warn(
        'No user found for that email.',
        stackTrace: s,
      );
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: message,
            message: additionalMessage ?? '',
            code: SignUpErrCode.userNotFound,
          ),
        ),
      );
    } else if (e.code == 'wrong-password') {
      log.warn(
        'Wrong password provided for that user.',
        stackTrace: s,
      );
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: 'Wrong password',
            message: 'Wrong password provided',
            code: SignUpErrCode.wrongPassword,
          ),
        ),
      );
    } else if (e.code == 'weak-password') {
      log.warn(
        'The password provided is too weak.',
        stackTrace: s,
      );
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: 'Weak password',
            message: 'The password provided is too weak.',
            code: SignUpErrCode.weakPassword,
          ),
        ),
      );
    } else if (e.code == 'internal-error') {
      log.error(
        'Firebase internal error: ${e.message}',
        stackTrace: s,
      );
      print(e);
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: 'Internal firebase error',
            message: e.message ?? message,
            code: SignUpErrCode.serverError,
          ),
        ),
      );
    } else {
      log.warn(
        'Firebase signin error: $message',
        stackTrace: s,
      );
      store.dispatch(
        SignupFailed(
          error: SignUpErrorDetails(
            title: 'Firebase signin error',
            message: message,
          ),
        ),
      );
    }
    if (dontComplete) {
      return;
    }
    return _complete(
      store: store,
      firebaseStatus: firebaseStatusIfNotHandled,
    );
  }

  Future<void> _catchUnknownException(
    Exception e,
    StackTrace s, {
    String? additionalMessage,
    FirebaseAuthenticationStatus? firebaseStatusIfNotHandled,
    bool dontComplete = false,
  }) async {
    log
      ..error(e, stackTrace: s)
      ..error(
        'with additional message: $additionalMessage',
        stackTrace: s,
      );
    final store = await reduxStore;
    if (dontComplete) {
      return;
    }
    return _complete(
      store: store,
      firebaseStatus: firebaseStatusIfNotHandled,
    );
  }

  @override
  Future<void> nextOnboardingPage({PageRouteInfo? currentRoute}) async {
    final store = await reduxStore;
    log.info(
      'Onboarding strategy to next onboarding page from ${currentRoute?.routeName ?? rootRouter.current.name}',
      sentry: false,
    );
    
    final currentRouteInd = onboardingRoutesOrder
        .indexOf(currentRoute?.routeName ?? rootRouter.current.name);
    if (!store.state.userState.isLoggedIn &&
        onboardingAuthRoutesOrder
                .contains(currentRoute?.routeName ?? rootRouter.current.name) ==
            false) {
      await rootRouter.replaceAll([const SignUpScreen()]);
    }
    if (store.state.userState.email.trim().isEmpty &&
        currentRouteInd <
            onboardingRoutesOrder.indexOf(SetEmailOnboardingScreen.name)) {
      await rootRouter.push(const SetEmailOnboardingScreen());
    } else if (store.state.userState.displayName.isEmpty &&
        currentRouteInd < onboardingRoutesOrder.indexOf(UserNameScreen.name)) {
      await rootRouter.push(UserNameScreen());
    } else if (store.state.userState.authType == BiometricAuth.none &&
        currentRouteInd <
            onboardingRoutesOrder.indexOf(ChooseSecurityOption.name)) {
      await rootRouter.push(const ChooseSecurityOption());
    } else if (!store.state.userState.biometricallyAuthenticated &&
        currentRouteInd < onboardingRoutesOrder.indexOf(PinCodeScreen.name)) {
      await rootRouter.push(const PinCodeScreen());
    } else {
      await rootRouter.push(const MainScreen());
    }
  }
}

enum LoggedInToVegiResult {
  success,
  failed,
  failedEmptySessionCookie,
  firebaseTokenExpired,
}
