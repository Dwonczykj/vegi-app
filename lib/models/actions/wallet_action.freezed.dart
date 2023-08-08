// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletAction _$WalletActionFromJson(Map<String, dynamic> json) {
  switch (json['name']) {
    case 'tokenBonus':
      return Bonus.fromJson(json);
    case 'sendTokens':
      return Send.fromJson(json);
    case 'fiat-deposit':
      return FiatDeposit.fromJson(json);
    case 'createWallet':
      return CreateWallet.fromJson(json);
    case 'swapTokens':
      return Swap.fromJson(json);
    case 'receiveTokens':
      return Receive.fromJson(json);
    case 'receiveNFT':
      return ReceiveNFT.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'name', 'WalletAction',
          'Invalid union type "${json['name']}"!');
  }
}

/// @nodoc
mixin _$WalletAction {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get txHash => throw _privateConstructorUsedError;
  int? get blockNumber => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)
        bonus,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        send,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)
        fiatDeposit,
    required TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)
        createWallet,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        receive,
    required TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber) receiveNFT,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult? Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult? Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(Swap value) swap,
    required TResult Function(Receive value) receive,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Bonus value)? bonus,
    TResult? Function(Send value)? send,
    TResult? Function(FiatDeposit value)? fiatDeposit,
    TResult? Function(CreateWallet value)? createWallet,
    TResult? Function(Swap value)? swap,
    TResult? Function(Receive value)? receive,
    TResult? Function(ReceiveNFT value)? receiveNFT,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(Swap value)? swap,
    TResult Function(Receive value)? receive,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletActionCopyWith<WalletAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletActionCopyWith<$Res> {
  factory $WalletActionCopyWith(
          WalletAction value, $Res Function(WalletAction) then) =
      _$WalletActionCopyWithImpl<$Res, WalletAction>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String status,
      int timestamp,
      String name,
      String? txHash,
      int? blockNumber});
}

/// @nodoc
class _$WalletActionCopyWithImpl<$Res, $Val extends WalletAction>
    implements $WalletActionCopyWith<$Res> {
  _$WalletActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? timestamp = null,
    Object? name = null,
    Object? txHash = freezed,
    Object? blockNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BonusCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory _$$BonusCopyWith(_$Bonus value, $Res Function(_$Bonus) then) =
      __$$BonusCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String status,
      String tokenAddress,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      int timestamp,
      String name,
      String? txHash,
      int? blockNumber,
      String? from,
      String? bonusType});
}

/// @nodoc
class __$$BonusCopyWithImpl<$Res>
    extends _$WalletActionCopyWithImpl<$Res, _$Bonus>
    implements _$$BonusCopyWith<$Res> {
  __$$BonusCopyWithImpl(_$Bonus _value, $Res Function(_$Bonus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? tokenAddress = null,
    Object? to = null,
    Object? value = null,
    Object? tokenName = null,
    Object? tokenSymbol = null,
    Object? tokenDecimal = null,
    Object? timestamp = null,
    Object? name = null,
    Object? txHash = freezed,
    Object? blockNumber = freezed,
    Object? from = freezed,
    Object? bonusType = freezed,
  }) {
    return _then(_$Bonus(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: null == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      tokenDecimal: null == tokenDecimal
          ? _value.tokenDecimal
          : tokenDecimal // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      bonusType: freezed == bonusType
          ? _value.bonusType
          : bonusType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Bonus extends Bonus with DiagnosticableTreeMixin {
  const _$Bonus(
      {@JsonKey(name: '_id') required this.id,
      required this.status,
      required this.tokenAddress,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      this.timestamp = 0,
      this.name = 'tokenBonus',
      this.txHash,
      this.blockNumber = 0,
      this.from,
      this.bonusType})
      : super._();

  factory _$Bonus.fromJson(Map<String, dynamic> json) => _$$BonusFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String status;
  @override
  final String tokenAddress;
  @override
  final String to;
  @override
  final BigInt value;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;
  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  @JsonKey()
  final int? blockNumber;
  @override
  final String? from;
  @override
  final String? bonusType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.bonus(id: $id, status: $status, tokenAddress: $tokenAddress, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal, timestamp: $timestamp, name: $name, txHash: $txHash, blockNumber: $blockNumber, from: $from, bonusType: $bonusType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.bonus'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('bonusType', bonusType));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Bonus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                other.tokenSymbol == tokenSymbol) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                other.tokenDecimal == tokenDecimal) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.txHash, txHash) || other.txHash == txHash) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.bonusType, bonusType) ||
                other.bonusType == bonusType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      tokenAddress,
      to,
      value,
      tokenName,
      tokenSymbol,
      tokenDecimal,
      timestamp,
      name,
      txHash,
      blockNumber,
      from,
      bonusType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusCopyWith<_$Bonus> get copyWith =>
      __$$BonusCopyWithImpl<_$Bonus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)
        bonus,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        send,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)
        fiatDeposit,
    required TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)
        createWallet,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        receive,
    required TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber) receiveNFT,
  }) {
    return bonus(id, status, tokenAddress, to, value, tokenName, tokenSymbol,
        tokenDecimal, timestamp, name, txHash, blockNumber, from, bonusType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult? Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult? Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
  }) {
    return bonus?.call(
        id,
        status,
        tokenAddress,
        to,
        value,
        tokenName,
        tokenSymbol,
        tokenDecimal,
        timestamp,
        name,
        txHash,
        blockNumber,
        from,
        bonusType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
    required TResult orElse(),
  }) {
    if (bonus != null) {
      return bonus(id, status, tokenAddress, to, value, tokenName, tokenSymbol,
          tokenDecimal, timestamp, name, txHash, blockNumber, from, bonusType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(Swap value) swap,
    required TResult Function(Receive value) receive,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return bonus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Bonus value)? bonus,
    TResult? Function(Send value)? send,
    TResult? Function(FiatDeposit value)? fiatDeposit,
    TResult? Function(CreateWallet value)? createWallet,
    TResult? Function(Swap value)? swap,
    TResult? Function(Receive value)? receive,
    TResult? Function(ReceiveNFT value)? receiveNFT,
  }) {
    return bonus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(Swap value)? swap,
    TResult Function(Receive value)? receive,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (bonus != null) {
      return bonus(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusToJson(
      this,
    );
  }
}

abstract class Bonus extends WalletAction {
  const factory Bonus(
      {@JsonKey(name: '_id') required final String id,
      required final String status,
      required final String tokenAddress,
      required final String to,
      required final BigInt value,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal,
      final int timestamp,
      final String name,
      final String? txHash,
      final int? blockNumber,
      final String? from,
      final String? bonusType}) = _$Bonus;
  const Bonus._() : super._();

  factory Bonus.fromJson(Map<String, dynamic> json) = _$Bonus.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get status;
  String get tokenAddress;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  int get timestamp;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  int? get blockNumber;
  String? get from;
  String? get bonusType;
  @override
  @JsonKey(ignore: true)
  _$$BonusCopyWith<_$Bonus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory _$$SendCopyWith(_$Send value, $Res Function(_$Send) then) =
      __$$SendCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String status,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      int timestamp,
      String name,
      String? txHash,
      int? blockNumber});
}

/// @nodoc
class __$$SendCopyWithImpl<$Res>
    extends _$WalletActionCopyWithImpl<$Res, _$Send>
    implements _$$SendCopyWith<$Res> {
  __$$SendCopyWithImpl(_$Send _value, $Res Function(_$Send) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? tokenAddress = null,
    Object? from = null,
    Object? to = null,
    Object? value = null,
    Object? tokenName = null,
    Object? tokenSymbol = null,
    Object? tokenDecimal = null,
    Object? timestamp = null,
    Object? name = null,
    Object? txHash = freezed,
    Object? blockNumber = freezed,
  }) {
    return _then(_$Send(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: null == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      tokenDecimal: null == tokenDecimal
          ? _value.tokenDecimal
          : tokenDecimal // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Send extends Send with DiagnosticableTreeMixin {
  const _$Send(
      {@JsonKey(name: '_id') required this.id,
      required this.status,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      this.timestamp = 0,
      this.name = 'sendTokens',
      this.txHash,
      this.blockNumber = 0})
      : super._();

  factory _$Send.fromJson(Map<String, dynamic> json) => _$$SendFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String status;
  @override
  final String tokenAddress;
  @override
  final String from;
  @override
  final String to;
  @override
  final BigInt value;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;
  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  @JsonKey()
  final int? blockNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.send(id: $id, status: $status, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal, timestamp: $timestamp, name: $name, txHash: $txHash, blockNumber: $blockNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.send'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('blockNumber', blockNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Send &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                other.tokenSymbol == tokenSymbol) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                other.tokenDecimal == tokenDecimal) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.txHash, txHash) || other.txHash == txHash) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      tokenAddress,
      from,
      to,
      value,
      tokenName,
      tokenSymbol,
      tokenDecimal,
      timestamp,
      name,
      txHash,
      blockNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendCopyWith<_$Send> get copyWith =>
      __$$SendCopyWithImpl<_$Send>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)
        bonus,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        send,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)
        fiatDeposit,
    required TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)
        createWallet,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        receive,
    required TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber) receiveNFT,
  }) {
    return send(id, status, tokenAddress, from, to, value, tokenName,
        tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult? Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult? Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
  }) {
    return send?.call(id, status, tokenAddress, from, to, value, tokenName,
        tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
    required TResult orElse(),
  }) {
    if (send != null) {
      return send(id, status, tokenAddress, from, to, value, tokenName,
          tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(Swap value) swap,
    required TResult Function(Receive value) receive,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return send(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Bonus value)? bonus,
    TResult? Function(Send value)? send,
    TResult? Function(FiatDeposit value)? fiatDeposit,
    TResult? Function(CreateWallet value)? createWallet,
    TResult? Function(Swap value)? swap,
    TResult? Function(Receive value)? receive,
    TResult? Function(ReceiveNFT value)? receiveNFT,
  }) {
    return send?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(Swap value)? swap,
    TResult Function(Receive value)? receive,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (send != null) {
      return send(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SendToJson(
      this,
    );
  }
}

abstract class Send extends WalletAction {
  const factory Send(
      {@JsonKey(name: '_id') required final String id,
      required final String status,
      required final String tokenAddress,
      required final String from,
      required final String to,
      required final BigInt value,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal,
      final int timestamp,
      final String name,
      final String? txHash,
      final int? blockNumber}) = _$Send;
  const Send._() : super._();

  factory Send.fromJson(Map<String, dynamic> json) = _$Send.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get status;
  String get tokenAddress;
  String get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  int get timestamp;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  int? get blockNumber;
  @override
  @JsonKey(ignore: true)
  _$$SendCopyWith<_$Send> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FiatDepositCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory _$$FiatDepositCopyWith(
          _$FiatDeposit value, $Res Function(_$FiatDeposit) then) =
      __$$FiatDepositCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String status,
      String tokenAddress,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      int timestamp,
      String name,
      String? txHash,
      int? blockNumber,
      String? from});
}

/// @nodoc
class __$$FiatDepositCopyWithImpl<$Res>
    extends _$WalletActionCopyWithImpl<$Res, _$FiatDeposit>
    implements _$$FiatDepositCopyWith<$Res> {
  __$$FiatDepositCopyWithImpl(
      _$FiatDeposit _value, $Res Function(_$FiatDeposit) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? tokenAddress = null,
    Object? to = null,
    Object? value = null,
    Object? tokenName = null,
    Object? tokenSymbol = null,
    Object? tokenDecimal = null,
    Object? timestamp = null,
    Object? name = null,
    Object? txHash = freezed,
    Object? blockNumber = freezed,
    Object? from = freezed,
  }) {
    return _then(_$FiatDeposit(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: null == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      tokenDecimal: null == tokenDecimal
          ? _value.tokenDecimal
          : tokenDecimal // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FiatDeposit extends FiatDeposit with DiagnosticableTreeMixin {
  const _$FiatDeposit(
      {@JsonKey(name: '_id') required this.id,
      required this.status,
      required this.tokenAddress,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      this.timestamp = 0,
      this.name = 'fiat-deposit',
      this.txHash,
      this.blockNumber = 0,
      this.from})
      : super._();

  factory _$FiatDeposit.fromJson(Map<String, dynamic> json) =>
      _$$FiatDepositFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String status;
  @override
  final String tokenAddress;
  @override
  final String to;
  @override
  final BigInt value;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;
  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  @JsonKey()
  final int? blockNumber;
  @override
  final String? from;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.fiatDeposit(id: $id, status: $status, tokenAddress: $tokenAddress, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal, timestamp: $timestamp, name: $name, txHash: $txHash, blockNumber: $blockNumber, from: $from)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.fiatDeposit'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('from', from));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiatDeposit &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                other.tokenSymbol == tokenSymbol) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                other.tokenDecimal == tokenDecimal) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.txHash, txHash) || other.txHash == txHash) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber) &&
            (identical(other.from, from) || other.from == from));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      tokenAddress,
      to,
      value,
      tokenName,
      tokenSymbol,
      tokenDecimal,
      timestamp,
      name,
      txHash,
      blockNumber,
      from);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FiatDepositCopyWith<_$FiatDeposit> get copyWith =>
      __$$FiatDepositCopyWithImpl<_$FiatDeposit>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)
        bonus,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        send,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)
        fiatDeposit,
    required TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)
        createWallet,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        receive,
    required TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber) receiveNFT,
  }) {
    return fiatDeposit(id, status, tokenAddress, to, value, tokenName,
        tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber, from);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult? Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult? Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
  }) {
    return fiatDeposit?.call(id, status, tokenAddress, to, value, tokenName,
        tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber, from);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
    required TResult orElse(),
  }) {
    if (fiatDeposit != null) {
      return fiatDeposit(
          id,
          status,
          tokenAddress,
          to,
          value,
          tokenName,
          tokenSymbol,
          tokenDecimal,
          timestamp,
          name,
          txHash,
          blockNumber,
          from);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(Swap value) swap,
    required TResult Function(Receive value) receive,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return fiatDeposit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Bonus value)? bonus,
    TResult? Function(Send value)? send,
    TResult? Function(FiatDeposit value)? fiatDeposit,
    TResult? Function(CreateWallet value)? createWallet,
    TResult? Function(Swap value)? swap,
    TResult? Function(Receive value)? receive,
    TResult? Function(ReceiveNFT value)? receiveNFT,
  }) {
    return fiatDeposit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(Swap value)? swap,
    TResult Function(Receive value)? receive,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (fiatDeposit != null) {
      return fiatDeposit(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FiatDepositToJson(
      this,
    );
  }
}

abstract class FiatDeposit extends WalletAction {
  const factory FiatDeposit(
      {@JsonKey(name: '_id') required final String id,
      required final String status,
      required final String tokenAddress,
      required final String to,
      required final BigInt value,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal,
      final int timestamp,
      final String name,
      final String? txHash,
      final int? blockNumber,
      final String? from}) = _$FiatDeposit;
  const FiatDeposit._() : super._();

  factory FiatDeposit.fromJson(Map<String, dynamic> json) =
      _$FiatDeposit.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get status;
  String get tokenAddress;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  int get timestamp;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  int? get blockNumber;
  String? get from;
  @override
  @JsonKey(ignore: true)
  _$$FiatDepositCopyWith<_$FiatDeposit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateWalletCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory _$$CreateWalletCopyWith(
          _$CreateWallet value, $Res Function(_$CreateWallet) then) =
      __$$CreateWalletCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String status,
      int timestamp,
      String name,
      String? txHash,
      int? blockNumber});
}

/// @nodoc
class __$$CreateWalletCopyWithImpl<$Res>
    extends _$WalletActionCopyWithImpl<$Res, _$CreateWallet>
    implements _$$CreateWalletCopyWith<$Res> {
  __$$CreateWalletCopyWithImpl(
      _$CreateWallet _value, $Res Function(_$CreateWallet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? timestamp = null,
    Object? name = null,
    Object? txHash = freezed,
    Object? blockNumber = freezed,
  }) {
    return _then(_$CreateWallet(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateWallet extends CreateWallet with DiagnosticableTreeMixin {
  const _$CreateWallet(
      {@JsonKey(name: '_id') required this.id,
      required this.status,
      this.timestamp = 0,
      this.name = 'createWallet',
      this.txHash,
      this.blockNumber = 0})
      : super._();

  factory _$CreateWallet.fromJson(Map<String, dynamic> json) =>
      _$$CreateWalletFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String status;
  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  @JsonKey()
  final int? blockNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.createWallet(id: $id, status: $status, timestamp: $timestamp, name: $name, txHash: $txHash, blockNumber: $blockNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.createWallet'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('blockNumber', blockNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateWallet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.txHash, txHash) || other.txHash == txHash) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, status, timestamp, name, txHash, blockNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateWalletCopyWith<_$CreateWallet> get copyWith =>
      __$$CreateWalletCopyWithImpl<_$CreateWallet>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)
        bonus,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        send,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)
        fiatDeposit,
    required TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)
        createWallet,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        receive,
    required TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber) receiveNFT,
  }) {
    return createWallet(id, status, timestamp, name, txHash, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult? Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult? Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
  }) {
    return createWallet?.call(id, status, timestamp, name, txHash, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
    required TResult orElse(),
  }) {
    if (createWallet != null) {
      return createWallet(id, status, timestamp, name, txHash, blockNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(Swap value) swap,
    required TResult Function(Receive value) receive,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return createWallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Bonus value)? bonus,
    TResult? Function(Send value)? send,
    TResult? Function(FiatDeposit value)? fiatDeposit,
    TResult? Function(CreateWallet value)? createWallet,
    TResult? Function(Swap value)? swap,
    TResult? Function(Receive value)? receive,
    TResult? Function(ReceiveNFT value)? receiveNFT,
  }) {
    return createWallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(Swap value)? swap,
    TResult Function(Receive value)? receive,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (createWallet != null) {
      return createWallet(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateWalletToJson(
      this,
    );
  }
}

abstract class CreateWallet extends WalletAction {
  const factory CreateWallet(
      {@JsonKey(name: '_id') required final String id,
      required final String status,
      final int timestamp,
      final String name,
      final String? txHash,
      final int? blockNumber}) = _$CreateWallet;
  const CreateWallet._() : super._();

  factory CreateWallet.fromJson(Map<String, dynamic> json) =
      _$CreateWallet.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get status;
  @override
  int get timestamp;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  int? get blockNumber;
  @override
  @JsonKey(ignore: true)
  _$$CreateWalletCopyWith<_$CreateWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SwapCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory _$$SwapCopyWith(_$Swap value, $Res Function(_$Swap) then) =
      __$$SwapCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String status,
      int timestamp,
      String name,
      String? txHash,
      int? blockNumber,
      @JsonKey(name: 'metadata') Trade? tradeInfo});

  $TradeCopyWith<$Res>? get tradeInfo;
}

/// @nodoc
class __$$SwapCopyWithImpl<$Res>
    extends _$WalletActionCopyWithImpl<$Res, _$Swap>
    implements _$$SwapCopyWith<$Res> {
  __$$SwapCopyWithImpl(_$Swap _value, $Res Function(_$Swap) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? timestamp = null,
    Object? name = null,
    Object? txHash = freezed,
    Object? blockNumber = freezed,
    Object? tradeInfo = freezed,
  }) {
    return _then(_$Swap(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      tradeInfo: freezed == tradeInfo
          ? _value.tradeInfo
          : tradeInfo // ignore: cast_nullable_to_non_nullable
              as Trade?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TradeCopyWith<$Res>? get tradeInfo {
    if (_value.tradeInfo == null) {
      return null;
    }

    return $TradeCopyWith<$Res>(_value.tradeInfo!, (value) {
      return _then(_value.copyWith(tradeInfo: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Swap extends Swap with DiagnosticableTreeMixin {
  const _$Swap(
      {@JsonKey(name: '_id') required this.id,
      required this.status,
      this.timestamp = 0,
      this.name = 'swapTokens',
      this.txHash,
      this.blockNumber = 0,
      @JsonKey(name: 'metadata') this.tradeInfo})
      : super._();

  factory _$Swap.fromJson(Map<String, dynamic> json) => _$$SwapFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String status;
  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  @JsonKey()
  final int? blockNumber;
  @override
  @JsonKey(name: 'metadata')
  final Trade? tradeInfo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.swap(id: $id, status: $status, timestamp: $timestamp, name: $name, txHash: $txHash, blockNumber: $blockNumber, tradeInfo: $tradeInfo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.swap'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('blockNumber', blockNumber))
      ..add(DiagnosticsProperty('tradeInfo', tradeInfo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Swap &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.txHash, txHash) || other.txHash == txHash) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber) &&
            (identical(other.tradeInfo, tradeInfo) ||
                other.tradeInfo == tradeInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, status, timestamp, name, txHash, blockNumber, tradeInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SwapCopyWith<_$Swap> get copyWith =>
      __$$SwapCopyWithImpl<_$Swap>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)
        bonus,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        send,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)
        fiatDeposit,
    required TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)
        createWallet,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        receive,
    required TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber) receiveNFT,
  }) {
    return swap(id, status, timestamp, name, txHash, blockNumber, tradeInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult? Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult? Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
  }) {
    return swap?.call(
        id, status, timestamp, name, txHash, blockNumber, tradeInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
    required TResult orElse(),
  }) {
    if (swap != null) {
      return swap(id, status, timestamp, name, txHash, blockNumber, tradeInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(Swap value) swap,
    required TResult Function(Receive value) receive,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return swap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Bonus value)? bonus,
    TResult? Function(Send value)? send,
    TResult? Function(FiatDeposit value)? fiatDeposit,
    TResult? Function(CreateWallet value)? createWallet,
    TResult? Function(Swap value)? swap,
    TResult? Function(Receive value)? receive,
    TResult? Function(ReceiveNFT value)? receiveNFT,
  }) {
    return swap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(Swap value)? swap,
    TResult Function(Receive value)? receive,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (swap != null) {
      return swap(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SwapToJson(
      this,
    );
  }
}

abstract class Swap extends WalletAction {
  const factory Swap(
      {@JsonKey(name: '_id') required final String id,
      required final String status,
      final int timestamp,
      final String name,
      final String? txHash,
      final int? blockNumber,
      @JsonKey(name: 'metadata') final Trade? tradeInfo}) = _$Swap;
  const Swap._() : super._();

  factory Swap.fromJson(Map<String, dynamic> json) = _$Swap.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get status;
  @override
  int get timestamp;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  int? get blockNumber;
  @JsonKey(name: 'metadata')
  Trade? get tradeInfo;
  @override
  @JsonKey(ignore: true)
  _$$SwapCopyWith<_$Swap> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReceiveCopyWith<$Res> implements $WalletActionCopyWith<$Res> {
  factory _$$ReceiveCopyWith(_$Receive value, $Res Function(_$Receive) then) =
      __$$ReceiveCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String status,
      String tokenAddress,
      String from,
      String to,
      BigInt value,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      int timestamp,
      String name,
      String? txHash,
      int? blockNumber});
}

/// @nodoc
class __$$ReceiveCopyWithImpl<$Res>
    extends _$WalletActionCopyWithImpl<$Res, _$Receive>
    implements _$$ReceiveCopyWith<$Res> {
  __$$ReceiveCopyWithImpl(_$Receive _value, $Res Function(_$Receive) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? tokenAddress = null,
    Object? from = null,
    Object? to = null,
    Object? value = null,
    Object? tokenName = null,
    Object? tokenSymbol = null,
    Object? tokenDecimal = null,
    Object? timestamp = null,
    Object? name = null,
    Object? txHash = freezed,
    Object? blockNumber = freezed,
  }) {
    return _then(_$Receive(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: null == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      tokenDecimal: null == tokenDecimal
          ? _value.tokenDecimal
          : tokenDecimal // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Receive extends Receive with DiagnosticableTreeMixin {
  const _$Receive(
      {@JsonKey(name: '_id') required this.id,
      required this.status,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.value,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      this.timestamp = 0,
      this.name = 'receiveTokens',
      this.txHash,
      this.blockNumber = 0})
      : super._();

  factory _$Receive.fromJson(Map<String, dynamic> json) =>
      _$$ReceiveFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String status;
  @override
  final String tokenAddress;
  @override
  final String from;
  @override
  final String to;
  @override
  final BigInt value;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;
  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  @JsonKey()
  final int? blockNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.receive(id: $id, status: $status, tokenAddress: $tokenAddress, from: $from, to: $to, value: $value, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal, timestamp: $timestamp, name: $name, txHash: $txHash, blockNumber: $blockNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.receive'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('blockNumber', blockNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Receive &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                other.tokenSymbol == tokenSymbol) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                other.tokenDecimal == tokenDecimal) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.txHash, txHash) || other.txHash == txHash) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      tokenAddress,
      from,
      to,
      value,
      tokenName,
      tokenSymbol,
      tokenDecimal,
      timestamp,
      name,
      txHash,
      blockNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiveCopyWith<_$Receive> get copyWith =>
      __$$ReceiveCopyWithImpl<_$Receive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)
        bonus,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        send,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)
        fiatDeposit,
    required TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)
        createWallet,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        receive,
    required TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber) receiveNFT,
  }) {
    return receive(id, status, tokenAddress, from, to, value, tokenName,
        tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult? Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult? Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
  }) {
    return receive?.call(id, status, tokenAddress, from, to, value, tokenName,
        tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
    required TResult orElse(),
  }) {
    if (receive != null) {
      return receive(id, status, tokenAddress, from, to, value, tokenName,
          tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(Swap value) swap,
    required TResult Function(Receive value) receive,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return receive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Bonus value)? bonus,
    TResult? Function(Send value)? send,
    TResult? Function(FiatDeposit value)? fiatDeposit,
    TResult? Function(CreateWallet value)? createWallet,
    TResult? Function(Swap value)? swap,
    TResult? Function(Receive value)? receive,
    TResult? Function(ReceiveNFT value)? receiveNFT,
  }) {
    return receive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(Swap value)? swap,
    TResult Function(Receive value)? receive,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (receive != null) {
      return receive(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiveToJson(
      this,
    );
  }
}

abstract class Receive extends WalletAction {
  const factory Receive(
      {@JsonKey(name: '_id') required final String id,
      required final String status,
      required final String tokenAddress,
      required final String from,
      required final String to,
      required final BigInt value,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal,
      final int timestamp,
      final String name,
      final String? txHash,
      final int? blockNumber}) = _$Receive;
  const Receive._() : super._();

  factory Receive.fromJson(Map<String, dynamic> json) = _$Receive.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get status;
  String get tokenAddress;
  String get from;
  String get to;
  BigInt get value;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  int get timestamp;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  int? get blockNumber;
  @override
  @JsonKey(ignore: true)
  _$$ReceiveCopyWith<_$Receive> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReceiveNFTCopyWith<$Res>
    implements $WalletActionCopyWith<$Res> {
  factory _$$ReceiveNFTCopyWith(
          _$ReceiveNFT value, $Res Function(_$ReceiveNFT) then) =
      __$$ReceiveNFTCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String status,
      String tokenAddress,
      String from,
      String to,
      String tokenName,
      String tokenSymbol,
      int tokenDecimal,
      int timestamp,
      String name,
      String? txHash,
      int? blockNumber});
}

/// @nodoc
class __$$ReceiveNFTCopyWithImpl<$Res>
    extends _$WalletActionCopyWithImpl<$Res, _$ReceiveNFT>
    implements _$$ReceiveNFTCopyWith<$Res> {
  __$$ReceiveNFTCopyWithImpl(
      _$ReceiveNFT _value, $Res Function(_$ReceiveNFT) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? tokenAddress = null,
    Object? from = null,
    Object? to = null,
    Object? tokenName = null,
    Object? tokenSymbol = null,
    Object? tokenDecimal = null,
    Object? timestamp = null,
    Object? name = null,
    Object? txHash = freezed,
    Object? blockNumber = freezed,
  }) {
    return _then(_$ReceiveNFT(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenSymbol: null == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      tokenDecimal: null == tokenDecimal
          ? _value.tokenDecimal
          : tokenDecimal // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiveNFT extends ReceiveNFT with DiagnosticableTreeMixin {
  const _$ReceiveNFT(
      {@JsonKey(name: '_id') required this.id,
      required this.status,
      required this.tokenAddress,
      required this.from,
      required this.to,
      required this.tokenName,
      required this.tokenSymbol,
      required this.tokenDecimal,
      this.timestamp = 0,
      this.name = 'receiveNFT',
      this.txHash,
      this.blockNumber = 0})
      : super._();

  factory _$ReceiveNFT.fromJson(Map<String, dynamic> json) =>
      _$$ReceiveNFTFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String status;
  @override
  final String tokenAddress;
  @override
  final String from;
  @override
  final String to;
  @override
  final String tokenName;
  @override
  final String tokenSymbol;
  @override
  final int tokenDecimal;
  @override
  @JsonKey()
  final int timestamp;
  @override
  @JsonKey()
  final String name;
  @override
  final String? txHash;
  @override
  @JsonKey()
  final int? blockNumber;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WalletAction.receiveNFT(id: $id, status: $status, tokenAddress: $tokenAddress, from: $from, to: $to, tokenName: $tokenName, tokenSymbol: $tokenSymbol, tokenDecimal: $tokenDecimal, timestamp: $timestamp, name: $name, txHash: $txHash, blockNumber: $blockNumber)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WalletAction.receiveNFT'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('tokenAddress', tokenAddress))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('tokenName', tokenName))
      ..add(DiagnosticsProperty('tokenSymbol', tokenSymbol))
      ..add(DiagnosticsProperty('tokenDecimal', tokenDecimal))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('txHash', txHash))
      ..add(DiagnosticsProperty('blockNumber', blockNumber));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiveNFT &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                other.tokenSymbol == tokenSymbol) &&
            (identical(other.tokenDecimal, tokenDecimal) ||
                other.tokenDecimal == tokenDecimal) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.txHash, txHash) || other.txHash == txHash) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      tokenAddress,
      from,
      to,
      tokenName,
      tokenSymbol,
      tokenDecimal,
      timestamp,
      name,
      txHash,
      blockNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiveNFTCopyWith<_$ReceiveNFT> get copyWith =>
      __$$ReceiveNFTCopyWithImpl<_$ReceiveNFT>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)
        bonus,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        send,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)
        fiatDeposit,
    required TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)
        createWallet,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)
        swap,
    required TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)
        receive,
    required TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber) receiveNFT,
  }) {
    return receiveNFT(id, status, tokenAddress, from, to, tokenName,
        tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult? Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult? Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult? Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
  }) {
    return receiveNFT?.call(id, status, tokenAddress, from, to, tokenName,
        tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from,
            String? bonusType)?
        bonus,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        send,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            String? from)?
        fiatDeposit,
    TResult Function(@JsonKey(name: '_id') String id, String status,
            int timestamp, String name, String? txHash, int? blockNumber)?
        createWallet,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber,
            @JsonKey(name: 'metadata') Trade? tradeInfo)?
        swap,
    TResult Function(
            @JsonKey(name: '_id') String id,
            String status,
            String tokenAddress,
            String from,
            String to,
            BigInt value,
            String tokenName,
            String tokenSymbol,
            int tokenDecimal,
            int timestamp,
            String name,
            String? txHash,
            int? blockNumber)?
        receive,
    TResult Function(@JsonKey(name: '_id') String id, String status, String tokenAddress, String from, String to, String tokenName, String tokenSymbol, int tokenDecimal, int timestamp, String name, String? txHash, int? blockNumber)? receiveNFT,
    required TResult orElse(),
  }) {
    if (receiveNFT != null) {
      return receiveNFT(id, status, tokenAddress, from, to, tokenName,
          tokenSymbol, tokenDecimal, timestamp, name, txHash, blockNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Bonus value) bonus,
    required TResult Function(Send value) send,
    required TResult Function(FiatDeposit value) fiatDeposit,
    required TResult Function(CreateWallet value) createWallet,
    required TResult Function(Swap value) swap,
    required TResult Function(Receive value) receive,
    required TResult Function(ReceiveNFT value) receiveNFT,
  }) {
    return receiveNFT(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Bonus value)? bonus,
    TResult? Function(Send value)? send,
    TResult? Function(FiatDeposit value)? fiatDeposit,
    TResult? Function(CreateWallet value)? createWallet,
    TResult? Function(Swap value)? swap,
    TResult? Function(Receive value)? receive,
    TResult? Function(ReceiveNFT value)? receiveNFT,
  }) {
    return receiveNFT?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Bonus value)? bonus,
    TResult Function(Send value)? send,
    TResult Function(FiatDeposit value)? fiatDeposit,
    TResult Function(CreateWallet value)? createWallet,
    TResult Function(Swap value)? swap,
    TResult Function(Receive value)? receive,
    TResult Function(ReceiveNFT value)? receiveNFT,
    required TResult orElse(),
  }) {
    if (receiveNFT != null) {
      return receiveNFT(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiveNFTToJson(
      this,
    );
  }
}

abstract class ReceiveNFT extends WalletAction {
  const factory ReceiveNFT(
      {@JsonKey(name: '_id') required final String id,
      required final String status,
      required final String tokenAddress,
      required final String from,
      required final String to,
      required final String tokenName,
      required final String tokenSymbol,
      required final int tokenDecimal,
      final int timestamp,
      final String name,
      final String? txHash,
      final int? blockNumber}) = _$ReceiveNFT;
  const ReceiveNFT._() : super._();

  factory ReceiveNFT.fromJson(Map<String, dynamic> json) =
      _$ReceiveNFT.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get status;
  String get tokenAddress;
  String get from;
  String get to;
  String get tokenName;
  String get tokenSymbol;
  int get tokenDecimal;
  @override
  int get timestamp;
  @override
  String get name;
  @override
  String? get txHash;
  @override
  int? get blockNumber;
  @override
  @JsonKey(ignore: true)
  _$$ReceiveNFTCopyWith<_$ReceiveNFT> get copyWith =>
      throw _privateConstructorUsedError;
}
