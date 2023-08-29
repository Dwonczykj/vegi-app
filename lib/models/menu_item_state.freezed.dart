// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'menu_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MenuItemState _$MenuItemStateFromJson(Map<String, dynamic> json) {
  return _MenuItemState.fromJson(json);
}

/// @nodoc
mixin _$MenuItemState {
  @JsonKey(includeFromJson: false, includeToJson: false)
  RestaurantMenuItem? get menuItem => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Money get totalPrice => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  num get itemReward => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<int, ProductOptionValue> get selectedProductOptionsForCategory =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<int, GetProductResponse> get productsPurchased =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get loadingProductOptions => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MenuItemStateCopyWith<MenuItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemStateCopyWith<$Res> {
  factory $MenuItemStateCopyWith(
          MenuItemState value, $Res Function(MenuItemState) then) =
      _$MenuItemStateCopyWithImpl<$Res, MenuItemState>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      RestaurantMenuItem? menuItem,
      @JsonKey(includeFromJson: false, includeToJson: false) Money totalPrice,
      @JsonKey(includeFromJson: false, includeToJson: false) num itemReward,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<int, ProductOptionValue> selectedProductOptionsForCategory,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<int, GetProductResponse> productsPurchased,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool loadingProductOptions,
      @JsonKey(includeFromJson: false, includeToJson: false) int quantity});

  $RestaurantMenuItemCopyWith<$Res>? get menuItem;
}

/// @nodoc
class _$MenuItemStateCopyWithImpl<$Res, $Val extends MenuItemState>
    implements $MenuItemStateCopyWith<$Res> {
  _$MenuItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItem = freezed,
    Object? totalPrice = null,
    Object? itemReward = null,
    Object? selectedProductOptionsForCategory = null,
    Object? productsPurchased = null,
    Object? loadingProductOptions = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      menuItem: freezed == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as RestaurantMenuItem?,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as Money,
      itemReward: null == itemReward
          ? _value.itemReward
          : itemReward // ignore: cast_nullable_to_non_nullable
              as num,
      selectedProductOptionsForCategory: null ==
              selectedProductOptionsForCategory
          ? _value.selectedProductOptionsForCategory
          : selectedProductOptionsForCategory // ignore: cast_nullable_to_non_nullable
              as Map<int, ProductOptionValue>,
      productsPurchased: null == productsPurchased
          ? _value.productsPurchased
          : productsPurchased // ignore: cast_nullable_to_non_nullable
              as Map<int, GetProductResponse>,
      loadingProductOptions: null == loadingProductOptions
          ? _value.loadingProductOptions
          : loadingProductOptions // ignore: cast_nullable_to_non_nullable
              as bool,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RestaurantMenuItemCopyWith<$Res>? get menuItem {
    if (_value.menuItem == null) {
      return null;
    }

    return $RestaurantMenuItemCopyWith<$Res>(_value.menuItem!, (value) {
      return _then(_value.copyWith(menuItem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MenuItemStateCopyWith<$Res>
    implements $MenuItemStateCopyWith<$Res> {
  factory _$$_MenuItemStateCopyWith(
          _$_MenuItemState value, $Res Function(_$_MenuItemState) then) =
      __$$_MenuItemStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      RestaurantMenuItem? menuItem,
      @JsonKey(includeFromJson: false, includeToJson: false) Money totalPrice,
      @JsonKey(includeFromJson: false, includeToJson: false) num itemReward,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<int, ProductOptionValue> selectedProductOptionsForCategory,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<int, GetProductResponse> productsPurchased,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool loadingProductOptions,
      @JsonKey(includeFromJson: false, includeToJson: false) int quantity});

  @override
  $RestaurantMenuItemCopyWith<$Res>? get menuItem;
}

/// @nodoc
class __$$_MenuItemStateCopyWithImpl<$Res>
    extends _$MenuItemStateCopyWithImpl<$Res, _$_MenuItemState>
    implements _$$_MenuItemStateCopyWith<$Res> {
  __$$_MenuItemStateCopyWithImpl(
      _$_MenuItemState _value, $Res Function(_$_MenuItemState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItem = freezed,
    Object? totalPrice = null,
    Object? itemReward = null,
    Object? selectedProductOptionsForCategory = null,
    Object? productsPurchased = null,
    Object? loadingProductOptions = null,
    Object? quantity = null,
  }) {
    return _then(_$_MenuItemState(
      menuItem: freezed == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as RestaurantMenuItem?,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as Money,
      itemReward: null == itemReward
          ? _value.itemReward
          : itemReward // ignore: cast_nullable_to_non_nullable
              as num,
      selectedProductOptionsForCategory: null ==
              selectedProductOptionsForCategory
          ? _value.selectedProductOptionsForCategory
          : selectedProductOptionsForCategory // ignore: cast_nullable_to_non_nullable
              as Map<int, ProductOptionValue>,
      productsPurchased: null == productsPurchased
          ? _value.productsPurchased
          : productsPurchased // ignore: cast_nullable_to_non_nullable
              as Map<int, GetProductResponse>,
      loadingProductOptions: null == loadingProductOptions
          ? _value.loadingProductOptions
          : loadingProductOptions // ignore: cast_nullable_to_non_nullable
              as bool,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_MenuItemState extends _MenuItemState {
  _$_MenuItemState(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      this.menuItem = null,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.totalPrice = const Money.zeroGBPx(),
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.itemReward = 0,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.selectedProductOptionsForCategory = const {},
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.productsPurchased = const {},
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.loadingProductOptions = false,
      @JsonKey(includeFromJson: false, includeToJson: false) this.quantity = 0})
      : super._();

  factory _$_MenuItemState.fromJson(Map<String, dynamic> json) =>
      _$$_MenuItemStateFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final RestaurantMenuItem? menuItem;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Money totalPrice;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final num itemReward;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<int, ProductOptionValue> selectedProductOptionsForCategory;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<int, GetProductResponse> productsPurchased;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool loadingProductOptions;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int quantity;

  @override
  String toString() {
    return 'MenuItemState(menuItem: $menuItem, totalPrice: $totalPrice, itemReward: $itemReward, selectedProductOptionsForCategory: $selectedProductOptionsForCategory, productsPurchased: $productsPurchased, loadingProductOptions: $loadingProductOptions, quantity: $quantity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MenuItemState &&
            (identical(other.menuItem, menuItem) ||
                other.menuItem == menuItem) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.itemReward, itemReward) ||
                other.itemReward == itemReward) &&
            const DeepCollectionEquality().equals(
                other.selectedProductOptionsForCategory,
                selectedProductOptionsForCategory) &&
            const DeepCollectionEquality()
                .equals(other.productsPurchased, productsPurchased) &&
            (identical(other.loadingProductOptions, loadingProductOptions) ||
                other.loadingProductOptions == loadingProductOptions) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      menuItem,
      totalPrice,
      itemReward,
      const DeepCollectionEquality().hash(selectedProductOptionsForCategory),
      const DeepCollectionEquality().hash(productsPurchased),
      loadingProductOptions,
      quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MenuItemStateCopyWith<_$_MenuItemState> get copyWith =>
      __$$_MenuItemStateCopyWithImpl<_$_MenuItemState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MenuItemStateToJson(
      this,
    );
  }
}

abstract class _MenuItemState extends MenuItemState {
  factory _MenuItemState(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      final RestaurantMenuItem? menuItem,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Money totalPrice,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final num itemReward,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Map<int, ProductOptionValue> selectedProductOptionsForCategory,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Map<int, GetProductResponse> productsPurchased,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool loadingProductOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final int quantity}) = _$_MenuItemState;
  _MenuItemState._() : super._();

  factory _MenuItemState.fromJson(Map<String, dynamic> json) =
      _$_MenuItemState.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  RestaurantMenuItem? get menuItem;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Money get totalPrice;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  num get itemReward;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<int, ProductOptionValue> get selectedProductOptionsForCategory;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<int, GetProductResponse> get productsPurchased;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get loadingProductOptions;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$_MenuItemStateCopyWith<_$_MenuItemState> get copyWith =>
      throw _privateConstructorUsedError;
}
