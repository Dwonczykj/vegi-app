import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'dart:math' as math;
import 'package:vegan_liverpool/features/pay/dialogs/stripe_payment_confirmed_dialog.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/topup/dialogs/card_failed.dart';
import 'package:vegan_liverpool/features/topup/dialogs/minting_dialog.dart';
import 'package:vegan_liverpool/features/topup/dialogs/processing_payment.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/gbt_choose_cashback_picker_control.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/ppl_balance_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/gbt_choose_cashback_slider_control.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/shimmerButton.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/balance.dart';
import 'package:vegan_liverpool/redux/viewsmodels/paymentSheet.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class ChooseCashBackSlider extends StatelessWidget {
  const ChooseCashBackSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PeeplPaySheetViewModel>(
      converter: PeeplPaySheetViewModel.fromStore,
      onInit: (store) {
        store
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(SetPaymentButtonFlag(false))
          ..dispatch(
            UpdateSelectedAmounts(
              gbpxAmount:
                  store.state.cartState.cartTotal.inGBPxValue.toDouble(),
              pplAmount: 0,
            ),
          );
      },
      distinct: true,
      onWillChange: (previousViewModel, newViewModel) async {
        if (newViewModel.transferringTokens &&
            !(previousViewModel?.transferringTokens ?? false)) {
          await showDialog<void>(
            context: context,
            builder: (context) => const ProcessingPayment(),
          );
        } else if (newViewModel.stripePaymentStatus !=
            (previousViewModel?.stripePaymentStatus ??
                StripePaymentStatus.none)) {
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
                  amountText:
                      newViewModel.processingPayment!.amount.formattedGBPxPrice,
                  shouldPushToHome: false,
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
          } else {
            log.info(
              'Ignoring StripePaymentStatus update: "${newViewModel.stripePaymentStatus.name}"',
            );
          }
        }
      },
      builder: (_, viewmodel) {
        return FractionallySizedBox(
          heightFactor: 0.55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Discount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[800],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              const GBTInUseCard(),
              // const GBTTotalCard(),
              const Spacer(),
              // const GBTChooseCashBackSlider(),
              const GBTChooseCashBackPicker(),
              const Spacer(),

              // * Show an Apply button
              // if (viewmodel.transferringTokens)
              //   const CircularProgressIndicator(
              //     color: Colors.white,
              //   )
              // else
              //   SizedBox(
              //     width: MediaQuery.of(context).size.width * 0.4,
              //     child: ShimmerButton(
              //       buttonContent: const Center(
              //         child: Text(
              //           'Apply',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18,
              //             fontWeight: FontWeight.w900,
              //           ),
              //         ),
              //       ),
              //       buttonAction: () {
              //         Navigator.pop(context);
              //       },
              //       baseColor: Colors.grey[800]!,
              //       highlightColor: Colors.grey[850]!,
              //     ),
              //   ),
              // const Spacer()
            ],
          ),
        );
      },
    );
  }
}

class GBTTotalCard extends StatelessWidget {
  const GBTTotalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Text(
            'Current Cash Balance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[800],
          ),
          height: 85,
          child: StoreConnector<AppState, BalanceViewModel>(
            converter: BalanceViewModel.fromStore,
            builder: (context, viewmodel) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        viewmodel.gbtBalance.value.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        TokenDefinitions.greenBeanToken.symbol,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  // Center(
                  //   child: Image.asset(
                  //     ImagePaths.vegiBeanMan,
                  //     width: 25,
                  //   ),
                  // ),
                  VerticalDivider(
                    width: 20,
                    thickness: 2,
                    color: Colors.grey[600],
                    indent: 15,
                    endIndent: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getPoundValueFromGBT(
                          viewmodel.gbtBalance.value,
                        ).formattedGBPPrice,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      // Image.asset(
                      //   ImagePaths.vegiBeanMan,
                      //   width: 25,
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class GBTInUseCard extends StatelessWidget {
  const GBTInUseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Text(
            'Current Cash Balance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[800],
          ),
          height: 85,
          child: StoreConnector<AppState, BalanceViewModel>(
            converter: BalanceViewModel.fromStore,
            builder: (context, viewmodel) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Use',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        viewmodel.selectedGBTToSpend.value.toStringAsFixed(0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        TokenDefinitions.greenBeanToken.symbol,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  // Center(
                  //   child: Image.asset(
                  //     ImagePaths.vegiBeanMan,
                  //     width: 25,
                  //   ),
                  // ),
                  VerticalDivider(
                    width: 20,
                    thickness: 2,
                    color: Colors.grey[600],
                    indent: 15,
                    endIndent: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Keep',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        // getPoundValueFromGBT(
                        //   math.max(viewmodel.gbtBalance.value - viewmodel.selectedGBTToSpend.value, 0),
                        // ).formattedGBPPrice,
                        math
                            .max(
                                viewmodel.gbtBalance.value -
                                    viewmodel.selectedGBTToSpend.value,
                                0)
                            .toStringAsFixed(0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      // Image.asset(
                      //   ImagePaths.vegiBeanMan,
                      //   width: 25,
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
