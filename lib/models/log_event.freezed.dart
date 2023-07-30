// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'log_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LogEvent _$LogEventFromJson(Map<String, dynamic> json) {
  return _LogEvent.fromJson(json);
}

/// @nodoc
mixin _$LogEvent {
  String get message => throw _privateConstructorUsedError;
  Map<String, dynamic> get information => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogEventCopyWith<LogEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogEventCopyWith<$Res> {
  factory $LogEventCopyWith(LogEvent value, $Res Function(LogEvent) then) =
      _$LogEventCopyWithImpl<$Res, LogEvent>;
  @useResult
  $Res call(
      {String message, Map<String, dynamic> information, DateTime timestamp});
}

/// @nodoc
class _$LogEventCopyWithImpl<$Res, $Val extends LogEvent>
    implements $LogEventCopyWith<$Res> {
  _$LogEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? information = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      information: null == information
          ? _value.information
          : information // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LogEventCopyWith<$Res> implements $LogEventCopyWith<$Res> {
  factory _$$_LogEventCopyWith(
          _$_LogEvent value, $Res Function(_$_LogEvent) then) =
      __$$_LogEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message, Map<String, dynamic> information, DateTime timestamp});
}

/// @nodoc
class __$$_LogEventCopyWithImpl<$Res>
    extends _$LogEventCopyWithImpl<$Res, _$_LogEvent>
    implements _$$_LogEventCopyWith<$Res> {
  __$$_LogEventCopyWithImpl(
      _$_LogEvent _value, $Res Function(_$_LogEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? information = null,
    Object? timestamp = null,
  }) {
    return _then(_$_LogEvent(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      information: null == information
          ? _value.information
          : information // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_LogEvent extends _LogEvent {
  _$_LogEvent(
      {required this.message,
      required this.information,
      required this.timestamp})
      : super._();

  factory _$_LogEvent.fromJson(Map<String, dynamic> json) =>
      _$$_LogEventFromJson(json);

  @override
  final String message;
  @override
  final Map<String, dynamic> information;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'LogEvent(message: $message, information: $information, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LogEvent &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.information, information) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message,
      const DeepCollectionEquality().hash(information), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LogEventCopyWith<_$_LogEvent> get copyWith =>
      __$$_LogEventCopyWithImpl<_$_LogEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LogEventToJson(
      this,
    );
  }
}

abstract class _LogEvent extends LogEvent {
  factory _LogEvent(
      {required final String message,
      required final Map<String, dynamic> information,
      required final DateTime timestamp}) = _$_LogEvent;
  _LogEvent._() : super._();

  factory _LogEvent.fromJson(Map<String, dynamic> json) = _$_LogEvent.fromJson;

  @override
  String get message;
  @override
  Map<String, dynamic> get information;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_LogEventCopyWith<_$_LogEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
