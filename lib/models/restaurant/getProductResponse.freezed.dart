// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'getProductResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetProductResponse _$GetProductResponseFromJson(Map<String, dynamic> json) {
  return _GetProductResponse.fromJson(json);
}

/// @nodoc
mixin _$GetProductResponse {
  @JsonKey(fromJson: fromJsonProductDTO)
  ProductDTO? get product => throw _privateConstructorUsedError;
  @JsonKey(fromJson: fromJsonProductCategory)
  ProductCategory? get cateogory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetProductResponseCopyWith<GetProductResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetProductResponseCopyWith<$Res> {
  factory $GetProductResponseCopyWith(
          GetProductResponse value, $Res Function(GetProductResponse) then) =
      _$GetProductResponseCopyWithImpl<$Res, GetProductResponse>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: fromJsonProductDTO) ProductDTO? product,
      @JsonKey(fromJson: fromJsonProductCategory) ProductCategory? cateogory});

  $ProductDTOCopyWith<$Res>? get product;
  $ProductCategoryCopyWith<$Res>? get cateogory;
}

/// @nodoc
class _$GetProductResponseCopyWithImpl<$Res, $Val extends GetProductResponse>
    implements $GetProductResponseCopyWith<$Res> {
  _$GetProductResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
    Object? cateogory = freezed,
  }) {
    return _then(_value.copyWith(
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductDTO?,
      cateogory: freezed == cateogory
          ? _value.cateogory
          : cateogory // ignore: cast_nullable_to_non_nullable
              as ProductCategory?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductDTOCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductDTOCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductCategoryCopyWith<$Res>? get cateogory {
    if (_value.cateogory == null) {
      return null;
    }

    return $ProductCategoryCopyWith<$Res>(_value.cateogory!, (value) {
      return _then(_value.copyWith(cateogory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GetProductResponseCopyWith<$Res>
    implements $GetProductResponseCopyWith<$Res> {
  factory _$$_GetProductResponseCopyWith(_$_GetProductResponse value,
          $Res Function(_$_GetProductResponse) then) =
      __$$_GetProductResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: fromJsonProductDTO) ProductDTO? product,
      @JsonKey(fromJson: fromJsonProductCategory) ProductCategory? cateogory});

  @override
  $ProductDTOCopyWith<$Res>? get product;
  @override
  $ProductCategoryCopyWith<$Res>? get cateogory;
}

/// @nodoc
class __$$_GetProductResponseCopyWithImpl<$Res>
    extends _$GetProductResponseCopyWithImpl<$Res, _$_GetProductResponse>
    implements _$$_GetProductResponseCopyWith<$Res> {
  __$$_GetProductResponseCopyWithImpl(
      _$_GetProductResponse _value, $Res Function(_$_GetProductResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
    Object? cateogory = freezed,
  }) {
    return _then(_$_GetProductResponse(
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductDTO?,
      cateogory: freezed == cateogory
          ? _value.cateogory
          : cateogory // ignore: cast_nullable_to_non_nullable
              as ProductCategory?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_GetProductResponse extends _GetProductResponse {
  _$_GetProductResponse(
      {@JsonKey(fromJson: fromJsonProductDTO) required this.product,
      @JsonKey(fromJson: fromJsonProductCategory) required this.cateogory})
      : super._();

  factory _$_GetProductResponse.fromJson(Map<String, dynamic> json) =>
      _$$_GetProductResponseFromJson(json);

  @override
  @JsonKey(fromJson: fromJsonProductDTO)
  final ProductDTO? product;
  @override
  @JsonKey(fromJson: fromJsonProductCategory)
  final ProductCategory? cateogory;

  @override
  String toString() {
    return 'GetProductResponse(product: $product, cateogory: $cateogory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetProductResponse &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.cateogory, cateogory) ||
                other.cateogory == cateogory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, product, cateogory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetProductResponseCopyWith<_$_GetProductResponse> get copyWith =>
      __$$_GetProductResponseCopyWithImpl<_$_GetProductResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetProductResponseToJson(
      this,
    );
  }
}

abstract class _GetProductResponse extends GetProductResponse {
  factory _GetProductResponse(
      {@JsonKey(fromJson: fromJsonProductDTO)
      required final ProductDTO? product,
      @JsonKey(fromJson: fromJsonProductCategory)
      required final ProductCategory? cateogory}) = _$_GetProductResponse;
  _GetProductResponse._() : super._();

  factory _GetProductResponse.fromJson(Map<String, dynamic> json) =
      _$_GetProductResponse.fromJson;

  @override
  @JsonKey(fromJson: fromJsonProductDTO)
  ProductDTO? get product;
  @override
  @JsonKey(fromJson: fromJsonProductCategory)
  ProductCategory? get cateogory;
  @override
  @JsonKey(ignore: true)
  _$$_GetProductResponseCopyWith<_$_GetProductResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
