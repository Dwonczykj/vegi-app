import 'package:auto_route/auto_route.dart';
import 'package:vegan_liverpool/common/router/route_guards.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/features/account/screens/profile.dart';
import 'package:vegan_liverpool/features/topup/screens/topup.dart';

@RoutePage(name: 'AccountsRouter')
class AccountsRouterPage extends AutoRouter {
  @override
  List<AutoRoute> get routes => [
        accountTab,
      ];
}

final accountTab = AutoRoute(page: AccountsRouter.page);
