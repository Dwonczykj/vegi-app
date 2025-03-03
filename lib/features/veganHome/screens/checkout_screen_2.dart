import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/pay/dialogs/stripe_payment_confirmed_dialog.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/topup/dialogs/card_failed.dart';
import 'package:vegan_liverpool/features/topup/dialogs/minting_dialog.dart';
import 'package:vegan_liverpool/features/topup/dialogs/processing_payment.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/appbars/checkout_appbar.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/appbars/ppl_rewards_appbar.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/cart_items/cart_items_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/delivery_address/delivery_address_selector.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/delivery_address/fulfilment_method_selector.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/delivery_slots/delivery_time_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/other_cards/bill_summary_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/other_cards/discount_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/other_cards/save_the_oceans_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/other_cards/tip_selection_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/other_cards/your_details_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/payment_bar/checkout_error_bar.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/checkout/payment_bar/payment_bar.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/dialogs/addCardsToWalletDialog.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/checkout/payment_method_vm.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

import 'package:auto_route/annotations.dart';

@RoutePage()
class CheckoutScreenPt2 extends StatelessWidget {
  const CheckoutScreenPt2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (_, flag) => const [
          CheckoutAppBar(
            key: ValueKey('checkoutAppBar'),
          ),
          PeeplRewardsAppBar(
            key: ValueKey('peeplAppBar'),
          )
        ],
        body: StoreConnector<AppState, PaymentMethodViewModel>(
          onInit: (store) {
            store
              ..dispatch(resetCashbackAmountSelected())
              ..dispatch(getNextAvaliableSlot())
              ..dispatch(autoSelectDeliveryAddress());
          },
          converter: PaymentMethodViewModel.fromStore,
          distinct: true,
          onWillChange: (previousViewModel, newViewModel) async {
            final store = StoreProvider.of<AppState>(context);
            final showErrorBar = ![
              OrderCreationProcessStatus.none,
              OrderCreationProcessStatus.success
            ].contains(newViewModel.orderCreationProcessStatus);
            final orderStatusMessageUpdated =
                newViewModel.orderCreationProcessStatus !=
                    (previousViewModel?.orderCreationProcessStatus ??
                        OrderCreationProcessStatus.none);
            final stripeMessageUpdated = newViewModel.stripePaymentStatus !=
                (previousViewModel?.stripePaymentStatus ??
                    StripePaymentStatus.none);
            if (newViewModel.transferringTokens &&
                !(previousViewModel?.transferringTokens ?? false)) {
              // await showDialog<void>(
              //   context: context,
              //   builder: (context) => const ProcessingPayment(),
              // );
            } else if (orderStatusMessageUpdated ||
                (!stripeMessageUpdated && showErrorBar)) {
              if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.needToSelectATimeSlot) {
                await showErrorSnack(
                  context: context,
                  title: 'Please select a time slot',
                  message: '',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.needToSelectADeliveryAddress) {
                await showErrorSnack(
                  context: context,
                  title: 'Please select a delivery address',
                  message: '',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.sendOrderCallServerError) {
                await showErrorSnack(
                  context: context,
                  title: newViewModel.orderCreationStatusMessage,
                  message: '',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.sendOrderCallClientError) {
                await showErrorSnack(
                  context: context,
                  title: 'Failed to process order',
                  message: '',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.success) {
                // do nothing
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.sendOrderCallTimedOut) {
                await showErrorSnack(
                  context: context,
                  title: newViewModel.orderCreationStatusMessage,
                  message: '',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus
                      .paymentIntentAmountDoesntMatchCartTotal) {
                await showErrorSnack(
                  context: context,
                  title: "Order totals aren't matching",
                  message: '',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.paymentIntentCheckNotFound) {
                await showErrorSnack(
                  context: context,
                  title: 'Connection issue',
                  message: 'Failed to validate payment',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.orderIsBelowVendorMinimumOrder) {
                await showErrorSnack(
                  context: context,
                  title: 'This restaurant is not accepting orders below '
                      '${newViewModel.restaurantMinimumOrder.formattedGBPxPrice}',
                  message: '',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.orderCancelled) {
                await showInfoSnack(
                  context,
                  title: 'Order creation cancelled',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.stripeServiceFailedOnServer) {
                await showInfoSnack(
                  context,
                  title: 'Stripe service failed on server, please retry now',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.invalidSlot) {
                await showInfoSnack(
                  context,
                  title:
                      'Whoops, over-subscribed delivery slot, please pick a new slot',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.invalidPostalDistrict) {
                await showInfoSnack(
                  context,
                  title:
                      'Whoops, vendor doesn\'t deliver to "${store.state.cartState.selectedDeliveryAddress?.postalCode ?? 'the selected postcode'}", please choose a different delivery address or change to collection',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.invalidDiscountCode) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.badItemsRequest) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.allItemsUnavailable) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.minimumOrderAmount) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.deliveryPartnerUnavailable) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.invalidUserAddress) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.invalidProductOption) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.invalidProduct) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.invalidFulfilmentMethod) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.invalidVendor) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus ==
                  OrderCreationProcessStatus.noItemsFound) {
                await showInfoSnack(
                  context,
                  title: newViewModel.orderCreationStatusMessage.isNotEmpty
                      ? newViewModel.orderCreationStatusMessage
                      : 'Whoops, ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
              } else if (newViewModel.orderCreationProcessStatus !=
                  OrderCreationProcessStatus.none) {
                await showInfoSnack(
                  context,
                  title:
                      'Order creation failed: ${newViewModel.orderCreationProcessStatus.name.capitalizeWordsFromLowerCamelCase()}',
                );
                log.info(
                  'Ignoring OrderCreationProcessStatus update: "${newViewModel.orderCreationProcessStatus.name}"',
                  stackTrace: StackTrace.current,
                );
              }
            } else if (stripeMessageUpdated) {
              String title = '';
              String message = '';
              if (newViewModel.stripePaymentStatus ==
                  StripePaymentStatus.mintingFailed) {
                title = 'Minting update';
                message = 'minting failed';
                await showInfoSnack(
                  context,
                  title: message,
                );
              } else if (newViewModel.stripePaymentStatus ==
                      StripePaymentStatus.mintingStarted &&
                  newViewModel.processingPayment != null) {
                await showDialog<void>(
                  context: context,
                  builder: (context) {
                    return MintingDialog(
                      amountText: newViewModel
                          .processingPayment!.amount.formattedGBPxPrice,
                      shouldPushToHome: true,
                    );
                  },
                  barrierDismissible: false,
                );
              } else if (newViewModel.stripePaymentStatus ==
                  StripePaymentStatus.mintingSucceeded) {
                title = 'Minting update';
                message = 'minting succeeded';
                await showInfoSnack(
                  context,
                  title: message,
                );
              } else if (newViewModel.stripePaymentStatus ==
                  StripePaymentStatus.paymentConfirmed) {
                // title = 'Payment update';
                // message = 'Payment confirmed';
                await showDialog<void>(
                  context: context,
                  builder: (context) {
                    return const StripePaymentConfirmedDialog(); //TODO: Replace this with MintingDialog copy
                  },
                  barrierDismissible: false,
                );
              } else if (newViewModel.stripePaymentStatus ==
                  StripePaymentStatus.paymentFailed) {
                await showDialog<void>(
                  context: context,
                  builder: (context) => const TopUpFailed(
                    isFailed: true,
                  ),
                );
              } else if (newViewModel.stripePaymentStatus ==
                  StripePaymentStatus.topupSucceeded) {
                title = 'Topup update';
                message = 'Topup succeeded';
                await showInfoSnack(
                  context,
                  title: message,
                );
              } else if (newViewModel.stripePaymentStatus ==
                      StripePaymentStatus.paymentConfirmed &&
                  previousViewModel?.stripePaymentStatus !=
                      StripePaymentStatus.paymentConfirmed) {
                await rootRouter.push(const OrderConfirmedScreen());
              } else if (newViewModel.stripePaymentStatus ==
                      StripePaymentStatus.paymentMethodNotSupportedOnDevice &&
                  previousViewModel?.stripePaymentStatus !=
                      StripePaymentStatus.paymentMethodNotSupportedOnDevice) {
                await showDialog(
                    context: context,
                    builder: ((context) => AddCardsToWalletDialog()));
              } else {
                log.info(
                  'Ignoring StripePaymentStatus update: "${newViewModel.stripePaymentStatus.name}"',
                );
              }
            }
          },
          builder: (context, viewmodel) {
            final isDelivery = viewmodel.isDelivery;
            final showErrorBar = ![
              OrderCreationProcessStatus.none,
              OrderCreationProcessStatus.success
            ].contains(viewmodel.orderCreationProcessStatus);
            final double errorBarAdditionalHeight = showErrorBar ? 100 : 0;
            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    const DeliveryTimeCard(),
                    const FulfilmentMethodSelector(),
                    const CartItemsCard(),
                    const DiscountCards(),
                    const BillSummaryCard(),
                    if (isDelivery) const TipSelectionCard(),
                    const YourDetailsCard(),
                    //const SaveTheOceansCard(),
                    const SizedBox(
                      height: 200,
                    )
                  ],
                ),
                DeliveryAddressSelector(
                  diplayOffsetFromBottom: 100 + errorBarAdditionalHeight,
                ),
                PaymentBar(
                  diplayOffsetFromBottom: 0 + errorBarAdditionalHeight,
                  diplayHeight: 100,
                ),
                if (showErrorBar)
                  CheckoutErrorBar(
                    displayHeight: errorBarAdditionalHeight.toDouble(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
