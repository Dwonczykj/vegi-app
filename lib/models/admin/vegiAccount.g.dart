// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vegiAccount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VegiAccount _$$_VegiAccountFromJson(Map<String, dynamic> json) =>
    _$_VegiAccount(
      id: json['id'] as int,
      verified: json['verified'] as bool,
      walletAddress: json['walletAddress'] as String,
      accountType:
          $enumDecodeNullable(_$VegiAccountTypeEnumMap, json['accountType']) ??
              null,
      imageUrl: json['imageUrl'] as String? ?? '',
      stripeCustomerId: json['stripeCustomerId'] as String? ?? null,
      stripeAccountId: json['stripeAccountId'] as String? ?? null,
      bankCardNumber: json['bankCardNumber'] as String? ?? null,
      bankCardAccountName: json['bankCardAccountName'] as String? ?? null,
      bankCardExpiryDateMonth: json['bankCardExpiryDateMonth'] as int? ?? null,
      bankCardExpiryDateYear: json['bankCardExpiryDateYear'] as int? ?? null,
    );

Map<String, dynamic> _$$_VegiAccountToJson(_$_VegiAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'verified': instance.verified,
      'walletAddress': instance.walletAddress,
      'accountType': _$VegiAccountTypeEnumMap[instance.accountType],
      'imageUrl': instance.imageUrl,
      'stripeCustomerId': instance.stripeCustomerId,
      'stripeAccountId': instance.stripeAccountId,
      'bankCardNumber': instance.bankCardNumber,
      'bankCardAccountName': instance.bankCardAccountName,
      'bankCardExpiryDateMonth': instance.bankCardExpiryDateMonth,
      'bankCardExpiryDateYear': instance.bankCardExpiryDateYear,
    };

const _$VegiAccountTypeEnumMap = {
  VegiAccountType.ethereum: 'ethereum',
  VegiAccountType.bank: 'bank',
};
