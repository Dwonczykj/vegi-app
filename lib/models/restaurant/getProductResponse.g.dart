// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getProductResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetProductResponse _$$_GetProductResponseFromJson(
        Map<String, dynamic> json) =>
    _$_GetProductResponse(
      product: fromJsonProductDTO(json['product']),
      cateogory: fromJsonProductCategory(json['cateogory']),
    );

Map<String, dynamic> _$$_GetProductResponseToJson(
        _$_GetProductResponse instance) =>
    <String, dynamic>{
      'product': instance.product?.toJson(),
      'cateogory': instance.cateogory?.toJson(),
    };
