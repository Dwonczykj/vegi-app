// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acceptVoucherResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AcceptVoucherResponse _$$_AcceptVoucherResponseFromJson(
        Map<String, dynamic> json) =>
    _$_AcceptVoucherResponse(
      codeAcceptanceStatus: $enumDecode(
          _$DiscountCodeAcceptanceStatusEnumMap, json['codeAcceptanceStatus']),
      discount: json['discount'] == null
          ? null
          : Discount.fromJson(json['discount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AcceptVoucherResponseToJson(
        _$_AcceptVoucherResponse instance) =>
    <String, dynamic>{
      'codeAcceptanceStatus':
          _$DiscountCodeAcceptanceStatusEnumMap[instance.codeAcceptanceStatus]!,
      'discount': instance.discount?.toJson(),
    };

const _$DiscountCodeAcceptanceStatusEnumMap = {
  DiscountCodeAcceptanceStatus.accepted: 'accepted',
  DiscountCodeAcceptanceStatus.rejected: 'rejected',
  DiscountCodeAcceptanceStatus.already_accepted: 'already_accepted',
};
