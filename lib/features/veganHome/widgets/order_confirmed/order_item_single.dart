import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/models/cart/view_item.dart';
import 'package:vegan_liverpool/models/restaurant/cartItem.dart';
import 'package:vegan_liverpool/services.dart';

class OrderItemSingle extends StatelessWidget {
  const OrderItemSingle({required this.orderItem, Key? key}) : super(key: key);

  final ViewItem orderItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (orderItem.id != null) {
          rootRouter.push(ESCExplainRatingScreen(productId: orderItem.id!));
        } else {
          showInfoSnack(context,
              title: 'No explanations available for this product right now');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderItem.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    orderItem.totalPriceFormatted,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ] +
            orderItem.chosenOptions
                .map<Widget>(
                  Text.new,
                )
                .toList(),
      ),
    );
  }
}
