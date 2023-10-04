import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/actions/actions.dart';
import 'package:vegan_liverpool/models/cash_wallet_state.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/models/tokens/price.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/format.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

part 'token.freezed.dart';
part 'token.g.dart';

@Freezed()
class Token with _$Token implements Comparable<Token> {
  factory Token({
    required String address,
    required String name,
    required String symbol,
    required BigInt amount,
    required int decimals,
    @Default(false) bool isNative,
    String? imageUrl,
    int? timestamp,
    Price? priceInfo,
    String? communityAddress,
    @Default(TimeFrame.day) TimeFrame timeFrame,
    @Default(0) num priceChange,
    @Default([]) List<IntervalStats> intervalStats,
    @JsonKey(fromJson: walletActionsFromJson) WalletActions? walletActions,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  const Token._();

  @override
  int compareTo(Token? other) {
    if (other == null) return 1;
    return num.parse(getFiatBalanceFormatted(withPrecision: true)).compareTo(
        num.parse(other.getFiatBalanceFormatted(withPrecision: true)));
  }

  double getAmountTokens() => Formatter.fromWei(amount, decimals).toDouble();
  Money getBalanceMoney() => Money(
        currency:
            EnumHelpers.enumFromString<Currency>(Currency.values, symbol) ??
                Currency.GBT,
        value: EnumHelpers.enumFromString<Currency>(Currency.values, symbol) ==
                null
            ? 0.0
            : getAmountTokens(),
      );
  BigInt getAmountWei() => amount;

  String getBalance({bool withPrecision = false}) => Formatter.formatValue(
        amount,
        decimals,
        withPrecision,
      );

  double getFiatBalance({bool withPrecision = false}) => hasPriceInfo
      ? Formatter.formatValueToFiatAmount(
          amount,
          decimals,
          double.parse(priceInfo!.quote),
        ).toDouble()
      : symbol == 'GBT'
          ? getPoundValueFromGBT(getAmountTokens())
          : 0.0;

  String getFiatBalanceFormatted({bool withPrecision = false}) => hasPriceInfo
      ? Formatter.formatValueToFiatFormatted(
          amount,
          decimals,
          double.parse(priceInfo!.quote),
          withPrecision,
        )
      : symbol == 'GBT'
          ? getPoundValueFromGBT(getAmountTokens()).formattedGBPPriceNoDec
          : 0.formattedGBPPriceNoDec;

  bool get hasPriceInfo => priceInfo != null && priceInfo?.hasPriceInfo == true;

  Future<dynamic> fetchBalance(
    String accountAddress, {
    required void Function(BigInt) onDone,
    required dynamic Function(Object, StackTrace) onError,
  }) async {
    if ([null, ''].contains(accountAddress) || [null, ''].contains(address)) {
      return;
    }
    try {
      final tokenBalanceData =
          await fuseWalletSDK.explorerModule.getTokenBalance(
        address,
        accountAddress,
      );
      return tokenBalanceData.pick(
        onData: (BigInt value) {
          log.debug(
              'Token Balance Update: $symbol ${Formatter.fromWei(value, decimals).toStringAsFixed(2)}');
          onDone(value);
        },
        onError: (err) {
          throw err;
        },
      );
    } catch (e, s) {
      log.error(
        'Error - fetch token balance $name',
        error: e,
        stackTrace: s,
      );
      onError.call(e, s);
      rethrow;
    }
  }

  Future<dynamic> fetchLatestPrice({
    required void Function(Price) onDone,
    required dynamic Function(Object, StackTrace) onError,
    String currency = 'usd',
  }) async {
    try {
      final priceData = await (await fuseWalletSDK).tradeModule.price(address);
      return priceData.pick(
        onData: (String tokenPrice) {
          // Do you magic here
          onDone(
            Price(
              currency: currency,
              quote: Decimal.parse(tokenPrice).toString(),
            ),
          );
        },
        onError: (err) {
          // Handle errors
          onError(err, StackTrace.current);
        },
      );
    } catch (e, s) {
      onError(e, s);
    }
  }

  Future<dynamic> fetchPriceChangeInLast24Hours({
    required void Function(num) onDone,
    required dynamic Function(Object, StackTrace) onError,
  }) async {
    try {
      final priceChangeData =
          await (await fuseWalletSDK).tradeModule.priceChange(address);
      priceChangeData.pick(
        onData: (String priceChange) {
          onDone(num.parse(Decimal.parse(priceChange).toString()));
        },
        onError: (err) {
          // Handle errors
          onError(err, StackTrace.current);
        },
      );
    } catch (e, s) {
      onError(e, s);
    }
  }

  Future<dynamic> fetchPriceChangeInLastNHours({
    required void Function(List<IntervalStats>) onDone,
    required dynamic Function(Object, StackTrace) onError,
    TimeFrame timeFrame = TimeFrame.day,
  }) async {
    try {
      final intervalData =
          await fuseWalletSDK.tradeModule.interval(address, timeFrame);
      return intervalData.pick(
        onData: (List<IntervalStats> stats) {
          onDone(stats);
        },
        onError: (err) {
          onError(err, StackTrace.current);
        },
      );
    } catch (e, s) {
      onError(e, s);
    }
  }
}
