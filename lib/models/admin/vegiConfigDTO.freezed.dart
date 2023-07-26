// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'vegiConfigDTO.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VegiConfigDTO _$VegiConfigDTOFromJson(Map<String, dynamic> json) {
  return _VegiConfigDTO.fromJson(json);
}

/// @nodoc
mixin _$VegiConfigDTO {
  String get databaseUrl => throw _privateConstructorUsedError;
  String get databaseSailsAdapter => throw _privateConstructorUsedError;
  String get webserverHostName => throw _privateConstructorUsedError;
  String get environment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VegiConfigDTOCopyWith<VegiConfigDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VegiConfigDTOCopyWith<$Res> {
  factory $VegiConfigDTOCopyWith(
          VegiConfigDTO value, $Res Function(VegiConfigDTO) then) =
      _$VegiConfigDTOCopyWithImpl<$Res, VegiConfigDTO>;
  @useResult
  $Res call(
      {String databaseUrl,
      String databaseSailsAdapter,
      String webserverHostName,
      String environment});
}

/// @nodoc
class _$VegiConfigDTOCopyWithImpl<$Res, $Val extends VegiConfigDTO>
    implements $VegiConfigDTOCopyWith<$Res> {
  _$VegiConfigDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? databaseUrl = null,
    Object? databaseSailsAdapter = null,
    Object? webserverHostName = null,
    Object? environment = null,
  }) {
    return _then(_value.copyWith(
      databaseUrl: null == databaseUrl
          ? _value.databaseUrl
          : databaseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      databaseSailsAdapter: null == databaseSailsAdapter
          ? _value.databaseSailsAdapter
          : databaseSailsAdapter // ignore: cast_nullable_to_non_nullable
              as String,
      webserverHostName: null == webserverHostName
          ? _value.webserverHostName
          : webserverHostName // ignore: cast_nullable_to_non_nullable
              as String,
      environment: null == environment
          ? _value.environment
          : environment // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VegiConfigDTOCopyWith<$Res>
    implements $VegiConfigDTOCopyWith<$Res> {
  factory _$$_VegiConfigDTOCopyWith(
          _$_VegiConfigDTO value, $Res Function(_$_VegiConfigDTO) then) =
      __$$_VegiConfigDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String databaseUrl,
      String databaseSailsAdapter,
      String webserverHostName,
      String environment});
}

/// @nodoc
class __$$_VegiConfigDTOCopyWithImpl<$Res>
    extends _$VegiConfigDTOCopyWithImpl<$Res, _$_VegiConfigDTO>
    implements _$$_VegiConfigDTOCopyWith<$Res> {
  __$$_VegiConfigDTOCopyWithImpl(
      _$_VegiConfigDTO _value, $Res Function(_$_VegiConfigDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? databaseUrl = null,
    Object? databaseSailsAdapter = null,
    Object? webserverHostName = null,
    Object? environment = null,
  }) {
    return _then(_$_VegiConfigDTO(
      databaseUrl: null == databaseUrl
          ? _value.databaseUrl
          : databaseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      databaseSailsAdapter: null == databaseSailsAdapter
          ? _value.databaseSailsAdapter
          : databaseSailsAdapter // ignore: cast_nullable_to_non_nullable
              as String,
      webserverHostName: null == webserverHostName
          ? _value.webserverHostName
          : webserverHostName // ignore: cast_nullable_to_non_nullable
              as String,
      environment: null == environment
          ? _value.environment
          : environment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_VegiConfigDTO extends _VegiConfigDTO {
  _$_VegiConfigDTO(
      {required this.databaseUrl,
      required this.databaseSailsAdapter,
      required this.webserverHostName,
      required this.environment})
      : super._();

  factory _$_VegiConfigDTO.fromJson(Map<String, dynamic> json) =>
      _$$_VegiConfigDTOFromJson(json);

  @override
  final String databaseUrl;
  @override
  final String databaseSailsAdapter;
  @override
  final String webserverHostName;
  @override
  final String environment;

  @override
  String toString() {
    return 'VegiConfigDTO(databaseUrl: $databaseUrl, databaseSailsAdapter: $databaseSailsAdapter, webserverHostName: $webserverHostName, environment: $environment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VegiConfigDTO &&
            (identical(other.databaseUrl, databaseUrl) ||
                other.databaseUrl == databaseUrl) &&
            (identical(other.databaseSailsAdapter, databaseSailsAdapter) ||
                other.databaseSailsAdapter == databaseSailsAdapter) &&
            (identical(other.webserverHostName, webserverHostName) ||
                other.webserverHostName == webserverHostName) &&
            (identical(other.environment, environment) ||
                other.environment == environment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, databaseUrl,
      databaseSailsAdapter, webserverHostName, environment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VegiConfigDTOCopyWith<_$_VegiConfigDTO> get copyWith =>
      __$$_VegiConfigDTOCopyWithImpl<_$_VegiConfigDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VegiConfigDTOToJson(
      this,
    );
  }
}

abstract class _VegiConfigDTO extends VegiConfigDTO {
  factory _VegiConfigDTO(
      {required final String databaseUrl,
      required final String databaseSailsAdapter,
      required final String webserverHostName,
      required final String environment}) = _$_VegiConfigDTO;
  _VegiConfigDTO._() : super._();

  factory _VegiConfigDTO.fromJson(Map<String, dynamic> json) =
      _$_VegiConfigDTO.fromJson;

  @override
  String get databaseUrl;
  @override
  String get databaseSailsAdapter;
  @override
  String get webserverHostName;
  @override
  String get environment;
  @override
  @JsonKey(ignore: true)
  _$$_VegiConfigDTOCopyWith<_$_VegiConfigDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
