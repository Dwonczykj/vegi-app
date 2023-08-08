// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openingHours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OpeningHours _$$_OpeningHoursFromJson(Map<String, dynamic> json) =>
    _$_OpeningHours(
      id: json['id'] as int,
      openTime: json['openTime'] as String,
      closeTime: json['closeTime'] as String,
      timezone: json['timezone'] as String?,
      specialDate: json['specialDate'] as String?,
      dayOfWeek: $enumDecode(_$DayOfWeekEnumMap, json['dayOfWeek']),
      logicId: json['logicId'] as String?,
      isOpen: json['isOpen'] as bool? ?? false,
    );

Map<String, dynamic> _$$_OpeningHoursToJson(_$_OpeningHours instance) =>
    <String, dynamic>{
      'id': instance.id,
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
      'timezone': instance.timezone,
      'specialDate': instance.specialDate,
      'dayOfWeek': _$DayOfWeekEnumMap[instance.dayOfWeek]!,
      'logicId': instance.logicId,
      'isOpen': instance.isOpen,
    };

const _$DayOfWeekEnumMap = {
  DayOfWeek.Monday: 'Monday',
  DayOfWeek.Tuesday: 'Tuesday',
  DayOfWeek.Wednesday: 'Wednesday',
  DayOfWeek.Thursday: 'Thursday',
  DayOfWeek.Friday: 'Friday',
  DayOfWeek.Saturday: 'Saturday',
  DayOfWeek.Sunday: 'Sunday',
};
