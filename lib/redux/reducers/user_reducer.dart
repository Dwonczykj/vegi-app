import 'package:redux/redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/user_state.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/cash_wallet_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

final userReducers = combineReducers<UserState>([
  TypedReducer<UserState, ResetAppState>(_resetApp).call,
  TypedReducer<UserState, SetAppUpdateRequired>(_setAppUpdateRequired).call,
  TypedReducer<UserState, SetAppUpdateAcknowledged>(
          _setAppUpdateNotificationCheked)
      .call,
  TypedReducer<UserState, ResetSurveyCompleted>(_resetSurveyCompleted).call,
  TypedReducer<UserState, SetSubscribedToWaitingListUpdates>(
          _setSubscribedToWaitingListUpdates)
      .call,
  TypedReducer<UserState, SetWalletConnectURI>(_setWalletConnectURI).call,
  TypedReducer<UserState, GotWalletDataSuccess>(_getWalletDataSuccess).call,
  TypedReducer<UserState, SetSmartWalletInMemory>(_setSmartWallet).call,
  TypedReducer<UserState, SetStripeCustomerDetails>(_setStripeCustomerDetails)
      .call,
  TypedReducer<UserState, ScrollToTop>(_scrollToTop).call,
  TypedReducer<UserState, ToggleUpgrade>(_toggleUpgrade).call,
  TypedReducer<UserState, CreateLocalAccountSuccess>(_createNewWalletSuccess)
      .call,
  TypedReducer<UserState, ResetFuseCredentials>(_resetFuseCredentials).call,
  // TypedReducer<UserState, AddSurveyEmailSuccess>(_addSurveyEmailSuccess),
  TypedReducer<UserState, CreateSurveyCompletedSuccess>(_completeSurveySuccess)
      .call,
  TypedReducer<UserState, SetPhoneNumberSuccess>(_setPhoneNumber).call,
  TypedReducer<UserState, LoginRequestSuccess>(_loginSuccess).call,
  TypedReducer<UserState, SetJWTSuccess>(_setJWTSuccess).call,
  TypedReducer<UserState, LogoutRequestSuccess>(_logoutSuccess).call,
  TypedReducer<UserState, SetPincodeSuccess>(_setPincode).call,
  TypedReducer<UserState, SetCompletedOnboardingSuccess>(
          _setCompletedOnboarding)
      .call,
  TypedReducer<UserState, SetDisplayName>(_setDisplayName).call,
  TypedReducer<UserState, SetEmail>(_setEmail).call,
  TypedReducer<UserState, SetEmailPassword>(_setEmailAndPassword).call,
  TypedReducer<UserState, SetPreferredSignOnMethod>(_setPreferredSignonMethod)
      .call,
  TypedReducer<UserState, SetUserAuthenticationStatus>(
          _setUserAuthenticationStatus)
      .call,
  TypedReducer<UserState, EmailWLRegistrationSuccess>(
    _setUserEmailForRegistrationToWaitingList,
  ).call,
  TypedReducer<UserState, SetSurveyQuestionsSuccess>(
    _setSurveyQuestions,
  ).call,
  TypedReducer<UserState, SetUserAvatar>(_setUserAvatar).call,
  TypedReducer<UserState, SetTempUserAvatar>(_setTempUserAvatar).call,
  TypedReducer<UserState, BackupSuccess>(_backupSuccess).call,
  TypedReducer<UserState, StoreBackupStatus>(_storeBackupStatus).call,
  TypedReducer<UserState, SetFirebaseCredentials>(_setFirebaseCredentials).call,
  TypedReducer<UserState, SetFirebaseSessionToken>(_setFirebaseSessionToken)
      .call,
  TypedReducer<UserState, SetFuseWalletCredentials>(_setFuseWalletCredentials)
      .call,
  TypedReducer<UserState, SetVerificationId>(_setVerificationId).call,
  TypedReducer<UserState, SetVerificationFailed>(_setVerificationFailed).call,
  TypedReducer<UserState, SetFirebaseSessionExpired>(_setVegiSessionExpired)
      .call,
  TypedReducer<UserState, SetVegiSessionCookie>(_setVegiSessionCookie).call,
  TypedReducer<UserState, SetVegiUserId>(_setVegiUserId).call,
  TypedReducer<UserState, SetVegiSessionCookie>(_setVegiSessionCookie).call,
  TypedReducer<UserState, JustInstalled>(_justInstalled).call,
  TypedReducer<UserState, DeviceIdSuccess>(_deviceIdSuccess).call,
  TypedReducer<UserState, SetSecurityType>(_setSecurityType).call,
  TypedReducer<UserState, SetBiometricallyAuthenticated>(
          _setBiometricallyAuthenticated)
      .call,
  TypedReducer<UserState, WarnSendDialogShowed>(_warnSendDialogShowed).call,
  TypedReducer<UserState, UpdateCurrency>(_updateCurrency).call,
  TypedReducer<UserState, UpdateLocale>(_updateLocale).call,
  TypedReducer<UserState, UpdateListOfDeliveryAddresses>(_addDeliveryAddress)
      .call,
  TypedReducer<UserState, SetShowSeedPhraseBanner>(_setShowSeedPhraseBanner)
      .call,
  TypedReducer<UserState, SetHasSavedSeedPhrase>(_setHasSavedSeedPhrase).call,
  TypedReducer<UserState, EnableLocationServices>(_setLocationServicesEnabled)
      .call,
  TypedReducer<UserState, SetUserVerifiedStatusSuccess>(
    _setUserVerifiedStatusSuccessResponse,
  ).call,
  TypedReducer<UserState, SetUserVegiAccountIdSuccess>(
    _setUserVegiAccountIdSuccessResponse,
  ).call,
  TypedReducer<UserState, SetUserIsVendorStatusSuccess>(
    _setUserIsVendorSuccessResponse,
  ).call,
  TypedReducer<UserState, SetDeviceIsSimulatorRTO>(
    _setDeviceIsSimulator,
  ).call,
  TypedReducer<UserState, SetUserRoleOnVegi>(
    _setVegiRole,
  ).call,
  TypedReducer<UserState, SetPositionInWaitingList>(
    _setPositionInWaitingList,
  ).call,
]);

UserState _resetApp(
  UserState state,
  ResetAppState action,
) {
  return UserState.initial();
}

UserState _setAppUpdateRequired(
  UserState state,
  SetAppUpdateRequired action,
) {
  return state.copyWith(
    appUpdateNeeded: action.appUpdateNeeded,
    appUpdateNextVersion: action.appUpdateNextVersion,
  );
}

UserState _setAppUpdateNotificationCheked(
  UserState state,
  SetAppUpdateAcknowledged action,
) {
  return state.copyWith(
    appUpdateNotificationSeenForBuildNumber: action.versionNumberAcknowledged,
  );
}

UserState _resetSurveyCompleted(
  UserState state,
  ResetSurveyCompleted action,
) {
  return state.copyWith(
    surveyCompleted: false,
  );
}

UserState _setSubscribedToWaitingListUpdates(
  UserState state,
  SetSubscribedToWaitingListUpdates action,
) {
  return state.copyWith(
    subscribedToWaitingListUpdates: action.updatedEntry.emailUpdates,
  );
}

UserState _setVegiRole(
  UserState state,
  SetUserRoleOnVegi action,
) {
  return state.copyWith(
    userVegiRole: action.userRole,
    isVegiSuperAdmin: action.isSuperAdmin,
  );
}

UserState _setPositionInWaitingList(
  UserState state,
  SetPositionInWaitingList action,
) {
  return state.copyWith(
    positionInWaitingList: action.positionInQueue,
  );
}

UserState _setWalletConnectURI(
  UserState state,
  SetWalletConnectURI action,
) {
  return state.copyWith(wcURI: action.wcURI);
}

UserState _scrollToTop(
  UserState state,
  ScrollToTop action,
) {
  return state.copyWith(scrollToTop: action.value);
}

UserState _toggleUpgrade(
  UserState state,
  ToggleUpgrade action,
) {
  return state.copyWith(
    hasUpgrade: action.value,
  );
}

UserState _updateLocale(
  UserState state,
  UpdateLocale action,
) {
  return state.copyWith(locale: action.locale);
}

UserState _updateCurrency(
  UserState state,
  UpdateCurrency action,
) {
  return state.copyWith(currency: action.currency);
}

UserState _setDeviceIsSimulator(
  UserState state,
  SetDeviceIsSimulatorRTO action,
) {
  return state.copyWith(
    isUsingSimulator: action.isSimulator,
    isUsingIosSimulator: action.isIosSimulator,
  );
}

UserState _warnSendDialogShowed(
  UserState state,
  WarnSendDialogShowed action,
) {
  return state.copyWith(
    warnSendDialogShowed: action.value,
  );
}

UserState _getWalletDataSuccess(
  UserState state,
  GotWalletDataSuccess action,
) {
  return state.copyWith(
    networks: action.networks,
    walletAddress: action.walletAddress,
    walletModules: action.walletModules,
  );
}

UserState _setSmartWallet(
  UserState state,
  SetSmartWalletInMemory action,
) {
  return state.copyWith(
    smartWallet: action.smartWallet,
  );
}

UserState _setStripeCustomerDetails(
  UserState state,
  SetStripeCustomerDetails action,
) {
  return state.copyWith(
    stripeCustomerId: action.customerId,
  );
}

UserState _backupSuccess(
  UserState state,
  BackupSuccess action,
) {
  return state.copyWith(backup: true);
}

UserState _storeBackupStatus(
  UserState state,
  StoreBackupStatus action,
) {
  return state.copyWith(backup: action.isSmartWalletBackedUp);
}

UserState _setUserAuthenticationStatus(
  UserState state,
  SetUserAuthenticationStatus action,
) {
  log.info(
    'AUTH CHG: (${state.authStateEmj}) + (${action.updates()}) -> '
    '🔥->${authEnumToEmoji(action.firebaseStatus ?? state.firebaseAuthenticationStatus)}, 🥑->${authEnumToEmoji(action.vegiStatus ?? state.vegiAuthenticationStatus)}, 👾->${authEnumToEmoji(action.fuseStatus ?? state.fuseAuthenticationStatus)}',
    sentry: true,
    stackTrace: StackTrace.current,
  );
  if (action.fuseStatus != null &&
      state.fuseAuthenticationStatus ==
          FuseAuthenticationStatus.authenticated) {
    log.info('AUTH CHANGE: FUSE -> ${action.fuseStatus}');
  }
  if (action.firebaseStatus != null &&
      state.firebaseAuthenticationStatus ==
          FirebaseAuthenticationStatus.authenticated) {
    log.info('AUTH CHANGE: FIREBASE -> ${action.firebaseStatus}');
  }
  if (action.vegiStatus != null &&
      state.vegiAuthenticationStatus ==
          VegiAuthenticationStatus.authenticated) {
    log.info('AUTH CHANGE: VEGI -> ${action.vegiStatus}');
  }
  return state.copyWith(
    firebaseAuthenticationStatus:
        action.firebaseStatus ?? state.firebaseAuthenticationStatus,
    fuseAuthenticationStatus:
        action.fuseStatus ?? state.fuseAuthenticationStatus,
    vegiAuthenticationStatus:
        action.vegiStatus ?? state.vegiAuthenticationStatus,
    // isLoggedOut: (action.vegiStatus ?? state.vegiAuthenticationStatus) ==
    //             VegiAuthenticationStatus.authenticated &&
    //         state.isLoggedOut
    //     ? false
    //     : state.isLoggedOut,
  );
}

UserState _createNewWalletSuccess(
  UserState state,
  CreateLocalAccountSuccess action,
) {
  return state.copyWith(
    mnemonic: action.mnemonic,
    privateKey: action.privateKey,
    fuseWalletCredentials: action.fuseWalletCredentials,
    // accountAddress: action.accountAddress,
  );
}

UserState _resetFuseCredentials(
  UserState state,
  ResetFuseCredentials action,
) {
  return state.copyWith(
    privateKey: action.privateKeyForPhone ?? '',
    fuseAuthenticationStatus: FuseAuthenticationStatus.unauthenticated,
    fuseWalletCredentials: null,
    // accountAddress: action.accountAddress,
  );
}

// UserState _addSurveyEmailSuccess(
//   UserState state,
//   AddSurveyEmailSuccess action,
// ) {
//   return state.copyWith(
//     surveyEmailUsed: action.email,
//   );
// }

UserState _completeSurveySuccess(
  UserState state,
  CreateSurveyCompletedSuccess action,
) {
  return state.copyWith(
    surveyCompleted: action.completed,
  );
}

UserState _setPhoneNumber(
  UserState state,
  SetPhoneNumberSuccess action,
) {
  return state.copyWith(
    countryCode: action.countryCode.dialCode!,
    isoCode: action.countryCode.code!,
    phoneNumberNoCountry: action.phoneNumber.nationalNumber,
    phoneNumber: action.phoneNumber.e164,
  );
}

UserState _loginSuccess(
  UserState state,
  LoginRequestSuccess action,
) {
  log.info('$action');
  return state.copyWith(
    countryCode: action.countryCode.dialCode!,
    isoCode: action.countryCode.code!,
    phoneNumber: action.phoneNumber.e164,
    phoneNumberNoCountry: action.phoneNumber.nationalNumber,
    firebaseAuthenticationStatus: FirebaseAuthenticationStatus.authenticated,
  );
}

UserState _setVerificationId(
  UserState state,
  SetVerificationId action,
) {
  return state.copyWith(
    verificationId: action.verificationId,
  );
}

UserState _setVerificationFailed(
  UserState state,
  SetVerificationFailed action,
) {
  log.info('$action');
  return state.copyWith(
    verificationPassed: false,
    firebaseAuthenticationStatus:
        FirebaseAuthenticationStatus.phoneAuthVerificationFailed,
  );
}

UserState _setVegiSessionExpired(
  UserState state,
  SetFirebaseSessionExpired action,
) {
  log.info('$action');
  return state.copyWith(
    firebaseAuthenticationStatus: FirebaseAuthenticationStatus.expired,
  );
}

UserState _setVegiSessionCookie(
  UserState state,
  SetVegiSessionCookie action,
) {
  log.info('$action');
  return state.copyWith(
    vegiSessionCookie: action.cookie,
  );
}

UserState _setVegiUserId(
  UserState state,
  SetVegiUserId action,
) {
  log.info('$action');
  return state.copyWith(
    vegiUserId: action.id,
  );
}

UserState _setJWTSuccess(
  UserState state,
  SetJWTSuccess action,
) {
  return state.copyWith(
    jwtToken: action.jwtToken,
  );
}

UserState _logoutSuccess(
  UserState state,
  LogoutRequestSuccess action,
) {
  log.info('LogoutRequestSuccess ACTION: $action');
  return state.copyWith(
    biometricallyAuthenticated: false,
    firebaseSessionToken: null,
    fuseAuthenticationStatus: FuseAuthenticationStatus.unauthenticated,
    firebaseAuthenticationStatus: FirebaseAuthenticationStatus.unauthenticated,
    vegiAuthenticationStatus: VegiAuthenticationStatus.unauthenticated,
    jwtToken: '',
    verificationId: '',
    walletAddress: '',
    privateKey: '',
    userIsVerified: false,
    password: '',
    // vegiUserId: null,
    // email: '',
    // phoneNumber: '',
    displayName: '',
    avatarUrl: '',
    firebaseCredentials: null,
    // accountAddress: '',
    hasSavedSeedPhrase: false,
    // mnemonic: [
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    // ],
    // preferredSignonMethod: PreferredSignonMethod.phone,
  );
}

UserState _setDisplayName(
  UserState state,
  SetDisplayName action,
) {
  return state.copyWith(displayName: action.displayName);
}

UserState _setEmail(
  UserState state,
  SetEmail action,
) {
  return state.copyWith(email: action.email.toLowerCase());
}

UserState _setEmailAndPassword(
  UserState state,
  SetEmailPassword action,
) {
  return state.copyWith(
    email: action.email.toLowerCase(),
    password: action.password,
  );
}

UserState _setPreferredSignonMethod(
  UserState state,
  SetPreferredSignOnMethod action,
) {
  return state.copyWith(
    preferredSignonMethod: action.preferredSignonMethod,
  );
}

UserState _setUserAvatar(
  UserState state,
  SetUserAvatar action,
) {
  return state.copyWith(
    avatarUrl: action.avatarUrl,
    avatarTempFilePath: '',
  );
}

UserState _setTempUserAvatar(
  UserState state,
  SetTempUserAvatar action,
) {
  return state.copyWith(
    avatarTempFilePath: action.tempAvatarFile.path,
    avatarUrl: '',
  );
}

UserState _setPincode(
  UserState state,
  SetPincodeSuccess action,
) {
  return state.copyWith(
    pincode: action.pincode,
  );
}

UserState _setCompletedOnboarding(
  UserState state,
  SetCompletedOnboardingSuccess action,
) {
  return state;
}

UserState _setSecurityType(
  UserState state,
  SetSecurityType action,
) {
  return state.copyWith(
    authType: action.biometricAuth,
  );
}

UserState _setBiometricallyAuthenticated(
  UserState state,
  SetBiometricallyAuthenticated action,
) {
  return state.copyWith(
    biometricallyAuthenticated: action.isBiometricallyAuthenticated,
  );
}

UserState _setFirebaseCredentials(
  UserState state,
  SetFirebaseCredentials action,
) {
  return state.copyWith(firebaseCredentials: action.firebaseCredentials);
}

UserState _setFirebaseSessionToken(
  UserState state,
  SetFirebaseSessionToken action,
) {
  return state.copyWith(
    firebaseSessionToken: action.firebaseSessionToken,
    firebaseAuthenticationStatus: FirebaseAuthenticationStatus.authenticated,
  );
}

UserState _setFuseWalletCredentials(
  UserState state,
  SetFuseWalletCredentials action,
) {
  return state.copyWith(fuseWalletCredentials: action.fuseWalletCredentials);
}

UserState _justInstalled(
  UserState state,
  JustInstalled action,
) {
  return state.copyWith(installedAt: action.installedAt);
}

UserState _deviceIdSuccess(
  UserState state,
  DeviceIdSuccess action,
) {
  return state.copyWith(identifier: action.identifier);
}

UserState _addDeliveryAddress(
  UserState state,
  UpdateListOfDeliveryAddresses action,
) {
  return state.copyWith(listOfDeliveryAddresses: action.listOfAddresses);
}

UserState _setShowSeedPhraseBanner(
  UserState state,
  SetShowSeedPhraseBanner action,
) {
  return state.copyWith(showSeedPhraseBanner: action.showSeedPhraseBanner);
}

UserState _setHasSavedSeedPhrase(
  UserState state,
  SetHasSavedSeedPhrase action,
) {
  return state.copyWith(hasSavedSeedPhrase: action.hasSavedSeedPhrase);
}

UserState _setLocationServicesEnabled(
  UserState state,
  EnableLocationServices action,
) {
  return state.copyWith(useLiveLocation: action.enabled);
}

UserState _setUserLocation(
  UserState state,
  UpdateUserLocation action,
) {
  return state.copyWith(userLocation: action.newLocation);
}

UserState _setUserEmailForRegistrationToWaitingList(
  UserState state,
  EmailWLRegistrationSuccess action,
) {
  return state.copyWith(
    email: action.entry.email.toLowerCase(),
    surveyEmailUsed: action.entry.email.toLowerCase(),
    subscribedToWaitingListUpdates: action.entry.emailUpdates,
    waitingListEntryId: action.entry.id,
  );
}

UserState _setSurveyQuestions(
  UserState state,
  SetSurveyQuestionsSuccess action,
) {
  return state.copyWith(
    surveyQuestions: action.questions,
  );
}

UserState _setUserVerifiedStatusSuccessResponse(
  UserState state,
  SetUserVerifiedStatusSuccess action,
) {
  return state.copyWith(
    userIsVerified: action.userIsVerified,
  );
}

UserState _setUserVegiAccountIdSuccessResponse(
  UserState state,
  SetUserVegiAccountIdSuccess action,
) {
  return state.copyWith(
    vegiAccountId: action.accountId,
  );
}

UserState _setUserIsVendorSuccessResponse(
  UserState state,
  SetUserIsVendorStatusSuccess action,
) {
  return state.copyWith(
    isVendor: action.isVendor,
  );
}

// UserState _setSurveyResponse(
//   UserState state,
//   SurveyResponseSuccess action,
// ) {
//   return state.copyWith(email: action.email.toLowerCase(), questionNumberResponded: action.questionNumber,);
// }
