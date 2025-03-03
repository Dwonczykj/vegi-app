import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/cart/createOrderForFulfilment.dart';
import 'package:vegan_liverpool/models/restaurant/cartItem.dart';
import 'package:vegan_liverpool/models/restaurant/deliveryAddresses.dart';
import 'package:vegan_liverpool/utils/constants.dart';

part 'createOrderForDelivery.freezed.dart';
part 'createOrderForDelivery.g.dart';

@Freezed()
class CreateOrderForDelivery extends CreateOrderForFulfilment
    with _$CreateOrderForDelivery {
  @JsonSerializable()
  factory CreateOrderForDelivery({
    required List<CartItem> items,
    required num total,
    required Currency currency,
    required int tipAmount,
    required bool marketingOptIn,
    required List<String> discountCodes,
    required String vendor,
    required String walletAddress,
    required DeliveryAddresses address,
    required int fulfilmentMethod,
    required String fulfilmentSlotFrom,
    required String fulfilmentSlotTo,
    required bool isDelivery,
    required String fcmToken,
    required String publicId,
  }) = _CreateOrderForDelivery;

  CreateOrderForDelivery._();

  factory CreateOrderForDelivery.fromJson(Map<String, dynamic> json) =>
      _$$_CreateOrderForDeliveryFromJson(json);

  factory CreateOrderForDelivery.fromStore(Store<AppState> store) {
    final DeliveryAddresses selectedAddress =
        store.state.cartState.selectedDeliveryAddress!;
    return CreateOrderForDelivery(
        isDelivery: true,
        items: store.state.cartState.cartItems,
        total: store.state.cartState.cartTotal.value,
        currency: store.state.cartState.cartTotal.currency,
        tipAmount: store.state.cartState.selectedTipAmount.inGBPxValue.round(),
        marketingOptIn: false,
        discountCodes: store.state.cartState.discountCode.isEmpty
          ? store.state.cartState.appliedVouchers
              .map((voucher) => voucher.code)
              .toList()
          : [
          store.state.cartState
              .discountCode, // TODO: Apply discount vouchers here somehow?
          ...store.state.cartState.appliedVouchers
              .map((voucher) => voucher.code)
              .toList(),
        ],
        vendor: store.state.cartState.restaurantID,
        walletAddress: store.state.userState.walletAddress,
        fcmToken: store.state.userState.firebaseMessagingToken,
        address: selectedAddress.copyWith(
          name: store.state.userState.displayName,
          phoneNumber: store.state.userState.phoneNumber,
          email: store.state.userState.email.isEmpty
              ? EMAIL_NOT_PROVIDED
              : store.state.userState.email,
          instructions: store.state.cartState.deliveryInstructions,
        ),
        fulfilmentMethod:
            store.state.cartState.selectedTimeSlot!.fulfilmentMethodId,
        fulfilmentSlotFrom:
            store.state.cartState.selectedTimeSlot!.startTime.formattedForAPI,
        fulfilmentSlotTo: store.state.cartState.selectedTimeSlot!.endTime
            .formattedForAPI,
        publicId: '',
        );
  }
  
  @override
  @JsonEnum()
  final FulfilmentMethodType fulfilmentTypeString = FulfilmentMethodType.delivery;
}
