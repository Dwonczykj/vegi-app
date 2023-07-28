import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_number/phone_number.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/package_info.dart';
import 'package:vegan_liverpool/common/network/web3auth.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/analytics_props.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/admin/surveyQuestion.dart';
import 'package:vegan_liverpool/models/admin/postVegiResponse.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/restaurant/deliveryAddresses.dart';
import 'package:vegan_liverpool/models/user_state.dart';
import 'package:vegan_liverpool/models/waitingListFunnel/waitingListEntry.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/cash_wallet_actions.dart';
import 'package:vegan_liverpool/redux/actions/home_page_actions.dart';
import 'package:vegan_liverpool/redux/actions/onboarding_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/errorDetails.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/services/apis/locationService.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/json_helpers.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/onboard/authentication.dart';
import 'package:vegan_liverpool/utils/onboard/firebase.dart';
import 'package:vegan_liverpool/utils/onboard/fuseAuthUtils.dart';
import 'package:vegan_liverpool/version.dart';

class ResetAppState {
  ResetAppState();
  @override
  String toString() => 'ResetAppState';
}

class SetWalletConnectURI {
  SetWalletConnectURI(this.wcURI);
  final String wcURI;

  @override
  String toString() => 'SetWalletConnectURI : wcURI: $wcURI';
}

class SetAppUpdateRequired {
  SetAppUpdateRequired({
    required this.appUpdateNeeded,
    required this.appUpdateNextVersion,
  });

  final bool appUpdateNeeded;
  final Version? appUpdateNextVersion;

  @override
  String toString() {
    return 'SetAppUpdateRequired : updateNeeded:"$appUpdateNeeded", appUpdateNextVersion: $appUpdateNextVersion';
  }
}

class SetAppUpdateAcknowledged {
  SetAppUpdateAcknowledged({
    required this.versionNumberAcknowledged,
  });

  final Version? versionNumberAcknowledged;

  @override
  String toString() {
    return 'SetAppUpdateAcknowledged : versionNumberAcknowledged:"$versionNumberAcknowledged"';
  }
}

class ScrollToTop {
  ScrollToTop({
    required this.value,
  });
  final bool value;

  @override
  String toString() => 'ScrollToTop : value: $value';
}

class ToggleUpgrade {
  ToggleUpgrade({
    required this.value,
  });
  final bool value;

  @override
  String toString() => 'ToggleUpgrade : value: $value';
}

class EnableLocationServices {
  EnableLocationServices({
    required this.enabled,
  });
  final bool enabled;

  @override
  String toString() => 'EnableLocationServices : enabled: $enabled';
}

class UpdateUserLocation {
  UpdateUserLocation({
    required this.newLocation,
  });
  final Position newLocation;

  @override
  String toString() => 'UpdateUserLocation : newLocation: $newLocation';
}

class UpdateCurrency {
  UpdateCurrency({required this.currency});
  final String currency;

  @override
  String toString() => 'UpdateCurrency : currency: $currency';
}

class UpdateLocale {
  UpdateLocale({required this.locale});
  final Locale locale;

  @override
  String toString() => 'UpdateLocale : locale: $locale';
}

class SetDeviceIsSimulatorRTO {
  SetDeviceIsSimulatorRTO({
    required this.isSimulator,
    required this.isIosSimulator,
  });

  final bool isSimulator;
  final bool isIosSimulator;

  @override
  String toString() {
    return 'SetDeviceIsSimulatorRTO : Simulator=$isSimulator; ios=$isIosSimulator';
  }
}

class SetStripeCustomerDetails {
  SetStripeCustomerDetails({
    required this.customerId,
  });

  final String? customerId;

  @override
  String toString() {
    return 'SetStripeCustomerDetails : customerId=$customerId';
  }
}

class WarnSendDialogShowed {
  WarnSendDialogShowed({
    required this.value,
  });
  final bool value;

  @override
  String toString() => 'WarnSendDialogShowed : value: $value';
}

class SetSecurityType {
  SetSecurityType({required this.biometricAuth});
  BiometricAuth biometricAuth;

  @override
  String toString() => 'SetSecurityType : biometricAuth: $biometricAuth';
}

class SetBiometricallyAuthenticated {
  SetBiometricallyAuthenticated({required this.isBiometricallyAuthenticated});
  bool isBiometricallyAuthenticated;

  @override
  String toString() =>
      'SetBiometricallyAuthenticated : isBiometricallyAuthenticated: $isBiometricallyAuthenticated';
}

class CreateLocalAccountSuccess {
  CreateLocalAccountSuccess(
    this.mnemonic,
    this.privateKey,
    this.fuseWalletCredentials,
    // this.accountAddress,
  );
  final List<String> mnemonic;
  final String privateKey;
  final EthPrivateKey fuseWalletCredentials;
  // final String accountAddress;

  @override
  String toString() => 'CreateLocalAccountSuccess';
}

class ResetFuseCredentials {
  ResetFuseCredentials({
    required this.privateKeyForPhone,
  });

  final String? privateKeyForPhone;

  @override
  String toString() {
    return 'ResetFuseCredentials: privateKey:"$privateKeyForPhone"';
  }
}

class CreateSurveyCompletedSuccess {
  CreateSurveyCompletedSuccess(
    this.completed,
  );

  final bool completed;

  @override
  String toString() => 'CreateSurveyCompletedSuccess:'
      ' completed: $completed';
}

class AddSurveyEmailSuccess {
  AddSurveyEmailSuccess(
    this.email,
  );

  final String email;

  @override
  String toString() => 'AddSurveyEmailSuccess:'
      ' email: $email';
}

class SetUserAuthenticationStatus {
  SetUserAuthenticationStatus({
    this.firebaseStatus,
    this.vegiStatus,
    this.fuseStatus,
  }) {
    log.info(
      '$this',
      sentry: true,
      stackTraceLines: StackTrace.current.filterCallStack(
        ignoreLastNCalls: 1,
      ),
    );
  }

  final FirebaseAuthenticationStatus? firebaseStatus;
  final VegiAuthenticationStatus? vegiStatus;
  final FuseAuthenticationStatus? fuseStatus;

  @override
  String toString() {
    return 'SetUserAuthenticationStatus ACTION: '
        '${fuseStatus == null ? '' : 'Fuse.[${fuseStatus!.name}]'}, '
        '${firebaseStatus == null ? '' : 'Firebase.[${firebaseStatus!.name}]'}, '
        '${vegiStatus == null ? '' : 'Vegi.[${vegiStatus!.name}]'}';
  }

  String updates() {
    String updateStr = '';
    if (vegiStatus != null) {
      final add = '🥑: ${vegiStatus!.name}';
      updateStr = updateStr.isEmpty ? add : '$updateStr, $add';
    }
    if (firebaseStatus != null) {
      final add = '🔥: ${firebaseStatus!.name}';
      updateStr = updateStr.isEmpty ? add : '$updateStr, $add';
    }
    if (fuseStatus != null) {
      final add = '👾: ${fuseStatus!.name}';
      updateStr = updateStr.isEmpty ? add : '$updateStr, $add';
    }
    return updateStr;
  }
}

// class AuthenticateFuseWalletSDKFailure {
//   AuthenticateFuseWalletSDKFailure({
//     required this.fuseStatus,
//   });

//   final FuseAuthenticationStatus fuseStatus;

//   @override
//   String toString() {
//     return 'AuthenticateFuseWalletSDKFailure : error:"$fuseStatus"';
//   }
// }

// class FetchFuseSmartWalletFailure {
//   FetchFuseSmartWalletFailure({
//     required this.fuseStatus,
//   });

//   final FuseAuthenticationStatus fuseStatus;

//   @override
//   String toString() {
//     return 'FetchFuseSmartWalletFailure : $fuseStatus';
//   }
// }

class EmailWLRegistrationSuccess {
  EmailWLRegistrationSuccess({
    required this.entry,
  });
  final WaitingListEntry entry;

  @override
  String toString() => 'EmailWLRegistrationSuccess : email: $entry';
}

// class SurveyResponseSuccess {
//   SurveyResponseSuccess({
//     required this.email,
//     required this.questionNumber,
//     required this.question,
//     required this.answer,
//   });
//   final String email;
//   final int questionNumber;
//   final String question;
//   final String answer;

//   @override
//   String toString() =>
//       'SurveyResponseSuccess : email: $email, questionNumber: $questionNumber, question: $question, answer: $answer';
// }

class SetSurveyQuestionsSuccess {
  SetSurveyQuestionsSuccess({
    required this.questions,
  });
  final List<SurveyQuestion> questions;

  @override
  String toString() => 'SetSurveyQuestionsSuccess : email[${questions.length}]';
}

class SetPhoneNumberSuccess {
  SetPhoneNumberSuccess({
    required this.countryCode,
    required this.phoneNumber,
    this.displayName,
    this.email,
  });
  final CountryCode countryCode;
  final PhoneNumber phoneNumber;
  final String? displayName;
  final String? email;

  @override
  String toString() => 'SetPhoneNumberSuccess : countryCode: $countryCode, '
      'phoneNumber: ${phoneNumber.e164}, displayName: $displayName, email: $email';
}

class LoginRequestSuccess {
  LoginRequestSuccess({
    required this.countryCode,
    required this.phoneNumber,
    this.displayName,
    this.email,
  });
  final CountryCode countryCode;
  final PhoneNumber phoneNumber;
  final String? displayName;
  final String? email;

  @override
  String toString() => 'LoginRequestSuccess : countryCode: $countryCode, '
      'phoneNumber: ${phoneNumber.e164}, displayName: $displayName, email: $email';
}

class LogoutRequestSuccess {
  LogoutRequestSuccess();

  @override
  String toString() => 'LogoutRequestSuccess';
}

class SetJWTSuccess {
  SetJWTSuccess(this.jwtToken);
  final String jwtToken;

  @override
  String toString() => 'LoginVerifySuccess : jwtToken: $jwtToken,';
}

class SetPincodeSuccess {
  SetPincodeSuccess(this.pincode);
  String pincode;

  @override
  String toString() => 'SetPincodeSuccess : pincode: $pincode';
}

class SetCompletedOnboardingSuccess {
  SetCompletedOnboardingSuccess({
    required this.onboardingCompleted,
  });

  final bool onboardingCompleted;

  @override
  String toString() {
    return 'SetCompletedOnboardingSuccess : onboardingCompleted:"$onboardingCompleted"';
  }
}

class SetDisplayName {
  SetDisplayName(this.displayName);
  String displayName;

  @override
  String toString() => 'SetDisplayName : displayName: $displayName';
}

class SetEmail {
  SetEmail(this.email);
  String email;

  @override
  String toString() => 'SetEmail : email: $email';
}

class SetEmailPassword {
  SetEmailPassword({
    required this.email,
    required this.password,
  });
  String email;
  String password;

  @override
  String toString() => 'SetEmailPassword : email: $email';
}

class SetPreferredSignOnMethod {
  SetPreferredSignOnMethod({
    required this.preferredSignonMethod,
  });

  final PreferredSignonMethod preferredSignonMethod;

  @override
  String toString() {
    return 'SetPreferredSignOnMethod : preferredSignonMethod:"${preferredSignonMethod.name}"';
  }
}

class ResetSurveyCompleted {
  ResetSurveyCompleted();

  @override
  String toString() {
    return 'ResetSurveyCompleted';
  }
}

class SetUserAvatar {
  SetUserAvatar(this.avatarUrl);
  String avatarUrl;

  @override
  String toString() => 'SetUserAvatar : avatarUrl: $avatarUrl';
}

class SetTempUserAvatar {
  SetTempUserAvatar({
    required this.tempAvatarFile,
  });

  final XFile tempAvatarFile;

  @override
  String toString() {
    return 'SetTempUserAvatar : tempAvatarFile:"$tempAvatarFile"';
  }
}

class SetUserVerifiedStatusSuccess {
  SetUserVerifiedStatusSuccess(this.userIsVerified);
  bool userIsVerified;

  @override
  String toString() =>
      'SetUserVerifiedStatusSuccess : userIsVerified: $userIsVerified';
}

class SetUserRoleOnVegi {
  SetUserRoleOnVegi({
    required this.userRole,
    required this.isSuperAdmin,
  });
  VegiRole userRole;
  bool isSuperAdmin;

  @override
  String toString() => 'SetUserRoleOnVegi : userRole: $userRole';
}

class SetUserVegiAccountIdSuccess {
  SetUserVegiAccountIdSuccess(this.accountId);
  int accountId;

  @override
  String toString() => 'SetUserVegiAccountIdSuccess : accountId: $accountId';
}

class SetUserIsVendorStatusSuccess {
  SetUserIsVendorStatusSuccess(this.isVendor);
  bool isVendor;

  @override
  String toString() => 'SetUserIsVendorStatusSuccess : isVendor: $isVendor';
}

class BackupRequest {
  BackupRequest();

  @override
  String toString() => 'BackupRequest';
}

class BackupSuccess {
  BackupSuccess();

  @override
  String toString() => 'BackupSuccess';
}

class StoreBackupStatus {
  StoreBackupStatus({
    required this.isSmartWalletBackedUp,
  });

  final bool isSmartWalletBackedUp;

  @override
  String toString() => 'StoreBackupStatus: $isSmartWalletBackedUp';
}

class SetFirebaseCredentials {
  SetFirebaseCredentials(this.firebaseCredentials);
  AuthCredential? firebaseCredentials;

  @override
  String toString() =>
      'SetFirebaseCredentials : credentials: $firebaseCredentials';
}

class SetFirebaseSessionToken {
  SetFirebaseSessionToken({required this.firebaseSessionToken});
  String? firebaseSessionToken;

  @override
  String toString() =>
      'SetFirebaseSessionToken : firebaseSessionToken: $firebaseSessionToken';
}

class SetFuseWalletCredentials {
  SetFuseWalletCredentials(this.fuseWalletCredentials);
  EthPrivateKey? fuseWalletCredentials;

  @override
  String toString() =>
      'SetFuseWalletCredentials : fuseWalletCredentials: $fuseWalletCredentials';
}

class SetSmartWalletInMemory {
  SetSmartWalletInMemory({
    required this.smartWallet,
  });

  final SmartWallet smartWallet;

  @override
  String toString() {
    return 'SetSmartWalletInMemory [smartWallet]:"${smartWallet.smartWalletAddress}"';
  }
}

class SetVerificationId {
  SetVerificationId(this.verificationId);
  String verificationId;

  @override
  String toString() => 'SetVerificationId : verificationId: $verificationId';
}

class SetVerificationFailed {
  SetVerificationFailed();

  @override
  String toString() {
    return 'SetVerificationFailed';
  }
}

class SetFirebaseSessionExpired {
  SetFirebaseSessionExpired();

  @override
  String toString() {
    return 'SetVegiSessionExpired';
  }
}

class SetVegiSessionCookie {
  SetVegiSessionCookie({
    required this.cookie,
  });

  final String cookie;

  @override
  String toString() {
    return 'SetVegiSessionCookie : cookie:"$cookie"';
  }
}

class SetVegiUserId {
  SetVegiUserId({
    required this.id,
  });

  final int id;

  @override
  String toString() {
    return 'SetVegiUserId : id:"$id"';
  }
}

class JustInstalled {
  JustInstalled(this.installedAt);
  final DateTime installedAt;

  @override
  String toString() => 'JustInstalled : installedAt: $installedAt';
}

class DeviceIdSuccess {
  DeviceIdSuccess(this.identifier);
  final String identifier;

  @override
  String toString() => 'DeviceIdSuccess : identifier: $identifier';
}

class UpdateListOfDeliveryAddresses {
  UpdateListOfDeliveryAddresses(this.listOfAddresses);
  final List<DeliveryAddresses> listOfAddresses;

  @override
  String toString() =>
      'UpdateListOfDeliveryAddresses : listOfAddresses: $listOfAddresses';
}

class SetShowSeedPhraseBanner {
  SetShowSeedPhraseBanner({required this.showSeedPhraseBanner});
  final bool showSeedPhraseBanner;

  @override
  String toString() =>
      'SetShowSeedPhraseBanner : showSeedPhraseBanner: $showSeedPhraseBanner,';
}

class SetHasSavedSeedPhrase {
  SetHasSavedSeedPhrase({required this.hasSavedSeedPhrase});
  final bool hasSavedSeedPhrase;

  @override
  String toString() =>
      'SetHasSavedSeedPhrase : hasSavedSeedPhrase: $hasSavedSeedPhrase';
}

class SetPositionInWaitingList {
  SetPositionInWaitingList({
    required this.positionInQueue,
  });

  final int positionInQueue;

  @override
  String toString() {
    return 'SetPositionInWaitingList : positionInQueue:"$positionInQueue"';
  }
}

ThunkAction<AppState> loggedInToVegiSuccess() {
  return (Store<AppState> store) async {
    try {
      store
        ..dispatch(
          SetUserAuthenticationStatus(
            vegiStatus: VegiAuthenticationStatus.authenticated,
            firebaseStatus: FirebaseAuthenticationStatus.authenticated,
          ),
        )
        ..dispatch(
          SignUpFailed(
            error: null,
          ),
        );
    } catch (e, s) {
      log.error(
        'ERROR - loggedInToVegiSuccess $e',
        sentryHint: 'ERROR - loggedInToVegiSuccess $e',
        stackTrace: s,
      );
    }
  };
}

ThunkAction<AppState> logoutRequest() {
  return (Store<AppState> store) async {
    try {
      await authenticator.logout(bypassSeedPhraseCheck: true);
      store.dispatch(LogoutRequestSuccess());
    } catch (e, s) {
      log.error('ERROR - logout $e', stackTrace: s);
    }
  };
}

ThunkAction<AppState> updateEmailForWaitingListEntry({
  required String email,
  void Function(String)? onError,
}) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(SetEmail(email.toLowerCase().trim()));

      if (store.state.userState.waitingListEntryId == null) {
        final warning =
            "Can't update user email with vegi as no waiting list entry id is stored in state...";
        log.error(warning);
        // onError(warning);
      } else {
        final updatedEntry =
            await peeplEatsService.updateEmailForWaitingListEntry(
          email: email,
          waitingListEntryId: store.state.userState.waitingListEntryId!,
          onError: (errStr) {
            log.error(errStr);
            Analytics.track(
              eventName: AnalyticsEvents.emailWLUpdateEmail,
              properties: {
                AnalyticsProps.status: AnalyticsProps.failed,
                'error': errStr,
              },
            );
            onError?.call(errStr);
          },
        );
        if (updatedEntry != null) {
          store
            ..dispatch(
              EmailWLRegistrationSuccess(
                entry: updatedEntry,
              ),
            )
            ..dispatch(
              SetSubscribedToWaitingListUpdates(
                updatedEntry: updatedEntry,
              ),
            );
          if (updatedEntry.email.toLowerCase() == email.toLowerCase()) {
            await onBoardStrategy.updateEmail(
              email: email,
            );
          }
        }
      }
    } catch (e, s) {
      log.error(
        'ERROR - updateEmailForWaitingListEntry $e',
        stackTrace: s,
      );
      // onError(
      //   'ERROR - updateEmailForWaitingListEntry $e',
      // );
    }
  };
}

ThunkAction<AppState> updateEmail({
  required String email,
  void Function(String)? onError,
}) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(SetEmail(email.toLowerCase().trim()));

      final regex = RegExp(r'\+([0-9]+)');
      final matchFull = regex.firstMatch(store.state.userState.countryCode);
      int countryCodeInt = 44;
      if (matchFull != null && matchFull.groupCount == 1) {
        countryCodeInt = int.parse(matchFull.group(1)!);
      }

      final errMsg = await peeplEatsService.updateUserDetails(
        phoneNoCountry: store.state.userState.phoneNumberNoCountry,
        phoneCountryCode: countryCodeInt,
        email: email,
        // onError: onError,
      );
      if (errMsg != null) {
        // onError?.call(errMsg);
        log.info(
          errMsg,
          sentry: true,
        );
        onError?.call(
            'Unable to update users email as another user has that email. Please check if you have previously registered with a different number.');
      }

      return;
    } catch (e, s) {
      log.error(
        'ERROR - updateEmail $e',
        stackTrace: s,
      );
      // onError?.call(
      //   'ERROR - updateEmail $e',
      // );
    }
  };
}

ThunkAction<AppState> fetchDeviceType() {
  return (Store<AppState> store) async {
    try {
      final isSimulator = await thisDeviceIsSimulator();
      final isIosSimulator = await thisDeviceIsIosSimulator();
      store.dispatch(
        SetDeviceIsSimulatorRTO(
          isSimulator: isSimulator,
          isIosSimulator: isIosSimulator,
        ),
      );
    } catch (e, s) {
      log.error(
        'ERROR - fetchDeviceType e',
        stackTrace: s,
      );
    }
  };
}

ThunkAction<AppState> checkForUpdatesAppStore() {
  return (Store<AppState> store) async {
    bool updateNeeded = false;
    Version? currentBuildVersion;
    try {
      final status = await newVersion.getVersionStatus();
      if (status != null) {
        updateNeeded = status.canUpdate; // (true)
        currentBuildVersion = status.localVersionParsed; // (1.2.1)
        final requiredBuildVersion = status.storeVersionParsed; // (1.2.3)
        // status
        //     .appStoreLink; // (https://itunes.apple.com/us/app/google/id284815942?mt=8)
        store.dispatch(
          SetAppUpdateRequired(
            appUpdateNeeded: updateNeeded,
            appUpdateNextVersion: requiredBuildVersion,
          ),
        );
      } else {
        store.dispatch(
          SetAppUpdateRequired(
            appUpdateNeeded: false,
            appUpdateNextVersion: currentBuildVersion,
          ),
        );
      }
    } catch (err, s) {
      log.error(
        err,
        stackTrace: s,
      );
    }
  };
}

ThunkAction<AppState> checkForUpdatesFirebaseRemoteConfig() {
  return (Store<AppState> store) async {
    bool updateNeededUsingFirebaseConfig = false;
    Version? currentBuildNumber;
    // ~ https://firebase.google.com/docs/remote-config/get-started?platform=flutter#get-remote-config
    final remoteConfigBuildNoKey = Platform.isAndroid
        ? 'requiredBuildNumberAndroid'
        : Platform.isIOS
            ? 'requiredBuildNumberIOS'
            : 'requiredWebScriptsCacheUID';

    try {
      final requiredBuildNumber = Version.parse(
        firebaseRemoteConfig.getString(
          remoteConfigBuildNoKey, // 1.0.2
        ),
      );

      final currentBuildVersionStatus = await newVersion.getVersionStatus();
      if (currentBuildVersionStatus != null) {
        currentBuildNumber = currentBuildVersionStatus.localVersionParsed;
        if (currentBuildNumber == null || requiredBuildNumber == null) {
          updateNeededUsingFirebaseConfig = false;
        } else {
          updateNeededUsingFirebaseConfig =
              currentBuildNumber < requiredBuildNumber;
        }
        store.dispatch(
          SetAppUpdateRequired(
            appUpdateNeeded: updateNeededUsingFirebaseConfig,
            appUpdateNextVersion: requiredBuildNumber,
          ),
        );
      }
    } on Exception catch (e) {
      log
        ..error(
          'Unable to check firebase_remote_config for "$remoteConfigBuildNoKey" key: $e',
          stackTrace: StackTrace.current,
        )
        ..error(
          e,
          stackTrace: StackTrace.current,
        );
      updateNeededUsingFirebaseConfig = false;
      store.dispatch(
        SetAppUpdateRequired(
          appUpdateNeeded: updateNeededUsingFirebaseConfig,
          appUpdateNextVersion: currentBuildNumber,
        ),
      );
    }
    if (updateNeededUsingFirebaseConfig == false &&
        store.state.userState.isVegiSuperAdmin) {
      store.dispatch(checkForUpdatesAppStore());
    }
  };
}

ThunkAction<AppState> updateAppNeededNotificationSeen() {
  return (Store<AppState> store) async {
    try {
      store.dispatch(
        SetAppUpdateAcknowledged(
          versionNumberAcknowledged: store.state.userState.appUpdateNextVersion,
        ),
      );
    } catch (e, s) {
      log.error('ERROR - updateAppNeededNotificationSeen $e', stackTrace: s);
    }
  };
}

ThunkAction<AppState> fetchPositionInWaitingListQueue({
  void Function()? successHandler,
  required void Function(String) errorHandler,
}) {
  return (Store<AppState> store) async {
    try {
      final positionInQueue = await peeplEatsService.getPositionInWaitingList(
        store.state.userState.email,
        (error) {
          return errorHandler(error);
        },
      );
      store
          .dispatch(SetPositionInWaitingList(positionInQueue: positionInQueue));

      successHandler?.call();
    } catch (e, s) {
      log.error(
        'ERROR - fetchPositionInWaitingListQueue $e',
        stackTrace: s,
      );
      errorHandler(
        'ERROR - fetchPositionInWaitingListQueue $e',
      );
    }
  };
}

// ThunkAction<AppState> checkIfSmartWalletIsBackedUpToVegi({
//   required void Function(String, VegiBackendResponseErrCode) errorHandler,
// }) {
//   return (Store<AppState> store) async {
//     try {
//       final isBackedUp = await peeplEatsService.isUserSKBackedUp(
//           smartWalletAddress: store.state.userState.walletAddress);
//       store.dispatch(StoreBackupStatus(isSmartWalletBackedUp: isBackedUp));
//     } catch (e, s) {
//       log.error('ERROR - checkIfSmartWalletIsBackedUpToVegi $e');
//       await Sentry.captureException(
//         e,
//         stackTrace: s,
//
//       );
//       errorHandler(
//         'ERROR - checkIfSmartWalletIsBackedUpToVegi $e',
//         VegiBackendResponseErrCode.connectionIssue,
//       );
//     }
//   };
// }

ThunkAction<AppState> fetchSurveyQuestions() {
  return (Store<AppState> store) async {
    try {
      final questions = await peeplEatsService.getSurveyQuestions();
      store.dispatch(SetSurveyQuestionsSuccess(questions: questions));
    } catch (e, s) {
      log.error(
        'ERROR - fetchSurveyQuestions Request',
        error: e,
        stackTrace: s,
      );
      await Analytics.track(
        eventName: AnalyticsEvents.submitSurveyResponse,
        properties: {
          AnalyticsProps.status: AnalyticsProps.failed,
          'error': e.toString(),
        },
      );
    }
  };
}

ThunkAction<AppState> submitSurveyResponse(
  String question,
  String response,
  void Function() onSuccess,
  void Function(String error) onError,
) {
  return (Store<AppState> store) async {
    try {
      await peeplEatsService.submitSurveyResponse(
        store.state.userState.email,
        question,
        response,
        () {
          Analytics.track(
            eventName: AnalyticsEvents.submitSurveyResponse,
            properties: {
              AnalyticsProps.status: AnalyticsProps.success,
            },
          );
          // store.dispatch(
          //   SurveyResponseSuccess(
          //     email: store.state.userState.email,
          //     questionNumber: store.state.userState.,
          //     answer: response,
          //   ),
          // );
          onSuccess?.call();
        },
        (eStr) {
          Analytics.track(
            eventName: AnalyticsEvents.submitSurveyResponse,
            properties: {
              AnalyticsProps.status: AnalyticsProps.failed,
              'error': eStr,
            },
          );
          onError?.call(eStr);
        },
      );
    } catch (e, s) {
      log.error(
        'ERROR - submitSurveyResponse Request',
        error: e,
        stackTrace: s,
      );
      onError?.call(e.toString());
      await Analytics.track(
        eventName: AnalyticsEvents.submitSurveyResponse,
        properties: {
          AnalyticsProps.status: AnalyticsProps.failed,
          'error': e.toString(),
        },
      );
    }
  };
}

ThunkAction<AppState> isBetaWhitelistedAddress() {
  return (Store<AppState> store) async {
    try {
      if (store.state.userState.walletAddress.isEmpty) {
        // TODO RC 1.5.1: 1. Investigate the potential callstacks that could see us here without wallet initialised.
        // TODO RC 1.5.1: 2. Show UNs for functions further up in this callstack that require wallet to be initialised for functionality
        const warning =
            "User wallet not initialised! Can't check the whitelist";
        log.warn(warning, stackTrace: StackTrace.current);
        return;
      }
      final vegiAccount = await peeplEatsService.getVegiAccountForWalletAddress(
        store.state.userState.walletAddress,
        (eStr) {
          Analytics.track(
            eventName: AnalyticsEvents.getUserForWalletAddress,
            properties: {
              AnalyticsProps.status: AnalyticsProps.failed,
              'error': eStr,
            },
          );
        },
      );
      unawaited(
        Analytics.track(
          eventName: AnalyticsEvents.getUserForWalletAddress,
          properties: {
            AnalyticsProps.status: AnalyticsProps.success,
          },
        ),
      );
      if (vegiAccount != null) {
        store
          ..dispatch(
            SetStripeCustomerDetails(
              customerId: vegiAccount.stripeCustomerId,
            ),
          )
          ..dispatch(SetUserVerifiedStatusSuccess(vegiAccount.verified))
          ..dispatch(SetUserAvatar(vegiAccount.imageUrl))
          ..dispatch(SetUserVegiAccountIdSuccess(vegiAccount.id));
        if (vegiAccount.imageUrl.isEmpty) {
          store.dispatch(
            setRandomUserAvatar(vegiAccountId: vegiAccount.id),
          );
        }
      }

      if (store.state.userState.isLoggedInToVegi &&
          store.state.userState.email.isNotEmpty) {
        store.dispatch(getUserDetails());
      }
    } catch (e, s) {
      log.error(
        'ERROR - isBetaWhitelistedAddress Request',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction<AppState> getUserDetails() {
  return (Store<AppState> store) async {
    try {
      final vegiUser = await peeplEatsService.getUserDetails(
        store.state.userState.email,
        store.state.userState.phoneNumberNoCountry,
        (eStr) {
          Analytics.track(
            eventName: AnalyticsEvents.getUserForWalletAddress,
            properties: {
              AnalyticsProps.status: AnalyticsProps.failed,
              'error': eStr,
            },
          );
        },
      );
      if (vegiUser != null) {
        store
          ..dispatch(
            SetUserRoleOnVegi(
              userRole: vegiUser.role,
              isSuperAdmin: vegiUser.isSuperAdmin,
            ),
          )
          ..dispatch(
            SetEmail(
              vegiUser.email ?? store.state.userState.email,
            ),
          )
          ..dispatch(
            SetDisplayName(
              vegiUser.name,
            ),
          );
      }
    } catch (e, s) {
      log.error(
        'ERROR - getUserDetails $e',
        stackTrace: s,
      );
    }
  };
}

ThunkAction<AppState> isUserWalletAddressAVendorAddress({
  void Function()? success,
  void Function(String)? error,
}) {
  return (Store<AppState> store) async {
    try {
      await peeplEatsService.getAccountIsVendor(
        store.state.userState.walletAddress,
        (isVendor, vendorId) {
          Analytics.track(
            eventName: AnalyticsEvents.getUserForWalletAddress,
            properties: {
              AnalyticsProps.status: AnalyticsProps.success,
            },
          );
          store.dispatch(SetUserIsVendorStatusSuccess(isVendor));
          if (isVendor && vendorId != null) {
            store
              ..dispatch(
                fetchRestaurantById(
                  restaurantID: vendorId.toString(),
                  success: success,
                  error: error,
                ),
              )
              ..dispatch(
                setRestaurantDetails(
                  restaurantItem:
                      store.state.homePageState.featuredRestaurants.firstWhere(
                    (element) => element.restaurantID == vendorId.toString(),
                  ),
                  clearCart: true,
                ),
              );
          }
        },
        (eStr) {
          Analytics.track(
            eventName: AnalyticsEvents.getUserForWalletAddress,
            properties: {
              AnalyticsProps.status: AnalyticsProps.failed,
              'error': eStr,
            },
          );
        },
      );
    } catch (e, s) {
      log.error(
        'ERROR - isUserWalletAddressAVendorAddress Request',
        error: e,
        stackTrace: s,
      );
      // onError?.call(e.toString());
      await Analytics.track(
        eventName: AnalyticsEvents.submitSurveyResponse,
        properties: {
          AnalyticsProps.status: AnalyticsProps.failed,
          'error': e.toString(),
        },
      );
    }
  };
}

// ThunkAction<AppState> loginHandler(
//   CountryCode countryCode,
//   PhoneNumber phoneNumber,
// ) {
//   bool _useWeb3Auth = false;
//   return (Store<AppState> store) async {
//     try {
//       store.dispatch(setDevicePhoneNumberForId(phoneNumber.e164));
//       await Analytics.setUserId(phoneNumber.e164);
//       // TODO: Replace this with a dispatch to user_actions.authenticate and integrate test this method
//       if (store.state.userState.firebaseCredentialIsValid) {
//         // try reauthentication first?...
//         final reauthSucceeded = await onBoardStrategy.reauthenticateUser();
//         if (reauthSucceeded) {
//           return;
//         }
//       }
//       await onBoardStrategy.login(
//         store,
//         phoneNumber.e164,
//       );
//     } catch (e, s) {
//       log.error(
//         'ERROR - Login Request',
//         error: e,
//         stackTrace: s,
//       );
//       store
//         ..dispatch(
//           SignupFailed(
//             error: SignUpErrorDetails(
//               title:
//                   e.toString().contains('blocked all requests from this device')
//                       ? 'Verification error'
//                       : 'Something went wrong',
//               message: store.state.userState.isVegiSuperAdmin
//                   ? 'Firebase error: $e'
//                   : '$e',
//             ),
//           ),
//         )
//         ..dispatch(
//           SetUserAuthenticationStatus(
//             firebaseStatus: FirebaseAuthenticationStatus.phoneAuthFailed,
//             vegiStatus: VegiAuthenticationStatus.failed,
//           ),
//         );
//       await Analytics.track(
//         eventName: AnalyticsEvents.loginWithPhone,
//         properties: {
//           AnalyticsProps.status: AnalyticsProps.failed,
//           'error': e.toString(),
//         },
//       );
//       await Sentry.captureException(
//         Exception('Error in login with phone number: $e'),
//         stackTrace: s,
//
//       );
//     }
//   };
// }

// ThunkAction<AppState> verifyHandler(
//   String verificationCode,
// ) {
//   return (Store<AppState> store) async {
//     await onBoardStrategy.verify(
//       store,
//       verificationCode,
//     );
//   };
// }

ThunkAction<AppState> restoreWalletCall(
  // only allow to call this from a custom route link that allows myself and verity to add our mnemonics to createa our smart wallets and remove all other recoveries locations
  List<String> mnemonicWords,
  VoidCallback successCallback,
  VoidCallback failureCallback,
) {
  return (Store<AppState> store) async {
    try {
      await Analytics.track(
        eventName: AnalyticsEvents.restoreWallet,
      );
      await authenticator.restoreFuseFromMnemonic(
        mnemonicWords: mnemonicWords,
      );
      // final mnemonic = mnemonicWords.join(' ');
      // log
      //   ..info('restore wallet')
      //   ..info('compute pk');
      // final String privateKey = Mnemonic.privateKeyFromMnemonic(mnemonic);
      // //! await peeplEatsService.backupUserSK(privateKey);
      // final EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
      // final EthereumAddress accountAddress = credentials.address;
      // log.info('accountAddress: $accountAddress');
      // store.dispatch(
      //   CreateLocalAccountSuccess(
      //     mnemonicWords,
      //     privateKey,
      //     credentials,
      //     // accountAddress.toString(),
      //   ),
      // );
      // await authenticator.initFuse();
      successCallback();
    } catch (e, s) {
      log.error(
        'ERROR - restoreWalletCall',
        error: e,
        stackTrace: s,
      );
      failureCallback();
    }
  };
}

ThunkAction<AppState> setDevicePhoneNumberForId(String phoneNumber) {
  return (Store<AppState> store) async {
    final String identifier = await FlutterUdid.udid;
    // mixpanel.alias(identifier, phoneNumber);
    log.info('device identifier: $identifier');
    store.dispatch(DeviceIdSuccess(identifier));
  };
}

// ThunkAction<AppState> reAuthenticateOnBoarding() {
//   return (Store<AppState> store) async {
//     try {
//       final sessionStillValid =
//           await peeplEatsService.checkVegiSessionIsStillValid();
//       if (sessionStillValid) {
//         store.dispatch(
//           SetUserAuthenticationStatus(
//             firebaseStatus: FirebaseAuthenticationStatus.authenticated,
//             vegiStatus: VegiAuthenticationStatus.authenticated,
//           ),
//         );
//         return;
//       }
//       if (store.state.userState.firebaseCredentialIsValid) {
//         // try reauthentication first?...
//         final reauthSucceeded = await onBoardStrategy.reauthenticateUser();
//       }
//     } on Exception catch (error, s) {
//       store.dispatch(
//         SetUserAuthenticationStatus(
//           firebaseStatus:
//               FirebaseAuthenticationStatus.phoneAuthReauthenticationFailed,
//         ),
//       );
//       await Analytics.track(
//         eventName: AnalyticsEvents.verify,
//         properties: {
//           AnalyticsProps.status: AnalyticsProps.failed,
//           'error': error.toString(),
//         },
//       );
//       await Sentry.captureException(
//         Exception(
//             'Error in reauthenticate user [${onBoardStrategy.strategy.name}]: $error'),
//         stackTrace: s,
//
//       );
//     }
//   };
// }

ThunkAction<AppState> identifyCall({String? wallet}) {
  return (Store<AppState> store) async {
    final UserState userState = store.state.userState;
    final String displayName = userState.displayName;

    final String phoneNumber = userState.phoneNumber;
    final String walletAddress = wallet ?? userState.walletAddress;
    final String accountAddress = userState.accountAddress;
    final String identifier = userState.identifier;

    final Map<String, dynamic> properties = {
      'identifier': identifier,
      'phoneNumber': phoneNumber,
      'walletAddress': walletAddress,
      'accountAddress': accountAddress,
      'language': userState.locale.toString(),
      'displayName': displayName,
    };
    await Analytics.setUserInformation(properties);
    await Analytics.setUserId(phoneNumber);
    DateTime? installedAt = userState.installedAt;
    if (installedAt == null) {
      log.info('Identify - $phoneNumber');
      installedAt = DateTime.now().toUtc();
      store.dispatch(JustInstalled(installedAt));
    }
  };
}

void updateFirebaseCurrentUser(
  void Function({
    required User firebaseUser,
  })
      userUpdateCallback,
) async {
  if (FirebaseAuth.instance.currentUser != null) {
    userUpdateCallback(
      firebaseUser: FirebaseAuth.instance.currentUser!,
    );
  } else {
    log.warn(
      'WARNING - updateFirebaseCurrentUser called when no user signed in...',
      stackTrace: StackTrace.current,
    );
  }
}

ThunkAction<AppState> updateDisplayNameCall(String displayName) {
  return (Store<AppState> store) async {
    try {
      // * Do this first to avoid app breaking as load mainscreen before username is set, same for email
      store.dispatch(SetDisplayName(displayName));

      updateFirebaseCurrentUser(({required User firebaseUser}) async {
        await firebaseUser.updateDisplayName(displayName);
        final errMsg = await peeplEatsService.updateUserDetails(
          phoneNoCountry: store.state.userState.phoneNumberNoCountry,
          phoneCountryCode:
              int.tryParse(store.state.userState.countryCode) ?? 44,
          name: displayName,
        );
        if (errMsg != null) {
          log.info(
            errMsg,
            sentry: true,
          );
        }
      });
    } catch (e, s) {
      log.error(
        'ERROR - updateDisplayNameCall',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction<AppState> setRandomUserAvatarIfNone() {
  return (Store<AppState> store) async {
    try {
      store.dispatch(SetIsLoadingHttpRequest(isLoading: true));

      final vegiAccount = await peeplEatsService.getVegiAccountForWalletAddress(
        store.state.userState.walletAddress,
        (eStr) {
          Analytics.track(
            eventName: AnalyticsEvents.getUserForWalletAddress,
            properties: {
              AnalyticsProps.status: AnalyticsProps.failed,
              'error': eStr,
            },
          );
        },
      );

      if (vegiAccount != null &&
          vegiAccount.imageUrl.isEmpty &&
          vegiAccount.id > 0) {
        store.dispatch(
          setRandomUserAvatar(
            vegiAccountId: vegiAccount.id,
          ),
        );
      }

      store.dispatch(SetIsLoadingHttpRequest(isLoading: false));
    } catch (e, s) {
      log.error('ERROR - setRandomUserAvatarIfNone $e', stackTrace: s);
      store.dispatch(SetIsLoadingHttpRequest(isLoading: false));
    }
  };
}

ThunkAction<AppState> setRandomUserAvatar({
  required int vegiAccountId,
}) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(
        SetIsLoadingHttpRequest(
          isLoading: true,
        ),
      );
      updateFirebaseCurrentUser(({required User firebaseUser}) async {
        final imageUrl = await peeplEatsService.setRandomAvatar(
          accountId: vegiAccountId,
          onError: (error) async {
            log.error(
              'ERROR - peeplEatsService.setRandomAvatar',
              error: error,
              stackTrace: StackTrace.current,
            );
            store.dispatch(
              SetIsLoadingHttpRequest(
                isLoading: false,
              ),
            );
          },
        );
        if (imageUrl.isNotEmpty) {
          await firebaseUser.updatePhotoURL(imageUrl);
          store.dispatch(SetUserAvatar(imageUrl));
        }
        store.dispatch(
          SetIsLoadingHttpRequest(
            isLoading: false,
          ),
        );
      });
    } catch (e, s) {
      store.dispatch(
        SetIsLoadingHttpRequest(
          isLoading: false,
        ),
      );
      log.error(
        'ERROR - getRandomUserAvatar',
        error: e,
        stackTrace: s,
      );
      store
        ..dispatch(SetUserAvatar(''))
        ..dispatch(
          SignUpErrorDetails(
            title: Messages.connectionError,
            message: Messages.operationFailed,
          ),
        );
    }
  };
}

ThunkAction<AppState> deleteUser() {
  return (Store<AppState> store) async {
    try {
      await authenticator.deregisterUser();
    } catch (e, s) {
      log.error('ERROR - deleteUser $e', stackTrace: s);
    }
  };
}

ThunkAction<AppState> updateUserAvatarCall(
  ImageSource source, {
  ProgressCallback? progressCallback,
  void Function()? onSuccess,
  void Function(String errStr)? onError,
}) {
  return (Store<AppState> store) async {
    if (store.state.userState.vegiAccountId == null) {
      log.error(
          'No Account is set on vegi for user. Please login and retrieve account details first.');
      store.dispatch(
        SetIsLoadingHttpRequest(
          isLoading: false,
        ),
      );
      return;
    }
    XFile? file;
    try {
      file = await ImagePicker().pickImage(source: source);
    } on PlatformException catch (err, s) {
      if (err.code == 'invalid_image' &&
          err.details == 'NSItemProviderErrorDomain') {
        log.error(
          'Image seems to be corrupt. See https://stackoverflow.com/questions/75492854/platformexceptioninvalid-image-cannot-load-representation-of-type-public-jpeg. \nTry uploading a different image. Message was: "${err.message}"',
          stackTrace: s,
        );
      } else {
        log.error(err);
      }
    } on Exception catch (e, s) {
      log.error(e, stackTrace: s);
    }
    if (file != null) {
      store.dispatch(
        SetTempUserAvatar(
          tempAvatarFile: file,
        ),
      );
      try {
        updateFirebaseCurrentUser(({required User firebaseUser}) async {
          final imageUrl = await peeplEatsService.uploadImageForUserAvatar(
            image: File(file!.path),
            accountId: store.state.userState.vegiAccountId!.round(),
            onError: (error, errCode) async {
              log.error(
                'ERROR - peeplEatsService.uploadImageForUserAvatar',
                error: error,
                stackTrace: StackTrace.current,
              );
              onError?.call(error);
              store.dispatch(
                SetIsLoadingHttpRequest(
                  isLoading: false,
                ),
              );
            },
            onReceiveProgress: progressCallback,
          );
          if (imageUrl != null) {
            await firebaseUser.updatePhotoURL(imageUrl);
            store
              ..dispatch(SetUserAvatar(imageUrl))
              ..dispatch(
                SetIsLoadingHttpRequest(
                  isLoading: false,
                ),
              );
            onSuccess?.call();
          }
        });
      } catch (e, s) {
        log.error(
          'ERROR - updateUserAvatarCall',
          error: e,
          stackTrace: s,
        );
        store.dispatch(
          SetIsLoadingHttpRequest(
            isLoading: false,
          ),
        );
      }
    } else {
      store.dispatch(
        SetIsLoadingHttpRequest(
          isLoading: false,
        ),
      );
    }
  };
}

ThunkAction<AppState> addDeliveryAddress({
  required DeliveryAddresses newAddress,
}) {
  return (Store<AppState> store) {
    try {
      final List<DeliveryAddresses> listOfAddresses =
          List.from(store.state.userState.listOfDeliveryAddresses)
            ..add(newAddress);

      store.dispatch(UpdateListOfDeliveryAddresses(listOfAddresses));
    } catch (e, s) {
      log.error(
        'ERROR - addDeliveryAddress',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction<AppState> removeDeliveryAddress({
  required int addressId,
}) {
  return (Store<AppState> store) {
    try {
      final List<DeliveryAddresses> listOfAddresses =
          List.from(store.state.userState.listOfDeliveryAddresses)
            ..removeWhere((element) => element.internalID == addressId);

      store.dispatch(UpdateListOfDeliveryAddresses(listOfAddresses));
    } catch (e, s) {
      log.error(
        'ERROR - removeDeliveryAddress',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction<AppState> updateDeliveryAddress({
  required int oldId,
  required DeliveryAddresses newAddress,
}) {
  return (Store<AppState> store) {
    try {
      final List<DeliveryAddresses> listOfAddresses =
          List.from(store.state.userState.listOfDeliveryAddresses);
      final index =
          listOfAddresses.indexWhere((element) => element.internalID == oldId);

      listOfAddresses
        ..removeAt(index)
        ..insert(index, newAddress);

      store.dispatch(UpdateListOfDeliveryAddresses(listOfAddresses));
    } catch (e, s) {
      log.error(
        'ERROR - updateDeliveryAddress',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction<AppState> checkForSavedSeedPhrase() {
  return (Store<AppState> store) async {
    if (store.state.userState.hasSavedSeedPhrase) return;
    if (store.state.userState.initialLoginDateTime.isEmpty) return;
    if (DateTime.now()
            .difference(
              DateTime.fromMillisecondsSinceEpoch(
                int.parse(
                  store.state.userState.initialLoginDateTime,
                ),
              ),
            )
            .inDays <
        7) {
      //show the banner
      store.dispatch(SetShowSeedPhraseBanner(showSeedPhraseBanner: true));
    }
  };
}

ThunkAction<AppState> fetchUserLocation({
  void Function() callbackIfDenied = ToNull,
}) {
  return (Store<AppState> store) async {
    if (!store.state.userState.useLiveLocation) return;

    final Position newPosition = await locationService.getUserCurrentLocation(
      callbackIfDenied: callbackIfDenied,
    );
    store.dispatch(UpdateUserLocation(newLocation: newPosition));
  };
}
