import 'package:auto_route/auto_route.dart';

import '../../../common/router/routes.gr.dart';

@RoutePage(name: 'TopUpRouter')
class TopUpRouterPage extends AutoRouter {}

final topupTab = AutoRoute(
  path: 'topup',
  page: TopUpRouter.page,
  children: [
    AutoRoute(
      initial: true,
      path: 'topUp',
      page: TopupScreen.page,
    ),
    AutoRoute(
      page: TopupExplained.page,
    ),
  ],
);
