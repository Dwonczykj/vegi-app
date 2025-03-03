import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/cart/order.dart';
import 'package:vegan_liverpool/models/restaurant/orderDetails.dart';
import 'package:vegan_liverpool/redux/viewsmodels/bill_invoice_vm.dart';
import 'package:vegan_liverpool/utils/config.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class BillInvoiceCard extends StatelessWidget {
  const BillInvoiceCard({
    required this.order,
    Key? key,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: themeShade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: StoreConnector<AppState, BillInvoiceViewModel>(
            converter: BillInvoiceViewModel.fromStore,
            distinct: true,
            builder: (context, viewmodel) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bill Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Payment status',
                      ),
                      Text(
                        order.paymentStatusLabel,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount paid in ${order.GBPAmountPaid.currency.name}',
                      ),
                      Text(
                        (order.GBPAmountPaid).formattedGBPPrice,
                      ),
                    ],
                  ),
                  if (order.didUseGBT) ...[
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount paid in ${TokenDefinitions.greenBeanToken.name}',
                        ),
                        Text(
                          order.rewardsTokensAmountPaid.toStringAsFixed(0),
                        ),
                      ],
                    ),
                  ],
                  const Divider(
                    color: themeShade300,
                    thickness: 1,
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Rewards Earned',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      // const SizedBox(
                      //   width: 4,
                      // ),
                      // Image.asset(
                      //   ImagePaths.pplAvatar35width,
                      //   width: 23,
                      // ),
                      const Spacer(),
                      Text(
                        '${order.rewardsEarnedInTokensFormatted} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '(${order.gbtRewardsEarnedValue})',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
