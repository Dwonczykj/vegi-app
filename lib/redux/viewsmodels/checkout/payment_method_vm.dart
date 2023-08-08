import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/payments/live_payment.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/models/restaurant/payment_methods.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class PaymentMethodViewModel extends Equatable {
  const PaymentMethodViewModel({
    required this.selectedPaymentMethod,
    required this.pplBalance,
    required this.hasPplBalance,
    required this.cartTotal,
    required this.firebaseAuthenticationStatus,
    required this.fuseAuthenticationStatus,
    required this.vegiAuthenticationStatus,
    required this.restaurantMinimumOrder,
    required this.startPaymentProcess,
    required this.isLoading,
    required this.isSuperAdmin,
    required this.selectedRestaurantIsLive,
    required this.selectedFulfilmentMethod,
    required this.showvegiPay,
    required this.orderCreationProcessStatus,
    required this.orderCreationStatusMessage,
    required this.stripePaymentStatus,
    required this.transferringTokens,
    required this.processingPayment,
    required this.setPaymentMethod,
    required this.isDelivery,
  });

  factory PaymentMethodViewModel.fromStore(Store<AppState> store) {
    final pplBalance =
        store.state.cashWalletState.tokens[pplToken.address]!.getAmount();

    return PaymentMethodViewModel(
      selectedPaymentMethod:
          store.state.cartState.selectedPaymentMethod ?? PaymentMethod.stripe,
      pplBalance: '£${getPoundValueFormattedFromPPL(pplBalance)}',
      isLoading: store.state.cartState.payButtonLoading,
      isDelivery: store.state.cartState.isDelivery,
      selectedRestaurantIsLive: store.state.cartState.restaurantIsLive,
      selectedFulfilmentMethod: store.state.cartState.fulfilmentMethod,
      showvegiPay: store.state.userState.isVendor ||
          store.state.cartState.fulfilmentMethod ==
              FulfilmentMethodType.inStore,
      isSuperAdmin: store.state.userState.isVegiSuperAdmin,
      hasPplBalance: pplBalance > 0,
      cartTotal: store.state.cartState.cartTotal,
      firebaseAuthenticationStatus:
          store.state.userState.firebaseAuthenticationStatus,
      fuseAuthenticationStatus: store.state.userState.fuseAuthenticationStatus,
      vegiAuthenticationStatus: store.state.userState.vegiAuthenticationStatus,
      restaurantMinimumOrder: store.state.cartState.restaurantMinimumOrder,
      orderCreationProcessStatus:
          store.state.cartState.orderCreationProcessStatus,
      orderCreationStatusMessage:
          store.state.cartState.orderCreationStatusMessage,
      stripePaymentStatus: store.state.cartState.stripePaymentStatus,
      processingPayment: store.state.cartState.paymentInProcess,
      transferringTokens: store.state.cartState.transferringTokens,
      startPaymentProcess: ({
        required Future<void> Function(PaymentMethod?) showBottomPaymentSheet,
      }) {
        if (store.state.cartState.payButtonLoading) {
          store.dispatch(
            stopPaymentProcess(),
          );
        } else {
          store.dispatch(
            startOrderCreationProcess(
              showBottomPaymentSheet: showBottomPaymentSheet,
            ),
          );
        }
      },
      setPaymentMethod: ({required PaymentMethod paymentMethod}) {
        store.dispatch(SetPaymentMethod(paymentMethod));
      },
    );
  }

  final PaymentMethod selectedPaymentMethod;
  final String pplBalance;
  final bool hasPplBalance;
  final bool isLoading;
  final bool isDelivery;
  final bool isSuperAdmin;
  final bool showvegiPay;
  final bool selectedRestaurantIsLive;
  final FulfilmentMethodType selectedFulfilmentMethod;
  final int restaurantMinimumOrder;
  final Money cartTotal;
  final FirebaseAuthenticationStatus firebaseAuthenticationStatus;
  final FuseAuthenticationStatus fuseAuthenticationStatus;
  final VegiAuthenticationStatus vegiAuthenticationStatus;
  final void Function({required PaymentMethod paymentMethod}) setPaymentMethod;
  final void Function({
    required Future<void> Function(PaymentMethod?) showBottomPaymentSheet,
  }) startPaymentProcess;
  final OrderCreationProcessStatus orderCreationProcessStatus;
  final String orderCreationStatusMessage;
  final StripePaymentStatus stripePaymentStatus;
  final LivePayment? processingPayment;
  final bool transferringTokens;

  bool get disablePayments =>
      fuseAuthenticationStatus != FuseAuthenticationStatus.authenticated ||
      firebaseAuthenticationStatus !=
          FirebaseAuthenticationStatus.authenticated ||
      vegiAuthenticationStatus != VegiAuthenticationStatus.authenticated;

  @override
  List<Object?> get props => [
        selectedPaymentMethod,
        pplBalance,
        isLoading,
        isDelivery,
        isSuperAdmin,
        selectedRestaurantIsLive,
        selectedFulfilmentMethod,
        showvegiPay,
        hasPplBalance,
        restaurantMinimumOrder,
        cartTotal,
        orderCreationProcessStatus,
        orderCreationStatusMessage,
        stripePaymentStatus,
        processingPayment?.amount,
        processingPayment?.status,
        transferringTokens,
        firebaseAuthenticationStatus,
        fuseAuthenticationStatus,
        vegiAuthenticationStatus,
      ];
}
