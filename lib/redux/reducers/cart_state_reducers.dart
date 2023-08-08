import 'package:redux/redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/envService.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/admin/uploadProductSuggestionImageResponse.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/models/user_cart_state.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';

final cartStateReducers = combineReducers<UserCartState>([
  TypedReducer<UserCartState, ResetAppState>(_resetApp).call,
  TypedReducer<UserCartState, UpdateCartItems>(_updateCartItems).call,
  TypedReducer<UserCartState, UpdateCartItem>(_updateCartItem).call,
  TypedReducer<UserCartState, UpdateComputedCartValues>(_computeCartTotals).call,
  TypedReducer<UserCartState, UpdateCartDiscount>(_updateCartDiscount).call,
  TypedReducer<UserCartState, AddValidVoucherCodeToCart>(
      _addValidVoucherCodeToCart,).call,
  TypedReducer<UserCartState, RemoveVoucherCodeFromCart>(
      _removeVoucherCodeFromCart,).call,
  TypedReducer<UserCartState, ClearCart>(_clearCart).call,
  TypedReducer<UserCartState, UpdateSlots>(_updateSlots).call,
  TypedReducer<UserCartState, OrderCreationProcessStatusUpdate>(
      _updateOrderCreationProcessStatus,).call,
  TypedReducer<UserCartState, StripePaymentStatusUpdate>(
      _updateStripePaymentStatus,).call,
  TypedReducer<UserCartState, UpdateSelectedTimeSlot>(_updateSelectedTimeSlot).call,
  TypedReducer<UserCartState, UpdateTipAmount>(_updateTipAmount).call,
  TypedReducer<UserCartState, UpdateSelectedDeliveryAddress>(
    _updateSelectedDeliveryAddress,
  ).call,
  TypedReducer<UserCartState, CreateOrder>(_createOrder).call,
  TypedReducer<UserCartState, CancelOrder>(_cancelOrder).call,
  TypedReducer<UserCartState, SetTransferringPayment>(_toggleTransfer).call,
  TypedReducer<UserCartState, SetError>(_toggleError).call,
  TypedReducer<UserCartState, SetCartErrorResolved>(_setCartErrorResolved).call,
  TypedReducer<UserCartState, SetCartError>(_setCartError).call,
  TypedReducer<UserCartState, SetCartIsLoading>(_setCartIsLoading).call,
  TypedReducer<UserCartState, SetConfirmed>(_toggleConfirmed).call,
  TypedReducer<UserCartState, UpdateSelectedAmounts>(_updateSelectedAmounts).call,
  TypedReducer<UserCartState, SetRestaurantDetails>(_setRestaurantDetails).call,
  TypedReducer<UserCartState, SetFulfilmentMethod>(_setFulfilmentMethodType).call,
  TypedReducer<UserCartState, SetDeliveryInstructions>(
    _setDeliveryInstructions,
  ).call,
  TypedReducer<UserCartState, SetPaymentMethod>(_setPaymentMethod).call,
  TypedReducer<UserCartState, SetPaymentButtonFlag>(_setPaymentButtonFlag).call,
  TypedReducer<UserCartState, UpdateEligibleOrderDates>(
    _updateEligibleOrderDates,
  ).call,
  TypedReducer<UserCartState, UpdateNextAvaliableTimeSlots>(
    _updateNextAvaliableSlots,
  ).call,
  TypedReducer<UserCartState, AddImageToProductSuggestionRTO>(
    _addImageToProductSuggestion,
  ).call,
  TypedReducer<UserCartState, AddQRCodeToProductSuggestionRTO>(
    _addQRCodeToProductSuggestion,
  ).call,
  TypedReducer<UserCartState, AddAdditionalInformationToProductSuggestionRTO>(
    _addAdditionalInfoToProductSuggestion,
  ).call,
  TypedReducer<UserCartState, AddProductNameToProductSuggestionRTO>(
    _addProductNameToProductSuggestion,
  ).call,
  TypedReducer<UserCartState, CreateProductSuggestion>(
    _createProductSuggestion,
  ).call,
  TypedReducer<UserCartState, OrderPaymentAttemptCreated>(
    _orderPaymentAttemptCreated,
  ).call,
]);

UserCartState _resetApp(
  UserCartState state,
  ResetAppState action,
) {
  return UserCartState.initial();
}

UserCartState _updateCartItems(
  UserCartState state,
  UpdateCartItems action,
) {
  return state.copyWith(cartItems: action.cartItems);
}

UserCartState _updateCartItem(
  UserCartState state,
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

UserCartState _computeCartTotals(
  UserCartState state,
  UpdateComputedCartValues action,
) {
  return state.copyWith(
    cartCurrency: action.cartTotal.currency,
    cartSubTotal: action.cartSubTotal,
    cartTax: action.cartTax,
    cartTotal: action.cartTotal,
    cartDiscountComputed: action.cartDiscountComputed,
  );
}

UserCartState _clearCart(
  UserCartState state,
  ClearCart action,
) {
  return state.copyWith(
    cartItems: [],
    cartSubTotal: Money.zero(inCurrency: state.cartCurrency),
    cartTax: Money.zero(inCurrency: state.cartCurrency),
    cartTotal: Money.zero(inCurrency: state.cartCurrency),
    cartDiscountPercent: 0.0,
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

UserCartState _updateCartDiscount(
  UserCartState state,
  UpdateCartDiscount action,
) {
  return state.copyWith(
    cartDiscountPercent: action.cartDiscountPercent,
    discountCode: action.discountCode,
  );
}

UserCartState _addValidVoucherCodeToCart(
  UserCartState state,
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

UserCartState _removeVoucherCodeFromCart(
  UserCartState state,
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

UserCartState _updateSlots(
  UserCartState state,
  UpdateSlots action,
) {
  return state.copyWith(
    deliverySlots: action.deliverySlots,
    collectionSlots: action.collectionSlots,
  );
}

UserCartState _updateOrderCreationProcessStatus(
  UserCartState state,
  OrderCreationProcessStatusUpdate action,
) {
  return state.copyWith(
    orderCreationProcessStatus: action.status,
    orderCreationStatusMessage: action.orderCreationStatusMessage,
    payButtonLoading: false,
  );
}

UserCartState _updateStripePaymentStatus(
  UserCartState state,
  StripePaymentStatusUpdate action,
) {
  return state.copyWith(
    stripePaymentStatus: action.status,
  );
}

UserCartState _updateSelectedTimeSlot(
  UserCartState state,
  UpdateSelectedTimeSlot action,
) {
  return state.copyWith(selectedTimeSlot: action.selectedTimeSlot);
}

UserCartState _updateTipAmount(
  UserCartState state,
  UpdateTipAmount action,
) {
  return state.copyWith(selectedTipAmount: action.tipAmount);
}

UserCartState _updateSelectedDeliveryAddress(
  UserCartState state,
  UpdateSelectedDeliveryAddress action,
) {
  return state.copyWith(selectedDeliveryAddress: action.selectedAddress);
}

UserCartState _createOrder(
  UserCartState state,
  CreateOrder action,
) {
  return state.copyWith(
    order: action.order,
    paymentIntentID: action.paymentIntentId,
    paymentIntent: action.stripePaymentIntent,
    paymentIntentClientSecret: action.stripePaymentIntent.paymentIntent.clientSecret,
    ephemeralKey: action.stripePaymentIntent.ephemeralKey,
    publishableKey: action.stripePaymentIntent.publishableKey,
  );
}

UserCartState _cancelOrder(
  UserCartState state,
  CancelOrder action,
) {
  return state.copyWith(
    order: null,
    paymentIntentID: '',
  );
}

UserCartState _orderPaymentAttemptCreated(
  UserCartState state,
  OrderPaymentAttemptCreated action,
) {
  return state.copyWith(
    order: state.order?.copyWith(paymentAttempted: true),
    paymentIntentID: '',
  );
}

UserCartState _toggleTransfer(
  UserCartState state,
  SetTransferringPayment action,
) {
  return state.copyWith(transferringTokens: action.flag);
}

UserCartState _toggleError(
  UserCartState state,
  SetError action,
) {
  return state.copyWith(errorCompletingPayment: action.flag);
}

UserCartState _setCartErrorResolved(
  UserCartState state,
  SetCartErrorResolved action,
) {
  return state.copyWith(errorDetails: null);
}

UserCartState _setCartIsLoading(
  UserCartState state,
  SetCartIsLoading action,
) {
  return state.copyWith(isLoadingCartState: action.isLoading);
}

UserCartState _setCartError(
  UserCartState state,
  SetCartError action,
) {
  return state.copyWith(errorDetails: action.error);
}

UserCartState _toggleConfirmed(
  UserCartState state,
  SetConfirmed action,
) {
  return state.copyWith(
    confirmedPayment: action.flag,
    orderCreationProcessStatus: OrderCreationProcessStatus.success,
  );
}

UserCartState _updateSelectedAmounts(
  UserCartState state,
  UpdateSelectedAmounts action,
) {
  return state.copyWith(
    selectedGBPxAmount: action.gbpxAmount,
    selectedPPLAmount: action.pplAmount,
  );
}

UserCartState _setRestaurantDetails(
  UserCartState state,
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

UserCartState _setFulfilmentMethodType(
  UserCartState state,
  SetFulfilmentMethod action,
) {
  return state.copyWith(
    fulfilmentMethod: action.fulfilmentMethodType,
  );
}

UserCartState _setDeliveryInstructions(
  UserCartState state,
  SetDeliveryInstructions action,
) {
  return state.copyWith(deliveryInstructions: action.deliveryInstructions);
}

UserCartState _setPaymentMethod(UserCartState state, SetPaymentMethod action) {
  return state.copyWith(selectedPaymentMethod: action.paymentMethod);
}

UserCartState _setPaymentButtonFlag(
  UserCartState state,
  SetPaymentButtonFlag action,
) {
  return state.copyWith(payButtonLoading: action.flag);
}

UserCartState _updateEligibleOrderDates(
  UserCartState state,
  UpdateEligibleOrderDates action,
) {
  return state.copyWith(eligibleOrderDates: action.eligibleOrderDates);
}

UserCartState _updateNextAvaliableSlots(
  UserCartState state,
  UpdateNextAvaliableTimeSlots action,
) {
  return state.copyWith(
    nextDeliverySlot: action.deliverySlot,
    nextCollectionSlot: action.collectionSlot,
  );
}

UserCartState _createProductSuggestion(
  UserCartState state,
  CreateProductSuggestion action,
) {
  return state.copyWith(
    productSuggestion: action.productSuggestion,
  );
}

UserCartState _addImageToProductSuggestion(
  UserCartState state,
  AddImageToProductSuggestionRTO action,
) {
  return state.copyWith(
    productSuggestion: state.productSuggestion?.copyWith(
      images: Map.fromEntries(<
          MapEntry<ProductSuggestionImageType,
              UploadProductSuggestionImageResponse>>[
        ...state.productSuggestion!.images.entries,
        MapEntry(action.imageType, action.image),
      ]),
    ),
  );
}

UserCartState _addQRCodeToProductSuggestion(
  UserCartState state,
  AddQRCodeToProductSuggestionRTO action,
) {
  return state.copyWith(
    productSuggestion: state.productSuggestion?.copyWith(
      qrCode: action.qrCode,
    ),
  );
}

UserCartState _addAdditionalInfoToProductSuggestion(
  UserCartState state,
  AddAdditionalInformationToProductSuggestionRTO action,
) {
  return state.copyWith(
    productSuggestion: state.productSuggestion
        ?.copyWith(additionalInformation: action.additionalInfo),
  );
}

UserCartState _addProductNameToProductSuggestion(
  UserCartState state,
  AddProductNameToProductSuggestionRTO action,
) {
  return state.copyWith(
    productSuggestion: state.productSuggestion?.copyWith(
      name: action.productName,
      store: action.retailerName,
    ),
  );
}
