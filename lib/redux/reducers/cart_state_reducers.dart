import 'package:redux/redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/envService.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/admin/uploadProductSuggestionImageResponse.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/models/cart_state.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';

final cartStateReducers = combineReducers<CartState>([
  TypedReducer<CartState, LogoutRequestSuccess>(_logoutSuccess).call,
  TypedReducer<CartState, ResetAppState>(_resetApp).call,
  TypedReducer<CartState, UpdateCartItems>(_updateCartItems).call,
  TypedReducer<CartState, UpdateCartItem>(_updateCartItem).call,
  TypedReducer<CartState, UpdateComputedCartValues>(_computeCartTotals).call,
  TypedReducer<CartState, UpdateCartDiscount>(_updateCartDiscount).call,
  TypedReducer<CartState, UpdateSelectedCashBackAppliedToCart>(
          _updateCartSelectedCashBack)
      .call,
  TypedReducer<CartState, AddValidVoucherCodeToCart>(
    _addValidVoucherCodeToCart,
  ).call,
  TypedReducer<CartState, RemoveVoucherCodeFromCart>(
    _removeVoucherCodeFromCart,
  ).call,
  TypedReducer<CartState, ClearCart>(_clearCart).call,
  TypedReducer<CartState, UpdateSlots>(_updateSlots).call,
  TypedReducer<CartState, OrderCreationProcessStatusUpdate>(
    _updateOrderCreationProcessStatus,
  ).call,
  TypedReducer<CartState, StripePaymentStatusUpdate>(
    _updateStripePaymentStatus,
  ).call,
  TypedReducer<CartState, UpdateSelectedTimeSlot>(_updateSelectedTimeSlot).call,
  TypedReducer<CartState, UpdateTipAmount>(_updateTipAmount).call,
  TypedReducer<CartState, UpdateSelectedDeliveryAddress>(
    _updateSelectedDeliveryAddress,
  ).call,
  TypedReducer<CartState, CreateOrder>(_createOrder).call,
  TypedReducer<CartState, CancelOrder>(_cancelOrder).call,
  TypedReducer<CartState, SetTransferringPayment>(_toggleTransfer).call,
  TypedReducer<CartState, SetError>(_toggleError).call,
  TypedReducer<CartState, SetCartErrorResolved>(_setCartErrorResolved).call,
  TypedReducer<CartState, SetCartError>(_setCartError).call,
  TypedReducer<CartState, SetCartIsLoading>(_setCartIsLoading).call,
  TypedReducer<CartState, SetConfirmed>(_toggleConfirmed).call,
  TypedReducer<CartState, UpdateSelectedAmounts>(_updateSelectedAmounts).call,
  TypedReducer<CartState, SetRestaurantDetails>(_setRestaurantDetails).call,
  TypedReducer<CartState, SetFulfilmentMethod>(_setFulfilmentMethodType).call,
  TypedReducer<CartState, SetDeliveryInstructions>(
    _setDeliveryInstructions,
  ).call,
  TypedReducer<CartState, SetPaymentMethod>(_setPaymentMethod).call,
  TypedReducer<CartState, SetPaymentButtonFlag>(_setPaymentButtonFlag).call,
  TypedReducer<CartState, UpdateEligibleOrderDates>(
    _updateEligibleOrderDates,
  ).call,
  TypedReducer<CartState, UpdateNextAvaliableTimeSlots>(
    _updateNextAvaliableSlots,
  ).call,
  TypedReducer<CartState, AddImageToProductSuggestionRTO>(
    _addImageToProductSuggestion,
  ).call,
  TypedReducer<CartState, AddQRCodeToProductSuggestionRTO>(
    _addQRCodeToProductSuggestion,
  ).call,
  TypedReducer<CartState, AddAdditionalInformationToProductSuggestionRTO>(
    _addAdditionalInfoToProductSuggestion,
  ).call,
  TypedReducer<CartState, AddProductNameToProductSuggestionRTO>(
    _addProductNameToProductSuggestion,
  ).call,
  TypedReducer<CartState, CreateProductSuggestion>(
    _createProductSuggestion,
  ).call,
  TypedReducer<CartState, OrderPaymentAttemptCreated>(
    _orderPaymentAttemptCreated,
  ).call,
]);

CartState _logoutSuccess(
  CartState state,
  LogoutRequestSuccess action,
) =>
    CartState.initial();

CartState _resetApp(
  CartState state,
  ResetAppState action,
) {
  return CartState.initial();
}

CartState _updateCartItems(
  CartState state,
  UpdateCartItems action,
) {
  return state.copyWith(cartItems: action.cartItems);
}

CartState _updateCartItem(
  CartState state,
  UpdateCartItem action,
) {
  return state.copyWith(
    cartItems: state.cartItems
        .where(
          (element) => element.id != action.cartItem.id,
        )
        .toList()
      ..add(action.cartItem),
  );
}

CartState _computeCartTotals(
  CartState state,
  UpdateComputedCartValues action,
) {
  return state.copyWith(
    cartCurrency: action.cartTotal.currency,
    cartSubTotal: action.cartSubTotal,
    cartTax: action.cartTax,
    cartTotal: action.cartTotal,
    cartTotalWithoutGBTRewards: action.cartTotalWithoutGBTRewards,
    cartDiscountComputed: action.cartDiscountComputed,
  );
}

CartState _clearCart(
  CartState state,
  ClearCart action,
) {
  return state.copyWith(
    cartItems: [],
    cartSubTotal: Money.zero(inCurrency: state.cartCurrency),
    cartTax: Money.zero(inCurrency: state.cartCurrency),
    cartTotal: Money.zero(inCurrency: state.cartCurrency),
    cartDiscountPercent: 0.0,
    cartTotalWithoutGBTRewards: Money.zero(inCurrency: state.cartCurrency),
    cartDiscountComputed: Money.zero(inCurrency: state.cartCurrency),
    selectedTimeSlot: null,
    selectedTipAmount: Money.zero(inCurrency: state.cartCurrency),
    discountCode: '',
    selectedDeliveryAddress: null,
    paymentIntentID: '',
    paymentIntent: null,
    ephemeralKey: '',
    publishableKey: '',
    paymentIntentClientSecret: '',
    order: null,
    selectedGBPxAmount: 0,
    selectedPPLAmount: 0,
    transferringTokens: false,
    errorCompletingPayment: false,
    confirmedPayment: false,
    payButtonLoading: false,
    restaurantName: '',
    restaurantID: '',
    restaurantIsLive: !EnvService.isUsingProdServices,
    restaurantAddress: null,
  );
}

CartState _updateCartDiscount(
  CartState state,
  UpdateCartDiscount action,
) {
  return state.copyWith(
    cartDiscountPercent: action.cartDiscountPercent,
    discountCode: action.discountCode,
  );
}

CartState _updateCartSelectedCashBack(
  CartState state,
  UpdateSelectedCashBackAppliedToCart action,
) {
  return state.copyWith(
    selectedCashBackAppliedToCart: action.applyCashBack,
  );
}

CartState _addValidVoucherCodeToCart(
  CartState state,
  AddValidVoucherCodeToCart action,
) {
  final appliedVouchers = [
    ...state.appliedVouchers.where(
      (element) =>
          element.code != action.voucher.code &&
          element.discountType != action.voucher.discountType,
    ),
    action.voucher
  ];
  num potValue = 0.0;
  final thisCurrency = action.voucher.currency;
  if (action.voucher.vendor != null) {
    potValue = appliedVouchers.sum(
      (previousValue, discount) =>
          ((discount.vendor?.id ?? '') == (action.voucher.vendor?.id ?? '') &&
                  discount.currency == thisCurrency
              ? discount.value
              : 0.0) +
          previousValue,
    );
  }
  return state.copyWith(
    voucherPotValue: Money(
      currency: thisCurrency,
      value: potValue,
    ),
    appliedVouchers: appliedVouchers,
  );
}

CartState _removeVoucherCodeFromCart(
  CartState state,
  RemoveVoucherCodeFromCart action,
) {
  final appliedVouchers = state.appliedVouchers
      .where(
        (element) =>
            element.code != action.voucher.code &&
            element.discountType != action.voucher.discountType,
      )
      .toList();

  num potValue = 0.0;
  final thisCurrency = action.voucher.currency;
  if (action.voucher.vendor != null) {
    potValue = appliedVouchers.sum(
      (previousValue, discount) =>
          ((discount.vendor?.id.toString() ?? '') ==
                      (action.voucher.vendor?.id.toString() ?? '') &&
                  discount.currency == thisCurrency
              ? discount.value
              : 0.0) +
          previousValue,
    );
  }
  return state.copyWith(
    voucherPotValue: Money(
      currency: thisCurrency,
      value: potValue,
    ),
    appliedVouchers: appliedVouchers,
  );
}

CartState _updateSlots(
  CartState state,
  UpdateSlots action,
) {
  return state.copyWith(
    deliverySlots: action.deliverySlots,
    collectionSlots: action.collectionSlots,
  );
}

CartState _updateOrderCreationProcessStatus(
  CartState state,
  OrderCreationProcessStatusUpdate action,
) {
  return state.copyWith(
    orderCreationProcessStatus: action.status,
    orderCreationStatusMessage: action.orderCreationStatusMessage,
    payButtonLoading: false,
  );
}

CartState _updateStripePaymentStatus(
  CartState state,
  StripePaymentStatusUpdate action,
) {
  return state.copyWith(
    stripePaymentStatus: action.status,
  );
}

CartState _updateSelectedTimeSlot(
  CartState state,
  UpdateSelectedTimeSlot action,
) {
  return state.copyWith(selectedTimeSlot: action.selectedTimeSlot);
}

CartState _updateTipAmount(
  CartState state,
  UpdateTipAmount action,
) {
  return state.copyWith(selectedTipAmount: action.tipAmount);
}

CartState _updateSelectedDeliveryAddress(
  CartState state,
  UpdateSelectedDeliveryAddress action,
) {
  return state.copyWith(selectedDeliveryAddress: action.selectedAddress);
}

CartState _createOrder(
  CartState state,
  CreateOrder action,
) {
  return state.copyWith(
    order: action.order,
    paymentIntentID: action.paymentIntentId,
    paymentIntent: action.stripePaymentIntent,
    paymentIntentClientSecret:
        action.stripePaymentIntent.paymentIntent.clientSecret,
    ephemeralKey: action.stripePaymentIntent.ephemeralKey,
    publishableKey: action.stripePaymentIntent.publishableKey,
  );
}

CartState _cancelOrder(
  CartState state,
  CancelOrder action,
) {
  return state.copyWith(
    order: null,
    paymentIntentID: '',
  );
}

CartState _orderPaymentAttemptCreated(
  CartState state,
  OrderPaymentAttemptCreated action,
) {
  return state.copyWith(
    order: state.order?.copyWith(paymentAttempted: true),
    paymentIntentID: '',
  );
}

CartState _toggleTransfer(
  CartState state,
  SetTransferringPayment action,
) {
  return state.copyWith(transferringTokens: action.flag);
}

CartState _toggleError(
  CartState state,
  SetError action,
) {
  return state.copyWith(errorCompletingPayment: action.flag);
}

CartState _setCartErrorResolved(
  CartState state,
  SetCartErrorResolved action,
) {
  return state.copyWith(errorDetails: null);
}

CartState _setCartIsLoading(
  CartState state,
  SetCartIsLoading action,
) {
  return state.copyWith(isLoadingCartState: action.isLoading);
}

CartState _setCartError(
  CartState state,
  SetCartError action,
) {
  return state.copyWith(errorDetails: action.error);
}

CartState _toggleConfirmed(
  CartState state,
  SetConfirmed action,
) {
  return state.copyWith(
    confirmedPayment: action.flag,
    orderCreationProcessStatus: OrderCreationProcessStatus.success,
  );
}

CartState _updateSelectedAmounts(
  CartState state,
  UpdateSelectedAmounts action,
) {
  return state.copyWith(
    selectedGBPxAmount: action.gbpxAmount,
    selectedPPLAmount: action.pplAmount,
  );
}

CartState _setRestaurantDetails(
  CartState state,
  SetRestaurantDetails action,
) {
  return state.copyWith(
    restaurantID: action.restaurantID,
    restaurantIsLive: !EnvService.isUsingProdServices,
    restaurantName: action.restaurantName,
    restaurantAddress: action.restaurantAddress,
    restaurantWalletAddress: action.walletAddress,
    restaurantMinimumOrder: action.minimumOrder,
    restaurantPlatformFee: action.platformFee,
    fulfilmentPostalDistricts: action.fulfilmentPostalDistricts,
  );
}

CartState _setFulfilmentMethodType(
  CartState state,
  SetFulfilmentMethod action,
) {
  return state.copyWith(
    fulfilmentMethod: action.fulfilmentMethodType,
  );
}

CartState _setDeliveryInstructions(
  CartState state,
  SetDeliveryInstructions action,
) {
  return state.copyWith(deliveryInstructions: action.deliveryInstructions);
}

CartState _setPaymentMethod(CartState state, SetPaymentMethod action) {
  return state.copyWith(
    selectedPaymentMethod: action.paymentMethod,
    preferredPaymentMethod: action.paymentMethod,
  );
}

CartState _setPaymentButtonFlag(
  CartState state,
  SetPaymentButtonFlag action,
) {
  return state.copyWith(payButtonLoading: action.flag);
}

CartState _updateEligibleOrderDates(
  CartState state,
  UpdateEligibleOrderDates action,
) {
  return state.copyWith(eligibleOrderDates: action.eligibleOrderDates);
}

CartState _updateNextAvaliableSlots(
  CartState state,
  UpdateNextAvaliableTimeSlots action,
) {
  return state.copyWith(
    nextDeliverySlot: action.deliverySlot,
    nextCollectionSlot: action.collectionSlot,
  );
}

CartState _createProductSuggestion(
  CartState state,
  CreateProductSuggestion action,
) {
  return state.copyWith(
    productSuggestion: action.productSuggestion,
  );
}

CartState _addImageToProductSuggestion(
  CartState state,
  AddImageToProductSuggestionRTO action,
) {
  return state.copyWith(
    productSuggestion: state.productSuggestion?.copyWith(
      images: Map.fromEntries(<MapEntry<ProductSuggestionImageType,
          UploadProductSuggestionImageResponse>>[
        ...state.productSuggestion!.images.entries,
        MapEntry(action.imageType, action.image),
      ]),
    ),
  );
}

CartState _addQRCodeToProductSuggestion(
  CartState state,
  AddQRCodeToProductSuggestionRTO action,
) {
  return state.copyWith(
    productSuggestion: state.productSuggestion?.copyWith(
      qrCode: action.qrCode,
    ),
  );
}

CartState _addAdditionalInfoToProductSuggestion(
  CartState state,
  AddAdditionalInformationToProductSuggestionRTO action,
) {
  return state.copyWith(
    productSuggestion: state.productSuggestion
        ?.copyWith(additionalInformation: action.additionalInfo),
  );
}

CartState _addProductNameToProductSuggestion(
  CartState state,
  AddProductNameToProductSuggestionRTO action,
) {
  return state.copyWith(
    productSuggestion: state.productSuggestion?.copyWith(
      name: action.productName,
      store: action.retailerName,
    ),
  );
}
