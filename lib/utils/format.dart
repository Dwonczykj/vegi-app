import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:number_display/number_display.dart';
import 'package:vegan_liverpool/models/tokens/price.dart';
import 'package:vegan_liverpool/models/tokens/token.dart';

class Formatter {
  static Decimal fromWei(
    BigInt value,
    int decimals,
  ) =>
      (Decimal.fromBigInt(
                value,
              ) /
              Decimal.fromBigInt(
                BigInt.from(
                  pow(10, decimals),
                ),
              ))
          .toDecimal();

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return Decimal.tryParse(s) != null;
  }

  static bool isSmallThan(Decimal value, [num valueToCompareWith = 0.01]) {
    return value.compareTo(Decimal.zero) == 1 &&
        value.compareTo(Decimal.parse(valueToCompareWith.toString())) <= 0;
  }

  static String smallNumbersConvertor(Decimal value) {
    if (isSmallThan(value)) {
      return '< 0.01';
    }
    return display2(value.toDouble());
  }

  static String formatValue(
    BigInt value,
    int decimals, [
    bool withPrecision = false,
  ]) {
    final Decimal formattedValue = fromWei(value, decimals);
    if (withPrecision) return formattedValue.toStringAsFixed(8);
    return smallNumbersConvertor(formattedValue);
  }

  static String amountPrinter(
    BigInt value,
    int decimals,
    Price? priceInfo, [
    bool withPrecision = false,
  ]) {
    final bool hasPriceInfo =
        ![null, '', '0', 0, 'NaN'].contains(priceInfo?.quote);
    if (hasPriceInfo) {
      return '\$${formatValueToFiatFormatted(
        value,
        decimals,
        double.parse(priceInfo!.quote),
        withPrecision,
      )}';
    } else {
      return formatValue(
        value,
        decimals,
        withPrecision,
      );
    }
  }

  static Decimal formatValueToFiatAmount(
    BigInt valueWEI,
    int decimals,
    double price,
  ) {
    final Decimal formattedValue =
        fromWei(valueWEI, decimals) * Decimal.parse(price.toString());
    return formattedValue;
  }

  static String formatValueToFiatFormatted(
    BigInt valueWEI,
    int decimals,
    double price, [
    bool withPrecision = false,
  ]) {
    final Decimal formattedValue =
        fromWei(valueWEI, decimals) * Decimal.parse(price.toString());
    if (withPrecision) return formattedValue.toStringAsFixed(8);
    return smallNumbersConvertor(formattedValue);
  }

  static String formatEthAddress(String? address, [int endIndex = 6]) {
    if (address == null || address.isEmpty) return '';
    return '${address.substring(0, endIndex)}...${address.substring(address.length - 4, address.length)}';
  }

  /// convert number of tokens to number of WEI
  static BigInt toBigInt(dynamic value, int? decimals) {
    if (value == null || decimals == null) return BigInt.zero;
    final Decimal tokensAmountDecimal = Decimal.parse(value.toString());
    final Decimal decimalsPow = Decimal.parse(pow(10, decimals).toString());
    return BigInt.parse((tokensAmountDecimal * decimalsPow).toString());
  }

  /// convert number of tokens to number of WEI
  static BigInt toAmountWEI(
    dynamic value, {
    required Token token,
  }) {
    final decimals = token.decimals;
    if (value == null) return BigInt.zero;
    final Decimal tokensAmountDecimal = Decimal.parse(value.toString());
    final Decimal decimalsPow = Decimal.parse(pow(10, decimals).toString());
    return BigInt.parse((tokensAmountDecimal * decimalsPow).toString());
  }

  static String formatTokenName(String tokenName) {
    if (tokenName.endsWith('on Fuse')) {
      final List splitted = tokenName.split(' ')
        ..removeWhere((ele) => ele == 'on' || ele == 'Fuse');
      return splitted.join(' ');
    }
    return tokenName;
  }
}

final Display display1 = createDisplay(
  decimal: 1,
);

final Display display2 = createDisplay(
  decimal: 2,
);

final Display display4 = createDisplay(
  decimal: 4,
);

final Display display6 = createDisplay(
  decimal: 4,
);

final Map<String, num> fees = {
  'DZAR': 17,
  'DAI': 1,
  'USDT': 1,
  'USDC': 1,
  'IDRT': 14442.61,
  'EURS': 1,
  'TUSD': 1,
};

num getPercentChange(num valueNow, num value24HoursAgo) {
  final adjustedPercentChange =
      ((valueNow - value24HoursAgo) / value24HoursAgo) * 100;
  if (adjustedPercentChange.isNaN || !adjustedPercentChange.isFinite) {
    return 0;
  }
  return adjustedPercentChange;
}
