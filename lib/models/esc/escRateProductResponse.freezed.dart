// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'escRateProductResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EscRateProductResponse _$EscRateProductResponseFromJson(
    Map<String, dynamic> json) {
  return _EscRateProductResponse.fromJson(json);
}

/// @nodoc
mixin _$EscRateProductResponse {
  @JsonKey(fromJson: fromJsonProductCategory)
  ProductCategory? get category => throw _privateConstructorUsedError;
  @JsonKey(fromJson: fromJsonEscMostSimilarESCProduct)
  EscMostSimilarESCProduct? get most_similar_esc_product =>
      throw _privateConstructorUsedError;
  @JsonKey(fromJson: fromJsonEscNewRating)
  EscNewRating? get new_rating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EscRateProductResponseCopyWith<EscRateProductResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EscRateProductResponseCopyWith<$Res> {
  factory $EscRateProductResponseCopyWith(EscRateProductResponse value,
          $Res Function(EscRateProductResponse) then) =
      _$EscRateProductResponseCopyWithImpl<$Res, EscRateProductResponse>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: fromJsonProductCategory) ProductCategory? category,
      @JsonKey(fromJson: fromJsonEscMostSimilarESCProduct)
      EscMostSimilarESCProduct? most_similar_esc_product,
      @JsonKey(fromJson: fromJsonEscNewRating) EscNewRating? new_rating});

  $ProductCategoryCopyWith<$Res>? get category;
  $EscMostSimilarESCProductCopyWith<$Res>? get most_similar_esc_product;
  $EscNewRatingCopyWith<$Res>? get new_rating;
}

/// @nodoc
class _$EscRateProductResponseCopyWithImpl<$Res,
        $Val extends EscRateProductResponse>
    implements $EscRateProductResponseCopyWith<$Res> {
  _$EscRateProductResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? most_similar_esc_product = freezed,
    Object? new_rating = freezed,
  }) {
    return _then(_value.copyWith(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ProductCategory?,
      most_similar_esc_product: freezed == most_similar_esc_product
          ? _value.most_similar_esc_product
          : most_similar_esc_product // ignore: cast_nullable_to_non_nullable
              as EscMostSimilarESCProduct?,
      new_rating: freezed == new_rating
          ? _value.new_rating
          : new_rating // ignore: cast_nullable_to_non_nullable
              as EscNewRating?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductCategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $ProductCategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EscMostSimilarESCProductCopyWith<$Res>? get most_similar_esc_product {
    if (_value.most_similar_esc_product == null) {
      return null;
    }

    return $EscMostSimilarESCProductCopyWith<$Res>(
        _value.most_similar_esc_product!, (value) {
      return _then(_value.copyWith(most_similar_esc_product: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EscNewRatingCopyWith<$Res>? get new_rating {
    if (_value.new_rating == null) {
      return null;
    }

    return $EscNewRatingCopyWith<$Res>(_value.new_rating!, (value) {
      return _then(_value.copyWith(new_rating: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EscRateProductResponseCopyWith<$Res>
    implements $EscRateProductResponseCopyWith<$Res> {
  factory _$$_EscRateProductResponseCopyWith(_$_EscRateProductResponse value,
          $Res Function(_$_EscRateProductResponse) then) =
      __$$_EscRateProductResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: fromJsonProductCategory) ProductCategory? category,
      @JsonKey(fromJson: fromJsonEscMostSimilarESCProduct)
      EscMostSimilarESCProduct? most_similar_esc_product,
      @JsonKey(fromJson: fromJsonEscNewRating) EscNewRating? new_rating});

  @override
  $ProductCategoryCopyWith<$Res>? get category;
  @override
  $EscMostSimilarESCProductCopyWith<$Res>? get most_similar_esc_product;
  @override
  $EscNewRatingCopyWith<$Res>? get new_rating;
}

/// @nodoc
class __$$_EscRateProductResponseCopyWithImpl<$Res>
    extends _$EscRateProductResponseCopyWithImpl<$Res,
        _$_EscRateProductResponse>
    implements _$$_EscRateProductResponseCopyWith<$Res> {
  __$$_EscRateProductResponseCopyWithImpl(_$_EscRateProductResponse _value,
      $Res Function(_$_EscRateProductResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? most_similar_esc_product = freezed,
    Object? new_rating = freezed,
  }) {
    return _then(_$_EscRateProductResponse(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ProductCategory?,
      most_similar_esc_product: freezed == most_similar_esc_product
          ? _value.most_similar_esc_product
          : most_similar_esc_product // ignore: cast_nullable_to_non_nullable
              as EscMostSimilarESCProduct?,
      new_rating: freezed == new_rating
          ? _value.new_rating
          : new_rating // ignore: cast_nullable_to_non_nullable
              as EscNewRating?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_EscRateProductResponse extends _EscRateProductResponse {
  _$_EscRateProductResponse(
      {@JsonKey(fromJson: fromJsonProductCategory) this.category,
      @JsonKey(fromJson: fromJsonEscMostSimilarESCProduct)
      this.most_similar_esc_product,
      @JsonKey(fromJson: fromJsonEscNewRating) this.new_rating})
      : super._();

  factory _$_EscRateProductResponse.fromJson(Map<String, dynamic> json) =>
      _$$_EscRateProductResponseFromJson(json);

  @override
  @JsonKey(fromJson: fromJsonProductCategory)
  final ProductCategory? category;
  @override
  @JsonKey(fromJson: fromJsonEscMostSimilarESCProduct)
  final EscMostSimilarESCProduct? most_similar_esc_product;
  @override
  @JsonKey(fromJson: fromJsonEscNewRating)
  final EscNewRating? new_rating;

  @override
  String toString() {
    return 'EscRateProductResponse(category: $category, most_similar_esc_product: $most_similar_esc_product, new_rating: $new_rating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EscRateProductResponse &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(
                    other.most_similar_esc_product, most_similar_esc_product) ||
                other.most_similar_esc_product == most_similar_esc_product) &&
            (identical(other.new_rating, new_rating) ||
                other.new_rating == new_rating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, category, most_similar_esc_product, new_rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EscRateProductResponseCopyWith<_$_EscRateProductResponse> get copyWith =>
      __$$_EscRateProductResponseCopyWithImpl<_$_EscRateProductResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EscRateProductResponseToJson(
      this,
    );
  }
}

abstract class _EscRateProductResponse extends EscRateProductResponse {
  factory _EscRateProductResponse(
      {@JsonKey(fromJson: fromJsonProductCategory)
      final ProductCategory? category,
      @JsonKey(fromJson: fromJsonEscMostSimilarESCProduct)
      final EscMostSimilarESCProduct? most_similar_esc_product,
      @JsonKey(fromJson: fromJsonEscNewRating)
      final EscNewRating? new_rating}) = _$_EscRateProductResponse;
  _EscRateProductResponse._() : super._();

  factory _EscRateProductResponse.fromJson(Map<String, dynamic> json) =
      _$_EscRateProductResponse.fromJson;

  @override
  @JsonKey(fromJson: fromJsonProductCategory)
  ProductCategory? get category;
  @override
  @JsonKey(fromJson: fromJsonEscMostSimilarESCProduct)
  EscMostSimilarESCProduct? get most_similar_esc_product;
  @override
  @JsonKey(fromJson: fromJsonEscNewRating)
  EscNewRating? get new_rating;
  @override
  @JsonKey(ignore: true)
  _$$_EscRateProductResponseCopyWith<_$_EscRateProductResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
