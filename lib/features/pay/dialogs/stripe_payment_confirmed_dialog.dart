import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/vegiDialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/vegiDialogButton.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:redux/redux.dart';

class _StripePaymentConfirmedDialogViewModel extends Equatable {
  const _StripePaymentConfirmedDialogViewModel({
    required this.confirmedPayment,
  });

  factory _StripePaymentConfirmedDialogViewModel.fromStore(
    Store<AppState> store,
  ) {
    return _StripePaymentConfirmedDialogViewModel(
      confirmedPayment: store.state.cartState.confirmedPayment,
    );
  }
  final bool confirmedPayment;

  @override
  List<Object> get props => [
        confirmedPayment,
      ];
}

class StripePaymentConfirmedDialog extends StatefulWidget {
  const StripePaymentConfirmedDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<StripePaymentConfirmedDialog> createState() =>
      _StripePaymentConfirmedDialogState();
}

class _StripePaymentConfirmedDialogState
    extends State<StripePaymentConfirmedDialog> {
  bool hasNavigatedAway = false;
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (hasNavigatedAway) {
          return;
        }
        setState(() {
          hasNavigatedAway = true;
        });
        context.router.pop().then(
              (_) => context.router.navigate(const OrderConfirmedScreen()),
            );
        // await rootRouter.popAndPush(const OrderConfirmedScreen());
      },
    );
    final width = MediaQuery.of(context).size.width;
    return VegiDialog<_StripePaymentConfirmedDialogViewModel>(
      storeConverter: _StripePaymentConfirmedDialogViewModel.fromStore,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Payment submitted',
              style: const TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                PrimaryButton(
                  onPressed: () {
                    if (hasNavigatedAway) {
                      return;
                    }
                    setState(() {
                      hasNavigatedAway = true;
                    });
                    context.router.pop().then(
                          (_) => context.router
                              .navigate(const OrderConfirmedScreen()),
                        );
                    // await rootRouter.popAndPush(const OrderConfirmedScreen());
                  },
                  label: 'ok',
                  width: width * 0.3,
                  height: 40,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
