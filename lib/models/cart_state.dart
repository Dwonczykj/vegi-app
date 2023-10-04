import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/envService.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/cart/discount.dart';
import 'package:vegan_liverpool/models/cart/order.dart';
import 'package:vegan_liverpool/models/cart/productSuggestion.dart';
import 'package:vegan_liverpool/models/payments/live_payment.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/models/payments/stripe_payment_intent.dart';
import 'package:vegan_liverpool/models/restaurant/cartItem.dart';
import 'package:vegan_liverpool/models/restaurant/deliveryAddresses.dart';
import 'package:vegan_liverpool/models/restaurant/payment_methods.dart';
import 'package:vegan_liverpool/models/restaurant/time_slot.dart';
import 'package:vegan_liverpool/redux/viewsmodels/errorDetails.dart';
import 'package:vegan_liverpool/redux/viewsmodels/signUpErrorDetails.dart';

part 'cart_state.freezed.dart';
part 'cart_state.g.dart';

Map<String, dynamic> paymentInProcessToJson(
  LivePayment? paymentInProcess,
) =>
    paymentInProcess?.toJson() ?? {};

@Freezed()
class CartState with _$CartState {
  @JsonSerializable()
  factory CartState({
    @Default([]) List<CartItem> cartItems,
    @JsonKey(
      fromJson: Money.fromJson,
      toJson: Money.toJson,
    )
    @Default(Money.zeroGBP())
    Money cartSubTotal,
    @JsonKey(
      fromJson: Money.fromJson,
      toJson: Money.toJson,
    )
    @Default(Money.zeroGBP())
    Money cartTax,
    @JsonKey(
      fromJson: Money.fromJson,
      toJson: Money.toJson,
    )
    @Default(Money.zeroGBP())
    Money cartTotalWithoutGBTRewards,
    @JsonKey(
      fromJson: Money.fromJson,
      toJson: Money.toJson,
    )
    @Default(Money.zeroGBP())
    Money cartTotal,
    @Default(Currency.GBP) Currency cartCurrency,
    @Default(0) num cartDiscountPercent,
    @JsonKey(
      fromJson: Money.fromJson,
      toJson: Money.toJson,
    )
    @Default(Money.zeroGBP())
    Money cartDiscountComputed,
    @JsonKey(
      fromJson: Money.fromJson,
      toJson: Money.toJson,
    )
    @Default(Money.zeroGBP())
    Money voucherPotValue,
    @Default([]) List<Discount> appliedVouchers,
    @JsonKey(
      fromJson: Money.fromJson,
      toJson: Money.toJson,
    )
    @Default(Money.zeroGBP())
    Money selectedCashBackAppliedToCart,
    @Default([]) List<TimeSlot> deliverySlots,
    @Default([]) List<TimeSlot> collectionSlots,
    @Default(null) DeliveryAddresses? selectedDeliveryAddress,
    @Default(null) TimeSlot? selectedTimeSlot,
    @JsonKey(
      fromJson: Money.fromJson,
      toJson: Money.toJson,
    )
    @Default(Money.zeroGBP())
    Money selectedTipAmount,
    @Default('') String discountCode,
    @Default('') String paymentIntentID,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String paymentIntentClientSecret,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(null)
    StripePaymentIntent? paymentIntent,
    @Default('') String ephemeralKey,
    @Default('') String publishableKey,
    @Default(null) Order? order,
    @Default(0.0) double selectedGBPxAmount,
    @Default(0.0) double selectedPPLAmount,
    @Default(false) bool payButtonLoading,
    @Default(false) bool transferringTokens,
    @Default(false) bool errorCompletingPayment,
    @Default(false) bool confirmedPayment,
    @Default('') String restaurantName,
    @Default('') String restaurantID,
    @Default(false) bool restaurantIsLive,
    @Default(null) DeliveryAddresses? restaurantAddress,
    @Default('') String restaurantWalletAddress,
    @Default(FulfilmentMethodType.collection)
    FulfilmentMethodType fulfilmentMethod,
    @Default(0) int restaurantMinimumOrder,
    @JsonKey(
      fromJson: Money.fromJson,
      toJson: Money.toJson,
    )
    @Default(Money.zeroGBP())
    Money restaurantPlatformFee,
    @Default('') String deliveryInstructions,
    @Default(null) PaymentMethod? selectedPaymentMethod,
    @Default(null) PaymentMethod? preferredPaymentMethod,
    @Default([]) List<String> fulfilmentPostalDistricts,
    @Default([]) List<DateTime> eligibleOrderDates,
    @Default(null) TimeSlot? nextCollectionSlot,
    @Default(null) TimeSlot? nextDeliverySlot,
    @Default(null) ProductSuggestion? productSuggestion,
    @Default(OrderCreationProcessStatus.none)
    OrderCreationProcessStatus orderCreationProcessStatus,
    @Default('') String orderCreationStatusMessage,
    @Default(StripePaymentStatus.none) StripePaymentStatus stripePaymentStatus,
    @JsonKey(
      fromJson: LivePayment.fromJson,
      toJson: paymentInProcessToJson,
    )
    @Default(null)
    LivePayment? paymentInProcess,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isLoadingCartState,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(null)
    ErrorDetails<CartErrCode>? errorDetails,
  }) = _CartState;

  const CartState._();

  factory CartState.initial() => CartState(
        cartItems: [],
        cartDiscountPercent: 0.0,
        deliverySlots: [],
        collectionSlots: [],
        restaurantIsLive: !EnvService.isUsingProdServices,
        fulfilmentPostalDistricts: [],
        eligibleOrderDates: [],
        paymentInProcess: LivePayment.initial(),
        preferredPaymentMethod: Platform.isIOS
            ? PaymentMethod.applePay
            : Platform.isAndroid
                ? PaymentMethod.googlePay
                : PaymentMethod.stripe,
      );

  factory CartState.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$CartStateFromJson(json),
      );

  String get orderID => order?.id.toString() ?? '';

  bool get isDelivery => fulfilmentMethod == FulfilmentMethodType.delivery;
  bool get isCollection => fulfilmentMethod == FulfilmentMethodType.collection;
  bool get isInStore => fulfilmentMethod == FulfilmentMethodType.inStore;

  Future<Money> cartTotalInCurrency({
    required Currency inCurrency,
  }) async =>
      Money(
        currency: inCurrency,
        value: await convertCurrencyAmount(
          amount: cartTotal.value,
          fromCurrency: cartTotal.currency,
          toCurrency: inCurrency,
        ),
      );

  Future<Money> get cartTotalGBP async => Money(
        currency: Currency.GBP,
        value: await convertCurrencyAmount(
          amount: cartTotal.value,
          fromCurrency: cartTotal.currency,
        ),
      );

  Future<Money> platformFeeMoney({
    required Currency inCurrency,
  }) async =>
      Money(
        currency: inCurrency,
        value: await convertCurrencyAmount(
          amount: restaurantPlatformFee.value,
          fromCurrency: restaurantPlatformFee.currency,
          toCurrency: inCurrency,
        ),
      );

  Future<Money> get platformFeeGBP async => Money(
        currency: Currency.GBP,
        value: await convertCurrencyAmount(
          amount: restaurantPlatformFee.value,
          fromCurrency: restaurantPlatformFee.currency,
        ),
      );

  Future<Money> cartTipMoney({
    required Currency inCurrency,
  }) async =>
      Money(
        currency: inCurrency,
        value: await convertCurrencyAmount(
          amount: selectedTipAmount.value,
          fromCurrency: selectedTipAmount.currency,
          toCurrency: inCurrency,
        ),
      );

  Future<Money> get cartTipGBP async => Money(
        currency: Currency.GBP,
        value: await convertCurrencyAmount(
          amount: selectedTipAmount.value,
          fromCurrency: selectedTipAmount.currency,
        ),
      );

  Future<Money> fulfilmentChargeMoney({
    required Currency inCurrency,
  }) async =>
      Money(
        currency: inCurrency,
        value: await convertCurrencyAmount(
          amount: selectedTimeSlot?.priceModifier ?? 0.0,
          fromCurrency: Currency.GBPx,
          toCurrency: inCurrency,
        ),
      );

  Future<Money> get fulfilmentChargeGBP async => Money(
        currency: Currency.GBP,
        value: await convertCurrencyAmount(
          amount: selectedTimeSlot?.priceModifier ?? 0.0,
          fromCurrency: Currency.GBPx,
        ),
      );
}

class CartStateConverter
    implements JsonConverter<CartState, Map<String, dynamic>?> {
  const CartStateConverter();

  @override
  CartState fromJson(Map<String, dynamic>? json) => tryCatchRethrowInline(
        () => json != null ? CartState.fromJson(json) : CartState.initial(),
      );

  @override
  Map<String, dynamic> toJson(CartState instance) => instance.toJson();
}
