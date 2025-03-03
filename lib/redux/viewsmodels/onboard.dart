import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/common/router/route_guards.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/user_state.dart';
import 'package:vegan_liverpool/redux/actions/home_page_actions.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart' as VegiConstants;

class VerifyOnboardViewModel extends Equatable {
  const VerifyOnboardViewModel({
    required this.countryCode,
    required this.phoneNumber,
    required this.displayName,
    required this.email,
    required this.avatarUrl,
    required this.isLoggedOut,
    required this.accountDetailsExist,
    required this.biometricAuth,
    required this.verificationId,
    required this.firebaseCredentials,
    required this.signupIsInFlux,
    required this.httpRequestIsInFlux,
    required this.setSignupFailed,
    required this.signupError,
    required this.signupStatusMessage,
    required this.setLoading,
    required this.verify,
    required this.setDisplayName,
    required this.firebaseAuthenticationStatus,
    required this.fuseAuthenticationStatus,
    required this.vegiAuthenticationStatus,
    required this.editAvatar,
  });

  factory VerifyOnboardViewModel.fromStore(Store<AppState> store) {
    final UserState userState = store.state.userState;
    return VerifyOnboardViewModel(
      countryCode: store.state.userState.countryCode,
      phoneNumber: store.state.userState.phoneNumber,
      displayName: store.state.userState.displayName,
      email: store.state.userState.email,
      avatarUrl: store.state.userState.avatarUrl,
      isLoggedOut: store.state.userState.hasNotOnboarded ||
          !store.state.userState.isLoggedIn ||
          store.state.userState.jwtToken == '',
      accountDetailsExist: store.state.userState.accountDetailsExist,
      verificationId: store.state.userState.verificationId,
      biometricAuth: store.state.userState.authType,
      firebaseCredentials: userState.firebaseCredentials,
      firebaseAuthenticationStatus:
          store.state.userState.firebaseAuthenticationStatus,
      fuseAuthenticationStatus: store.state.userState.fuseAuthenticationStatus,
      vegiAuthenticationStatus: store.state.userState.vegiAuthenticationStatus,
      signupIsInFlux: store.state.onboardingState.signupIsInFlux,
      httpRequestIsInFlux: store.state.homePageState.isLoadingHttpRequest,
      signupError: store.state.onboardingState.signupError,
      signupStatusMessage: store.state.onboardingState.signupStatusMessage,
      setSignupFailed: (error) {
        store.dispatch(
          SignUpFailed(
            error: error,
          ),
        );
      },
      setLoading: (isLoading) {
        store.dispatch(
          SignupLoading(
            isLoading: isLoading,
          ),
        );
      },
      verify: (
        String verificationCode,
      ) {
        // store.dispatch(
        //   verifyHandler(
        //     verificationCode,
        //   ),
        // );
        authenticator.verifySMSVerificationCode(verificationCode);
      },
      editAvatar: (
        source, {
        ProgressCallback? progressCallback,
        void Function()? onSuccess,
        void Function(String errStr)? onError,
      }) {
        store
          ..dispatch(
            updateUserAvatarCall(
              source,
              progressCallback: progressCallback,
              onSuccess: onSuccess,
              onError: onError,
            ),
          );
      },
      setDisplayName: ({required displayName}) {
        isAuthenticatedRouteGuard = true;
        store.dispatch(updateDisplayNameCall(displayName));
        // ..dispatch(
        //   authenticate(
        //       // todo confirm that this flow still works to initialise the new smartWallet
        //       // () {},
        //       ),
        // );
        unawaited(Analytics.track(eventName: AnalyticsEvents.fillUserName));
      },
    );
  }

  final String countryCode;
  final String phoneNumber;
  final SignUpErrorDetails? signupError;
  final String signupStatusMessage;
  final String displayName;
  final String email;
  final String avatarUrl;
  final bool isLoggedOut;
  final bool accountDetailsExist;
  final BiometricAuth biometricAuth;
  final String? verificationId;
  final AuthCredential? firebaseCredentials;
  final FirebaseAuthenticationStatus firebaseAuthenticationStatus;
  final FuseAuthenticationStatus fuseAuthenticationStatus;
  final VegiAuthenticationStatus vegiAuthenticationStatus;
  final dynamic Function(
    String code,
  ) verify;
  final bool signupIsInFlux;
  final bool httpRequestIsInFlux;
  final dynamic Function(
    SignUpErrorDetails error,
  ) setSignupFailed;
  final dynamic Function(
    bool isLoading,
  ) setLoading;
  final void Function({required String displayName}) setDisplayName;
  final void Function(
    ImageSource source, {
    ProgressCallback? progressCallback,
    void Function()? onSuccess,
    void Function(String errStr)? onError,
  }) editAvatar;

  bool get displayNameIsSet =>
      displayName != '' && displayName != VegiConstants.defaultDisplayName;

  bool get biometricAuthIsSet => biometricAuth != BiometricAuth.none;

  bool get emailIsSet => email.isNotEmpty;

  bool get isLoggedIn => !isLoggedOut && accountDetailsExist;

  @override
  List<Object?> get props => [
        countryCode,
        phoneNumber,
        displayName,
        email,
        avatarUrl,
        biometricAuth,
        signupError,
        signupStatusMessage,
        firebaseAuthenticationStatus,
        signupIsInFlux,
        httpRequestIsInFlux,
        fuseAuthenticationStatus,
        vegiAuthenticationStatus,
      ];
}
