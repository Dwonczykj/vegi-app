// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'acceptVoucherResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AcceptVoucherResponse _$AcceptVoucherResponseFromJson(
    Map<String, dynamic> json) {
  return _AcceptVoucherResponse.fromJson(json);
}

/// @nodoc
mixin _$AcceptVoucherResponse {
  /// 'accepted' | 'rejected' | 'already_accepted'
  DiscountCodeAcceptanceStatus get codeAcceptanceStatus =>
      throw _privateConstructorUsedError;
  @JsonKey()
  Discount? get discount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AcceptVoucherResponseCopyWith<AcceptVoucherResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcceptVoucherResponseCopyWith<$Res> {
  factory $AcceptVoucherResponseCopyWith(AcceptVoucherResponse value,
          $Res Function(AcceptVoucherResponse) then) =
      _$AcceptVoucherResponseCopyWithImpl<$Res, AcceptVoucherResponse>;
  @useResult
  $Res call(
      {DiscountCodeAcceptanceStatus codeAcceptanceStatus,
      @JsonKey() Discount? discount});

  $DiscountCopyWith<$Res>? get discount;
}

/// @nodoc
class _$AcceptVoucherResponseCopyWithImpl<$Res,
        $Val extends AcceptVoucherResponse>
    implements $AcceptVoucherResponseCopyWith<$Res> {
  _$AcceptVoucherResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeAcceptanceStatus = null,
    Object? discount = freezed,
  }) {
    return _then(_value.copyWith(
      codeAcceptanceStatus: null == codeAcceptanceStatus
          ? _value.codeAcceptanceStatus
          : codeAcceptanceStatus // ignore: cast_nullable_to_non_nullable
              as DiscountCodeAcceptanceStatus,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as Discount?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DiscountCopyWith<$Res>? get discount {
    if (_value.discount == null) {
      return null;
    }

    return $DiscountCopyWith<$Res>(_value.discount!, (value) {
      return _then(_value.copyWith(discount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AcceptVoucherResponseCopyWith<$Res>
    implements $AcceptVoucherResponseCopyWith<$Res> {
  factory _$$_AcceptVoucherResponseCopyWith(_$_AcceptVoucherResponse value,
          $Res Function(_$_AcceptVoucherResponse) then) =
      __$$_AcceptVoucherResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DiscountCodeAcceptanceStatus codeAcceptanceStatus,
      @JsonKey() Discount? discount});

  @override
  $DiscountCopyWith<$Res>? get discount;
}

/// @nodoc
class __$$_AcceptVoucherResponseCopyWithImpl<$Res>
    extends _$AcceptVoucherResponseCopyWithImpl<$Res, _$_AcceptVoucherResponse>
    implements _$$_AcceptVoucherResponseCopyWith<$Res> {
  __$$_AcceptVoucherResponseCopyWithImpl(_$_AcceptVoucherResponse _value,
      $Res Function(_$_AcceptVoucherResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeAcceptanceStatus = null,
    Object? discount = freezed,
  }) {
    return _then(_$_AcceptVoucherResponse(
      codeAcceptanceStatus: null == codeAcceptanceStatus
          ? _value.codeAcceptanceStatus
          : codeAcceptanceStatus // ignore: cast_nullable_to_non_nullable
              as DiscountCodeAcceptanceStatus,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as Discount?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_AcceptVoucherResponse extends _AcceptVoucherResponse {
  _$_AcceptVoucherResponse(
      {required this.codeAcceptanceStatus, @JsonKey() this.discount = null})
      : super._();

  factory _$_AcceptVoucherResponse.fromJson(Map<String, dynamic> json) =>
      _$$_AcceptVoucherResponseFromJson(json);

  /// 'accepted' | 'rejected' | 'already_accepted'
  @override
  final DiscountCodeAcceptanceStatus codeAcceptanceStatus;
  @override
  @JsonKey()
  final Discount? discount;

  @override
  String toString() {
    return 'AcceptVoucherResponse(codeAcceptanceStatus: $codeAcceptanceStatus, discount: $discount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AcceptVoucherResponse &&
            (identical(other.codeAcceptanceStatus, codeAcceptanceStatus) ||
                other.codeAcceptanceStatus == codeAcceptanceStatus) &&
            (identical(other.discount, discount) ||
                other.discount == discount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, codeAcceptanceStatus, discount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AcceptVoucherResponseCopyWith<_$_AcceptVoucherResponse> get copyWith =>
      __$$_AcceptVoucherResponseCopyWithImpl<_$_AcceptVoucherResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AcceptVoucherResponseToJson(
      this,
    );
  }
}

abstract class _AcceptVoucherResponse extends AcceptVoucherResponse {
  factory _AcceptVoucherResponse(
      {required final DiscountCodeAcceptanceStatus codeAcceptanceStatus,
      @JsonKey() final Discount? discount}) = _$_AcceptVoucherResponse;
  _AcceptVoucherResponse._() : super._();

  factory _AcceptVoucherResponse.fromJson(Map<String, dynamic> json) =
      _$_AcceptVoucherResponse.fromJson;

  @override

  /// 'accepted' | 'rejected' | 'already_accepted'
  DiscountCodeAcceptanceStatus get codeAcceptanceStatus;
  @override
  @JsonKey()
  Discount? get discount;
  @override
  @JsonKey(ignore: true)
  _$$_AcceptVoucherResponseCopyWith<_$_AcceptVoucherResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
