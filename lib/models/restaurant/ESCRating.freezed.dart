// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ESCRating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ESCRating _$ESCRatingFromJson(Map<String, dynamic> json) {
  return _ESCRating.fromJson(json);
}

/// @nodoc
mixin _$ESCRating {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: jsonToTimeStampNullable,
      toJson: timeStampToJsonStringNullable,
      name: 'calculated_on')
  DateTime? get calculatedOn =>
      throw _privateConstructorUsedError; // required double createdAt,
// required Product product,
  int get product =>
      throw _privateConstructorUsedError; // required String productPublicId,
  String get product_id => throw _privateConstructorUsedError;
  String get product_name => throw _privateConstructorUsedError;
  num get rating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ESCRatingCopyWith<ESCRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ESCRatingCopyWith<$Res> {
  factory $ESCRatingCopyWith(ESCRating value, $Res Function(ESCRating) then) =
      _$ESCRatingCopyWithImpl<$Res, ESCRating>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(
          fromJson: jsonToTimeStampNullable,
          toJson: timeStampToJsonStringNullable,
          name: 'calculated_on')
      DateTime? calculatedOn,
      int product,
      String product_id,
      String product_name,
      num rating});
}

/// @nodoc
class _$ESCRatingCopyWithImpl<$Res, $Val extends ESCRating>
    implements $ESCRatingCopyWith<$Res> {
  _$ESCRatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? calculatedOn = freezed,
    Object? product = null,
    Object? product_id = null,
    Object? product_name = null,
    Object? rating = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      calculatedOn: freezed == calculatedOn
          ? _value.calculatedOn
          : calculatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as int,
      product_id: null == product_id
          ? _value.product_id
          : product_id // ignore: cast_nullable_to_non_nullable
              as String,
      product_name: null == product_name
          ? _value.product_name
          : product_name // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ESCRatingCopyWith<$Res> implements $ESCRatingCopyWith<$Res> {
  factory _$$_ESCRatingCopyWith(
          _$_ESCRating value, $Res Function(_$_ESCRating) then) =
      __$$_ESCRatingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(
          fromJson: jsonToTimeStampNullable,
          toJson: timeStampToJsonStringNullable,
          name: 'calculated_on')
      DateTime? calculatedOn,
      int product,
      String product_id,
      String product_name,
      num rating});
}

/// @nodoc
class __$$_ESCRatingCopyWithImpl<$Res>
    extends _$ESCRatingCopyWithImpl<$Res, _$_ESCRating>
    implements _$$_ESCRatingCopyWith<$Res> {
  __$$_ESCRatingCopyWithImpl(
      _$_ESCRating _value, $Res Function(_$_ESCRating) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? calculatedOn = freezed,
    Object? product = null,
    Object? product_id = null,
    Object? product_name = null,
    Object? rating = null,
  }) {
    return _then(_$_ESCRating(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      calculatedOn: freezed == calculatedOn
          ? _value.calculatedOn
          : calculatedOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as int,
      product_id: null == product_id
          ? _value.product_id
          : product_id // ignore: cast_nullable_to_non_nullable
              as String,
      product_name: null == product_name
          ? _value.product_name
          : product_name // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_ESCRating extends _ESCRating {
  _$_ESCRating(
      {required this.id,
      @JsonKey(
          fromJson: jsonToTimeStampNullable,
          toJson: timeStampToJsonStringNullable,
          name: 'calculated_on')
      required this.calculatedOn,
      required this.product,
      required this.product_id,
      required this.product_name,
      required this.rating})
      : super._();

  factory _$_ESCRating.fromJson(Map<String, dynamic> json) =>
      _$$_ESCRatingFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(
      fromJson: jsonToTimeStampNullable,
      toJson: timeStampToJsonStringNullable,
      name: 'calculated_on')
  final DateTime? calculatedOn;
// required double createdAt,
// required Product product,
  @override
  final int product;
// required String productPublicId,
  @override
  final String product_id;
  @override
  final String product_name;
  @override
  final num rating;

  @override
  String toString() {
    return 'ESCRating(id: $id, calculatedOn: $calculatedOn, product: $product, product_id: $product_id, product_name: $product_name, rating: $rating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ESCRating &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.calculatedOn, calculatedOn) ||
                other.calculatedOn == calculatedOn) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.product_id, product_id) ||
                other.product_id == product_id) &&
            (identical(other.product_name, product_name) ||
                other.product_name == product_name) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, calculatedOn, product, product_id, product_name, rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ESCRatingCopyWith<_$_ESCRating> get copyWith =>
      __$$_ESCRatingCopyWithImpl<_$_ESCRating>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ESCRatingToJson(
      this,
    );
  }
}

abstract class _ESCRating extends ESCRating {
  factory _ESCRating(
      {required final int id,
      @JsonKey(
          fromJson: jsonToTimeStampNullable,
          toJson: timeStampToJsonStringNullable,
          name: 'calculated_on')
      required final DateTime? calculatedOn,
      required final int product,
      required final String product_id,
      required final String product_name,
      required final num rating}) = _$_ESCRating;
  _ESCRating._() : super._();

  factory _ESCRating.fromJson(Map<String, dynamic> json) =
      _$_ESCRating.fromJson;

  @override
  int get id;
  @override
  @JsonKey(
      fromJson: jsonToTimeStampNullable,
      toJson: timeStampToJsonStringNullable,
      name: 'calculated_on')
  DateTime? get calculatedOn;
  @override // required double createdAt,
// required Product product,
  int get product;
  @override // required String productPublicId,
  String get product_id;
  @override
  String get product_name;
  @override
  num get rating;
  @override
  @JsonKey(ignore: true)
  _$$_ESCRatingCopyWith<_$_ESCRating> get copyWith =>
      throw _privateConstructorUsedError;
}
