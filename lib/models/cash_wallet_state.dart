import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/constants/addresses.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/actions/actions.dart';
import 'package:vegan_liverpool/models/actions/wallet_action.dart';
import 'package:vegan_liverpool/models/tokens/token.dart';
import 'package:vegan_liverpool/utils/constants.dart';

part 'cash_wallet_state.freezed.dart';
part 'cash_wallet_state.g.dart';

WalletActions walletActionsFromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return WalletActions.initial();
  } else {
    return WalletActions(
      list: WalletAction.actionsFromJson(
        json['list'] as Iterable<dynamic>,
      ),
      updatedAt: json['updatedAt'] as num? ?? 0,
      currentPage: json['currentPage'] as int? ?? 1,
    );
  }
}

Map<String, Token> tokensFromJson(Map<String, dynamic> tokens) => tokens.map(
      (k, e) {
        if (k == Addresses.zeroAddress) {
          return MapEntry(
            Addresses.nativeTokenAddress,
            Token.fromJson(
              {
                ...e as Map<String, dynamic>,
                'address': Addresses.nativeTokenAddress,
              },
            ),
          );
        } else {
          return MapEntry(
            k,
            Token.fromJson(
              e as Map<String, dynamic>,
            ),
          );
        }
      },
    )
      // ..putIfAbsent(gbpxToken.address, () => gbpxToken)
      // ..putIfAbsent(pplToken.address, () => pplToken)
      ..putIfAbsent(TokenDefinitions.greenBeanToken.address,
          () => TokenDefinitions.greenBeanToken);

@freezed
class CashWalletState with _$CashWalletState {
  factory CashWalletState({
    @JsonKey(fromJson: tokensFromJson) @Default({}) Map<String, Token> tokens,
    @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,

    ///
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isTransfersFetchingStarted,

    /// an indicator variable to show whether the periodic timer has been started to reguarly fetch balances.
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isFetchingBalances,
  }) = _CashWalletState;

  const CashWalletState._();

  factory CashWalletState.initial() {
    return CashWalletState(
      tokens: Map<String, Token>.fromIterables(
        {
          // gbpxToken.address,
          // pplToken.address,
          TokenDefinitions.greenBeanToken.address,
        },
        [
          // gbpxToken.copyWith(),
          // pplToken.copyWith(),
          TokenDefinitions.greenBeanToken.copyWith(),
        ],
      ),
      walletActions: WalletActions().copyWith(
        list: <WalletAction>[],
        updatedAt: 0,
      ),
    );
  }

  factory CashWalletState.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$CashWalletStateFromJson(json),
      );
}

class CashWalletStateConverter
    implements JsonConverter<CashWalletState, Map<String, dynamic>?> {
  const CashWalletStateConverter();

  @override
  CashWalletState fromJson(Map<String, dynamic>? json) => tryCatchRethrowInline(
        () => json != null
            ? CashWalletState.fromJson(json)
            : CashWalletState.initial(),
      );

  @override
  Map<String, dynamic> toJson(CashWalletState instance) => instance.toJson();
}
