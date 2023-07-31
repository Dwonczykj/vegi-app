// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signUpErrorDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SignUpErrorDetails _$$_SignUpErrorDetailsFromJson(
        Map<String, dynamic> json) =>
    _$_SignUpErrorDetails(
      title: json['title'] as String,
      message: json['message'] as String,
      stackTrace: stackTraceFromString(json['stackTrace']),
      code: $enumDecodeNullable(_$SignUpErrCodeEnumMap, json['code']),
    );

Map<String, dynamic> _$$_SignUpErrorDetailsToJson(
        _$_SignUpErrorDetails instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'stackTrace': stackTraceToString(instance.stackTrace),
      'code': _$SignUpErrCodeEnumMap[instance.code],
    };

const _$SignUpErrCodeEnumMap = {
  SignUpErrCode.invalidCredentials: 'invalidCredentials',
  SignUpErrCode.invalidVerificationId: 'invalidVerificationId',
  SignUpErrCode.wrongPassword: 'wrongPassword',
  SignUpErrCode.userNotFound: 'userNotFound',
  SignUpErrCode.weakPassword: 'weakPassword',
  SignUpErrCode.emailAlreadyInUse: 'emailAlreadyInUse',
  SignUpErrCode.sessionExpired: 'sessionExpired',
  SignUpErrCode.failedToFetchFuseWallet: 'failedToFetchFuseWallet',
  SignUpErrCode.signonMethodNotImplemented: 'signonMethodNotImplemented',
  SignUpErrCode.invalidEmail: 'invalidEmail',
  SignUpErrCode.userDisabled: 'userDisabled',
  SignUpErrCode.emailLinkExpired: 'emailLinkExpired',
  SignUpErrCode.unauthorizedDomain: 'unauthorizedDomain',
  SignUpErrCode.serverError: 'serverError',
  SignUpErrCode.fuseWalletSDKFailedAuthentication:
      'fuseWalletSDKFailedAuthentication',
  SignUpErrCode
          .fuseWalletSDKFailedAuthenticationAsMissingUserDetailsToAuthFuseWallet:
      'fuseWalletSDKFailedAuthenticationAsMissingUserDetailsToAuthFuseWallet',
  SignUpErrCode.fuseWalletSDKFailedCreateLocalAccountPrivateKey:
      'fuseWalletSDKFailedCreateLocalAccountPrivateKey',
  SignUpErrCode.fuseWalletSDKFailedCreate: 'fuseWalletSDKFailedCreate',
  SignUpErrCode
          .fuseWalletSDKFailedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt:
      'fuseWalletSDKFailedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt',
  SignUpErrCode.fuseWalletSDKFailedFetch: 'fuseWalletSDKFailedFetch',
};
