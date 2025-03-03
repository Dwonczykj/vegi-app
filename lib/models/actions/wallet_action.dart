import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/tokens/price.dart';
import 'package:vegan_liverpool/utils/format.dart';
import 'package:vegan_liverpool/utils/json_helpers.dart';

part 'wallet_action.freezed.dart';
part 'wallet_action.g.dart';

@Freezed(unionKey: 'name')
class WalletAction with _$WalletAction implements Comparable<WalletAction> {
  @FreezedUnionValue('tokenBonus')
  const factory WalletAction.bonus({
    @JsonKey(name: '_id') required String id, required String status, required String tokenAddress, required String to, required BigInt value, required String tokenName, required String tokenSymbol, required int tokenDecimal, @Default(0) int timestamp,
    @Default('tokenBonus') String name,
    String? txHash,
    @Default(0) int? blockNumber,
    String? from,
    String? bonusType,
  }) = Bonus;

  @FreezedUnionValue('sendTokens')
  const factory WalletAction.send({
    @JsonKey(name: '_id') required String id, required String status, required String tokenAddress, required String from, required String to, required BigInt value, required String tokenName, required String tokenSymbol, required int tokenDecimal, @Default(0) int timestamp,
    @Default('sendTokens') String name,
    String? txHash,
    @Default(0) int? blockNumber,
  }) = Send;

  @FreezedUnionValue('fiat-deposit')
  const factory WalletAction.fiatDeposit({
    @JsonKey(name: '_id') required String id, required String status, required String tokenAddress, required String to, required BigInt value, required String tokenName, required String tokenSymbol, required int tokenDecimal, @Default(0) int timestamp,
    @Default('fiat-deposit') String name,
    String? txHash,
    @Default(0) int? blockNumber,
    String? from,
  }) = FiatDeposit;

  factory WalletAction.fromJson(Map<String, dynamic> json) =>
      _$WalletActionFromJson(json);

  @FreezedUnionValue('createWallet')
  const factory WalletAction.createWallet({
    @JsonKey(name: '_id') required String id, required String status, @Default(0) int timestamp,
    @Default('createWallet') String name,
    String? txHash,
    @Default(0) int? blockNumber,
  }) = CreateWallet;

  @FreezedUnionValue('swapTokens')
  const factory WalletAction.swap({
    @JsonKey(name: '_id') required String id, required String status, @Default(0) int timestamp,
    @Default('swapTokens') String name,
    String? txHash,
    @Default(0) int? blockNumber,
    @JsonKey(name: 'metadata') Trade? tradeInfo,
  }) = Swap;

  factory WalletAction.create(Map<String, dynamic> json) {
    final Map<String, dynamic> newJson = json.containsKey('data')
        ? Map.from({...json, ...json['data'] as Map<String, dynamic>})
        : json;
    newJson['timestamp'] =
        DateTime.parse(json['updatedAt'] as String).millisecondsSinceEpoch;
    newJson['value'] = isJsonValEmpty(json, 'value') ? '0' : json['value'];
    if (json.containsKey('status')) {
      newJson['status'] = json['status'].toString().toUpperCase();
    }
    return WalletAction.fromJson(newJson);
  }

  @FreezedUnionValue('receiveTokens')
  const factory WalletAction.receive({
    @JsonKey(name: '_id') required String id, required String status, required String tokenAddress, required String from, required String to, required BigInt value, required String tokenName, required String tokenSymbol, required int tokenDecimal, @Default(0) int timestamp,
    @Default('receiveTokens') String name,
    String? txHash,
    @Default(0) int? blockNumber,
  }) = Receive;

  @FreezedUnionValue('receiveNFT')
  const factory WalletAction.receiveNFT({
    @JsonKey(name: '_id') required String id, required String status, required String tokenAddress, required String from, required String to, required String tokenName, required String tokenSymbol, required int tokenDecimal, @Default(0) int timestamp,
    @Default('receiveNFT') String name,
    String? txHash,
    @Default(0) int? blockNumber,
  }) = ReceiveNFT;
  const WalletAction._();

  @override
  int compareTo(WalletAction? other) {
    if (other == null) return 1;
    return timestamp.compareTo(other.timestamp);
  }

  static List<WalletAction> actionsFromJson(Iterable<dynamic> docs) =>
      List<Map<String, dynamic>>.from(docs).fold<List<WalletAction>>([],
          (previousValue, action) {
        try {
          return [...previousValue, WalletAction.create(action)];
        } catch (e) {
          return previousValue;
        }
      });

  bool isPending() => status == 'PENDING' || status == 'STARTED';
  bool isFailed() => status == 'FAILED';
  bool isConfirmed() => status == 'CONFIRMED' || status == 'SUCCEEDED';

  // ImageProvider getImage(
  //   Contact? contact,
  //   String? accountAddress,
  //   Map<String, String> tokensImages,
  // ) {
  //   final bool hasAvatar =
  //       contact?.avatar != null && contact!.avatar!.isNotEmpty;
  //   if (hasAvatar) {
  //     return MemoryImage(contact.avatar as Uint8List);
  //   }
  //   return map(
  //     receiveNFT: (value) => const AssetImage(
  //       'assets/images/recieve.png',
  //     ),
  //     createWallet: (value) => const AssetImage(
  //       'assets/images/generate_wallet.png',
  //     ),
  //     fiatDeposit: (value) => const AssetImage(
  //       'assets/images/deposit.png',
  //     ),
  //     bonus: (value) => const AssetImage(
  //       'assets/images/referral_bonus.png',
  //     ),
  //     send: (value) => const AssetImage('assets/images/send.png'),
  //     receive: (value) => const AssetImage('assets/images/recieve.png'),
  //     swap: (value) => const AssetImage('assets/images/swap_logo.png'),
  //   );
  // }

  String getSubtitle(
    BuildContext context,
  ) {
    return maybeMap(
      orElse: () => '',
      receiveNFT: (value) => value.tokenName,
      fiatDeposit: (value) => I10n.of(context).action_fiatDeposit,
      bonus: (value) => I10n.of(context).action_bonus,
      send: (value) => I10n.of(context).action_send,
      receive: (value) => I10n.of(context).action_receive,
      swap: (value) => I10n.of(context).action_swap,
    );
  }

  String getAmount([Price? priceInfo]) {
    return maybeMap(
      orElse: () => '',
      fiatDeposit: (value) => Formatter.amountPrinter(
        value.value,
        value.tokenDecimal,
        priceInfo,
      ),
      bonus: (value) => Formatter.amountPrinter(
        value.value,
        value.tokenDecimal,
        priceInfo,
      ),
      send: (value) => Formatter.amountPrinter(
        value.value,
        value.tokenDecimal,
        priceInfo,
      ),
      receive: (value) => Formatter.amountPrinter(
        value.value,
        value.tokenDecimal,
        priceInfo,
      ),
      swap: (value) {
        if (priceInfo != null && priceInfo.hasPriceInfo) {
          final Decimal fiatValue =
              Decimal.parse(value.tradeInfo!.outputAmount) *
                  Decimal.parse(priceInfo.quote);
          return '\$${Formatter.smallNumbersConvertor(fiatValue)}';
        }
        return Formatter.smallNumbersConvertor(
          Decimal.parse(value.tradeInfo?.outputAmount ?? '0'),
        );
      },
    );
  }

  bool isGenerateWallet() {
    return maybeMap(
      orElse: () => false,
      createWallet: (value) => true,
    );
  }

  bool isSwapAction() {
    return maybeMap(
      orElse: () => false,
      swap: (value) => true,
    );
  }

  bool isNFTAction() {
    return maybeMap(
      orElse: () => false,
      receiveNFT: (value) => true,
    );
  }

  Widget getStatusIcon([
    double? width = 25,
    double? height = 25,
  ]) {
    if (isFailed()) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          'assets/images/failed_icon.svg',
          width: width,
          height: height,
        ),
      );
    } else if (isConfirmed()) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          'assets/images/approve_icon.svg',
          width: width,
          height: height,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SvgPicture.asset(
          'assets/images/pending.svg',
          width: width,
          height: height,
        ),
      );
    }
  }

  String getText(
    BuildContext context, {
    String? displayName,
  }) {
    return map(
      receiveNFT: (value) => I10n.of(context).you_got_a_new_NFT,
      createWallet: (value) {
        if (value.isFailed()) {
          return I10n.of(context).generate_wallet_failed;
        } else if (value.isConfirmed()) {
          return I10n.of(context).generated_wallet;
        } else {
          return I10n.of(context).generating_wallet;
        }
      },
      fiatDeposit: (value) {
        if (value.isFailed()) {
          return 'fUSD - ${I10n.of(context).deposit_failed}';
        } else if (value.isConfirmed()) {
          return I10n.of(context).deposit;
        } else {
          return I10n.of(context).waiting_for_deposit;
        }
      },
      bonus: (value) {
        if (value.isFailed()) {
          return '${I10n.of(context).receiving} ${value.bonusType} ${I10n.of(context).bonus} ${I10n.of(context).failed.toLowerCase()}';
        } else if (value.isConfirmed()) {
          return '${I10n.of(context).you_got_a} ${value.bonusType} ${I10n.of(context).bonus}!';
        } else {
          return '${I10n.of(context).you_got_a} ${value.bonusType} ${I10n.of(context).bonus}';
        }
      },
      send: (value) {
        final name = displayName ?? Formatter.formatEthAddress(value.to);
        if (value.isFailed()) {
          return '${I10n.of(context).sent} ${value.tokenSymbol} ${I10n.of(context).to.toLowerCase()} $name';
        } else if (value.isConfirmed()) {
          return '${I10n.of(context).sent} ${value.tokenSymbol} ${I10n.of(context).to.toLowerCase()} $name';
        } else {
          return '${I10n.of(context).sent} ${value.tokenSymbol} ${I10n.of(context).to.toLowerCase()} $name';
        }
      },
      receive: (value) {
        final name = displayName ?? Formatter.formatEthAddress(value.to);
        if (value.isFailed()) {
          return '${I10n.of(context).received} ${value.tokenSymbol} ${I10n.of(context).from.toLowerCase()} $name';
        } else if (value.isConfirmed()) {
          return '${I10n.of(context).received} ${value.tokenSymbol} ${I10n.of(context).from.toLowerCase()} $name';
        } else {
          return '${I10n.of(context).received} ${value.tokenSymbol} ${I10n.of(context).from.toLowerCase()} $name';
        }
      },
      swap: (value) {
        final String text =
            '${value.tradeInfo?.inputToken}${I10n.of(context).for_text} ${value.tradeInfo?.outputToken}';
        return text;
      },
    );
  }

  String getSender() {
    return maybeMap(
      orElse: () => '',
      fiatDeposit: (value) => value.from ?? '',
      bonus: (value) => value.from ?? '',
      send: (value) => value.to,
      receive: (value) => value.from,
    );
  }

  String getRecipient() {
    return maybeMap(
      orElse: () => '',
      fiatDeposit: (value) => value.to,
      bonus: (value) => value.to,
      send: (value) => value.to,
      receive: (value) => value.to,
    );
  }
}
