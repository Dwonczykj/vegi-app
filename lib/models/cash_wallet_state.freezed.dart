// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cash_wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CashWalletState _$CashWalletStateFromJson(Map<String, dynamic> json) {
  return _CashWalletState.fromJson(json);
}

/// @nodoc
mixin _$CashWalletState {
  @JsonKey(fromJson: tokensFromJson)
  Map<String, Token> get tokens => throw _privateConstructorUsedError;
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions? get walletActions => throw _privateConstructorUsedError;

  ///
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isTransfersFetchingStarted => throw _privateConstructorUsedError;

  /// an indicator variable to show whether the periodic timer has been started to reguarly fetch balances.
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isFetchingBalances => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CashWalletStateCopyWith<CashWalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashWalletStateCopyWith<$Res> {
  factory $CashWalletStateCopyWith(
          CashWalletState value, $Res Function(CashWalletState) then) =
      _$CashWalletStateCopyWithImpl<$Res, CashWalletState>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: tokensFromJson) Map<String, Token> tokens,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isTransfersFetchingStarted,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isFetchingBalances});

  $WalletActionsCopyWith<$Res>? get walletActions;
}

/// @nodoc
class _$CashWalletStateCopyWithImpl<$Res, $Val extends CashWalletState>
    implements $CashWalletStateCopyWith<$Res> {
  _$CashWalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
    Object? walletActions = freezed,
    Object? isTransfersFetchingStarted = null,
    Object? isFetchingBalances = null,
  }) {
    return _then(_value.copyWith(
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>,
      walletActions: freezed == walletActions
          ? _value.walletActions
          : walletActions // ignore: cast_nullable_to_non_nullable
              as WalletActions?,
      isTransfersFetchingStarted: null == isTransfersFetchingStarted
          ? _value.isTransfersFetchingStarted
          : isTransfersFetchingStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingBalances: null == isFetchingBalances
          ? _value.isFetchingBalances
          : isFetchingBalances // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WalletActionsCopyWith<$Res>? get walletActions {
    if (_value.walletActions == null) {
      return null;
    }

    return $WalletActionsCopyWith<$Res>(_value.walletActions!, (value) {
      return _then(_value.copyWith(walletActions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CashWalletStateCopyWith<$Res>
    implements $CashWalletStateCopyWith<$Res> {
  factory _$$_CashWalletStateCopyWith(
          _$_CashWalletState value, $Res Function(_$_CashWalletState) then) =
      __$$_CashWalletStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: tokensFromJson) Map<String, Token> tokens,
      @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isTransfersFetchingStarted,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isFetchingBalances});

  @override
  $WalletActionsCopyWith<$Res>? get walletActions;
}

/// @nodoc
class __$$_CashWalletStateCopyWithImpl<$Res>
    extends _$CashWalletStateCopyWithImpl<$Res, _$_CashWalletState>
    implements _$$_CashWalletStateCopyWith<$Res> {
  __$$_CashWalletStateCopyWithImpl(
      _$_CashWalletState _value, $Res Function(_$_CashWalletState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = null,
    Object? walletActions = freezed,
    Object? isTransfersFetchingStarted = null,
    Object? isFetchingBalances = null,
  }) {
    return _then(_$_CashWalletState(
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, Token>,
      walletActions: freezed == walletActions
          ? _value.walletActions
          : walletActions // ignore: cast_nullable_to_non_nullable
              as WalletActions?,
      isTransfersFetchingStarted: null == isTransfersFetchingStarted
          ? _value.isTransfersFetchingStarted
          : isTransfersFetchingStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      isFetchingBalances: null == isFetchingBalances
          ? _value.isFetchingBalances
          : isFetchingBalances // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CashWalletState extends _CashWalletState with DiagnosticableTreeMixin {
  _$_CashWalletState(
      {@JsonKey(fromJson: tokensFromJson) this.tokens = const {},
      @JsonKey(fromJson: walletActionsFromJson) this.walletActions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.isTransfersFetchingStarted = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.isFetchingBalances = false})
      : super._();

  factory _$_CashWalletState.fromJson(Map<String, dynamic> json) =>
      _$$_CashWalletStateFromJson(json);

  @override
  @JsonKey(fromJson: tokensFromJson)
  final Map<String, Token> tokens;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  final WalletActions? walletActions;

  ///
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isTransfersFetchingStarted;

  /// an indicator variable to show whether the periodic timer has been started to reguarly fetch balances.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isFetchingBalances;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CashWalletState(tokens: $tokens, walletActions: $walletActions, isTransfersFetchingStarted: $isTransfersFetchingStarted, isFetchingBalances: $isFetchingBalances)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CashWalletState'))
      ..add(DiagnosticsProperty('tokens', tokens))
      ..add(DiagnosticsProperty('walletActions', walletActions))
      ..add(DiagnosticsProperty(
          'isTransfersFetchingStarted', isTransfersFetchingStarted))
      ..add(DiagnosticsProperty('isFetchingBalances', isFetchingBalances));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CashWalletState &&
            const DeepCollectionEquality().equals(other.tokens, tokens) &&
            (identical(other.walletActions, walletActions) ||
                other.walletActions == walletActions) &&
            (identical(other.isTransfersFetchingStarted,
                    isTransfersFetchingStarted) ||
                other.isTransfersFetchingStarted ==
                    isTransfersFetchingStarted) &&
            (identical(other.isFetchingBalances, isFetchingBalances) ||
                other.isFetchingBalances == isFetchingBalances));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tokens),
      walletActions,
      isTransfersFetchingStarted,
      isFetchingBalances);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CashWalletStateCopyWith<_$_CashWalletState> get copyWith =>
      __$$_CashWalletStateCopyWithImpl<_$_CashWalletState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CashWalletStateToJson(
      this,
    );
  }
}

abstract class _CashWalletState extends CashWalletState {
  factory _CashWalletState(
      {@JsonKey(fromJson: tokensFromJson) final Map<String, Token> tokens,
      @JsonKey(fromJson: walletActionsFromJson)
      final WalletActions? walletActions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool isTransfersFetchingStarted,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool isFetchingBalances}) = _$_CashWalletState;
  _CashWalletState._() : super._();

  factory _CashWalletState.fromJson(Map<String, dynamic> json) =
      _$_CashWalletState.fromJson;

  @override
  @JsonKey(fromJson: tokensFromJson)
  Map<String, Token> get tokens;
  @override
  @JsonKey(fromJson: walletActionsFromJson)
  WalletActions? get walletActions;
  @override

  ///
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isTransfersFetchingStarted;
  @override

  /// an indicator variable to show whether the periodic timer has been started to reguarly fetch balances.
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isFetchingBalances;
  @override
  @JsonKey(ignore: true)
  _$$_CashWalletStateCopyWith<_$_CashWalletState> get copyWith =>
      throw _privateConstructorUsedError;
}
