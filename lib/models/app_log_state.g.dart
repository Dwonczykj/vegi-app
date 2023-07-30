// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_log_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppLogState _$$_AppLogStateFromJson(Map<String, dynamic> json) =>
    _$_AppLogState(
      logs: (json['logs'] as List<dynamic>)
          .map((e) => LogEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AppLogStateToJson(_$_AppLogState instance) =>
    <String, dynamic>{
      'logs': instance.logs.map((e) => e.toJson()).toList(),
    };
