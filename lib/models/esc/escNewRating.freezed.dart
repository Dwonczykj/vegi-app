// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'escNewRating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EscNewRating _$EscNewRatingFromJson(Map<String, dynamic> json) {
  return _EscNewRating.fromJson(json);
}

/// @nodoc
mixin _$EscNewRating {
  @JsonKey(fromJson: fromJsonESCExplanationList)
  List<ESCExplanation> get explanations => throw _privateConstructorUsedError;
  @JsonKey(fromJson: fromJsonESCRating)
  ESCRating? get rating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EscNewRatingCopyWith<EscNewRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EscNewRatingCopyWith<$Res> {
  factory $EscNewRatingCopyWith(
          EscNewRating value, $Res Function(EscNewRating) then) =
      _$EscNewRatingCopyWithImpl<$Res, EscNewRating>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: fromJsonESCExplanationList)
      List<ESCExplanation> explanations,
      @JsonKey(fromJson: fromJsonESCRating) ESCRating? rating});

  $ESCRatingCopyWith<$Res>? get rating;
}

/// @nodoc
class _$EscNewRatingCopyWithImpl<$Res, $Val extends EscNewRating>
    implements $EscNewRatingCopyWith<$Res> {
  _$EscNewRatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? explanations = null,
    Object? rating = freezed,
  }) {
    return _then(_value.copyWith(
      explanations: null == explanations
          ? _value.explanations
          : explanations // ignore: cast_nullable_to_non_nullable
              as List<ESCExplanation>,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as ESCRating?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ESCRatingCopyWith<$Res>? get rating {
    if (_value.rating == null) {
      return null;
    }

    return $ESCRatingCopyWith<$Res>(_value.rating!, (value) {
      return _then(_value.copyWith(rating: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EscNewRatingCopyWith<$Res>
    implements $EscNewRatingCopyWith<$Res> {
  factory _$$_EscNewRatingCopyWith(
          _$_EscNewRating value, $Res Function(_$_EscNewRating) then) =
      __$$_EscNewRatingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: fromJsonESCExplanationList)
      List<ESCExplanation> explanations,
      @JsonKey(fromJson: fromJsonESCRating) ESCRating? rating});

  @override
  $ESCRatingCopyWith<$Res>? get rating;
}

/// @nodoc
class __$$_EscNewRatingCopyWithImpl<$Res>
    extends _$EscNewRatingCopyWithImpl<$Res, _$_EscNewRating>
    implements _$$_EscNewRatingCopyWith<$Res> {
  __$$_EscNewRatingCopyWithImpl(
      _$_EscNewRating _value, $Res Function(_$_EscNewRating) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? explanations = null,
    Object? rating = freezed,
  }) {
    return _then(_$_EscNewRating(
      explanations: null == explanations
          ? _value.explanations
          : explanations // ignore: cast_nullable_to_non_nullable
              as List<ESCExplanation>,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as ESCRating?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_EscNewRating extends _EscNewRating {
  _$_EscNewRating(
      {@JsonKey(fromJson: fromJsonESCExplanationList)
      this.explanations = const [],
      @JsonKey(fromJson: fromJsonESCRating) this.rating})
      : super._();

  factory _$_EscNewRating.fromJson(Map<String, dynamic> json) =>
      _$$_EscNewRatingFromJson(json);

  @override
  @JsonKey(fromJson: fromJsonESCExplanationList)
  final List<ESCExplanation> explanations;
  @override
  @JsonKey(fromJson: fromJsonESCRating)
  final ESCRating? rating;

  @override
  String toString() {
    return 'EscNewRating(explanations: $explanations, rating: $rating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EscNewRating &&
            const DeepCollectionEquality()
                .equals(other.explanations, explanations) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(explanations), rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EscNewRatingCopyWith<_$_EscNewRating> get copyWith =>
      __$$_EscNewRatingCopyWithImpl<_$_EscNewRating>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EscNewRatingToJson(
      this,
    );
  }
}

abstract class _EscNewRating extends EscNewRating {
  factory _EscNewRating(
          {@JsonKey(fromJson: fromJsonESCExplanationList)
          final List<ESCExplanation> explanations,
          @JsonKey(fromJson: fromJsonESCRating) final ESCRating? rating}) =
      _$_EscNewRating;
  _EscNewRating._() : super._();

  factory _EscNewRating.fromJson(Map<String, dynamic> json) =
      _$_EscNewRating.fromJson;

  @override
  @JsonKey(fromJson: fromJsonESCExplanationList)
  List<ESCExplanation> get explanations;
  @override
  @JsonKey(fromJson: fromJsonESCRating)
  ESCRating? get rating;
  @override
  @JsonKey(ignore: true)
  _$$_EscNewRatingCopyWith<_$_EscNewRating> get copyWith =>
      throw _privateConstructorUsedError;
}
