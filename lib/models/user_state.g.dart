// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserState _$$_UserStateFromJson(Map<String, dynamic> json) => _$_UserState(
      walletModules: json['walletModules'] == null
          ? null
          : WalletModules.fromJson(
              json['walletModules'] as Map<String, dynamic>),
      installedAt: json['installedAt'] == null
          ? null
          : DateTime.parse(json['installedAt'] as String),
      isContactsSynced: json['isContactsSynced'] as bool?,
      scrollToTop: json['scrollToTop'] as bool? ?? false,
      walletAddress: json['walletAddress'] as String? ?? '',
      privateKeyCached:
          (json['privateKeyCached'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const {},
      storedFusePublicKey: json['storedFusePublicKey'] as String? ?? '',
      fuseWalletCredentials: json['fuseWalletCredentials'] == null
          ? null
          : ethPrivateKeyFromJson(json['fuseWalletCredentials']),
      fuseAuthenticationStatus: $enumDecodeNullable(
              _$FuseAuthenticationStatusEnumMap,
              json['fuseAuthenticationStatus']) ??
          FuseAuthenticationStatus.unauthenticated,
      firebaseAuthenticationStatus: $enumDecodeNullable(
              _$FirebaseAuthenticationStatusEnumMap,
              json['firebaseAuthenticationStatus']) ??
          FirebaseAuthenticationStatus.unauthenticated,
      vegiAuthenticationStatus: $enumDecodeNullable(
              _$VegiAuthenticationStatusEnumMap,
              json['vegiAuthenticationStatus']) ??
          VegiAuthenticationStatus.unauthenticated,
      backup: json['backup'] as bool? ?? false,
      networks: (json['networks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      mnemonic: (json['mnemonic'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      pincode: json['pincode'] as String? ?? '',
      countryCode: json['countryCode'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      phoneNumberNoCountry: json['phoneNumberNoCountry'] as String? ?? '',
      warnSendDialogShowed: json['warnSendDialogShowed'] as bool? ?? false,
      isoCode: json['isoCode'] as String? ?? '',
      jwtToken: json['jwtToken'] as String? ?? '',
      displayName:
          json['displayName'] as String? ?? VegiConstants.defaultDisplayName,
      avatarUrl: json['avatarUrl'] as String? ?? '',
      avatarTempFilePath: json['avatarTempFilePath'] as String? ?? '',
      preferredSignonMethod: $enumDecodeNullable(
              _$PreferredSignonMethodEnumMap, json['preferredSignonMethod']) ??
          PreferredSignonMethod.phone,
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? null,
      verificationId: json['verificationId'] as String?,
      verificationPassed: json['verificationPassed'] as bool? ?? false,
      identifier: json['identifier'] as String? ?? '',
      deviceName: json['deviceName'] as String? ?? '',
      deviceOSName: json['deviceOSName'] as String? ?? '',
      deviceReleaseName: json['deviceReleaseName'] as String? ?? '',
      appUpdateNeeded: json['appUpdateNeeded'] as bool? ?? false,
      appUpdateNextVersion: json['appUpdateNextVersion'] == null
          ? null
          : Version.fromJson(json['appUpdateNextVersion']),
      appUpdateNotificationSeenForBuildNumber:
          json['appUpdateNotificationSeenForBuildNumber'] == null
              ? null
              : Version.fromJson(
                  json['appUpdateNotificationSeenForBuildNumber']),
      syncedContacts: (json['syncedContacts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      reverseContacts: (json['reverseContacts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      currency: json['currency'] as String? ?? 'usd',
      authType: $enumDecodeNullable(_$BiometricAuthEnumMap, json['authType']) ??
          BiometricAuth.none,
      locale: localeFromJson(json['locale'] as Map<String, dynamic>?),
      firebaseSessionToken: json['firebaseSessionToken'] as String? ?? null,
      firebaseMessagingToken: json['firebaseMessagingToken'] as String? ?? '',
      firebaseMessagingAPNSToken:
          json['firebaseMessagingAPNSToken'] as String? ?? '',
      vegiSessionCookie: json['vegiSessionCookie'] as String? ?? null,
      listOfDeliveryAddresses: (json['listOfDeliveryAddresses']
                  as List<dynamic>?)
              ?.map(
                  (e) => DeliveryAddresses.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hasSavedSeedPhrase: json['hasSavedSeedPhrase'] as bool? ?? false,
      useLiveLocation: json['useLiveLocation'] as bool? ?? false,
      initialLoginDateTime: json['initialLoginDateTime'] as String? ?? '',
      showSeedPhraseBanner: json['showSeedPhraseBanner'] as bool? ?? false,
      surveyCompleted: json['surveyCompleted'] as bool? ?? false,
      surveyEmailUsed: json['surveyEmailUsed'] as String? ?? '',
      isVendor: json['isVendor'] as bool? ?? false,
      stripeCustomerId: json['stripeCustomerId'] as String? ?? null,
      vegiAccountId: json['vegiAccountId'] as int? ?? null,
      vegiUserId: json['vegiUserId'] as int? ?? null,
      isTester: json['isTester'] as bool? ?? false,
      isVegiSuperAdmin: json['isVegiSuperAdmin'] as bool? ?? false,
      userVegiRole:
          $enumDecodeNullable(_$VegiRoleEnumMap, json['userVegiRole']) ??
              VegiRole.consumer,
      positionInWaitingList: json['positionInWaitingList'] as int? ?? null,
      subscribedToWaitingListUpdates:
          json['subscribedToWaitingListUpdates'] as bool? ?? false,
      waitingListEntryId: json['waitingListEntryId'] as int? ?? null,
      loginCounter: json['loginCounter'] as int? ?? 0,
    );

Map<String, dynamic> _$$_UserStateToJson(_$_UserState instance) =>
    <String, dynamic>{
      'walletModules': instance.walletModules?.toJson(),
      'installedAt': instance.installedAt?.toIso8601String(),
      'isContactsSynced': instance.isContactsSynced,
      'scrollToTop': instance.scrollToTop,
      'walletAddress': instance.walletAddress,
      'privateKeyCached': instance.privateKeyCached,
      'storedFusePublicKey': instance.storedFusePublicKey,
      'fuseWalletCredentials':
          ethPrivateKeyToJson(instance.fuseWalletCredentials),
      'fuseAuthenticationStatus':
          _$FuseAuthenticationStatusEnumMap[instance.fuseAuthenticationStatus]!,
      'firebaseAuthenticationStatus': _$FirebaseAuthenticationStatusEnumMap[
          instance.firebaseAuthenticationStatus]!,
      'vegiAuthenticationStatus':
          _$VegiAuthenticationStatusEnumMap[instance.vegiAuthenticationStatus]!,
      'backup': instance.backup,
      'networks': instance.networks,
      'mnemonic': instance.mnemonic,
      'pincode': instance.pincode,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberNoCountry': instance.phoneNumberNoCountry,
      'warnSendDialogShowed': instance.warnSendDialogShowed,
      'isoCode': instance.isoCode,
      'jwtToken': instance.jwtToken,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'avatarTempFilePath': instance.avatarTempFilePath,
      'preferredSignonMethod':
          _$PreferredSignonMethodEnumMap[instance.preferredSignonMethod]!,
      'email': instance.email,
      'password': instance.password,
      'verificationId': instance.verificationId,
      'verificationPassed': instance.verificationPassed,
      'identifier': instance.identifier,
      'deviceName': instance.deviceName,
      'deviceOSName': instance.deviceOSName,
      'deviceReleaseName': instance.deviceReleaseName,
      'appUpdateNeeded': instance.appUpdateNeeded,
      'appUpdateNextVersion': Version.toJson(instance.appUpdateNextVersion),
      'appUpdateNotificationSeenForBuildNumber':
          Version.toJson(instance.appUpdateNotificationSeenForBuildNumber),
      'syncedContacts': instance.syncedContacts,
      'reverseContacts': instance.reverseContacts,
      'currency': instance.currency,
      'authType': _$BiometricAuthEnumMap[instance.authType]!,
      'locale': localeToJson(instance.locale),
      'firebaseSessionToken': instance.firebaseSessionToken,
      'firebaseMessagingToken': instance.firebaseMessagingToken,
      'firebaseMessagingAPNSToken': instance.firebaseMessagingAPNSToken,
      'vegiSessionCookie': instance.vegiSessionCookie,
      'listOfDeliveryAddresses':
          instance.listOfDeliveryAddresses.map((e) => e.toJson()).toList(),
      'hasSavedSeedPhrase': instance.hasSavedSeedPhrase,
      'useLiveLocation': instance.useLiveLocation,
      'initialLoginDateTime': instance.initialLoginDateTime,
      'showSeedPhraseBanner': instance.showSeedPhraseBanner,
      'surveyCompleted': instance.surveyCompleted,
      'surveyEmailUsed': instance.surveyEmailUsed,
      'isVendor': instance.isVendor,
      'stripeCustomerId': instance.stripeCustomerId,
      'vegiAccountId': instance.vegiAccountId,
      'vegiUserId': instance.vegiUserId,
      'isTester': instance.isTester,
      'isVegiSuperAdmin': instance.isVegiSuperAdmin,
      'userVegiRole': _$VegiRoleEnumMap[instance.userVegiRole]!,
      'positionInWaitingList': instance.positionInWaitingList,
      'subscribedToWaitingListUpdates': instance.subscribedToWaitingListUpdates,
      'waitingListEntryId': instance.waitingListEntryId,
      'loginCounter': instance.loginCounter,
    };

const _$FuseAuthenticationStatusEnumMap = {
  FuseAuthenticationStatus.unauthenticated: 'unauthenticated',
  FuseAuthenticationStatus.loading: 'loading',
  FuseAuthenticationStatus.authenticated: 'authenticated',
  FuseAuthenticationStatus.createWalletForEOA: 'createWalletForEOA',
  FuseAuthenticationStatus.creationStarted: 'creationStarted',
  FuseAuthenticationStatus.creationSucceeded: 'creationSucceeded',
  FuseAuthenticationStatus.created: 'created',
  FuseAuthenticationStatus.fetched: 'fetched',
  FuseAuthenticationStatus.failedCreateLocalAccountPrivateKey:
      'failedCreateLocalAccountPrivateKey',
  FuseAuthenticationStatus.failedCreate: 'failedCreate',
  FuseAuthenticationStatus.failedAuthentication: 'failedAuthentication',
  FuseAuthenticationStatus
          .failedAuthenticationAsMissingUserDetailsToAuthFuseWallet:
      'failedAuthenticationAsMissingUserDetailsToAuthFuseWallet',
  FuseAuthenticationStatus
          .failedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt:
      'failedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt',
  FuseAuthenticationStatus.failedFetch: 'failedFetch',
  FuseAuthenticationStatus.creationTransactionHash: 'creationTransactionHash',
};

const _$FirebaseAuthenticationStatusEnumMap = {
  FirebaseAuthenticationStatus.unauthenticated: 'unauthenticated',
  FirebaseAuthenticationStatus.loading: 'loading',
  FirebaseAuthenticationStatus.reauthenticationFailed: 'reauthenticationFailed',
  FirebaseAuthenticationStatus.authenticated: 'authenticated',
  FirebaseAuthenticationStatus.expired: 'expired',
  FirebaseAuthenticationStatus.phoneAuthReauthenticationFailed:
      'phoneAuthReauthenticationFailed',
  FirebaseAuthenticationStatus.phoneAuthFailed: 'phoneAuthFailed',
  FirebaseAuthenticationStatus.phoneAuthTFAFailed: 'phoneAuthTFAFailed',
  FirebaseAuthenticationStatus.phoneAuthNoPhoneNumberSet:
      'phoneAuthNoPhoneNumberSet',
  FirebaseAuthenticationStatus.phoneAuthVerificationCodeTimedOut:
      'phoneAuthVerificationCodeTimedOut',
  FirebaseAuthenticationStatus.phoneAuthVerificationFailed:
      'phoneAuthVerificationFailed',
  FirebaseAuthenticationStatus.phoneAuthCredentialHasNoVerificationId:
      'phoneAuthCredentialHasNoVerificationId',
  FirebaseAuthenticationStatus.phoneAuthTimedOut: 'phoneAuthTimedOut',
  FirebaseAuthenticationStatus.phoneAuthFailedTooManyRequests:
      'phoneAuthFailedTooManyRequests',
  FirebaseAuthenticationStatus.invalidPhoneNumber: 'invalidPhoneNumber',
  FirebaseAuthenticationStatus.emailAlreadyInUseWithOtherAccount:
      'emailAlreadyInUseWithOtherAccount',
  FirebaseAuthenticationStatus.updateEmailUsingVerificationFailed:
      'updateEmailUsingVerificationFailed',
  FirebaseAuthenticationStatus.userGetIdTokenFailed: 'userGetIdTokenFailed',
  FirebaseAuthenticationStatus.invalidCredentials: 'invalidCredentials',
  FirebaseAuthenticationStatus.invalidVerificationId: 'invalidVerificationId',
  FirebaseAuthenticationStatus.beginAuthentication: 'beginAuthentication',
};

const _$VegiAuthenticationStatusEnumMap = {
  VegiAuthenticationStatus.unauthenticated: 'unauthenticated',
  VegiAuthenticationStatus.loading: 'loading',
  VegiAuthenticationStatus.authenticated: 'authenticated',
  VegiAuthenticationStatus.failed: 'failed',
};

const _$PreferredSignonMethodEnumMap = {
  PreferredSignonMethod.phone: 'phone',
  PreferredSignonMethod.emailAndPassword: 'emailAndPassword',
  PreferredSignonMethod.emailLink: 'emailLink',
  PreferredSignonMethod.google: 'google',
  PreferredSignonMethod.apple: 'apple',
};

const _$BiometricAuthEnumMap = {
  BiometricAuth.faceID: 'faceID',
  BiometricAuth.touchID: 'touchID',
  BiometricAuth.pincode: 'pincode',
  BiometricAuth.none: 'none',
};

const _$VegiRoleEnumMap = {
  VegiRole.admin: 'admin',
  VegiRole.vendor: 'vendor',
  VegiRole.deliveryPartner: 'deliveryPartner',
  VegiRole.consumer: 'consumer',
  VegiRole.service: 'service',
};
