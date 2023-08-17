// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_env_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppEnvState _$AppEnvStateFromJson(Map<String, dynamic> json) {
  return _AppEnvState.fromJson(json);
}

/// @nodoc
mixin _$AppEnvState {
  String get env => throw _privateConstructorUsedError;
  String get appMajorVersion => throw _privateConstructorUsedError;
  String get appMinorVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppEnvStateCopyWith<AppEnvState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppEnvStateCopyWith<$Res> {
  factory $AppEnvStateCopyWith(
          AppEnvState value, $Res Function(AppEnvState) then) =
      _$AppEnvStateCopyWithImpl<$Res, AppEnvState>;
  @useResult
  $Res call({String env, String appMajorVersion, String appMinorVersion});
}

/// @nodoc
class _$AppEnvStateCopyWithImpl<$Res, $Val extends AppEnvState>
    implements $AppEnvStateCopyWith<$Res> {
  _$AppEnvStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? env = null,
    Object? appMajorVersion = null,
    Object? appMinorVersion = null,
  }) {
    return _then(_value.copyWith(
      env: null == env
          ? _value.env
          : env // ignore: cast_nullable_to_non_nullable
              as String,
      appMajorVersion: null == appMajorVersion
          ? _value.appMajorVersion
          : appMajorVersion // ignore: cast_nullable_to_non_nullable
              as String,
      appMinorVersion: null == appMinorVersion
          ? _value.appMinorVersion
          : appMinorVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppEnvStateCopyWith<$Res>
    implements $AppEnvStateCopyWith<$Res> {
  factory _$$_AppEnvStateCopyWith(
          _$_AppEnvState value, $Res Function(_$_AppEnvState) then) =
      __$$_AppEnvStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String env, String appMajorVersion, String appMinorVersion});
}

/// @nodoc
class __$$_AppEnvStateCopyWithImpl<$Res>
    extends _$AppEnvStateCopyWithImpl<$Res, _$_AppEnvState>
    implements _$$_AppEnvStateCopyWith<$Res> {
  __$$_AppEnvStateCopyWithImpl(
      _$_AppEnvState _value, $Res Function(_$_AppEnvState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? env = null,
    Object? appMajorVersion = null,
    Object? appMinorVersion = null,
  }) {
    return _then(_$_AppEnvState(
      env: null == env
          ? _value.env
          : env // ignore: cast_nullable_to_non_nullable
              as String,
      appMajorVersion: null == appMajorVersion
          ? _value.appMajorVersion
          : appMajorVersion // ignore: cast_nullable_to_non_nullable
              as String,
      appMinorVersion: null == appMinorVersion
          ? _value.appMinorVersion
          : appMinorVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_AppEnvState extends _AppEnvState {
  _$_AppEnvState(
      {required this.env,
      required this.appMajorVersion,
      required this.appMinorVersion})
      : super._();

  factory _$_AppEnvState.fromJson(Map<String, dynamic> json) =>
      _$$_AppEnvStateFromJson(json);

  @override
  final String env;
  @override
  final String appMajorVersion;
  @override
  final String appMinorVersion;

  @override
  String toString() {
    return 'AppEnvState(env: $env, appMajorVersion: $appMajorVersion, appMinorVersion: $appMinorVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppEnvState &&
            (identical(other.env, env) || other.env == env) &&
            (identical(other.appMajorVersion, appMajorVersion) ||
                other.appMajorVersion == appMajorVersion) &&
            (identical(other.appMinorVersion, appMinorVersion) ||
                other.appMinorVersion == appMinorVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, env, appMajorVersion, appMinorVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppEnvStateCopyWith<_$_AppEnvState> get copyWith =>
      __$$_AppEnvStateCopyWithImpl<_$_AppEnvState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppEnvStateToJson(
      this,
    );
  }
}

abstract class _AppEnvState extends AppEnvState {
  factory _AppEnvState(
      {required final String env,
      required final String appMajorVersion,
      required final String appMinorVersion}) = _$_AppEnvState;
  _AppEnvState._() : super._();

  factory _AppEnvState.fromJson(Map<String, dynamic> json) =
      _$_AppEnvState.fromJson;

  @override
  String get env;
  @override
  String get appMajorVersion;
  @override
  String get appMinorVersion;
  @override
  @JsonKey(ignore: true)
  _$$_AppEnvStateCopyWith<_$_AppEnvState> get copyWith =>
      throw _privateConstructorUsedError;
}
