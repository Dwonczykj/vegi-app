// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escNewRating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EscNewRating _$$_EscNewRatingFromJson(Map<String, dynamic> json) =>
    _$_EscNewRating(
      explanations: json['explanations'] == null
          ? const []
          : fromJsonESCExplanationList(json['explanations']),
      rating: fromJsonESCRating(json['rating']),
    );

Map<String, dynamic> _$$_EscNewRatingToJson(_$_EscNewRating instance) =>
    <String, dynamic>{
      'explanations': instance.explanations.map((e) => e.toJson()).toList(),
      'rating': instance.rating?.toJson(),
    };
