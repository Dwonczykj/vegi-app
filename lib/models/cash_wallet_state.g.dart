// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CashWalletState _$$_CashWalletStateFromJson(Map<String, dynamic> json) =>
    _$_CashWalletState(
      tokens: json['tokens'] == null
          ? const {}
          : tokensFromJson(json['tokens'] as Map<String, dynamic>),
      walletActions:
          walletActionsFromJson(json['walletActions'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$_CashWalletStateToJson(_$_CashWalletState instance) =>
    <String, dynamic>{
      'tokens': instance.tokens.map((k, e) => MapEntry(k, e.toJson())),
      'walletActions': instance.walletActions?.toJson(),
    };
