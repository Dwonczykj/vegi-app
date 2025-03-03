import 'package:country_code_picker/country_code_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/authViewModel.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/onboard/authentication.dart';
import 'package:vegan_liverpool/utils/onboard/firebase.dart';

import 'package:vegan_liverpool/common/router/routes.gr.dart';

class BackupViewModel extends Equatable {
  const BackupViewModel({
    required this.backupWallet,
    required this.userMnemonic,
  });

  factory BackupViewModel.fromStore(Store<AppState> store) {
    return BackupViewModel(
      userMnemonic: store.state.userState.mnemonic,
      backupWallet: () {
        store.dispatch(
          BackupSuccess(),
        );
      },
    );
  }

  final void Function() backupWallet;
  final List<String> userMnemonic;

  @override
  List<Object?> get props => [userMnemonic];
}

class LockScreenViewModel extends Equatable implements IAuthViewModel {
  const LockScreenViewModel({
    required this.pincode,
    required this.loginAgain,
    required this.loggedIn,
    required this.signupInFlux,
    required this.biometricAuth,
    required this.biometricallyAuthenticated,
    required this.setBiometricallyAuthenticated,
    required this.loginToVegi,
    required this.firebaseAuthenticationStatus,
    required this.fuseAuthenticationStatus,
    required this.vegiAuthenticationStatus,
    required this.notAuthenticated,
    required this.notOnboarded,
  });

  factory LockScreenViewModel.fromStore(Store<AppState> store) {
    return LockScreenViewModel(
      pincode: store.state.userState.pincode,
      loggedIn: !store.state.userState.hasNotOnboarded,
      signupInFlux: store.state.onboardingState.signupIsInFlux,
      biometricAuth: store.state.userState.authType,
      biometricallyAuthenticated:
          store.state.userState.biometricallyAuthenticated,
      firebaseAuthenticationStatus:
          store.state.userState.firebaseAuthenticationStatus,
      fuseAuthenticationStatus: store.state.userState.fuseAuthenticationStatus,
      vegiAuthenticationStatus: store.state.userState.vegiAuthenticationStatus,
      setBiometricallyAuthenticated: ({
        required bool isBiometricallyAuthenticated,
      }) {
        store.dispatch(
          SetBiometricallyAuthenticated(
            isBiometricallyAuthenticated: isBiometricallyAuthenticated,
          ),
        );
      },
      loginToVegi: () async {
        if (store.state.userState.firebaseSessionToken == null) {
          return;
        }
        try {
          await authenticator.login(
            loginDetails: PhoneLoginDetails(
              countryCode: CountryCode(
                dialCode: store.state.userState.countryCode,
                code: store.state.userState.isoCode,
              ),
              phoneNumber: await PhoneNumberUtil().parse(
                store.state.userState.phoneNumberNoCountry,
                regionCode: store.state.userState.isoCode,
              ),
            ),
          );
        } on Exception catch (e, s) {
          log.error(
            'Failed to login to vegi from backup with error: $e',
            error: e,
            stackTrace: s,
          );
        }
      },
      loginAgain: authenticator.reauthenticate,
      notOnboarded: store.state.userState.hasNotOnboarded,
      notAuthenticated: !store.state.userState.isLoggedIn,
    );
  }

  final String pincode;
  final bool loggedIn;
  final bool signupInFlux;
  final bool notAuthenticated;
  final bool notOnboarded;
  final BiometricAuth biometricAuth;
  final bool biometricallyAuthenticated;
  final Future<void> Function() loginToVegi;
  final void Function() loginAgain;
  final void Function({required bool isBiometricallyAuthenticated})
      setBiometricallyAuthenticated;
  @override
  final FirebaseAuthenticationStatus firebaseAuthenticationStatus;
  @override
  final FuseAuthenticationStatus fuseAuthenticationStatus;
  @override
  final VegiAuthenticationStatus vegiAuthenticationStatus;

  @override
  List<Object?> get props => [
        pincode,
        loggedIn,
        signupInFlux,
        notOnboarded,
        notAuthenticated,
        biometricallyAuthenticated,
        biometricAuth,
        firebaseAuthenticationStatus,
        fuseAuthenticationStatus,
        vegiAuthenticationStatus,
      ];
}
