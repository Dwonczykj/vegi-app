// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'esc_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EscState _$$_EscStateFromJson(Map<String, dynamic> json) => _$_EscState(
      ratings: (json['ratings'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k), EscNewRating.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_EscStateToJson(_$_EscState instance) =>
    <String, dynamic>{
      'ratings':
          instance.ratings.map((k, e) => MapEntry(k.toString(), e.toJson())),
    };
