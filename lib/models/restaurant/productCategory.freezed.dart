// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'productCategory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) {
  return _ProductCategory.fromJson(json);
}

/// @nodoc
mixin _$ProductCategory {
  int? get categoryGroup => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(fromJson: fromJsonVendorDTO)
  VendorDTO? get vendor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCategoryCopyWith<ProductCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCategoryCopyWith<$Res> {
  factory $ProductCategoryCopyWith(
          ProductCategory value, $Res Function(ProductCategory) then) =
      _$ProductCategoryCopyWithImpl<$Res, ProductCategory>;
  @useResult
  $Res call(
      {int? categoryGroup,
      int? id,
      String imageUrl,
      String name,
      @JsonKey(fromJson: fromJsonVendorDTO) VendorDTO? vendor});

  $VendorDTOCopyWith<$Res>? get vendor;
}

/// @nodoc
class _$ProductCategoryCopyWithImpl<$Res, $Val extends ProductCategory>
    implements $ProductCategoryCopyWith<$Res> {
  _$ProductCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryGroup = freezed,
    Object? id = freezed,
    Object? imageUrl = null,
    Object? name = null,
    Object? vendor = freezed,
  }) {
    return _then(_value.copyWith(
      categoryGroup: freezed == categoryGroup
          ? _value.categoryGroup
          : categoryGroup // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      vendor: freezed == vendor
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as VendorDTO?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VendorDTOCopyWith<$Res>? get vendor {
    if (_value.vendor == null) {
      return null;
    }

    return $VendorDTOCopyWith<$Res>(_value.vendor!, (value) {
      return _then(_value.copyWith(vendor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProductCategoryCopyWith<$Res>
    implements $ProductCategoryCopyWith<$Res> {
  factory _$$_ProductCategoryCopyWith(
          _$_ProductCategory value, $Res Function(_$_ProductCategory) then) =
      __$$_ProductCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? categoryGroup,
      int? id,
      String imageUrl,
      String name,
      @JsonKey(fromJson: fromJsonVendorDTO) VendorDTO? vendor});

  @override
  $VendorDTOCopyWith<$Res>? get vendor;
}

/// @nodoc
class __$$_ProductCategoryCopyWithImpl<$Res>
    extends _$ProductCategoryCopyWithImpl<$Res, _$_ProductCategory>
    implements _$$_ProductCategoryCopyWith<$Res> {
  __$$_ProductCategoryCopyWithImpl(
      _$_ProductCategory _value, $Res Function(_$_ProductCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryGroup = freezed,
    Object? id = freezed,
    Object? imageUrl = null,
    Object? name = null,
    Object? vendor = freezed,
  }) {
    return _then(_$_ProductCategory(
      categoryGroup: freezed == categoryGroup
          ? _value.categoryGroup
          : categoryGroup // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      vendor: freezed == vendor
          ? _value.vendor
          : vendor // ignore: cast_nullable_to_non_nullable
              as VendorDTO?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_ProductCategory extends _ProductCategory {
  _$_ProductCategory(
      {this.categoryGroup,
      this.id,
      this.imageUrl = '',
      required this.name,
      @JsonKey(fromJson: fromJsonVendorDTO) this.vendor})
      : super._();

  factory _$_ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$$_ProductCategoryFromJson(json);

  @override
  final int? categoryGroup;
  @override
  final int? id;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  final String name;
  @override
  @JsonKey(fromJson: fromJsonVendorDTO)
  final VendorDTO? vendor;

  @override
  String toString() {
    return 'ProductCategory(categoryGroup: $categoryGroup, id: $id, imageUrl: $imageUrl, name: $name, vendor: $vendor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductCategory &&
            (identical(other.categoryGroup, categoryGroup) ||
                other.categoryGroup == categoryGroup) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.vendor, vendor) || other.vendor == vendor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, categoryGroup, id, imageUrl, name, vendor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductCategoryCopyWith<_$_ProductCategory> get copyWith =>
      __$$_ProductCategoryCopyWithImpl<_$_ProductCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductCategoryToJson(
      this,
    );
  }
}

abstract class _ProductCategory extends ProductCategory {
  factory _ProductCategory(
          {final int? categoryGroup,
          final int? id,
          final String imageUrl,
          required final String name,
          @JsonKey(fromJson: fromJsonVendorDTO) final VendorDTO? vendor}) =
      _$_ProductCategory;
  _ProductCategory._() : super._();

  factory _ProductCategory.fromJson(Map<String, dynamic> json) =
      _$_ProductCategory.fromJson;

  @override
  int? get categoryGroup;
  @override
  int? get id;
  @override
  String get imageUrl;
  @override
  String get name;
  @override
  @JsonKey(fromJson: fromJsonVendorDTO)
  VendorDTO? get vendor;
  @override
  @JsonKey(ignore: true)
  _$$_ProductCategoryCopyWith<_$_ProductCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
