import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/pay/dialogs/stripe_payment_confirmed_dialog.dart';
import 'package:vegan_liverpool/features/pay/dialogs/unauthenticated_dialog.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/topup/dialogs/card_failed.dart';
import 'package:vegan_liverpool/features/topup/dialogs/minting_dialog.dart';
import 'package:vegan_liverpool/features/topup/dialogs/processing_payment.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/restaurant/restaurant_not_live_dialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/paymentSheet.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/qRFromCartSheet.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/shimmerButton.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/restaurant/payment_methods.dart';
import 'package:vegan_liverpool/redux/viewsmodels/checkout/payment_method_vm.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 60,
      child: StoreConnector<AppState, PaymentMethodViewModel>(
        converter: PaymentMethodViewModel.fromStore,
        distinct: true,
        builder: (context, viewmodel) {
          return ShimmerButton(
            disabled: viewmodel.disablePayments,
            showPopupOnDisabledButtonTapped: const UnauthenticatedDialog(),
            buttonContent: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewmodel.cartTotal.formattedGBPPrice,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  viewmodel.selectedFulfilmentMethod == FulfilmentMethodType.inStore ? 'Pay now' : 'Place Order',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            isLoading: viewmodel.isLoading,
            buttonAction: () {
              if (viewmodel.selectedRestaurantIsLive) {
                Analytics.track(
                  eventName: AnalyticsEvents.placeOrder,
                  properties: {'platform': 'vegi_app'},
                );
                viewmodel.startPaymentProcess(
                  showBottomPaymentSheet: (paymentMethod) async {
                    if (paymentMethod == PaymentMethod.qrPay) {
                      await showModalBottomSheet<Widget>(
                        isScrollControlled: true,
                        backgroundColor: const Color.fromARGB(255, 44, 42, 39),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        elevation: 5,
                        context: context,
                        builder: (context) => const QRFromCartSheet(),
                      );
                    } else if (paymentMethod == PaymentMethod.peeplPay) {
                      await showModalBottomSheet<Widget>(
                        isScrollControlled: true,
                        backgroundColor: Colors.grey[900],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        elevation: 5,
                        context: context,
                        builder: (context) => const PaymentSheet(),
                      );
                    }
                  },
                );
              } else {
                showDialog<Widget>(
                  context: context,
                  builder: (context) => const RestaurantNotLiveDialog(),
                );
              }
            },
            baseColor: Colors.white,
            highlightColor: Colors.grey.shade200,
          );
        },
      ),
    );
  }
}
