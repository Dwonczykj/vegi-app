import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/chooseCashBackSlider.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/paymentSheet.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/cart/discount.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/checkout/discount_card_vm.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class DiscountCards extends StatelessWidget {
  const DiscountCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DiscountCardViewModel>(
      converter: DiscountCardViewModel.fromStore,
      builder: (context, viewmodel) {
        return Column(
          children: [
            ...viewmodel.activeVouchers
                .where(
              (element) => element.currency == viewmodel.cartCurrency,
            )
                .map((voucher) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: DiscountCard(
                  hasDiscount: true,
                  discountCode: voucher.code,
                  discount: voucher,
                  onTap: () async {
                    await showErrorSnack(
                      context: context,
                      title: Messages.permissionDenied,
                      message: Messages.removeVoucherCodeNotAllowed,
                    );
                  },
                  allowRemovalAction: true,
                  removeDiscount: () {
                    log.verbose('remove applied voucher: [${voucher.id}]');
                    viewmodel.removeAppliedVoucher(
                      voucher: voucher,
                    );
                  },
                  icon: Icon(
                    voucher.currency == Currency.percent
                        ? FontAwesomeIcons.percent
                        : voucher.currency == Currency.GBP
                            ? FontAwesomeIcons.sterlingSign
                            : FontAwesomeIcons.coins,
                    size: 18,
                  ),
                ),
              );
            }),
            const CashBackGBTRewardsCard(),
            const CreateDiscountCard(),
          ],
        );
      },
    );
  }
}

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    required this.hasDiscount,
    required this.discountCode,
    required this.icon,
    required this.allowRemovalAction,
    this.discount,
    this.removeDiscount,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final bool hasDiscount;
  final bool allowRemovalAction;
  final String discountCode;
  final Discount? discount;
  final Icon icon;
  final void Function()? removeDiscount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final discountValue = discount == null
        ? null
        : Money(
            currency: discount!.currency,
            value: discount!.value,
          );

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: themeShade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Row(
              children: [
                icon,
                const SizedBox(
                  width: 5,
                ),
                Text(
                  hasDiscount
                      ? discountValue != null
                          ? '$discountCode ($discountValue)'
                          : discountCode
                      : 'Add a discount code',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (allowRemovalAction) ...[
                  const Spacer(),
                  if (hasDiscount && removeDiscount != null)
                    IconButton(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 2),
                      onPressed: removeDiscount,
                      icon: const Icon(
                        Icons.remove,
                        size: 18,
                      ),
                    )
                  else if (hasDiscount)
                    const Icon(
                      Icons.savings,
                      size: 18,
                    )
                  else
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CashBackGBTRewardsCard extends StatelessWidget {
  const CashBackGBTRewardsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, DiscountCardViewModel>(
      converter: DiscountCardViewModel.fromStore,
      builder: (context, viewmodel) {
        return DiscountCard(
          hasDiscount: true,
          discountCode: 'cash back',
          removeDiscount: null,
          discount: Discount(
            code: 'cash back',
            currency: Currency.GBP,
            discountType: DiscountType.fixed,
            id: -1,
            // value: store.state.cashWalletState.tokens[greenBeanToken.address]!
            //     .getFiatBalance(),
            value:
                store.state.cartState.selectedCashBackAppliedToCart.inGBPValue,
            isEnabled: true,
            expiryDateTime: null,
            linkedWalletAddress: null,
            maxUses: 1,
            timesUsed: 0,
            vendor: null,
          ),
          onTap: () async {
            unawaited(
              Analytics.track(
                eventName: AnalyticsEvents.addDiscount,
              ),
            );
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
              builder: (context) => const ChooseCashBackSlider(),
            );
          },
          icon: const Icon(
            Icons.currency_pound,
            size: 18,
          ),
          allowRemovalAction: true,
        );
      },
    );
  }
}

class CreateDiscountCard extends StatelessWidget {
  const CreateDiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DiscountCardViewModel>(
      converter: DiscountCardViewModel.fromStore,
      builder: (context, viewmodel) {
        return DiscountCard(
          hasDiscount: viewmodel.hasDiscount,
          discountCode: viewmodel.discountCode,
          removeDiscount: viewmodel.removeDiscount,
          onTap: () async {
            unawaited(
              Analytics.track(
                eventName: AnalyticsEvents.addDiscount,
              ),
            );
            await showModalBottomSheet<Widget>(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              context: context,
              builder: (_) => const DiscountSelectorModalSheet(),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.percent,
            size: 18,
          ),
          allowRemovalAction: true,
        );
      },
    );
  }
}

class DiscountSelectorModalSheet extends StatefulWidget {
  const DiscountSelectorModalSheet({Key? key}) : super(key: key);

  @override
  State<DiscountSelectorModalSheet> createState() =>
      _DiscountSelectorModalSheetState();
}

class _DiscountSelectorModalSheetState
    extends State<DiscountSelectorModalSheet> {
  late GlobalKey<FormBuilderState> _discountForm;

  bool _isLoading = false;

  @override
  void initState() {
    _discountForm = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: StoreConnector<AppState, void Function(String)>(
            converter: (store) {
              return (discountCode) {
                log.verbose('add voucher: "$discountCode"');
                store.dispatch(
                  updateCartDiscount(
                    newDiscountCode: discountCode,
                    successCallback: () => setState(() {
                      _isLoading = false;
                      context.router.pop();
                    }),
                    errorCallback: () {
                      setState(() {
                        _isLoading = false;
                        _discountForm.currentState!.invalidateField(
                          name: 'discountCode',
                          errorText: 'Discount code invalid',
                        );
                      });
                    },
                  ),
                );
              };
            },
            builder: (context, setDiscountCode) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter a discount code',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilder(
                    key: _discountForm,
                    child: FormBuilderTextField(
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Discount Code',
                        isDense: true,
                      ),
                      name: 'discountCode',
                      onChanged: (value) {
                        if (_discountForm
                            .currentState!.fields['discountCode']!.hasError) {
                          _discountForm.currentState!.fields['discountCode']!
                              .reset();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    onPressed: () {
                      setState(() => _isLoading = true);
                      setDiscountCode(
                        _discountForm.currentState!.fields['discountCode']!
                            .value as String,
                      );
                    },
                    label: 'Apply',
                    width: double.infinity,
                    preload: _isLoading,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
