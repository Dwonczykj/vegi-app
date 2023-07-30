// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LogEvent _$$_LogEventFromJson(Map<String, dynamic> json) => _$_LogEvent(
      message: json['message'] as String,
      information: json['information'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$_LogEventToJson(_$_LogEvent instance) =>
    <String, dynamic>{
      'message': instance.message,
      'information': instance.information,
      'timestamp': instance.timestamp.toIso8601String(),
    };
