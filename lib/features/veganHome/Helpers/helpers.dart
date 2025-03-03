import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrier_info/carrier_info.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/authViewModel.dart';
import 'package:vegan_liverpool/models/cart/createOrderForFulfilment.dart';
import 'package:vegan_liverpool/models/cart/discount.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/models/restaurant/ESCRating.dart';
import 'package:vegan_liverpool/models/restaurant/cartItem.dart';
import 'package:vegan_liverpool/models/restaurant/productOptionValue.dart';
import 'package:vegan_liverpool/models/restaurant/restaurantMenuItem.dart';
import 'package:vegan_liverpool/models/restaurant/time_slot.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/menu_item_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/config.dart' as VEGI_CONFIG;
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
// import 'dart:developer';

// class ExampleClass {
//   void printFunctionFileInfo() {
//     if (!kIsWeb) {
//       // Code specific to non-web platforms using the imported package
//     }
//     var frames = StackTrace.current.toString().split('\n');
//     var filteredFrames = frames.where((frame) => !frame.contains('packages/'));

//     if (filteredFrames.length >= 4) {
//       var lastFourFrames = filteredFrames.take(4).toList().reversed;
//       print('Last 4 lines of callstack:');
//       for (var frame in lastFourFrames) {
//         print(frame);
//       }
//     } else {
//       print('Callstack contains less than 4 lines.');
//     }

//     var currentFrame = filteredFrames.first.split(' ');
//     var functionName = currentFrame[1];
//     var fileName = currentFrame[2];
//     var className = currentFrame[3].split('.')[0];

//     print('Current function: $functionName');
//     print('Current file: $fileName');
//     print('Current class: $className');
//   }
// }

class BoolThenRouteResult {
  const BoolThenRouteResult({
    required this.succeeded,
    this.navigationToRun,
  });

  factory BoolThenRouteResult.from({required bool succeeded}) =>
      BoolThenRouteResult(succeeded: succeeded);

  final Future<void> Function()? navigationToRun;
  final bool succeeded;
  bool get failed => !succeeded;
  bool get navigationNeeded => navigationToRun != null;

  Future<void> runNavigationIfNeeded() async {
    if (navigationNeeded) {
      return navigationToRun!();
    }
  }
}

BoolThenRouteResult checkAuth<T extends IAuthViewModel>({
  required T? oldViewModel,
  required T newViewModel,
  required BuildContext routerContext,
}) {
  Future<void> Function()? navigationToRun;
  final oldFirebaseAuthStatus = oldViewModel?.firebaseAuthenticationStatus ??
      FirebaseAuthenticationStatus.unauthenticated;
  final oldFuseAuthStatus = oldViewModel?.fuseAuthenticationStatus ??
      FuseAuthenticationStatus.unauthenticated;
  final oldVegiAuthStatus = oldViewModel?.vegiAuthenticationStatus ??
      VegiAuthenticationStatus.unauthenticated;

  // Remove fuseWalletAuthCheck
  // if (newViewModel.fuseAuthenticationStatus
  //     .isNewFailureStatus(oldFuseAuthStatus)) {
  //   if (routerContext.mounted) {
  //     navigationToRun =
  //         () => rootRouter.replace(const CreateWalletFirstOnboardingScreen());
  //   }
  //   log.error(
  //       'fuse auth has failed, investigate why this is happening...: status: FuseAuthenticationStatus[${newViewModel.fuseAuthenticationStatus.name}]');
  //   return BoolThenRouteResult(
  //     succeeded: false,
  //     navigationToRun: navigationToRun,
  //   );
  // }
  if (newViewModel.firebaseAuthenticationStatus
      .isNewFailureStatus(oldFirebaseAuthStatus)) {
    if (routerContext.mounted) {
      log.info(
        'Push SignUpScreen() due to failed status: FirebaseAuthenticationStatus.[${newViewModel.firebaseAuthenticationStatus.name}]',
      );
      debugPrintStack(
        label:
            'Push SignUpScreen() due to failed status: FirebaseAuthenticationStatus.[${newViewModel.firebaseAuthenticationStatus.name}]',
        maxFrames: 3,
      );
      navigationToRun = () => rootRouter.replace(
            const SignUpScreen(),
          ); //TODO: Remove this as should be taken care of from authentication action failure inside the thunk
    }
    return BoolThenRouteResult(
      succeeded: false,
      navigationToRun: navigationToRun,
    );
  }
  if (newViewModel.vegiAuthenticationStatus
      .isNewFailureStatus(oldVegiAuthStatus)) {
    log.error(
      'vegi auth has failed, investigate why this is happening...: status: ${newViewModel.vegiAuthenticationStatus.name}',
    );
    return BoolThenRouteResult(
      succeeded: false,
      navigationToRun: navigationToRun,
    );
  }
  return BoolThenRouteResult(
    succeeded: true,
    navigationToRun: navigationToRun,
  );
}

Future<T> delayed<T>(
  int delayMillis,
  FutureOr<T> Function() callback,
  dynamic Function() execNow,
) {
  execNow();
  return Future.delayed(
    Duration(milliseconds: delayMillis),
    callback,
  );
}

String cFPrice(int price) {
  //isPence ? price = price ~/ 100 : price;
  return '£${(price / 100).toStringAsFixed(2)}';
}

String cFPriceNoDec(int price) {
  //isPence ? price = price ~/ 100 : price;
  return '£${(price / 100).toStringAsFixed(0)}';
}

Color? colorForESCRating(num rating) {
  if (rating > 4) {
    return const Color.fromRGBO(105, 240, 174, 1);
  } else if (rating > 3) {
    return Color.fromARGB(255, 174, 223, 16);
  } else if (rating > 2) {
    return Color.fromARGB(255, 239, 246, 185);
  } else if (rating > 1) {
    return Color.fromARGB(255, 255, 202, 127);
  } else if (rating > 0) {
    return Color.fromARGB(255, 255, 169, 64);
  } else {
    return Color.fromARGB(255, 200, 66, 13);
  }
}

DateTime? intToTimeStampNullable(int? json) => tryCatchRethrowInline(
      () => json?.toTimeStamp(),
    );
DateTime intToTimeStamp(int json) => intToTimeStampNullable(json)!;
DateTime? jsonToTimeStampNullable(dynamic json) => tryCatchRethrowInline(
      () => json == null
          ? null
          : json is int
              ? json.toTimeStamp()
              : DateTime.parse(json.toString()),
    );
DateTime jsonToTimeStamp(dynamic json) => jsonToTimeStampNullable(json)!;
int? timeStampToJsonIntNullable(DateTime? json) => tryCatchRethrowInline(
      () => json?.millisecondsSinceEpoch,
    );
String? timeStampToJsonStringNullable(DateTime? json) => tryCatchRethrowInline(
      () => json?.formattedForAPI,
    );
int timeStampToJsonInt(DateTime json) => timeStampToJsonIntNullable(json)!;

int objectIdFromJson(dynamic obj) {
  if (obj is int) {
    return obj;
  } else if (obj is String && int.tryParse(obj) != null) {
    return int.parse(obj);
  }
  if (obj is Map) {
    if (obj.containsKey('id')) {
      return obj['id'] as int;
    }
  }
  throw Exception('unable to cast json object $obj to int');
}

int? objectIdFromJsonNullable(dynamic obj) {
  if (obj == null) {
    return null;
  }
  return objectIdFromJson(obj);
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

String decodeHex(String hex) {
  List<int> bytes = [];

  for (int i = 0; i < hex.length; i += 2) {
    try {
      String byteString = hex.substring(i, i + 2);
      int byte = int.parse(byteString, radix: 16);
      bytes.add(byte);
    } catch (e, s) {
      log.error(
        '',
        stackTrace: s,
      );
      i = hex.length;
    }
  }

  return utf8.decode(bytes);
}

double parseBalance(String balance) {
  return double.parse(balance.replaceAll('<', '').replaceAll(',', ''));
}

String formatDateForOrderObject(String date) {
  return date.replaceFirst('T', ' ').replaceFirst('.000Z', '');
}

String formatDate(DateTime dateToFormat) {
  final DateFormat formatter = DateFormat('HH:mm - EEE, dd MMM');

  return formatter.format(dateToFormat);
}

String formatDateForCalendar(DateTime dateToFormat) {
  final DateFormat formatter = DateFormat('EEE, dd MMM');

  return formatter.format(dateToFormat);
}

bool isScheduledDelivery(TimeSlot selectedSlot) {
  if (selectedSlot.startTime.difference(DateTime.now()).inHours >
      VEGI_CONFIG.ONGOING_ORDERS_COUNTDOWN_HOURS) {
    return true;
  } else {
    return false;
  }
}

bool shouldEndOngoing(TimeSlot selectedSlot) {
  if (selectedSlot.endTime.isBefore(DateTime.now())) {
    return true;
  } else {
    return false;
  }
}

double roundFloorGBP(double gbtValue) {
  return (gbtValue / 100.0).floorToDouble() * 100.0;
}

double getGBTValueFromPence(num penceAmount) {
  return getGBTValueFromPounds(penceAmount / 100);
}

double getGBTValueFromPounds(num poundAmount) {
  return poundAmount * CurrencyRateConstants.numberOfGBTInOneGBP;
}

double getPoundValueFromGBT(num gbtAmount) {
  return gbtAmount / CurrencyRateConstants.numberOfGBTInOneGBP;
}

double getGBTRewardsFromPounds(num gBPAmount) {
  return getGBTValueFromPounds(
    gBPAmount * CurrencyRateConstants.rewardsPcntDelivery,
  );
}

double getGBTRewardsFromPence(num penceAmount) =>
    getGBTRewardsFromPounds(penceAmount / 100);

int calculateRewardsForPrice({
  required num penceAmount,
  required ESCRating? rating,
  required FulfilmentMethodType fulfilmentMethod,
}) {
  return ((Math.max(
                Math.min(
                  rating?.rating ?? 0,
                  CurrencyRateConstants.maxESCRating,
                ),
                CurrencyRateConstants.minESCRating,
              ) /
              CurrencyRateConstants.maxESCRating) *
          penceAmount *
          (fulfilmentMethod == FulfilmentMethodType.inStore
              ? CurrencyRateConstants.rewardsPcntPoS
              : CurrencyRateConstants.rewardsPcntDelivery))
      .floor();
  // return penceAmount * (fulfilmentMethod == FulfilmentMethodType.inStore ? 1 : 5) ~/ 100;
}

double calculateCartRewardsForPrice({
  required Iterable<CartItem> items,
  required FulfilmentMethodType fulfilmentMethod,
}) {
  final x = items.map(
    (item) {
      return (Math.max(
                Math.min(
                  item.menuItem.rating?.rating ?? 0,
                  CurrencyRateConstants.maxESCRating,
                ),
                CurrencyRateConstants.minESCRating,
              ) /
              CurrencyRateConstants.maxESCRating) *
          item.totalItemPrice.inGBPxValue *
          (fulfilmentMethod == FulfilmentMethodType.inStore
              ? CurrencyRateConstants.rewardsPcntPoS
              : CurrencyRateConstants.rewardsPcntDelivery);
    },
  ).reduce((value, element) => value + element);
  return x;
}

double calculateRewardsForOrder(CreateOrderForFulfilment order) {
  return calculateCartRewardsForPrice(
    items: order.items,
    fulfilmentMethod: order.fulfilmentTypeString,
  );
}

String getPoundValueFormattedFromGBT(num gbtAmount) {
  return getPoundValueFromGBT(gbtAmount).toStringAsFixed(2);
}

Future<UpdateTotalPrice> calculateMenuItemPrice({
  required RestaurantMenuItem menuItem,
  required int quantity,
  bool inStore = false,
  Iterable<ProductOptionValue> productOptions = const [],
}) async {
  // var total = quantity * (await menuItem.priceGBP).value;
  var total = menuItem.price * quantity;

  productOptions.forEach((element) async {
    total += (await element.priceGBP).value;
  });

  return UpdateTotalPrice(
    totalPrice: total,
    totalRewards: total.inGBPxValue *
        (inStore
                ? CurrencyRateConstants.rewardsPcntPoS
                : CurrencyRateConstants.rewardsPcntDelivery)
            .truncate(),
  );
}

Future<UpdateComputedCartValues?> computeTotalsFromCart({
  required List<CartItem> cartItems,
  required Money fulfilmentCharge,
  required Money platformFee,
  required num cartDiscountPercent,
  required Money cartTip,
  required Currency cartCurrency,
  required int vendorId,
  List<Discount> appliedVouchers = const <Discount>[],
}) async {
  try {
    final store = await reduxStore;
    final Money cartTax = Money.zero(inCurrency: cartCurrency);
    Money cartTotal = Money.zero(inCurrency: cartCurrency);
    Money cartSubTotal = Money.zero(inCurrency: cartCurrency);
    Money cartPcntDiscountComputed = Money.zero(inCurrency: cartCurrency);
    Money cartTotalWithoutGBTRewards = Money.zero(inCurrency: cartCurrency);
    Money cartTotalDiscountComputed = Money.zero(inCurrency: cartCurrency);

    for (final element in cartItems) {
      cartSubTotal +=
          (await element.totalItemPriceInCurrency(inCurrency: cartCurrency))
              .value;
    }

    cartPcntDiscountComputed =
        (cartSubTotal * cartDiscountPercent) ~/ 100; // subtotal * discount

    // final currenciesToConvert = appliedVouchers.map((discount) => discount.currency).toSet();

    num voucherPot = 0.0;
    for (final discount in appliedVouchers) {
      if ([
        '',
        vendorId.toString(),
      ].contains(discount.vendor?.id.toString() ?? '')) {
        if (discount.currency == cartCurrency) {
          voucherPot += discount.value;
        } else {
          voucherPot += await convertCurrencyAmount(
            amount: discount.value,
            fromCurrency: discount.currency,
            toCurrency: cartCurrency,
          );
        }
      }
    }

    // final voucherPot = appliedVouchers.sum(
    //   (previousValue, discount) =>
    //       ([
    //         '',
    //         vendorId.toString(),
    //       ].contains(discount.vendor?.id.toString() ?? '')
    //           ? discount.currency == cartCurrency
    //               ? discount.value
    //               : (await convertCurrencyAmount(
    //                   amount: discount.value,
    //                   fromCurrency: discount.currency,
    //                   toCurrency: cartCurrency,
    //                 ))
    //           : 0.0) +
    //       previousValue,
    // );

    final cashbackGBTAppliedToBasket = store
        .state.cartState.selectedCashBackAppliedToCart
        .inCcy(cartCurrency)
        .value;

    cartTotalDiscountComputed = cartPcntDiscountComputed + voucherPot;

    cartTotalWithoutGBTRewards = (cartSubTotal +
            cartTax.inCcy(cartCurrency).value +
            cartTip.inCcy(cartCurrency).value +
            fulfilmentCharge.inCcy(cartCurrency).value +
            platformFee.inCcy(cartCurrency).value) -
        cartTotalDiscountComputed.inCcy(cartCurrency).value;

    cartTotal = cartTotalWithoutGBTRewards - cashbackGBTAppliedToBasket;

    if (cartItems.isEmpty) {
      cartSubTotal = Money.zero(inCurrency: cartCurrency);
      cartTotal = Money.zero(inCurrency: cartCurrency);
      cartPcntDiscountComputed = Money.zero(inCurrency: cartCurrency);
      cartTotalWithoutGBTRewards = Money.zero(inCurrency: cartCurrency);
      cartTotalDiscountComputed = Money.zero(inCurrency: cartCurrency);
    }

    return UpdateComputedCartValues(
      cartSubTotal,
      cartTax,
      cartTotal,
      cartTotalWithoutGBTRewards,
      cartTotalDiscountComputed,
    );
  } catch (e, s) {
    log.error(
      'ERROR - computeCartTotals $e',
      stackTrace: s,
    );
    return null;
  }
}

///
///  Gives an amount of 1[fromCurrency] in [toCurrency]
///
/// @returns {Promise<number>}
///
num getInternalCurrencyConversionRateSync({
  required Currency fromCurrency,
  required Currency toCurrency,
}) {
  if (fromCurrency == toCurrency) {
    return 1.0;
  }
  if (fromCurrency == Currency.GBP) {
    if (toCurrency == Currency.GBPx) {
      return 1.0 / CurrencyRateConstants.GBPxPoundPegValue;
    } else if (toCurrency == Currency.GBT) {
      return 1.0 / CurrencyRateConstants.GBTPoundPegValue;
    } else if (toCurrency == Currency.PPL) {
      return 1.0 / CurrencyRateConstants.PPLPoundPegValue;
    } else if (toCurrency == Currency.USD || toCurrency == Currency.EUR) {
      throw Exception(
        'Requested a currency conversion from getInternalCurrencyConversionRateSync but toCurrency: $toCurrency is not an internal currency.',
      );
    } else {
      log.error(
        'Unsupported currencies requested from helpers.getCurrencyConversionRate of fromCurrency: $fromCurrency, toCurrency: $toCurrency.',
        stackTrace: StackTrace.current,
      );
      return 0.0;
    }
  } else if (toCurrency == Currency.GBP) {
    return 1.0 /
        (getInternalCurrencyConversionRateSync(
          fromCurrency: toCurrency,
          toCurrency: fromCurrency,
        ));
  } else {
    return (getInternalCurrencyConversionRateSync(
          fromCurrency: fromCurrency,
          toCurrency: Currency.GBP,
        )) *
        (getInternalCurrencyConversionRateSync(
          fromCurrency: Currency.GBP,
          toCurrency: toCurrency,
        ));
  }
}

///
///  Gives an amount of 1[fromCurrency] in [toCurrency]
///
/// @returns {Promise<number>}
///
Future<num> getCurrencyConversionRate({
  required Currency fromCurrency,
  required Currency toCurrency,
}) async {
  if (fromCurrency == toCurrency) {
    return 1.0;
  }

  if (fromCurrency == Currency.GBP) {
    if (toCurrency == Currency.GBPx) {
      return 1.0 / CurrencyRateConstants.GBPxPoundPegValue;
    } else if (toCurrency == Currency.GBT) {
      return 1.0 / CurrencyRateConstants.GBTPoundPegValue;
    } else if (toCurrency == Currency.PPL) {
      return 1.0 / CurrencyRateConstants.PPLPoundPegValue;
    } else if (toCurrency == Currency.USD || toCurrency == Currency.EUR) {
      final liveRate = await fxService.getFXRate(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
      );

      return liveRate;
    } else {
      log.error(
        'Unsupported currencies requested from helpers.getCurrencyConversionRate of fromCurrency: $fromCurrency, toCurrency: $toCurrency.',
        stackTrace: StackTrace.current,
      );
      return 0.0;
    }
  } else if (toCurrency == Currency.GBP) {
    return 1.0 /
        (await getCurrencyConversionRate(
          fromCurrency: toCurrency,
          toCurrency: fromCurrency,
        ));
  } else {
    return (await getCurrencyConversionRate(
          fromCurrency: fromCurrency,
          toCurrency: Currency.GBP,
        )) *
        (await getCurrencyConversionRate(
          fromCurrency: Currency.GBP,
          toCurrency: toCurrency,
        ));
  }
}

num convertInternalCurrencyAmount({
  required num amount,
  required Currency fromCurrency,
  Currency toCurrency = Currency.GBP,
}) {
  if (amount == 0) {
    return 0.0;
  }
  return amount *
      (getInternalCurrencyConversionRateSync(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
      ));
}

Future<num> fxAmount({
  required num amount,
  required Currency fromCurrency,
  Currency toCurrency = Currency.GBP,
}) async {
  if (amount == 0) {
    return 0.0;
  }
  return amount *
      (await getCurrencyConversionRate(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
      ));
  // var amountGBP = amount; // DEFAULT GBP CASE
  // if (fromCurrency == Currency.EUR || fromCurrency == Currency.USD) {
  //   throw Exception(
  //     'Not implemented cart totals for fromCurrency: $fromCurrency',
  //   );
  // } else if (fromCurrency == Currency.GBPx) {
  //   amountGBP = amount * 100;
  // } else if (fromCurrency == Currency.PPL) {
  //   amountGBP = getPoundValueFromPPL(amount);
  // } else if (fromCurrency == Currency.GBP) {
  //   amountGBP = amount;
  // } else if (fromCurrency == Currency.GBT) {
  //   throw Exception(
  //       'Not implemented cart totals for fromCurrency: $fromCurrency');
  // }

  // if (toCurrency == Currency.EUR ||
  //     toCurrency == Currency.USD ||
  //     toCurrency == Currency.GBT) {
  //   throw Exception('Not implemented cart totals for toCurrency: $toCurrency');
  // } else if (toCurrency == Currency.GBPx) {
  //   return amountGBP * 100;
  // } else if (toCurrency == Currency.PPL) {
  //   return getPPLValueFromPounds(amountGBP);
  // } else if (toCurrency == Currency.GBP) {
  //   return amountGBP;
  // } else {
  //   throw Exception('Not implemented cart totals for toCurrency: $toCurrency');
  // }
}

const convertCurrencyAmount = fxAmount;

// Conversion
// 1000GBP => 100,000 => 10,000 PPL Tokens
// 1GBP => 100 pence => 10 PPL tokens

// Reward Conversion Rate (5% reward)
// 1GBP => 100 pence => 5 pence => 0.5 PPL
// 1000GBP => 100,000 pence => 5000 pence => 500 PPL Tokens

String getErrorMessageForOrder(String errorCode) {
  switch (errorCode) {
    case 'invalidVendor':
      return 'This vendor is currently not delivering!';
    case 'invalidFulfilmentMethod':
      return 'This vendor is not currently accepting delivery/collection orders';
    case 'invalidProduct':
      return 'This product is not currently avaliable!';
    case 'invalidProductOption':
      return 'This option is not currently avaliable!';
    case 'invalidPostalDistrict':
      return 'The vendor does not delivery to this location, sorry!';
    case 'invalidSlot':
      return 'This slot is full. Please choose another slot!';
    case 'invalidDiscountCode':
      return 'The discount code entered is invalid, sorry!';
    case 'invalidUserAddress':
      return 'The address entered is invalid, sorry!';
    default:
      return 'Something went wrong: $errorCode';
  }
}

Future<String> getFileSizeDescriptor(File file, int decimals) async {
  final bytes = await file.length();
  if (bytes <= 0) return '0 B';
  const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  final i = (Math.log(bytes) / Math.log(1024)).floor();
  return '${(bytes / Math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

double getFileSizeMB(File? file) => (file?.lengthSync() ?? 0) / (1024 * 1024);

double triangleArea(
  Offset p1,
  Offset p2,
  Offset p3,
) =>
    0.5 *
    ((p1.dx * (p2.dy - p3.dy)) +
        (p2.dx * (p3.dy - p1.dy)) +
        (p3.dx * (p1.dy - p2.dy)));

double rectArea(
  Offset p1,
  Offset p2,
  Offset p3,
  Offset p4,
) =>
    triangleArea(p1, p2, p3) + triangleArea(p2, p3, p4);

Future<Size> calculateImageDimensionFromUrl({
  required String imageUrl,
}) async {
  final completer = Completer<Size>();
  final image = Image(
    image: CachedNetworkImageProvider(
      imageUrl,
    ),
  ); // I modified this line
  const imageConfig = ImageConfiguration.empty;
  image.image.resolve(imageConfig).addListener(
    ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        final myImage = image.image;
        final size = Size(myImage.width.toDouble(), myImage.height.toDouble());
        if (!completer.isCompleted) {
          completer.complete(size);
        }
      },
    ),
  );
  return completer.future;
}

Future<Size> calculateImageDimension({
  required Image image,
}) {
  final completer = Completer<Size>();
  const imageConfig = ImageConfiguration.empty;
  image.image.resolve(imageConfig).addListener(
    ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        final myImage = image.image;
        final size = Size(myImage.width.toDouble(), myImage.height.toDouble());
        completer.complete(size);
      },
    ),
  );
  return completer.future;
}

T tryCatchInline<T>(
  T Function() callback,
  T defaultResult, {
  bool silent = false,
}) {
  try {
    return callback();
  } catch (e, s) {
    if (!silent) {
      log.error(
        e,
        stackTrace: s,
      );
    }
    return defaultResult;
  }
}

T tryCatchRethrowInline<T>(
  T Function() callback,
) {
  try {
    return callback();
  } catch (e, s) {
    log.error(
      e,
      stackTrace: s,
    );
    rethrow;
  }
}

T? Function(dynamic) fromSailsObjectJson<T>(
  T Function(Map<String, dynamic> json) fromJson,
) =>
    (
      dynamic json,
    ) =>
        tryCatchRethrowInline(
          () => json is int || json == null || (json is Map && json.isEmpty)
              ? null
              : fromJson(json as Map<String, dynamic>),
        );

List<T> Function(dynamic) fromSailsListOfObjectJson<T>(
  T Function(Map<String, dynamic> json) fromJson,
) {
  List<T> fn(dynamic json) {
    if (json is Iterable) {
      return json
          .map((e) => fromSailsObjectJson<T>(fromJson)(e))
          .where((e) => e != null)
          .cast<T>()
          .toList();
    } else {
      return [];
    }
  }

  return fn;
}

Future<SetPhoneNumberSuccess?> getPhoneDetails({
  required String countryCodeString,
  required String phoneNoCountry,
}) async {
  final countryCode0 = await parseCountryCode(countryCode: countryCodeString);
  if (countryCode0 == null) {
    log.info(
      'Unable to parse country code from string: "$countryCodeString"',
      stackTrace: StackTrace.current,
    );
    return null;
  }
  final phoneNumber = await parsePhoneDetails(
    countryCode: countryCode0,
    phoneNoCountry: phoneNoCountry,
  );
  if (phoneNumber == null) {
    log.info(
      'Unable to parse phone number from string: "$phoneNoCountry"',
      stackTrace: StackTrace.current,
    );
    return null;
  }

  return SetPhoneNumberSuccess(
    countryCode: countryCode0,
    phoneNumber: phoneNumber,
  );
}

Future<PhoneNumber?> parsePhoneDetails({
  required CountryCode countryCode,
  required String phoneNoCountry,
}) async {
  PhoneNumber? phoneNumber;

  final String phoneNumber0 = '${countryCode.dialCode}$phoneNoCountry';

  if (phoneNoCountry == "0000000000") {
    log.debug(
        "parsePhoneDetails helper received the Zero phone number $phoneNoCountry");
    return null;
  }

  try {
    phoneNumber = await phoneNumberUtil.parse(
      phoneNumber0,
    );
  } catch (e) {
    // do nothing and try again....
  }
  if (phoneNumber != null) {
    return phoneNumber;
  } else {
    final validation = await phoneNumberUtil.validate(phoneNumber0);
  }

  try {
    phoneNumber ??= await PhoneNumberUtil().parse(
      phoneNoCountry,
      regionCode: countryCode.code,
    );
  } on Exception catch (e, s) {
    log.error(
      'Failed to parse phoneNumber "$phoneNoCountry": $e',
      stackTrace: s,
    );
    return null;
  }

  return phoneNumber;
}

Future<CountryCode?> parseCountryCode({
  required String countryCode,
}) async {
  try {
    var localeData = codes.firstWhereExists(
      (element) =>
          element['code'].toString().toUpperCase() == countryCode.toUpperCase(),
    );
    if (localeData != null) {
      return CountryCode(
        dialCode: localeData['dial_code'],
        code: localeData['code'],
      );
    }
    String? isoCode = 'GB';
    if (Platform.isAndroid) {
      final androidInfo = await CarrierInfo.getAndroidInfo();
      if ((androidInfo?.telephonyInfo.length ?? 0) >= 1) {
        isoCode = androidInfo?.telephonyInfo[0].isoCountryCode;
      }
    }
    if (Platform.isIOS) {
      final iosInfo = await CarrierInfo.getIosInfo();
      if (iosInfo.carrierData.isNotEmpty) {
        isoCode = iosInfo.carrierData[0].isoCountryCode;
      }
    }
    final currentCountryCode = isoCode ?? 'GB';
    localeData = codes.firstWhere(
      (Map<String, String> code) =>
          code['code'].toString().toLowerCase() ==
          currentCountryCode.toLowerCase(),
    );
    if (localeData.containsKey('dial_code') && localeData.containsKey('code')) {
      // check that country code below is correct for +1
      return CountryCode(
        dialCode: localeData['dial_code'],
        code: localeData['code'],
      );
    }
  } catch (e, s) {
    log.error(
      'Failed to deduce sim country code from inputCode: "$countryCode": $e',
      stackTrace: s,
    );
    return null;
  }
  return null;
}

String authEnumToEmoji(Enum value) {
  if (value.name == VegiAuthenticationStatus.authenticated.name) {
    return '✅';
  } else if (value.name == VegiAuthenticationStatus.failed.name) {
    return '❌';
  } else if (value.name == VegiAuthenticationStatus.unauthenticated.name) {
    return '🔒';
  } else if (value.name == VegiAuthenticationStatus.loading.name) {
    return '⏳';
  } else if (value.name.toLowerCase().contains('failed')) {
    return '🚨';
  } else {
    return value.name;
  }
}

FutureOr<T>? Function() logAndPipe<T>(
  FutureOr<T>? Function() fn, {
  String? funcName,
  String? className,
  String logMessage = '',
}) =>
    () => logFunctionCall(
          className: className,
          funcName: funcName,
          logMessage: logMessage,
          funcResult: fn(),
        );

/// The `logFunctionCall` function logs the name of a function and the class it belongs to, along with
/// an optional message, and returns the result of the function.
///
/// Args:
///   funcResult (FutureOr<T>): The result of the function call, which can be a Future or a value of
/// type T.
///   funcName (String): The `funcName` parameter is a string that represents the name of the function
/// being called.
///   className (String): The `className` parameter is used to specify the name of the class where the
/// function is being called from.
///   logMessage (String): The `logMessage` parameter is a string that represents an additional message
/// to be included in the log statement. It is optional and has a default value of an empty string.
///
/// Returns:
///   a `FutureOr<T>?` object.
FutureOr<T>? logFunctionCall<T>({
  FutureOr<T>? funcResult,
  String? funcName,
  String? className,
  String logMessage = '',
}) {
  try {
    final className_ = className ??
        StackTrace.current.getStackLine(lineNumberBase1: 2)?.className ??
        '';
    final funcName_ = funcName ??
        StackTrace.current.getStackLine(lineNumberBase1: 2)?.functionName ??
        '';
    log.info(
      '$funcName_ called in $className_ class. $logMessage',
      stackTrace: StackTrace.current,
      sentry: true,
    );
  } on Exception catch (error, stack) {
    log.error(
      'Unable to logFunctionCall as StackTrace info does not exist: $error',
      error: error,
      stackTrace: stack,
    );
  }
  return funcResult;
}

T Function() withHelloWorld<T>(T Function() function) {
  return () {
    log.verbose('The method ${getFunctionName(function)} was called.');
    return function();
  };
}

String getFunctionName(Function function) {
  // The function.toString() returns something like "Closure: () => dynamic from Function 'functionName'"
  final stringRepresentation = function.toString();
  final start = stringRepresentation.indexOf("'") + 1;
  final end = stringRepresentation.lastIndexOf("'");
  if (end <= start) {
    return stringRepresentation;
  }
  return stringRepresentation.substring(start, end);
}

Widget debugWidgetWrap({
  required Widget child,
  Color fillColor = Colors.transparent,
  Color borderColor = Colors.purple,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: borderColor,
        width: 4,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    child: ColoredBox(
      color: fillColor,
      child: child,
    ),
  );
}
