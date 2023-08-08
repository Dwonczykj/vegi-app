import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/onboard/firebase.dart';

abstract class IOnBoardStrategy {
  // IOnBoardStrategy(this.strategy, this.authLayer);
  IOnBoardStrategy(this.strategy);

  final OnboardStrategy strategy;

  bool registeredEmailIs(String email);

  // final OnboardingAuthChain authLayer;

  bool expectingSMSVerificationCode = false;

  Future<dynamic> login({
    required CountryCode countryCode,
    required PhoneNumber phoneNumber,
    required void Function() onCompleteFlow,
  });

  Future<UserCredential?> verify(
    Store<AppState> store,
    String verificationCode,
    // {required void Function() onCompleteFlow,}
  );

  Future<void> verifyRecaptchaToken({
    String? recaptchaToken,
    String? deepLinkId,
  });
  Future<bool> reauthenticateUser();
  Future<bool> updateEmail({required String email});
  // Future<LoggedInToVegiResult> loginToVegiWithPhone({
  //   required Store<AppState> store,
  //   required String phoneNumber,
  //   required String firebaseSessionToken,
  // });
  // Future<LoggedInToVegiResult> loginToVegiWithEmail({
  //   required Store<AppState> store,
  //   required String email,
  //   required String firebaseSessionToken,
  // });

  Future<UserCredential?> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<bool> signInUserBySendingEmailLink({
    required String email,
  });
  Future<UserCredential?> signInUserFromVerificationLink({
    required String email,
    required String emailLinkFromVerificationEmail,
  });
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signInWithApple();
  Future<void> signout();

  Future<void> nextOnboardingPage({
    PageRouteInfo<dynamic>? currentRoute,
  });

  bool get onOnboarding;
}

class OnBoardStrategyFactory {
  static IOnBoardStrategy create(String strategy) {
    if (strategy == 'firebase') {
      return FirebaseStrategy();
    } else {
      final err = UnsupportedError(
          '`$strategy` onboarding strategy no longer supported',);
      Sentry.captureException(
        err,
        stackTrace: StackTrace.current,
      );
      throw err;
      // } else if (strategy == 'vegi') {
      //   return VegiOnboardStrategy();
    }
  }
}
