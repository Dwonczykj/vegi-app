// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ESCExplanation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ESCExplanation _$$_ESCExplanationFromJson(Map<String, dynamic> json) =>
    _$_ESCExplanation(
      evidence: json['evidence'] as String,
      id: json['id'] as int,
      measure: json['measure'] as num,
      rating: json['rating'] as num,
      source: json['source'] as int,
      title: json['title'] as String,
      reasons:
          (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String? ?? '',
    );

Map<String, dynamic> _$$_ESCExplanationToJson(_$_ESCExplanation instance) =>
    <String, dynamic>{
      'evidence': instance.evidence,
      'id': instance.id,
      'measure': instance.measure,
      'rating': instance.rating,
      'source': instance.source,
      'title': instance.title,
      'reasons': instance.reasons,
      'imageUrl': instance.imageUrl,
    };
