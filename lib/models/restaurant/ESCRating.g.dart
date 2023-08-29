// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ESCRating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ESCRating _$$_ESCRatingFromJson(Map<String, dynamic> json) => _$_ESCRating(
      id: json['id'] as int,
      calculatedOn: jsonToTimeStampNullable(json['calculated_on']),
      product: json['product'] as int,
      product_id: json['product_id'] as String,
      product_name: json['product_name'] as String,
      rating: json['rating'] as num,
    );

Map<String, dynamic> _$$_ESCRatingToJson(_$_ESCRating instance) =>
    <String, dynamic>{
      'id': instance.id,
      'calculated_on': timeStampToJsonStringNullable(instance.calculatedOn),
      'product': instance.product,
      'product_id': instance.product_id,
      'product_name': instance.product_name,
      'rating': instance.rating,
    };
