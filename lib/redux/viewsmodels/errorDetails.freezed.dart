// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'errorDetails.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ErrorDetails<T> _$ErrorDetailsFromJson<T extends Enum>(
    Map<String, dynamic> json) {
  return _ErrorDetails<T>.fromJson(json);
}

/// @nodoc
mixin _$ErrorDetails<T extends Enum> {
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(fromJson: codeFromJson, toJson: codeToJson)
  T? get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorDetailsCopyWith<T, ErrorDetails<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorDetailsCopyWith<T extends Enum, $Res> {
  factory $ErrorDetailsCopyWith(
          ErrorDetails<T> value, $Res Function(ErrorDetails<T>) then) =
      _$ErrorDetailsCopyWithImpl<T, $Res, ErrorDetails<T>>;
  @useResult
  $Res call(
      {String title,
      String message,
      @JsonKey(fromJson: codeFromJson, toJson: codeToJson) T? code});
}

/// @nodoc
class _$ErrorDetailsCopyWithImpl<T extends Enum, $Res,
    $Val extends ErrorDetails<T>> implements $ErrorDetailsCopyWith<T, $Res> {
  _$ErrorDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as T?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ErrorDetailsCopyWith<T extends Enum, $Res>
    implements $ErrorDetailsCopyWith<T, $Res> {
  factory _$$_ErrorDetailsCopyWith(
          _$_ErrorDetails<T> value, $Res Function(_$_ErrorDetails<T>) then) =
      __$$_ErrorDetailsCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String message,
      @JsonKey(fromJson: codeFromJson, toJson: codeToJson) T? code});
}

/// @nodoc
class __$$_ErrorDetailsCopyWithImpl<T extends Enum, $Res>
    extends _$ErrorDetailsCopyWithImpl<T, $Res, _$_ErrorDetails<T>>
    implements _$$_ErrorDetailsCopyWith<T, $Res> {
  __$$_ErrorDetailsCopyWithImpl(
      _$_ErrorDetails<T> _value, $Res Function(_$_ErrorDetails<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? code = freezed,
  }) {
    return _then(_$_ErrorDetails<T>(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_ErrorDetails<T extends Enum> extends _ErrorDetails<T> {
  _$_ErrorDetails(
      {required this.title,
      required this.message,
      @JsonKey(fromJson: codeFromJson, toJson: codeToJson) this.code})
      : super._();

  factory _$_ErrorDetails.fromJson(Map<String, dynamic> json) =>
      _$$_ErrorDetailsFromJson(json);

  @override
  final String title;
  @override
  final String message;
  @override
  @JsonKey(fromJson: codeFromJson, toJson: codeToJson)
  final T? code;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorDetailsCopyWith<T, _$_ErrorDetails<T>> get copyWith =>
      __$$_ErrorDetailsCopyWithImpl<T, _$_ErrorDetails<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ErrorDetailsToJson<T>(
      this,
    );
  }
}

abstract class _ErrorDetails<T extends Enum> extends ErrorDetails<T> {
  factory _ErrorDetails(
          {required final String title,
          required final String message,
          @JsonKey(fromJson: codeFromJson, toJson: codeToJson) final T? code}) =
      _$_ErrorDetails<T>;
  _ErrorDetails._() : super._();

  factory _ErrorDetails.fromJson(Map<String, dynamic> json) =
      _$_ErrorDetails<T>.fromJson;

  @override
  String get title;
  @override
  String get message;
  @override
  @JsonKey(fromJson: codeFromJson, toJson: codeToJson)
  T? get code;
  @override
  @JsonKey(ignore: true)
  _$$_ErrorDetailsCopyWith<T, _$_ErrorDetails<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
