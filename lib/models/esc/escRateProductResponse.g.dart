// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escRateProductResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EscRateProductResponse _$$_EscRateProductResponseFromJson(
        Map<String, dynamic> json) =>
    _$_EscRateProductResponse(
      category: fromJsonProductCategory(json['category']),
      most_similar_esc_product:
          fromJsonEscMostSimilarESCProduct(json['most_similar_esc_product']),
      new_rating: fromJsonEscNewRating(json['new_rating']),
    );

Map<String, dynamic> _$$_EscRateProductResponseToJson(
        _$_EscRateProductResponse instance) =>
    <String, dynamic>{
      'category': instance.category?.toJson(),
      'most_similar_esc_product': instance.most_similar_esc_product?.toJson(),
      'new_rating': instance.new_rating?.toJson(),
    };
