import 'package:country_code_picker/country_code_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/authViewModel.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/onboard/authentication.dart';
import 'package:vegan_liverpool/version.dart';
import 'package:vegan_liverpool/utils/constants.dart' as VegiConstants;

class MainScreenViewModel extends Equatable implements IAuthViewModel {
  const MainScreenViewModel({
    required this.walletAddress,
    required this.userIsVerified,
    required this.loggedInToVegi,
    required this.hasLoggedInBefore,
    required this.surveyCompleted,
    required this.dialCode,
    required this.countryCode,
    required this.phoneNumber,
    required this.phoneNumberNoCountry,
    required this.isSuperAdmin,
    required this.email,
    required this.password,
    required this.displayName,
    required this.hasNotOnboarded,
    required this.accountDetailsExist,
    required this.isLoggedInToVegi,
    required this.biometricAuth,
    required this.firebaseSessionToken,
    required this.signupIsInFlux,
    required this.signupError,
    required this.signupStatusMessage,
    required this.firebaseAuthenticationStatus,
    required this.fuseAuthenticationStatus,
    required this.vegiAuthenticationStatus,
    required this.appUpdateNeeded,
    required this.appUpdateNextVersion,
    required this.appUpdateNotificationSeenForBuildNumber,
    required this.routeToLogin,
    // required this.setPhoneNumber,
    required this.setEmail,
    required this.signin,
    required this.setUserSessionExpired,
    required this.setLoading,
    required this.subscribeToEmailToNotifications,
    required this.signinEmailAndPassword,
    required this.signInUserUsingEmailLink,
    required this.setAppUpdateNotificationSeen,
  });

  factory MainScreenViewModel.fromStore(Store<AppState> store) {
    return MainScreenViewModel(
      walletAddress:
          store.state.userState.walletAddress, //.replaceFirst('x', 'f'),
      signupStatusMessage: store.state.onboardingState.signupStatusMessage,
      userIsVerified: store.state.userState.userIsVerified,
      hasNotOnboarded: store.state.userState.hasNotOnboarded ||
          store.state.userState.jwtToken == '',
      loggedInToVegi: store.state.userState.isLoggedInToVegi,
      hasLoggedInBefore: store.state.userState.hasLoggedInBefore,
      surveyCompleted: store.state.userState.surveyCompleted,
      isSuperAdmin: store.state.userState.isVegiSuperAdmin,
      phoneNumberNoCountry: store.state.userState.phoneNumberNoCountry,
      phoneNumber: store.state.userState.phoneNumber,
      countryCode: store.state.userState.isoCode, // the country code (IT,AF..)
      dialCode: store.state.userState.countryCode, // the dial code (+39,+93..)
      firebaseSessionToken: store.state.userState.firebaseSessionToken,
      signupIsInFlux: store.state.onboardingState.signupIsInFlux ||
          peeplEatsService.authenticating,
      email: store.state.userState.email,
      password: store.state.userState.password,
      displayName: store.state.userState.displayName,
      accountDetailsExist: store.state.userState.accountDetailsExist,
      isLoggedInToVegi: store.state.userState.isLoggedInToVegi,
      biometricAuth: store.state.userState.authType,
      signupError: store.state.onboardingState.signupError,
      firebaseAuthenticationStatus:
          store.state.userState.firebaseAuthenticationStatus,
      fuseAuthenticationStatus: store.state.userState.fuseAuthenticationStatus,
      vegiAuthenticationStatus: store.state.userState.vegiAuthenticationStatus,
      appUpdateNeeded: store.state.userState.appUpdateNeeded,
      appUpdateNextVersion: store.state.userState.appUpdateNextVersion,
      appUpdateNotificationSeenForBuildNumber:
          store.state.userState.appUpdateNotificationSeenForBuildNumber,
      // setPhoneNumber: ({
      //   required CountryCode countryCode,
      //   required PhoneNumber phoneNumber,
      // }) {
      //   store.dispatch(
      //     SetPhoneNumberSuccess(
      //       countryCode: countryCode,
      //       phoneNumber: phoneNumber,
      //     ),
      //   );
      // },
      setEmail: ({
        required String email,
        required void Function(String) onError,
        Future<void> Function()? onComplete,
      }) async {
        store.dispatch(
          updateEmail(
            email: email,
            onError: onError,
            onComplete: onComplete,
          ),
        );
      },
      signin: ({
        required CountryCode countryCode,
        required PhoneNumber phoneNumber,
      }) {
        authenticator.login(
          loginDetails: PhoneLoginDetails(
            countryCode: countryCode,
            phoneNumber: phoneNumber,
          ),
        );
      },
      setUserSessionExpired: () {
        store.dispatch(SetFirebaseSessionExpired());
      },
      routeToLogin: () async {
        await authenticator.routeToLoginScreen();
      },
      setLoading: (bool isLoading) {
        store.dispatch(
          SignupLoading(
            isLoading: isLoading,
          ),
        );
      },
      signinEmailAndPassword: ({
        required String email,
        required String password,
      }) async {
        await authenticator.login(
          loginDetails: EmailLoginDetails(
            email: email,
            password: password,
          ),
        );
      },
      signInUserUsingEmailLink: authenticator.requestEmailLinkForEmailAddress,
      setAppUpdateNotificationSeen: () {
        store.dispatch(updateAppNeededNotificationSeen());
      },
      subscribeToEmailToNotifications: ({
        required String email,
        required bool receiveNotifications,
      }) {
        if (email.toLowerCase().trim() != store.state.userState.email) {
          log.warn(
            'Cannot subscribeToEmailToNotifications as email on set email onboarding screen not same as email in userstate.',
          );
          return;
        }
        store.dispatch(
          subscribeToWaitingListEmails(
            email: email,
            receiveUpdates: receiveNotifications,
          ),
        );
      },
    );
  }

  final String walletAddress;
  final bool userIsVerified;
  final bool loggedInToVegi;
  final bool hasLoggedInBefore;
  final bool surveyCompleted;
  final String countryCode;
  final String dialCode;
  final String phoneNumber;
  final bool isSuperAdmin;
  final String phoneNumberNoCountry;
  final String email;
  final String? password;
  final String displayName;
  final bool hasNotOnboarded;
  final bool accountDetailsExist;
  final bool isLoggedInToVegi;
  final BiometricAuth biometricAuth;
  final String? firebaseSessionToken;
  @override
  final FirebaseAuthenticationStatus firebaseAuthenticationStatus;
  @override
  final FuseAuthenticationStatus fuseAuthenticationStatus;
  @override
  final VegiAuthenticationStatus vegiAuthenticationStatus;
  final bool signupIsInFlux;
  final SignUpErrorDetails? signupError;
  final bool appUpdateNeeded;
  final Version? appUpdateNextVersion;
  final Version? appUpdateNotificationSeenForBuildNumber;
  final String signupStatusMessage;

  final void Function({
    required String email,
    required bool receiveNotifications,
  }) subscribeToEmailToNotifications;
  // final void Function({
  //   required CountryCode countryCode,
  //   required PhoneNumber phoneNumber,
  // }) setPhoneNumber;
  final Future<void> Function({
    required String email,
    required void Function(String) onError,
    Future<void> Function()? onComplete,
  }) setEmail;
  final void Function({
    required CountryCode countryCode,
    required PhoneNumber phoneNumber,
  }) signin;
  final void Function() setUserSessionExpired;
  final void Function() routeToLogin;
  final void Function(bool) setLoading;
  final void Function({
    required String email,
    required String password,
  }) signinEmailAndPassword;
  final void Function({
    required String email,
  }) signInUserUsingEmailLink;
  final void Function() setAppUpdateNotificationSeen;

  bool get isReauthenticationRequest =>
      firebaseAuthenticationStatus !=
      FirebaseAuthenticationStatus.unauthenticated;

  bool get updateNotificationNeeded =>
      appUpdateNeeded &&
      appUpdateNextVersion != null &&
      appUpdateNotificationSeenForBuildNumber != null &&
      appUpdateNotificationSeenForBuildNumber! > appUpdateNextVersion!;

  bool get displayNameIsSet =>
      displayName != '' && displayName != VegiConstants.defaultDisplayName;

  bool get biometricAuthIsSet => biometricAuth != BiometricAuth.none;

  bool get emailIsSet => email.isNotEmpty;

  bool get isLoggedIn => isLoggedInToVegi;

  @override
  List<Object?> get props => [
        walletAddress,
        userIsVerified,
        loggedInToVegi,
        hasLoggedInBefore,
        surveyCompleted,
        isSuperAdmin,
        phoneNumber,
        phoneNumberNoCountry,
        email,
        password,
        displayName,
        hasNotOnboarded,
        accountDetailsExist,
        isLoggedInToVegi,
        biometricAuth,
        firebaseSessionToken ?? '',
        signupIsInFlux,
        signupError,
        signupStatusMessage,
        firebaseAuthenticationStatus,
        fuseAuthenticationStatus,
        vegiAuthenticationStatus,
        appUpdateNeeded,
        appUpdateNextVersion,
        appUpdateNotificationSeenForBuildNumber,
        dialCode,
        countryCode,
      ];
}
