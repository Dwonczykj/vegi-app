// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_log_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppLogState _$AppLogStateFromJson(Map<String, dynamic> json) {
  return _AppLogState.fromJson(json);
}

/// @nodoc
mixin _$AppLogState {
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<LogEvent> get logs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppLogStateCopyWith<AppLogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppLogStateCopyWith<$Res> {
  factory $AppLogStateCopyWith(
          AppLogState value, $Res Function(AppLogState) then) =
      _$AppLogStateCopyWithImpl<$Res, AppLogState>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      List<LogEvent> logs});
}

/// @nodoc
class _$AppLogStateCopyWithImpl<$Res, $Val extends AppLogState>
    implements $AppLogStateCopyWith<$Res> {
  _$AppLogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logs = null,
  }) {
    return _then(_value.copyWith(
      logs: null == logs
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<LogEvent>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppLogStateCopyWith<$Res>
    implements $AppLogStateCopyWith<$Res> {
  factory _$$_AppLogStateCopyWith(
          _$_AppLogState value, $Res Function(_$_AppLogState) then) =
      __$$_AppLogStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      List<LogEvent> logs});
}

/// @nodoc
class __$$_AppLogStateCopyWithImpl<$Res>
    extends _$AppLogStateCopyWithImpl<$Res, _$_AppLogState>
    implements _$$_AppLogStateCopyWith<$Res> {
  __$$_AppLogStateCopyWithImpl(
      _$_AppLogState _value, $Res Function(_$_AppLogState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logs = null,
  }) {
    return _then(_$_AppLogState(
      logs: null == logs
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<LogEvent>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_AppLogState extends _AppLogState {
  _$_AppLogState(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      this.logs = const <LogEvent>[]})
      : super._();

  factory _$_AppLogState.fromJson(Map<String, dynamic> json) =>
      _$$_AppLogStateFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<LogEvent> logs;

  @override
  String toString() {
    return 'AppLogState(logs: $logs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppLogState &&
            const DeepCollectionEquality().equals(other.logs, logs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(logs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppLogStateCopyWith<_$_AppLogState> get copyWith =>
      __$$_AppLogStateCopyWithImpl<_$_AppLogState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppLogStateToJson(
      this,
    );
  }
}

abstract class _AppLogState extends AppLogState {
  factory _AppLogState(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      final List<LogEvent> logs}) = _$_AppLogState;
  _AppLogState._() : super._();

  factory _AppLogState.fromJson(Map<String, dynamic> json) =
      _$_AppLogState.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<LogEvent> get logs;
  @override
  @JsonKey(ignore: true)
  _$$_AppLogStateCopyWith<_$_AppLogState> get copyWith =>
      throw _privateConstructorUsedError;
}
