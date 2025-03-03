import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/models/cart/order.dart';
import 'package:vegan_liverpool/models/restaurant/orderDetails.dart';

class PreparingOrderAppBar extends StatelessWidget {
  const PreparingOrderAppBar({required this.order, Key? key}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    String headerText =
        'Order #${order.orderID} ${order.restaurantAcceptanceStatus.displayTitle}';
    Color barColor = themeShade200;
    if (order.paymentStatus == OrderPaidStatus.failed ||
        order.paymentStatus == OrderPaidStatus.unpaid) {
      headerText =
          'Order #${order.orderID} payment ${order.paymentStatus.name}!';
      barColor = themeLightShade1000;
    }
    return SliverAppBar(
      toolbarHeight: 50,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      expandedHeight: MediaQuery.of(context).size.height * 0.01,
      flexibleSpace: FlexibleSpaceBar(
        title: GestureDetector(
          onTap: () => context.router.push(
            PreparingOrderRoute(order: order),
          ),
          child: Card(
            color: barColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: themeShade900,
                width: 2,
              ),
            ),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  headerText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
