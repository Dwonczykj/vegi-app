import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/features/veganHome/screens/orderView.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/order_confirmed/order_item_single.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/shimmerButton.dart';
import 'package:vegan_liverpool/models/cart/order.dart';
import 'package:vegan_liverpool/models/cart/view_item.dart';
import 'package:vegan_liverpool/models/restaurant/orderDetails.dart';

@RoutePage()
class PreparingOrderPage extends StatelessWidget {
  const PreparingOrderPage({required this.order, Key? key}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return OrderViewScreen(
      order: order,
      isNewOrder: false,
      homeAction: () {
        context.router.replaceAll([const VeganHomeScreen()]);
      },
    );
  }
}
