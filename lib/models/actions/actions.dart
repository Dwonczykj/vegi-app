import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/models/actions/wallet_action.dart';

part 'actions.freezed.dart';
part 'actions.g.dart';

@freezed
class WalletActions with _$WalletActions {
  factory WalletActions({
    @Default(<WalletAction>[]) List<WalletAction> list,
    @Default(0) num updatedAt,
    @Default(1) int currentPage,
  }) = _WalletActions;
  const WalletActions._();

  factory WalletActions.initial() {
    return WalletActions(
      
    );
  }

  factory WalletActions.fromJson(Map<String, dynamic> json) =>
      _$WalletActionsFromJson(json);
}
