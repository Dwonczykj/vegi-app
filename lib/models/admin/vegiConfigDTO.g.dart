// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vegiConfigDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VegiConfigDTO _$$_VegiConfigDTOFromJson(Map<String, dynamic> json) =>
    _$_VegiConfigDTO(
      databaseUrl: json['databaseUrl'] as String,
      databaseSailsAdapter: json['databaseSailsAdapter'] as String,
      webserverHostName: json['webserverHostName'] as String,
      environment: json['environment'] as String,
    );

Map<String, dynamic> _$$_VegiConfigDTOToJson(_$_VegiConfigDTO instance) =>
    <String, dynamic>{
      'databaseUrl': instance.databaseUrl,
      'databaseSailsAdapter': instance.databaseSailsAdapter,
      'webserverHostName': instance.webserverHostName,
      'environment': instance.environment,
    };
