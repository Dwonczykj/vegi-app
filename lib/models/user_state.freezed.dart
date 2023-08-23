// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return _UserState.fromJson(json);
}

/// @nodoc
mixin _$UserState {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get wcURI => throw _privateConstructorUsedError;
  WalletModules? get walletModules => throw _privateConstructorUsedError;
  DateTime? get installedAt => throw _privateConstructorUsedError;
  bool? get isContactsSynced => throw _privateConstructorUsedError;
  bool get scrollToTop => throw _privateConstructorUsedError;

  /// * The wallet address is a smart contract wallet which actually conducts payments, holds balances, etc.
  /// * So basically, there are 3 types of stake folder in the fuse network technically speaking,
  /// there are wallet addresses which are opinionless dapps or smart contracts or classes that only
  /// act when given a request and either succeed or fail to perform an action.
  /// Then you have account addresses, these are the accounts that simply own wallets and are allowed to
  /// direct wallet dapps to perform transfers or any other action.
  /// Then finally there is the community manager address that also has power
  /// to direct wallet addresses that it does not necessarily own to perform functions such as transfers.
  String get walletAddress => throw _privateConstructorUsedError;

  /// * the account address simply signs transactions 'on behalf' of the smart contract wallet.
  /// This is so only people who verify their phone numbers can create wallets or something.
  /// Fuse would be able to give you more information
  ///
  /// The account address is a 'real' wallet generated on the device which is only stored on the device.
// @Default('') String accountAddress,
  String get privateKey => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ethPrivateKeyFromJson, toJson: ethPrivateKeyToJson)
  EthPrivateKey? get fuseWalletCredentials =>
      throw _privateConstructorUsedError;
  SmartWallet? get smartWallet => throw _privateConstructorUsedError;
  FuseAuthenticationStatus get fuseAuthenticationStatus =>
      throw _privateConstructorUsedError;
  FirebaseAuthenticationStatus get firebaseAuthenticationStatus =>
      throw _privateConstructorUsedError;
  VegiAuthenticationStatus get vegiAuthenticationStatus =>
      throw _privateConstructorUsedError;
  bool get backup => throw _privateConstructorUsedError;
  List<String> get networks => throw _privateConstructorUsedError;
  List<String> get mnemonic => throw _privateConstructorUsedError;
  String get pincode => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError; // i.e. +44
  String get phoneNumber => throw _privateConstructorUsedError;
  String get phoneNumberNoCountry => throw _privateConstructorUsedError;
  bool get warnSendDialogShowed => throw _privateConstructorUsedError;
  String get isoCode => throw _privateConstructorUsedError; // i.e. 'GB'
  String get jwtToken => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;
  String get avatarTempFilePath => throw _privateConstructorUsedError;
  PreferredSignonMethod get preferredSignonMethod =>
      throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get verificationId => throw _privateConstructorUsedError;
  bool get verificationPassed => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  String get deviceOSName => throw _privateConstructorUsedError;
  String get deviceReleaseName => throw _privateConstructorUsedError;
  bool get appUpdateNeeded => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  Version? get appUpdateNextVersion => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  Version? get appUpdateNotificationSeenForBuildNumber =>
      throw _privateConstructorUsedError;
  List<String> get syncedContacts => throw _privateConstructorUsedError;
  Map<String, String> get reverseContacts => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get hasUpgrade => throw _privateConstructorUsedError;
  BiometricAuth get authType => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get biometricallyAuthenticated => throw _privateConstructorUsedError;
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  Locale? get locale => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  AuthCredential? get firebaseCredentials => throw _privateConstructorUsedError;
  String? get firebaseSessionToken => throw _privateConstructorUsedError;
  String get firebaseMessagingToken => throw _privateConstructorUsedError;
  String get firebaseMessagingAPNSToken => throw _privateConstructorUsedError;
  String? get vegiSessionCookie => throw _privateConstructorUsedError;
  List<DeliveryAddresses> get listOfDeliveryAddresses =>
      throw _privateConstructorUsedError;
  bool get hasSavedSeedPhrase => throw _privateConstructorUsedError;
  bool get useLiveLocation => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get userIsVerified => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Position? get userLocation => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isUsingSimulator => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isUsingIosSimulator => throw _privateConstructorUsedError;
  String get initialLoginDateTime => throw _privateConstructorUsedError;
  bool get showSeedPhraseBanner => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<SurveyQuestion> get surveyQuestions =>
      throw _privateConstructorUsedError;
  bool get surveyCompleted => throw _privateConstructorUsedError;
  String get surveyEmailUsed => throw _privateConstructorUsedError;
  bool get isVendor => throw _privateConstructorUsedError;
  String? get stripeCustomerId => throw _privateConstructorUsedError;
  int? get vegiAccountId => throw _privateConstructorUsedError;
  int? get vegiUserId => throw _privateConstructorUsedError;
  bool get isTester => throw _privateConstructorUsedError;
  bool get isVegiSuperAdmin => throw _privateConstructorUsedError;
  VegiRole get userVegiRole => throw _privateConstructorUsedError;
  int? get positionInWaitingList => throw _privateConstructorUsedError;
  bool get subscribedToWaitingListUpdates => throw _privateConstructorUsedError;
  int? get waitingListEntryId => throw _privateConstructorUsedError;
  int get loginCounter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStateCopyWith<UserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String? wcURI,
      WalletModules? walletModules,
      DateTime? installedAt,
      bool? isContactsSynced,
      bool scrollToTop,
      String walletAddress,
      String privateKey,
      @JsonKey(fromJson: ethPrivateKeyFromJson, toJson: ethPrivateKeyToJson)
      EthPrivateKey? fuseWalletCredentials,
      SmartWallet? smartWallet,
      FuseAuthenticationStatus fuseAuthenticationStatus,
      FirebaseAuthenticationStatus firebaseAuthenticationStatus,
      VegiAuthenticationStatus vegiAuthenticationStatus,
      bool backup,
      List<String> networks,
      List<String> mnemonic,
      String pincode,
      String countryCode,
      String phoneNumber,
      String phoneNumberNoCountry,
      bool warnSendDialogShowed,
      String isoCode,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String avatarTempFilePath,
      PreferredSignonMethod preferredSignonMethod,
      String email,
      String? password,
      String? verificationId,
      bool verificationPassed,
      String identifier,
      String deviceName,
      String deviceOSName,
      String deviceReleaseName,
      bool appUpdateNeeded,
      @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
      Version? appUpdateNextVersion,
      @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
      Version? appUpdateNotificationSeenForBuildNumber,
      List<String> syncedContacts,
      Map<String, String> reverseContacts,
      String currency,
      @JsonKey(includeFromJson: false, includeToJson: false) bool hasUpgrade,
      BiometricAuth authType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool biometricallyAuthenticated,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson) Locale? locale,
      @JsonKey(ignore: true) AuthCredential? firebaseCredentials,
      String? firebaseSessionToken,
      String firebaseMessagingToken,
      String firebaseMessagingAPNSToken,
      String? vegiSessionCookie,
      List<DeliveryAddresses> listOfDeliveryAddresses,
      bool hasSavedSeedPhrase,
      bool useLiveLocation,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool userIsVerified,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Position? userLocation,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isUsingSimulator,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isUsingIosSimulator,
      String initialLoginDateTime,
      bool showSeedPhraseBanner,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<SurveyQuestion> surveyQuestions,
      bool surveyCompleted,
      String surveyEmailUsed,
      bool isVendor,
      String? stripeCustomerId,
      int? vegiAccountId,
      int? vegiUserId,
      bool isTester,
      bool isVegiSuperAdmin,
      VegiRole userVegiRole,
      int? positionInWaitingList,
      bool subscribedToWaitingListUpdates,
      int? waitingListEntryId,
      int loginCounter});

  $WalletModulesCopyWith<$Res>? get walletModules;
  $SmartWalletCopyWith<$Res>? get smartWallet;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wcURI = freezed,
    Object? walletModules = freezed,
    Object? installedAt = freezed,
    Object? isContactsSynced = freezed,
    Object? scrollToTop = null,
    Object? walletAddress = null,
    Object? privateKey = null,
    Object? fuseWalletCredentials = freezed,
    Object? smartWallet = freezed,
    Object? fuseAuthenticationStatus = null,
    Object? firebaseAuthenticationStatus = null,
    Object? vegiAuthenticationStatus = null,
    Object? backup = null,
    Object? networks = null,
    Object? mnemonic = null,
    Object? pincode = null,
    Object? countryCode = null,
    Object? phoneNumber = null,
    Object? phoneNumberNoCountry = null,
    Object? warnSendDialogShowed = null,
    Object? isoCode = null,
    Object? jwtToken = null,
    Object? displayName = null,
    Object? avatarUrl = null,
    Object? avatarTempFilePath = null,
    Object? preferredSignonMethod = null,
    Object? email = null,
    Object? password = freezed,
    Object? verificationId = freezed,
    Object? verificationPassed = null,
    Object? identifier = null,
    Object? deviceName = null,
    Object? deviceOSName = null,
    Object? deviceReleaseName = null,
    Object? appUpdateNeeded = null,
    Object? appUpdateNextVersion = freezed,
    Object? appUpdateNotificationSeenForBuildNumber = freezed,
    Object? syncedContacts = null,
    Object? reverseContacts = null,
    Object? currency = null,
    Object? hasUpgrade = null,
    Object? authType = null,
    Object? biometricallyAuthenticated = null,
    Object? locale = freezed,
    Object? firebaseCredentials = freezed,
    Object? firebaseSessionToken = freezed,
    Object? firebaseMessagingToken = null,
    Object? firebaseMessagingAPNSToken = null,
    Object? vegiSessionCookie = freezed,
    Object? listOfDeliveryAddresses = null,
    Object? hasSavedSeedPhrase = null,
    Object? useLiveLocation = null,
    Object? userIsVerified = null,
    Object? userLocation = freezed,
    Object? isUsingSimulator = null,
    Object? isUsingIosSimulator = null,
    Object? initialLoginDateTime = null,
    Object? showSeedPhraseBanner = null,
    Object? surveyQuestions = null,
    Object? surveyCompleted = null,
    Object? surveyEmailUsed = null,
    Object? isVendor = null,
    Object? stripeCustomerId = freezed,
    Object? vegiAccountId = freezed,
    Object? vegiUserId = freezed,
    Object? isTester = null,
    Object? isVegiSuperAdmin = null,
    Object? userVegiRole = null,
    Object? positionInWaitingList = freezed,
    Object? subscribedToWaitingListUpdates = null,
    Object? waitingListEntryId = freezed,
    Object? loginCounter = null,
  }) {
    return _then(_value.copyWith(
      wcURI: freezed == wcURI
          ? _value.wcURI
          : wcURI // ignore: cast_nullable_to_non_nullable
              as String?,
      walletModules: freezed == walletModules
          ? _value.walletModules
          : walletModules // ignore: cast_nullable_to_non_nullable
              as WalletModules?,
      installedAt: freezed == installedAt
          ? _value.installedAt
          : installedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isContactsSynced: freezed == isContactsSynced
          ? _value.isContactsSynced
          : isContactsSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
      scrollToTop: null == scrollToTop
          ? _value.scrollToTop
          : scrollToTop // ignore: cast_nullable_to_non_nullable
              as bool,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      privateKey: null == privateKey
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String,
      fuseWalletCredentials: freezed == fuseWalletCredentials
          ? _value.fuseWalletCredentials
          : fuseWalletCredentials // ignore: cast_nullable_to_non_nullable
              as EthPrivateKey?,
      smartWallet: freezed == smartWallet
          ? _value.smartWallet
          : smartWallet // ignore: cast_nullable_to_non_nullable
              as SmartWallet?,
      fuseAuthenticationStatus: null == fuseAuthenticationStatus
          ? _value.fuseAuthenticationStatus
          : fuseAuthenticationStatus // ignore: cast_nullable_to_non_nullable
              as FuseAuthenticationStatus,
      firebaseAuthenticationStatus: null == firebaseAuthenticationStatus
          ? _value.firebaseAuthenticationStatus
          : firebaseAuthenticationStatus // ignore: cast_nullable_to_non_nullable
              as FirebaseAuthenticationStatus,
      vegiAuthenticationStatus: null == vegiAuthenticationStatus
          ? _value.vegiAuthenticationStatus
          : vegiAuthenticationStatus // ignore: cast_nullable_to_non_nullable
              as VegiAuthenticationStatus,
      backup: null == backup
          ? _value.backup
          : backup // ignore: cast_nullable_to_non_nullable
              as bool,
      networks: null == networks
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mnemonic: null == mnemonic
          ? _value.mnemonic
          : mnemonic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      pincode: null == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumberNoCountry: null == phoneNumberNoCountry
          ? _value.phoneNumberNoCountry
          : phoneNumberNoCountry // ignore: cast_nullable_to_non_nullable
              as String,
      warnSendDialogShowed: null == warnSendDialogShowed
          ? _value.warnSendDialogShowed
          : warnSendDialogShowed // ignore: cast_nullable_to_non_nullable
              as bool,
      isoCode: null == isoCode
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
      jwtToken: null == jwtToken
          ? _value.jwtToken
          : jwtToken // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      avatarTempFilePath: null == avatarTempFilePath
          ? _value.avatarTempFilePath
          : avatarTempFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      preferredSignonMethod: null == preferredSignonMethod
          ? _value.preferredSignonMethod
          : preferredSignonMethod // ignore: cast_nullable_to_non_nullable
              as PreferredSignonMethod,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationId: freezed == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationPassed: null == verificationPassed
          ? _value.verificationPassed
          : verificationPassed // ignore: cast_nullable_to_non_nullable
              as bool,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceOSName: null == deviceOSName
          ? _value.deviceOSName
          : deviceOSName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceReleaseName: null == deviceReleaseName
          ? _value.deviceReleaseName
          : deviceReleaseName // ignore: cast_nullable_to_non_nullable
              as String,
      appUpdateNeeded: null == appUpdateNeeded
          ? _value.appUpdateNeeded
          : appUpdateNeeded // ignore: cast_nullable_to_non_nullable
              as bool,
      appUpdateNextVersion: freezed == appUpdateNextVersion
          ? _value.appUpdateNextVersion
          : appUpdateNextVersion // ignore: cast_nullable_to_non_nullable
              as Version?,
      appUpdateNotificationSeenForBuildNumber: freezed ==
              appUpdateNotificationSeenForBuildNumber
          ? _value.appUpdateNotificationSeenForBuildNumber
          : appUpdateNotificationSeenForBuildNumber // ignore: cast_nullable_to_non_nullable
              as Version?,
      syncedContacts: null == syncedContacts
          ? _value.syncedContacts
          : syncedContacts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reverseContacts: null == reverseContacts
          ? _value.reverseContacts
          : reverseContacts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      hasUpgrade: null == hasUpgrade
          ? _value.hasUpgrade
          : hasUpgrade // ignore: cast_nullable_to_non_nullable
              as bool,
      authType: null == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as BiometricAuth,
      biometricallyAuthenticated: null == biometricallyAuthenticated
          ? _value.biometricallyAuthenticated
          : biometricallyAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      firebaseCredentials: freezed == firebaseCredentials
          ? _value.firebaseCredentials
          : firebaseCredentials // ignore: cast_nullable_to_non_nullable
              as AuthCredential?,
      firebaseSessionToken: freezed == firebaseSessionToken
          ? _value.firebaseSessionToken
          : firebaseSessionToken // ignore: cast_nullable_to_non_nullable
              as String?,
      firebaseMessagingToken: null == firebaseMessagingToken
          ? _value.firebaseMessagingToken
          : firebaseMessagingToken // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseMessagingAPNSToken: null == firebaseMessagingAPNSToken
          ? _value.firebaseMessagingAPNSToken
          : firebaseMessagingAPNSToken // ignore: cast_nullable_to_non_nullable
              as String,
      vegiSessionCookie: freezed == vegiSessionCookie
          ? _value.vegiSessionCookie
          : vegiSessionCookie // ignore: cast_nullable_to_non_nullable
              as String?,
      listOfDeliveryAddresses: null == listOfDeliveryAddresses
          ? _value.listOfDeliveryAddresses
          : listOfDeliveryAddresses // ignore: cast_nullable_to_non_nullable
              as List<DeliveryAddresses>,
      hasSavedSeedPhrase: null == hasSavedSeedPhrase
          ? _value.hasSavedSeedPhrase
          : hasSavedSeedPhrase // ignore: cast_nullable_to_non_nullable
              as bool,
      useLiveLocation: null == useLiveLocation
          ? _value.useLiveLocation
          : useLiveLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      userIsVerified: null == userIsVerified
          ? _value.userIsVerified
          : userIsVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      userLocation: freezed == userLocation
          ? _value.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as Position?,
      isUsingSimulator: null == isUsingSimulator
          ? _value.isUsingSimulator
          : isUsingSimulator // ignore: cast_nullable_to_non_nullable
              as bool,
      isUsingIosSimulator: null == isUsingIosSimulator
          ? _value.isUsingIosSimulator
          : isUsingIosSimulator // ignore: cast_nullable_to_non_nullable
              as bool,
      initialLoginDateTime: null == initialLoginDateTime
          ? _value.initialLoginDateTime
          : initialLoginDateTime // ignore: cast_nullable_to_non_nullable
              as String,
      showSeedPhraseBanner: null == showSeedPhraseBanner
          ? _value.showSeedPhraseBanner
          : showSeedPhraseBanner // ignore: cast_nullable_to_non_nullable
              as bool,
      surveyQuestions: null == surveyQuestions
          ? _value.surveyQuestions
          : surveyQuestions // ignore: cast_nullable_to_non_nullable
              as List<SurveyQuestion>,
      surveyCompleted: null == surveyCompleted
          ? _value.surveyCompleted
          : surveyCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      surveyEmailUsed: null == surveyEmailUsed
          ? _value.surveyEmailUsed
          : surveyEmailUsed // ignore: cast_nullable_to_non_nullable
              as String,
      isVendor: null == isVendor
          ? _value.isVendor
          : isVendor // ignore: cast_nullable_to_non_nullable
              as bool,
      stripeCustomerId: freezed == stripeCustomerId
          ? _value.stripeCustomerId
          : stripeCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      vegiAccountId: freezed == vegiAccountId
          ? _value.vegiAccountId
          : vegiAccountId // ignore: cast_nullable_to_non_nullable
              as int?,
      vegiUserId: freezed == vegiUserId
          ? _value.vegiUserId
          : vegiUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      isTester: null == isTester
          ? _value.isTester
          : isTester // ignore: cast_nullable_to_non_nullable
              as bool,
      isVegiSuperAdmin: null == isVegiSuperAdmin
          ? _value.isVegiSuperAdmin
          : isVegiSuperAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      userVegiRole: null == userVegiRole
          ? _value.userVegiRole
          : userVegiRole // ignore: cast_nullable_to_non_nullable
              as VegiRole,
      positionInWaitingList: freezed == positionInWaitingList
          ? _value.positionInWaitingList
          : positionInWaitingList // ignore: cast_nullable_to_non_nullable
              as int?,
      subscribedToWaitingListUpdates: null == subscribedToWaitingListUpdates
          ? _value.subscribedToWaitingListUpdates
          : subscribedToWaitingListUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      waitingListEntryId: freezed == waitingListEntryId
          ? _value.waitingListEntryId
          : waitingListEntryId // ignore: cast_nullable_to_non_nullable
              as int?,
      loginCounter: null == loginCounter
          ? _value.loginCounter
          : loginCounter // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WalletModulesCopyWith<$Res>? get walletModules {
    if (_value.walletModules == null) {
      return null;
    }

    return $WalletModulesCopyWith<$Res>(_value.walletModules!, (value) {
      return _then(_value.copyWith(walletModules: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmartWalletCopyWith<$Res>? get smartWallet {
    if (_value.smartWallet == null) {
      return null;
    }

    return $SmartWalletCopyWith<$Res>(_value.smartWallet!, (value) {
      return _then(_value.copyWith(smartWallet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$$_UserStateCopyWith(
          _$_UserState value, $Res Function(_$_UserState) then) =
      __$$_UserStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String? wcURI,
      WalletModules? walletModules,
      DateTime? installedAt,
      bool? isContactsSynced,
      bool scrollToTop,
      String walletAddress,
      String privateKey,
      @JsonKey(fromJson: ethPrivateKeyFromJson, toJson: ethPrivateKeyToJson)
      EthPrivateKey? fuseWalletCredentials,
      SmartWallet? smartWallet,
      FuseAuthenticationStatus fuseAuthenticationStatus,
      FirebaseAuthenticationStatus firebaseAuthenticationStatus,
      VegiAuthenticationStatus vegiAuthenticationStatus,
      bool backup,
      List<String> networks,
      List<String> mnemonic,
      String pincode,
      String countryCode,
      String phoneNumber,
      String phoneNumberNoCountry,
      bool warnSendDialogShowed,
      String isoCode,
      String jwtToken,
      String displayName,
      String avatarUrl,
      String avatarTempFilePath,
      PreferredSignonMethod preferredSignonMethod,
      String email,
      String? password,
      String? verificationId,
      bool verificationPassed,
      String identifier,
      String deviceName,
      String deviceOSName,
      String deviceReleaseName,
      bool appUpdateNeeded,
      @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
      Version? appUpdateNextVersion,
      @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
      Version? appUpdateNotificationSeenForBuildNumber,
      List<String> syncedContacts,
      Map<String, String> reverseContacts,
      String currency,
      @JsonKey(includeFromJson: false, includeToJson: false) bool hasUpgrade,
      BiometricAuth authType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool biometricallyAuthenticated,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson) Locale? locale,
      @JsonKey(ignore: true) AuthCredential? firebaseCredentials,
      String? firebaseSessionToken,
      String firebaseMessagingToken,
      String firebaseMessagingAPNSToken,
      String? vegiSessionCookie,
      List<DeliveryAddresses> listOfDeliveryAddresses,
      bool hasSavedSeedPhrase,
      bool useLiveLocation,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool userIsVerified,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Position? userLocation,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isUsingSimulator,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isUsingIosSimulator,
      String initialLoginDateTime,
      bool showSeedPhraseBanner,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<SurveyQuestion> surveyQuestions,
      bool surveyCompleted,
      String surveyEmailUsed,
      bool isVendor,
      String? stripeCustomerId,
      int? vegiAccountId,
      int? vegiUserId,
      bool isTester,
      bool isVegiSuperAdmin,
      VegiRole userVegiRole,
      int? positionInWaitingList,
      bool subscribedToWaitingListUpdates,
      int? waitingListEntryId,
      int loginCounter});

  @override
  $WalletModulesCopyWith<$Res>? get walletModules;
  @override
  $SmartWalletCopyWith<$Res>? get smartWallet;
}

/// @nodoc
class __$$_UserStateCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$_UserState>
    implements _$$_UserStateCopyWith<$Res> {
  __$$_UserStateCopyWithImpl(
      _$_UserState _value, $Res Function(_$_UserState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wcURI = freezed,
    Object? walletModules = freezed,
    Object? installedAt = freezed,
    Object? isContactsSynced = freezed,
    Object? scrollToTop = null,
    Object? walletAddress = null,
    Object? privateKey = null,
    Object? fuseWalletCredentials = freezed,
    Object? smartWallet = freezed,
    Object? fuseAuthenticationStatus = null,
    Object? firebaseAuthenticationStatus = null,
    Object? vegiAuthenticationStatus = null,
    Object? backup = null,
    Object? networks = null,
    Object? mnemonic = null,
    Object? pincode = null,
    Object? countryCode = null,
    Object? phoneNumber = null,
    Object? phoneNumberNoCountry = null,
    Object? warnSendDialogShowed = null,
    Object? isoCode = null,
    Object? jwtToken = null,
    Object? displayName = null,
    Object? avatarUrl = null,
    Object? avatarTempFilePath = null,
    Object? preferredSignonMethod = null,
    Object? email = null,
    Object? password = freezed,
    Object? verificationId = freezed,
    Object? verificationPassed = null,
    Object? identifier = null,
    Object? deviceName = null,
    Object? deviceOSName = null,
    Object? deviceReleaseName = null,
    Object? appUpdateNeeded = null,
    Object? appUpdateNextVersion = freezed,
    Object? appUpdateNotificationSeenForBuildNumber = freezed,
    Object? syncedContacts = null,
    Object? reverseContacts = null,
    Object? currency = null,
    Object? hasUpgrade = null,
    Object? authType = null,
    Object? biometricallyAuthenticated = null,
    Object? locale = freezed,
    Object? firebaseCredentials = freezed,
    Object? firebaseSessionToken = freezed,
    Object? firebaseMessagingToken = null,
    Object? firebaseMessagingAPNSToken = null,
    Object? vegiSessionCookie = freezed,
    Object? listOfDeliveryAddresses = null,
    Object? hasSavedSeedPhrase = null,
    Object? useLiveLocation = null,
    Object? userIsVerified = null,
    Object? userLocation = freezed,
    Object? isUsingSimulator = null,
    Object? isUsingIosSimulator = null,
    Object? initialLoginDateTime = null,
    Object? showSeedPhraseBanner = null,
    Object? surveyQuestions = null,
    Object? surveyCompleted = null,
    Object? surveyEmailUsed = null,
    Object? isVendor = null,
    Object? stripeCustomerId = freezed,
    Object? vegiAccountId = freezed,
    Object? vegiUserId = freezed,
    Object? isTester = null,
    Object? isVegiSuperAdmin = null,
    Object? userVegiRole = null,
    Object? positionInWaitingList = freezed,
    Object? subscribedToWaitingListUpdates = null,
    Object? waitingListEntryId = freezed,
    Object? loginCounter = null,
  }) {
    return _then(_$_UserState(
      wcURI: freezed == wcURI
          ? _value.wcURI
          : wcURI // ignore: cast_nullable_to_non_nullable
              as String?,
      walletModules: freezed == walletModules
          ? _value.walletModules
          : walletModules // ignore: cast_nullable_to_non_nullable
              as WalletModules?,
      installedAt: freezed == installedAt
          ? _value.installedAt
          : installedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isContactsSynced: freezed == isContactsSynced
          ? _value.isContactsSynced
          : isContactsSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
      scrollToTop: null == scrollToTop
          ? _value.scrollToTop
          : scrollToTop // ignore: cast_nullable_to_non_nullable
              as bool,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String,
      privateKey: null == privateKey
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String,
      fuseWalletCredentials: freezed == fuseWalletCredentials
          ? _value.fuseWalletCredentials
          : fuseWalletCredentials // ignore: cast_nullable_to_non_nullable
              as EthPrivateKey?,
      smartWallet: freezed == smartWallet
          ? _value.smartWallet
          : smartWallet // ignore: cast_nullable_to_non_nullable
              as SmartWallet?,
      fuseAuthenticationStatus: null == fuseAuthenticationStatus
          ? _value.fuseAuthenticationStatus
          : fuseAuthenticationStatus // ignore: cast_nullable_to_non_nullable
              as FuseAuthenticationStatus,
      firebaseAuthenticationStatus: null == firebaseAuthenticationStatus
          ? _value.firebaseAuthenticationStatus
          : firebaseAuthenticationStatus // ignore: cast_nullable_to_non_nullable
              as FirebaseAuthenticationStatus,
      vegiAuthenticationStatus: null == vegiAuthenticationStatus
          ? _value.vegiAuthenticationStatus
          : vegiAuthenticationStatus // ignore: cast_nullable_to_non_nullable
              as VegiAuthenticationStatus,
      backup: null == backup
          ? _value.backup
          : backup // ignore: cast_nullable_to_non_nullable
              as bool,
      networks: null == networks
          ? _value.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mnemonic: null == mnemonic
          ? _value.mnemonic
          : mnemonic // ignore: cast_nullable_to_non_nullable
              as List<String>,
      pincode: null == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumberNoCountry: null == phoneNumberNoCountry
          ? _value.phoneNumberNoCountry
          : phoneNumberNoCountry // ignore: cast_nullable_to_non_nullable
              as String,
      warnSendDialogShowed: null == warnSendDialogShowed
          ? _value.warnSendDialogShowed
          : warnSendDialogShowed // ignore: cast_nullable_to_non_nullable
              as bool,
      isoCode: null == isoCode
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
      jwtToken: null == jwtToken
          ? _value.jwtToken
          : jwtToken // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      avatarTempFilePath: null == avatarTempFilePath
          ? _value.avatarTempFilePath
          : avatarTempFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      preferredSignonMethod: null == preferredSignonMethod
          ? _value.preferredSignonMethod
          : preferredSignonMethod // ignore: cast_nullable_to_non_nullable
              as PreferredSignonMethod,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationId: freezed == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationPassed: null == verificationPassed
          ? _value.verificationPassed
          : verificationPassed // ignore: cast_nullable_to_non_nullable
              as bool,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceOSName: null == deviceOSName
          ? _value.deviceOSName
          : deviceOSName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceReleaseName: null == deviceReleaseName
          ? _value.deviceReleaseName
          : deviceReleaseName // ignore: cast_nullable_to_non_nullable
              as String,
      appUpdateNeeded: null == appUpdateNeeded
          ? _value.appUpdateNeeded
          : appUpdateNeeded // ignore: cast_nullable_to_non_nullable
              as bool,
      appUpdateNextVersion: freezed == appUpdateNextVersion
          ? _value.appUpdateNextVersion
          : appUpdateNextVersion // ignore: cast_nullable_to_non_nullable
              as Version?,
      appUpdateNotificationSeenForBuildNumber: freezed ==
              appUpdateNotificationSeenForBuildNumber
          ? _value.appUpdateNotificationSeenForBuildNumber
          : appUpdateNotificationSeenForBuildNumber // ignore: cast_nullable_to_non_nullable
              as Version?,
      syncedContacts: null == syncedContacts
          ? _value.syncedContacts
          : syncedContacts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reverseContacts: null == reverseContacts
          ? _value.reverseContacts
          : reverseContacts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      hasUpgrade: null == hasUpgrade
          ? _value.hasUpgrade
          : hasUpgrade // ignore: cast_nullable_to_non_nullable
              as bool,
      authType: null == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as BiometricAuth,
      biometricallyAuthenticated: null == biometricallyAuthenticated
          ? _value.biometricallyAuthenticated
          : biometricallyAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      firebaseCredentials: freezed == firebaseCredentials
          ? _value.firebaseCredentials
          : firebaseCredentials // ignore: cast_nullable_to_non_nullable
              as AuthCredential?,
      firebaseSessionToken: freezed == firebaseSessionToken
          ? _value.firebaseSessionToken
          : firebaseSessionToken // ignore: cast_nullable_to_non_nullable
              as String?,
      firebaseMessagingToken: null == firebaseMessagingToken
          ? _value.firebaseMessagingToken
          : firebaseMessagingToken // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseMessagingAPNSToken: null == firebaseMessagingAPNSToken
          ? _value.firebaseMessagingAPNSToken
          : firebaseMessagingAPNSToken // ignore: cast_nullable_to_non_nullable
              as String,
      vegiSessionCookie: freezed == vegiSessionCookie
          ? _value.vegiSessionCookie
          : vegiSessionCookie // ignore: cast_nullable_to_non_nullable
              as String?,
      listOfDeliveryAddresses: null == listOfDeliveryAddresses
          ? _value.listOfDeliveryAddresses
          : listOfDeliveryAddresses // ignore: cast_nullable_to_non_nullable
              as List<DeliveryAddresses>,
      hasSavedSeedPhrase: null == hasSavedSeedPhrase
          ? _value.hasSavedSeedPhrase
          : hasSavedSeedPhrase // ignore: cast_nullable_to_non_nullable
              as bool,
      useLiveLocation: null == useLiveLocation
          ? _value.useLiveLocation
          : useLiveLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      userIsVerified: null == userIsVerified
          ? _value.userIsVerified
          : userIsVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      userLocation: freezed == userLocation
          ? _value.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as Position?,
      isUsingSimulator: null == isUsingSimulator
          ? _value.isUsingSimulator
          : isUsingSimulator // ignore: cast_nullable_to_non_nullable
              as bool,
      isUsingIosSimulator: null == isUsingIosSimulator
          ? _value.isUsingIosSimulator
          : isUsingIosSimulator // ignore: cast_nullable_to_non_nullable
              as bool,
      initialLoginDateTime: null == initialLoginDateTime
          ? _value.initialLoginDateTime
          : initialLoginDateTime // ignore: cast_nullable_to_non_nullable
              as String,
      showSeedPhraseBanner: null == showSeedPhraseBanner
          ? _value.showSeedPhraseBanner
          : showSeedPhraseBanner // ignore: cast_nullable_to_non_nullable
              as bool,
      surveyQuestions: null == surveyQuestions
          ? _value.surveyQuestions
          : surveyQuestions // ignore: cast_nullable_to_non_nullable
              as List<SurveyQuestion>,
      surveyCompleted: null == surveyCompleted
          ? _value.surveyCompleted
          : surveyCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      surveyEmailUsed: null == surveyEmailUsed
          ? _value.surveyEmailUsed
          : surveyEmailUsed // ignore: cast_nullable_to_non_nullable
              as String,
      isVendor: null == isVendor
          ? _value.isVendor
          : isVendor // ignore: cast_nullable_to_non_nullable
              as bool,
      stripeCustomerId: freezed == stripeCustomerId
          ? _value.stripeCustomerId
          : stripeCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      vegiAccountId: freezed == vegiAccountId
          ? _value.vegiAccountId
          : vegiAccountId // ignore: cast_nullable_to_non_nullable
              as int?,
      vegiUserId: freezed == vegiUserId
          ? _value.vegiUserId
          : vegiUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      isTester: null == isTester
          ? _value.isTester
          : isTester // ignore: cast_nullable_to_non_nullable
              as bool,
      isVegiSuperAdmin: null == isVegiSuperAdmin
          ? _value.isVegiSuperAdmin
          : isVegiSuperAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      userVegiRole: null == userVegiRole
          ? _value.userVegiRole
          : userVegiRole // ignore: cast_nullable_to_non_nullable
              as VegiRole,
      positionInWaitingList: freezed == positionInWaitingList
          ? _value.positionInWaitingList
          : positionInWaitingList // ignore: cast_nullable_to_non_nullable
              as int?,
      subscribedToWaitingListUpdates: null == subscribedToWaitingListUpdates
          ? _value.subscribedToWaitingListUpdates
          : subscribedToWaitingListUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      waitingListEntryId: freezed == waitingListEntryId
          ? _value.waitingListEntryId
          : waitingListEntryId // ignore: cast_nullable_to_non_nullable
              as int?,
      loginCounter: null == loginCounter
          ? _value.loginCounter
          : loginCounter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_UserState extends _UserState with DiagnosticableTreeMixin {
  _$_UserState(
      {@JsonKey(includeFromJson: false, includeToJson: false) this.wcURI,
      this.walletModules,
      this.installedAt,
      this.isContactsSynced,
      this.scrollToTop = false,
      this.walletAddress = '',
      this.privateKey = '',
      @JsonKey(fromJson: ethPrivateKeyFromJson, toJson: ethPrivateKeyToJson)
      this.fuseWalletCredentials = null,
      this.smartWallet = null,
      this.fuseAuthenticationStatus = FuseAuthenticationStatus.unauthenticated,
      this.firebaseAuthenticationStatus =
          FirebaseAuthenticationStatus.unauthenticated,
      this.vegiAuthenticationStatus = VegiAuthenticationStatus.unauthenticated,
      this.backup = false,
      this.networks = const [],
      this.mnemonic = const [],
      this.pincode = '',
      this.countryCode = '',
      this.phoneNumber = '',
      this.phoneNumberNoCountry = '',
      this.warnSendDialogShowed = false,
      this.isoCode = '',
      this.jwtToken = '',
      this.displayName = VegiConstants.defaultDisplayName,
      this.avatarUrl = '',
      this.avatarTempFilePath = '',
      this.preferredSignonMethod = PreferredSignonMethod.phone,
      this.email = '',
      this.password = null,
      this.verificationId,
      this.verificationPassed = false,
      this.identifier = '',
      this.deviceName = '',
      this.deviceOSName = '',
      this.deviceReleaseName = '',
      this.appUpdateNeeded = false,
      @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
      this.appUpdateNextVersion = null,
      @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
      this.appUpdateNotificationSeenForBuildNumber = null,
      this.syncedContacts = const [],
      this.reverseContacts = const {},
      this.currency = 'usd',
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.hasUpgrade = false,
      this.authType = BiometricAuth.none,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.biometricallyAuthenticated = false,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson) this.locale,
      @JsonKey(ignore: true) this.firebaseCredentials = null,
      this.firebaseSessionToken = null,
      this.firebaseMessagingToken = '',
      this.firebaseMessagingAPNSToken = '',
      this.vegiSessionCookie = null,
      this.listOfDeliveryAddresses = const [],
      this.hasSavedSeedPhrase = false,
      this.useLiveLocation = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.userIsVerified = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.userLocation = null,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.isUsingSimulator = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.isUsingIosSimulator = false,
      this.initialLoginDateTime = '',
      this.showSeedPhraseBanner = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.surveyQuestions = const [],
      this.surveyCompleted = false,
      this.surveyEmailUsed = '',
      this.isVendor = false,
      this.stripeCustomerId = null,
      this.vegiAccountId = null,
      this.vegiUserId = null,
      this.isTester = false,
      this.isVegiSuperAdmin = false,
      this.userVegiRole = VegiRole.consumer,
      this.positionInWaitingList = null,
      this.subscribedToWaitingListUpdates = false,
      this.waitingListEntryId = null,
      this.loginCounter = 0})
      : super._();

  factory _$_UserState.fromJson(Map<String, dynamic> json) =>
      _$$_UserStateFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? wcURI;
  @override
  final WalletModules? walletModules;
  @override
  final DateTime? installedAt;
  @override
  final bool? isContactsSynced;
  @override
  @JsonKey()
  final bool scrollToTop;

  /// * The wallet address is a smart contract wallet which actually conducts payments, holds balances, etc.
  /// * So basically, there are 3 types of stake folder in the fuse network technically speaking,
  /// there are wallet addresses which are opinionless dapps or smart contracts or classes that only
  /// act when given a request and either succeed or fail to perform an action.
  /// Then you have account addresses, these are the accounts that simply own wallets and are allowed to
  /// direct wallet dapps to perform transfers or any other action.
  /// Then finally there is the community manager address that also has power
  /// to direct wallet addresses that it does not necessarily own to perform functions such as transfers.
  @override
  @JsonKey()
  final String walletAddress;

  /// * the account address simply signs transactions 'on behalf' of the smart contract wallet.
  /// This is so only people who verify their phone numbers can create wallets or something.
  /// Fuse would be able to give you more information
  ///
  /// The account address is a 'real' wallet generated on the device which is only stored on the device.
// @Default('') String accountAddress,
  @override
  @JsonKey()
  final String privateKey;
  @override
  @JsonKey(fromJson: ethPrivateKeyFromJson, toJson: ethPrivateKeyToJson)
  final EthPrivateKey? fuseWalletCredentials;
  @override
  @JsonKey()
  final SmartWallet? smartWallet;
  @override
  @JsonKey()
  final FuseAuthenticationStatus fuseAuthenticationStatus;
  @override
  @JsonKey()
  final FirebaseAuthenticationStatus firebaseAuthenticationStatus;
  @override
  @JsonKey()
  final VegiAuthenticationStatus vegiAuthenticationStatus;
  @override
  @JsonKey()
  final bool backup;
  @override
  @JsonKey()
  final List<String> networks;
  @override
  @JsonKey()
  final List<String> mnemonic;
  @override
  @JsonKey()
  final String pincode;
  @override
  @JsonKey()
  final String countryCode;
// i.e. +44
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  @JsonKey()
  final String phoneNumberNoCountry;
  @override
  @JsonKey()
  final bool warnSendDialogShowed;
  @override
  @JsonKey()
  final String isoCode;
// i.e. 'GB'
  @override
  @JsonKey()
  final String jwtToken;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final String avatarUrl;
  @override
  @JsonKey()
  final String avatarTempFilePath;
  @override
  @JsonKey()
  final PreferredSignonMethod preferredSignonMethod;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String? password;
  @override
  final String? verificationId;
  @override
  @JsonKey()
  final bool verificationPassed;
  @override
  @JsonKey()
  final String identifier;
  @override
  @JsonKey()
  final String deviceName;
  @override
  @JsonKey()
  final String deviceOSName;
  @override
  @JsonKey()
  final String deviceReleaseName;
  @override
  @JsonKey()
  final bool appUpdateNeeded;
  @override
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  final Version? appUpdateNextVersion;
  @override
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  final Version? appUpdateNotificationSeenForBuildNumber;
  @override
  @JsonKey()
  final List<String> syncedContacts;
  @override
  @JsonKey()
  final Map<String, String> reverseContacts;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool hasUpgrade;
  @override
  @JsonKey()
  final BiometricAuth authType;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool biometricallyAuthenticated;
  @override
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  final Locale? locale;
  @override
  @JsonKey(ignore: true)
  final AuthCredential? firebaseCredentials;
  @override
  @JsonKey()
  final String? firebaseSessionToken;
  @override
  @JsonKey()
  final String firebaseMessagingToken;
  @override
  @JsonKey()
  final String firebaseMessagingAPNSToken;
  @override
  @JsonKey()
  final String? vegiSessionCookie;
  @override
  @JsonKey()
  final List<DeliveryAddresses> listOfDeliveryAddresses;
  @override
  @JsonKey()
  final bool hasSavedSeedPhrase;
  @override
  @JsonKey()
  final bool useLiveLocation;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool userIsVerified;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Position? userLocation;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isUsingSimulator;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isUsingIosSimulator;
  @override
  @JsonKey()
  final String initialLoginDateTime;
  @override
  @JsonKey()
  final bool showSeedPhraseBanner;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<SurveyQuestion> surveyQuestions;
  @override
  @JsonKey()
  final bool surveyCompleted;
  @override
  @JsonKey()
  final String surveyEmailUsed;
  @override
  @JsonKey()
  final bool isVendor;
  @override
  @JsonKey()
  final String? stripeCustomerId;
  @override
  @JsonKey()
  final int? vegiAccountId;
  @override
  @JsonKey()
  final int? vegiUserId;
  @override
  @JsonKey()
  final bool isTester;
  @override
  @JsonKey()
  final bool isVegiSuperAdmin;
  @override
  @JsonKey()
  final VegiRole userVegiRole;
  @override
  @JsonKey()
  final int? positionInWaitingList;
  @override
  @JsonKey()
  final bool subscribedToWaitingListUpdates;
  @override
  @JsonKey()
  final int? waitingListEntryId;
  @override
  @JsonKey()
  final int loginCounter;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserState(wcURI: $wcURI, walletModules: $walletModules, installedAt: $installedAt, isContactsSynced: $isContactsSynced, scrollToTop: $scrollToTop, walletAddress: $walletAddress, privateKey: $privateKey, fuseWalletCredentials: $fuseWalletCredentials, smartWallet: $smartWallet, fuseAuthenticationStatus: $fuseAuthenticationStatus, firebaseAuthenticationStatus: $firebaseAuthenticationStatus, vegiAuthenticationStatus: $vegiAuthenticationStatus, backup: $backup, networks: $networks, mnemonic: $mnemonic, pincode: $pincode, countryCode: $countryCode, phoneNumber: $phoneNumber, phoneNumberNoCountry: $phoneNumberNoCountry, warnSendDialogShowed: $warnSendDialogShowed, isoCode: $isoCode, jwtToken: $jwtToken, displayName: $displayName, avatarUrl: $avatarUrl, avatarTempFilePath: $avatarTempFilePath, preferredSignonMethod: $preferredSignonMethod, email: $email, password: $password, verificationId: $verificationId, verificationPassed: $verificationPassed, identifier: $identifier, deviceName: $deviceName, deviceOSName: $deviceOSName, deviceReleaseName: $deviceReleaseName, appUpdateNeeded: $appUpdateNeeded, appUpdateNextVersion: $appUpdateNextVersion, appUpdateNotificationSeenForBuildNumber: $appUpdateNotificationSeenForBuildNumber, syncedContacts: $syncedContacts, reverseContacts: $reverseContacts, currency: $currency, hasUpgrade: $hasUpgrade, authType: $authType, biometricallyAuthenticated: $biometricallyAuthenticated, locale: $locale, firebaseCredentials: $firebaseCredentials, firebaseSessionToken: $firebaseSessionToken, firebaseMessagingToken: $firebaseMessagingToken, firebaseMessagingAPNSToken: $firebaseMessagingAPNSToken, vegiSessionCookie: $vegiSessionCookie, listOfDeliveryAddresses: $listOfDeliveryAddresses, hasSavedSeedPhrase: $hasSavedSeedPhrase, useLiveLocation: $useLiveLocation, userIsVerified: $userIsVerified, userLocation: $userLocation, isUsingSimulator: $isUsingSimulator, isUsingIosSimulator: $isUsingIosSimulator, initialLoginDateTime: $initialLoginDateTime, showSeedPhraseBanner: $showSeedPhraseBanner, surveyQuestions: $surveyQuestions, surveyCompleted: $surveyCompleted, surveyEmailUsed: $surveyEmailUsed, isVendor: $isVendor, stripeCustomerId: $stripeCustomerId, vegiAccountId: $vegiAccountId, vegiUserId: $vegiUserId, isTester: $isTester, isVegiSuperAdmin: $isVegiSuperAdmin, userVegiRole: $userVegiRole, positionInWaitingList: $positionInWaitingList, subscribedToWaitingListUpdates: $subscribedToWaitingListUpdates, waitingListEntryId: $waitingListEntryId, loginCounter: $loginCounter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserState'))
      ..add(DiagnosticsProperty('wcURI', wcURI))
      ..add(DiagnosticsProperty('walletModules', walletModules))
      ..add(DiagnosticsProperty('installedAt', installedAt))
      ..add(DiagnosticsProperty('isContactsSynced', isContactsSynced))
      ..add(DiagnosticsProperty('scrollToTop', scrollToTop))
      ..add(DiagnosticsProperty('walletAddress', walletAddress))
      ..add(DiagnosticsProperty('privateKey', privateKey))
      ..add(DiagnosticsProperty('fuseWalletCredentials', fuseWalletCredentials))
      ..add(DiagnosticsProperty('smartWallet', smartWallet))
      ..add(DiagnosticsProperty(
          'fuseAuthenticationStatus', fuseAuthenticationStatus))
      ..add(DiagnosticsProperty(
          'firebaseAuthenticationStatus', firebaseAuthenticationStatus))
      ..add(DiagnosticsProperty(
          'vegiAuthenticationStatus', vegiAuthenticationStatus))
      ..add(DiagnosticsProperty('backup', backup))
      ..add(DiagnosticsProperty('networks', networks))
      ..add(DiagnosticsProperty('mnemonic', mnemonic))
      ..add(DiagnosticsProperty('pincode', pincode))
      ..add(DiagnosticsProperty('countryCode', countryCode))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('phoneNumberNoCountry', phoneNumberNoCountry))
      ..add(DiagnosticsProperty('warnSendDialogShowed', warnSendDialogShowed))
      ..add(DiagnosticsProperty('isoCode', isoCode))
      ..add(DiagnosticsProperty('jwtToken', jwtToken))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl))
      ..add(DiagnosticsProperty('avatarTempFilePath', avatarTempFilePath))
      ..add(DiagnosticsProperty('preferredSignonMethod', preferredSignonMethod))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('verificationId', verificationId))
      ..add(DiagnosticsProperty('verificationPassed', verificationPassed))
      ..add(DiagnosticsProperty('identifier', identifier))
      ..add(DiagnosticsProperty('deviceName', deviceName))
      ..add(DiagnosticsProperty('deviceOSName', deviceOSName))
      ..add(DiagnosticsProperty('deviceReleaseName', deviceReleaseName))
      ..add(DiagnosticsProperty('appUpdateNeeded', appUpdateNeeded))
      ..add(DiagnosticsProperty('appUpdateNextVersion', appUpdateNextVersion))
      ..add(DiagnosticsProperty('appUpdateNotificationSeenForBuildNumber',
          appUpdateNotificationSeenForBuildNumber))
      ..add(DiagnosticsProperty('syncedContacts', syncedContacts))
      ..add(DiagnosticsProperty('reverseContacts', reverseContacts))
      ..add(DiagnosticsProperty('currency', currency))
      ..add(DiagnosticsProperty('hasUpgrade', hasUpgrade))
      ..add(DiagnosticsProperty('authType', authType))
      ..add(DiagnosticsProperty(
          'biometricallyAuthenticated', biometricallyAuthenticated))
      ..add(DiagnosticsProperty('locale', locale))
      ..add(DiagnosticsProperty('firebaseCredentials', firebaseCredentials))
      ..add(DiagnosticsProperty('firebaseSessionToken', firebaseSessionToken))
      ..add(
          DiagnosticsProperty('firebaseMessagingToken', firebaseMessagingToken))
      ..add(DiagnosticsProperty(
          'firebaseMessagingAPNSToken', firebaseMessagingAPNSToken))
      ..add(DiagnosticsProperty('vegiSessionCookie', vegiSessionCookie))
      ..add(DiagnosticsProperty(
          'listOfDeliveryAddresses', listOfDeliveryAddresses))
      ..add(DiagnosticsProperty('hasSavedSeedPhrase', hasSavedSeedPhrase))
      ..add(DiagnosticsProperty('useLiveLocation', useLiveLocation))
      ..add(DiagnosticsProperty('userIsVerified', userIsVerified))
      ..add(DiagnosticsProperty('userLocation', userLocation))
      ..add(DiagnosticsProperty('isUsingSimulator', isUsingSimulator))
      ..add(DiagnosticsProperty('isUsingIosSimulator', isUsingIosSimulator))
      ..add(DiagnosticsProperty('initialLoginDateTime', initialLoginDateTime))
      ..add(DiagnosticsProperty('showSeedPhraseBanner', showSeedPhraseBanner))
      ..add(DiagnosticsProperty('surveyQuestions', surveyQuestions))
      ..add(DiagnosticsProperty('surveyCompleted', surveyCompleted))
      ..add(DiagnosticsProperty('surveyEmailUsed', surveyEmailUsed))
      ..add(DiagnosticsProperty('isVendor', isVendor))
      ..add(DiagnosticsProperty('stripeCustomerId', stripeCustomerId))
      ..add(DiagnosticsProperty('vegiAccountId', vegiAccountId))
      ..add(DiagnosticsProperty('vegiUserId', vegiUserId))
      ..add(DiagnosticsProperty('isTester', isTester))
      ..add(DiagnosticsProperty('isVegiSuperAdmin', isVegiSuperAdmin))
      ..add(DiagnosticsProperty('userVegiRole', userVegiRole))
      ..add(DiagnosticsProperty('positionInWaitingList', positionInWaitingList))
      ..add(DiagnosticsProperty(
          'subscribedToWaitingListUpdates', subscribedToWaitingListUpdates))
      ..add(DiagnosticsProperty('waitingListEntryId', waitingListEntryId))
      ..add(DiagnosticsProperty('loginCounter', loginCounter));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserState &&
            (identical(other.wcURI, wcURI) || other.wcURI == wcURI) &&
            (identical(other.walletModules, walletModules) ||
                other.walletModules == walletModules) &&
            (identical(other.installedAt, installedAt) ||
                other.installedAt == installedAt) &&
            (identical(other.isContactsSynced, isContactsSynced) ||
                other.isContactsSynced == isContactsSynced) &&
            (identical(other.scrollToTop, scrollToTop) ||
                other.scrollToTop == scrollToTop) &&
            (identical(other.walletAddress, walletAddress) ||
                other.walletAddress == walletAddress) &&
            (identical(other.privateKey, privateKey) ||
                other.privateKey == privateKey) &&
            (identical(other.fuseWalletCredentials, fuseWalletCredentials) ||
                other.fuseWalletCredentials == fuseWalletCredentials) &&
            (identical(other.smartWallet, smartWallet) ||
                other.smartWallet == smartWallet) &&
            (identical(other.fuseAuthenticationStatus, fuseAuthenticationStatus) ||
                other.fuseAuthenticationStatus == fuseAuthenticationStatus) &&
            (identical(other.firebaseAuthenticationStatus, firebaseAuthenticationStatus) ||
                other.firebaseAuthenticationStatus ==
                    firebaseAuthenticationStatus) &&
            (identical(other.vegiAuthenticationStatus, vegiAuthenticationStatus) ||
                other.vegiAuthenticationStatus == vegiAuthenticationStatus) &&
            (identical(other.backup, backup) || other.backup == backup) &&
            const DeepCollectionEquality().equals(other.networks, networks) &&
            const DeepCollectionEquality().equals(other.mnemonic, mnemonic) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.phoneNumberNoCountry, phoneNumberNoCountry) ||
                other.phoneNumberNoCountry == phoneNumberNoCountry) &&
            (identical(other.warnSendDialogShowed, warnSendDialogShowed) ||
                other.warnSendDialogShowed == warnSendDialogShowed) &&
            (identical(other.isoCode, isoCode) || other.isoCode == isoCode) &&
            (identical(other.jwtToken, jwtToken) ||
                other.jwtToken == jwtToken) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.avatarTempFilePath, avatarTempFilePath) ||
                other.avatarTempFilePath == avatarTempFilePath) &&
            (identical(other.preferredSignonMethod, preferredSignonMethod) ||
                other.preferredSignonMethod == preferredSignonMethod) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.verificationPassed, verificationPassed) ||
                other.verificationPassed == verificationPassed) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceOSName, deviceOSName) ||
                other.deviceOSName == deviceOSName) &&
            (identical(other.deviceReleaseName, deviceReleaseName) ||
                other.deviceReleaseName == deviceReleaseName) &&
            (identical(other.appUpdateNeeded, appUpdateNeeded) || other.appUpdateNeeded == appUpdateNeeded) &&
            (identical(other.appUpdateNextVersion, appUpdateNextVersion) || other.appUpdateNextVersion == appUpdateNextVersion) &&
            (identical(other.appUpdateNotificationSeenForBuildNumber, appUpdateNotificationSeenForBuildNumber) || other.appUpdateNotificationSeenForBuildNumber == appUpdateNotificationSeenForBuildNumber) &&
            const DeepCollectionEquality().equals(other.syncedContacts, syncedContacts) &&
            const DeepCollectionEquality().equals(other.reverseContacts, reverseContacts) &&
            (identical(other.currency, currency) || other.currency == currency) &&
            (identical(other.hasUpgrade, hasUpgrade) || other.hasUpgrade == hasUpgrade) &&
            (identical(other.authType, authType) || other.authType == authType) &&
            (identical(other.biometricallyAuthenticated, biometricallyAuthenticated) || other.biometricallyAuthenticated == biometricallyAuthenticated) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.firebaseCredentials, firebaseCredentials) || other.firebaseCredentials == firebaseCredentials) &&
            (identical(other.firebaseSessionToken, firebaseSessionToken) || other.firebaseSessionToken == firebaseSessionToken) &&
            (identical(other.firebaseMessagingToken, firebaseMessagingToken) || other.firebaseMessagingToken == firebaseMessagingToken) &&
            (identical(other.firebaseMessagingAPNSToken, firebaseMessagingAPNSToken) || other.firebaseMessagingAPNSToken == firebaseMessagingAPNSToken) &&
            (identical(other.vegiSessionCookie, vegiSessionCookie) || other.vegiSessionCookie == vegiSessionCookie) &&
            const DeepCollectionEquality().equals(other.listOfDeliveryAddresses, listOfDeliveryAddresses) &&
            (identical(other.hasSavedSeedPhrase, hasSavedSeedPhrase) || other.hasSavedSeedPhrase == hasSavedSeedPhrase) &&
            (identical(other.useLiveLocation, useLiveLocation) || other.useLiveLocation == useLiveLocation) &&
            (identical(other.userIsVerified, userIsVerified) || other.userIsVerified == userIsVerified) &&
            (identical(other.userLocation, userLocation) || other.userLocation == userLocation) &&
            (identical(other.isUsingSimulator, isUsingSimulator) || other.isUsingSimulator == isUsingSimulator) &&
            (identical(other.isUsingIosSimulator, isUsingIosSimulator) || other.isUsingIosSimulator == isUsingIosSimulator) &&
            (identical(other.initialLoginDateTime, initialLoginDateTime) || other.initialLoginDateTime == initialLoginDateTime) &&
            (identical(other.showSeedPhraseBanner, showSeedPhraseBanner) || other.showSeedPhraseBanner == showSeedPhraseBanner) &&
            const DeepCollectionEquality().equals(other.surveyQuestions, surveyQuestions) &&
            (identical(other.surveyCompleted, surveyCompleted) || other.surveyCompleted == surveyCompleted) &&
            (identical(other.surveyEmailUsed, surveyEmailUsed) || other.surveyEmailUsed == surveyEmailUsed) &&
            (identical(other.isVendor, isVendor) || other.isVendor == isVendor) &&
            (identical(other.stripeCustomerId, stripeCustomerId) || other.stripeCustomerId == stripeCustomerId) &&
            (identical(other.vegiAccountId, vegiAccountId) || other.vegiAccountId == vegiAccountId) &&
            (identical(other.vegiUserId, vegiUserId) || other.vegiUserId == vegiUserId) &&
            (identical(other.isTester, isTester) || other.isTester == isTester) &&
            (identical(other.isVegiSuperAdmin, isVegiSuperAdmin) || other.isVegiSuperAdmin == isVegiSuperAdmin) &&
            (identical(other.userVegiRole, userVegiRole) || other.userVegiRole == userVegiRole) &&
            (identical(other.positionInWaitingList, positionInWaitingList) || other.positionInWaitingList == positionInWaitingList) &&
            (identical(other.subscribedToWaitingListUpdates, subscribedToWaitingListUpdates) || other.subscribedToWaitingListUpdates == subscribedToWaitingListUpdates) &&
            (identical(other.waitingListEntryId, waitingListEntryId) || other.waitingListEntryId == waitingListEntryId) &&
            (identical(other.loginCounter, loginCounter) || other.loginCounter == loginCounter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        wcURI,
        walletModules,
        installedAt,
        isContactsSynced,
        scrollToTop,
        walletAddress,
        privateKey,
        fuseWalletCredentials,
        smartWallet,
        fuseAuthenticationStatus,
        firebaseAuthenticationStatus,
        vegiAuthenticationStatus,
        backup,
        const DeepCollectionEquality().hash(networks),
        const DeepCollectionEquality().hash(mnemonic),
        pincode,
        countryCode,
        phoneNumber,
        phoneNumberNoCountry,
        warnSendDialogShowed,
        isoCode,
        jwtToken,
        displayName,
        avatarUrl,
        avatarTempFilePath,
        preferredSignonMethod,
        email,
        password,
        verificationId,
        verificationPassed,
        identifier,
        deviceName,
        deviceOSName,
        deviceReleaseName,
        appUpdateNeeded,
        appUpdateNextVersion,
        appUpdateNotificationSeenForBuildNumber,
        const DeepCollectionEquality().hash(syncedContacts),
        const DeepCollectionEquality().hash(reverseContacts),
        currency,
        hasUpgrade,
        authType,
        biometricallyAuthenticated,
        locale,
        firebaseCredentials,
        firebaseSessionToken,
        firebaseMessagingToken,
        firebaseMessagingAPNSToken,
        vegiSessionCookie,
        const DeepCollectionEquality().hash(listOfDeliveryAddresses),
        hasSavedSeedPhrase,
        useLiveLocation,
        userIsVerified,
        userLocation,
        isUsingSimulator,
        isUsingIosSimulator,
        initialLoginDateTime,
        showSeedPhraseBanner,
        const DeepCollectionEquality().hash(surveyQuestions),
        surveyCompleted,
        surveyEmailUsed,
        isVendor,
        stripeCustomerId,
        vegiAccountId,
        vegiUserId,
        isTester,
        isVegiSuperAdmin,
        userVegiRole,
        positionInWaitingList,
        subscribedToWaitingListUpdates,
        waitingListEntryId,
        loginCounter
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserStateCopyWith<_$_UserState> get copyWith =>
      __$$_UserStateCopyWithImpl<_$_UserState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserStateToJson(
      this,
    );
  }
}

abstract class _UserState extends UserState {
  factory _UserState(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      final String? wcURI,
      final WalletModules? walletModules,
      final DateTime? installedAt,
      final bool? isContactsSynced,
      final bool scrollToTop,
      final String walletAddress,
      final String privateKey,
      @JsonKey(fromJson: ethPrivateKeyFromJson, toJson: ethPrivateKeyToJson)
      final EthPrivateKey? fuseWalletCredentials,
      final SmartWallet? smartWallet,
      final FuseAuthenticationStatus fuseAuthenticationStatus,
      final FirebaseAuthenticationStatus firebaseAuthenticationStatus,
      final VegiAuthenticationStatus vegiAuthenticationStatus,
      final bool backup,
      final List<String> networks,
      final List<String> mnemonic,
      final String pincode,
      final String countryCode,
      final String phoneNumber,
      final String phoneNumberNoCountry,
      final bool warnSendDialogShowed,
      final String isoCode,
      final String jwtToken,
      final String displayName,
      final String avatarUrl,
      final String avatarTempFilePath,
      final PreferredSignonMethod preferredSignonMethod,
      final String email,
      final String? password,
      final String? verificationId,
      final bool verificationPassed,
      final String identifier,
      final String deviceName,
      final String deviceOSName,
      final String deviceReleaseName,
      final bool appUpdateNeeded,
      @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
      final Version? appUpdateNextVersion,
      @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
      final Version? appUpdateNotificationSeenForBuildNumber,
      final List<String> syncedContacts,
      final Map<String, String> reverseContacts,
      final String currency,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool hasUpgrade,
      final BiometricAuth authType,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool biometricallyAuthenticated,
      @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
      final Locale? locale,
      @JsonKey(ignore: true) final AuthCredential? firebaseCredentials,
      final String? firebaseSessionToken,
      final String firebaseMessagingToken,
      final String firebaseMessagingAPNSToken,
      final String? vegiSessionCookie,
      final List<DeliveryAddresses> listOfDeliveryAddresses,
      final bool hasSavedSeedPhrase,
      final bool useLiveLocation,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool userIsVerified,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Position? userLocation,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool isUsingSimulator,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool isUsingIosSimulator,
      final String initialLoginDateTime,
      final bool showSeedPhraseBanner,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<SurveyQuestion> surveyQuestions,
      final bool surveyCompleted,
      final String surveyEmailUsed,
      final bool isVendor,
      final String? stripeCustomerId,
      final int? vegiAccountId,
      final int? vegiUserId,
      final bool isTester,
      final bool isVegiSuperAdmin,
      final VegiRole userVegiRole,
      final int? positionInWaitingList,
      final bool subscribedToWaitingListUpdates,
      final int? waitingListEntryId,
      final int loginCounter}) = _$_UserState;
  _UserState._() : super._();

  factory _UserState.fromJson(Map<String, dynamic> json) =
      _$_UserState.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get wcURI;
  @override
  WalletModules? get walletModules;
  @override
  DateTime? get installedAt;
  @override
  bool? get isContactsSynced;
  @override
  bool get scrollToTop;
  @override

  /// * The wallet address is a smart contract wallet which actually conducts payments, holds balances, etc.
  /// * So basically, there are 3 types of stake folder in the fuse network technically speaking,
  /// there are wallet addresses which are opinionless dapps or smart contracts or classes that only
  /// act when given a request and either succeed or fail to perform an action.
  /// Then you have account addresses, these are the accounts that simply own wallets and are allowed to
  /// direct wallet dapps to perform transfers or any other action.
  /// Then finally there is the community manager address that also has power
  /// to direct wallet addresses that it does not necessarily own to perform functions such as transfers.
  String get walletAddress;
  @override

  /// * the account address simply signs transactions 'on behalf' of the smart contract wallet.
  /// This is so only people who verify their phone numbers can create wallets or something.
  /// Fuse would be able to give you more information
  ///
  /// The account address is a 'real' wallet generated on the device which is only stored on the device.
// @Default('') String accountAddress,
  String get privateKey;
  @override
  @JsonKey(fromJson: ethPrivateKeyFromJson, toJson: ethPrivateKeyToJson)
  EthPrivateKey? get fuseWalletCredentials;
  @override
  SmartWallet? get smartWallet;
  @override
  FuseAuthenticationStatus get fuseAuthenticationStatus;
  @override
  FirebaseAuthenticationStatus get firebaseAuthenticationStatus;
  @override
  VegiAuthenticationStatus get vegiAuthenticationStatus;
  @override
  bool get backup;
  @override
  List<String> get networks;
  @override
  List<String> get mnemonic;
  @override
  String get pincode;
  @override
  String get countryCode;
  @override // i.e. +44
  String get phoneNumber;
  @override
  String get phoneNumberNoCountry;
  @override
  bool get warnSendDialogShowed;
  @override
  String get isoCode;
  @override // i.e. 'GB'
  String get jwtToken;
  @override
  String get displayName;
  @override
  String get avatarUrl;
  @override
  String get avatarTempFilePath;
  @override
  PreferredSignonMethod get preferredSignonMethod;
  @override
  String get email;
  @override
  String? get password;
  @override
  String? get verificationId;
  @override
  bool get verificationPassed;
  @override
  String get identifier;
  @override
  String get deviceName;
  @override
  String get deviceOSName;
  @override
  String get deviceReleaseName;
  @override
  bool get appUpdateNeeded;
  @override
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  Version? get appUpdateNextVersion;
  @override
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  Version? get appUpdateNotificationSeenForBuildNumber;
  @override
  List<String> get syncedContacts;
  @override
  Map<String, String> get reverseContacts;
  @override
  String get currency;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get hasUpgrade;
  @override
  BiometricAuth get authType;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get biometricallyAuthenticated;
  @override
  @JsonKey(fromJson: localeFromJson, toJson: localeToJson)
  Locale? get locale;
  @override
  @JsonKey(ignore: true)
  AuthCredential? get firebaseCredentials;
  @override
  String? get firebaseSessionToken;
  @override
  String get firebaseMessagingToken;
  @override
  String get firebaseMessagingAPNSToken;
  @override
  String? get vegiSessionCookie;
  @override
  List<DeliveryAddresses> get listOfDeliveryAddresses;
  @override
  bool get hasSavedSeedPhrase;
  @override
  bool get useLiveLocation;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get userIsVerified;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Position? get userLocation;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isUsingSimulator;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isUsingIosSimulator;
  @override
  String get initialLoginDateTime;
  @override
  bool get showSeedPhraseBanner;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<SurveyQuestion> get surveyQuestions;
  @override
  bool get surveyCompleted;
  @override
  String get surveyEmailUsed;
  @override
  bool get isVendor;
  @override
  String? get stripeCustomerId;
  @override
  int? get vegiAccountId;
  @override
  int? get vegiUserId;
  @override
  bool get isTester;
  @override
  bool get isVegiSuperAdmin;
  @override
  VegiRole get userVegiRole;
  @override
  int? get positionInWaitingList;
  @override
  bool get subscribedToWaitingListUpdates;
  @override
  int? get waitingListEntryId;
  @override
  int get loginCounter;
  @override
  @JsonKey(ignore: true)
  _$$_UserStateCopyWith<_$_UserState> get copyWith =>
      throw _privateConstructorUsedError;
}
