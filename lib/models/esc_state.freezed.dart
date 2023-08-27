// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'esc_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EscState _$EscStateFromJson(Map<String, dynamic> json) {
  return _EscState.fromJson(json);
}

/// @nodoc
mixin _$EscState {
  Map<int, EscNewRating> get ratings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EscStateCopyWith<EscState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EscStateCopyWith<$Res> {
  factory $EscStateCopyWith(EscState value, $Res Function(EscState) then) =
      _$EscStateCopyWithImpl<$Res, EscState>;
  @useResult
  $Res call({Map<int, EscNewRating> ratings});
}

/// @nodoc
class _$EscStateCopyWithImpl<$Res, $Val extends EscState>
    implements $EscStateCopyWith<$Res> {
  _$EscStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ratings = null,
  }) {
    return _then(_value.copyWith(
      ratings: null == ratings
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as Map<int, EscNewRating>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EscStateCopyWith<$Res> implements $EscStateCopyWith<$Res> {
  factory _$$_EscStateCopyWith(
          _$_EscState value, $Res Function(_$_EscState) then) =
      __$$_EscStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<int, EscNewRating> ratings});
}

/// @nodoc
class __$$_EscStateCopyWithImpl<$Res>
    extends _$EscStateCopyWithImpl<$Res, _$_EscState>
    implements _$$_EscStateCopyWith<$Res> {
  __$$_EscStateCopyWithImpl(
      _$_EscState _value, $Res Function(_$_EscState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ratings = null,
  }) {
    return _then(_$_EscState(
      ratings: null == ratings
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as Map<int, EscNewRating>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_EscState extends _EscState {
  _$_EscState({required this.ratings}) : super._();

  factory _$_EscState.fromJson(Map<String, dynamic> json) =>
      _$$_EscStateFromJson(json);

  @override
  final Map<int, EscNewRating> ratings;

  @override
  String toString() {
    return 'EscState(ratings: $ratings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EscState &&
            const DeepCollectionEquality().equals(other.ratings, ratings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(ratings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EscStateCopyWith<_$_EscState> get copyWith =>
      __$$_EscStateCopyWithImpl<_$_EscState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EscStateToJson(
      this,
    );
  }
}

abstract class _EscState extends EscState {
  factory _EscState({required final Map<int, EscNewRating> ratings}) =
      _$_EscState;
  _EscState._() : super._();

  factory _EscState.fromJson(Map<String, dynamic> json) = _$_EscState.fromJson;

  @override
  Map<int, EscNewRating> get ratings;
  @override
  @JsonKey(ignore: true)
  _$$_EscStateCopyWith<_$_EscState> get copyWith =>
      throw _privateConstructorUsedError;
}
