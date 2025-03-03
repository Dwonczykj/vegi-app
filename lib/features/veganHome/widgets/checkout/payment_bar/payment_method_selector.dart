import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/restaurant/payment_methods.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/checkout/payment_method_vm.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/config.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Analytics.track(
          eventName: AnalyticsEvents.changePaymentMethod,
        );
        showModalBottomSheet<Widget>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          context: context,
          builder: (_) => const PaymentMethodSelectorModalSheet(),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Pay Using',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
              )
            ],
          ),
          StoreConnector<AppState, PaymentMethodViewModel>(
            converter: PaymentMethodViewModel.fromStore,
            onInit: (store) {
              final gbtBalance = store.state.cashWalletState
                  .tokens[TokenDefinitions.greenBeanToken.address]!
                  .getAmountTokens();

              // if (gbtBalance > 100) {
              //   store.dispatch(SetPaymentMethod(PaymentMethod.stripe));
              //   return;
              // }
              if (store.state.cartState.selectedTimeSlot == null) {
                store.dispatch(
                  SetPaymentMethod(
                    store.state.cartState.preferredPaymentMethod ??
                        PaymentMethod.stripe,
                  ),
                );
              }
            },
            builder: (context, viewmodel) {
              return Text(
                viewmodel.selectedPaymentMethod.formattedName,
              );
            },
          )
        ],
      ),
    );
  }
}

class PaymentMethodSelectorModalSheet extends StatelessWidget {
  const PaymentMethodSelectorModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: StoreConnector<AppState, PaymentMethodViewModel>(
        distinct: true,
        converter: PaymentMethodViewModel.fromStore,
        builder: (context, viewmodel) {
          return Wrap(
            children: [
              const Text(
                'Select a payment method',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (viewmodel.selectedFulfilmentMethod !=
                      FulfilmentMethodType.inStore ||
                  !viewmodel.showvegiPay) ...[
                if (viewmodel.isSuperAdmin && DebugHelpers.inDebugMode)
                  ListTile(
                    onTap: () {
                      viewmodel.setPaymentMethod(
                        paymentMethod: PaymentMethod.peeplPay,
                      );
                      context.router.pop();
                    },
                    leading: Image.asset(
                      TokenDefinitions.greenBeanToken.imageUrl!,
                      width: 35,
                    ),
                    title: Text(PaymentMethod.peeplPay.formattedName),
                    subtitle: viewmodel.hasGBTBalance
                        ? Text(
                            'Use your rewards and save ${viewmodel.gbtBalance}',
                          )
                        : null,
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ),
                ListTile(
                  onTap: () {
                    // ~ https://stripe.com/docs/testing#testing-interactively
                    viewmodel.setPaymentMethod(
                      paymentMethod: PaymentMethod.stripe,
                    );
                    context.router.pop();
                  },
                  leading: const Icon(
                    FontAwesomeIcons.creditCard,
                  ),
                  title: const Text('Credit & Debit Cards'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ),
                // ListTile(
                //   onTap: () {
                //     // ~ https://stripe.com/docs/testing#testing-interactively
                //     viewmodel.setPaymentMethod(
                //       paymentMethod: PaymentMethod.stripeToFuse,
                //     );
                //     context.router.pop();
                //   },
                //   leading: const Icon(
                //     FontAwesomeIcons.creditCard,
                //   ),
                //   title: const Text('Credit & Debit Cards'),
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios,
                //     size: 14,
                //   ),
                // ),
                if (Platform.isIOS)
                  ListTile(
                    onTap: () {
                      viewmodel.setPaymentMethod(
                        paymentMethod: PaymentMethod.applePay,
                      );
                      context.router.pop();
                    },
                    leading: const Icon(FontAwesomeIcons.applePay),
                    title: Text(PaymentMethod.applePay.formattedName),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  )
                else if (Platform.isAndroid)
                  ListTile(
                    onTap: () {
                      viewmodel.setPaymentMethod(
                        paymentMethod: PaymentMethod.googlePay,
                      );
                      context.router.pop();
                    },
                    leading: const Icon(FontAwesomeIcons.googlePay),
                    title: Text(PaymentMethod.googlePay.formattedName),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ),
                if (viewmodel.isSuperAdmin)
                  if (Platform.isIOS && AppConfig.useFusePayments)
                    ListTile(
                      onTap: () {
                        viewmodel.setPaymentMethod(
                          paymentMethod: PaymentMethod.applePayToFuse,
                        );
                        context.router.pop();
                      },
                      leading: const Icon(FontAwesomeIcons.applePay),
                      title: Text(PaymentMethod.applePayToFuse.formattedName),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                    )
                  else if (!Platform.isIOS && AppConfig.useFusePayments)
                    Opacity(
                      opacity: 0.5,
                      child: ListTile(
                        onTap: () {
                          // viewmodel.setPaymentMethod(
                          //   paymentMethod: PaymentMethod.googlePayToFuse,
                          // );
                          // context.router.pop();
                        },
                        enabled: false,
                        leading: const Icon(FontAwesomeIcons.googlePay),
                        title:
                            Text(PaymentMethod.googlePayToFuse.formattedName),
                        subtitle: const Text('Coming soon'),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                    )
                  // Ignored as apple pay already for the public above
                  // else if (Platform.isIOS && !AppConfig.useFusePayments)
                  else
                    Opacity(
                      opacity: 0.5,
                      child: ListTile(
                        onTap: () {
                          // viewmodel.setPaymentMethod(
                          //   paymentMethod: PaymentMethod.googlePay,
                          // );
                          // context.router.pop();
                        },
                        enabled: false,
                        leading: const Icon(FontAwesomeIcons.googlePay),
                        title: Text(PaymentMethod.googlePay.formattedName),
                        subtitle: const Text('Coming soon'),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                    ),
              ],
              if (viewmodel.showvegiPay)
                Opacity(
                  opacity: 0.5,
                  child: ListTile(
                    onTap: () {
                      viewmodel.setPaymentMethod(
                        paymentMethod: PaymentMethod.qrPay,
                      );
                      context.router.pop();
                    },
                    leading: const Icon(FontAwesomeIcons.barcode),
                    title: Text(PaymentMethod.qrPay.formattedName),
                    subtitle: const Text('Coming soon In Store'),
                    trailing: const Icon(
                      Icons.qr_code,
                      size: 14,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
