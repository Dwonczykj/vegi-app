import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/restaurant/VendorHomeView.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/restaurant/featuredRestaurantList.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/backupWalletAppBar.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/navDrawer.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/preparingOrderAppBar.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/searchVendorsAppBar.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/veganSliverAppBar.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/pastOrders.dart';
import 'package:auto_route/annotations.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';

@RoutePage()
class VeganHomeScreen extends StatelessWidget {
  const VeganHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PastOrdersViewmodel>(
      converter: PastOrdersViewmodel.fromStore,
      onInit: (store) async {
        store.dispatch(isUserWalletAddressAVendorAddress());
      },
      builder: (_, viewmodel) {
        return Scaffold(
          drawer: const NavDrawer(),
          body: Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder: (_, flag) => [
                  const VeganSliverAppBar(),
                  const BackupWalletAppBar(),
                  if (viewmodel.globalSearchIsVisible && !viewmodel.isVendor)
                    const SearchVendorsAppBar(),
                  if (!viewmodel.isVendor &&
                      viewmodel.scheduledOrderToShow != null)
                    PreparingOrderAppBar(
                      order: viewmodel.scheduledOrderToShow!,
                    ),
                ],
                body: viewmodel.isVendor
                    ? const VendorHomeView() // todo: Make this screen into 2 tiles... -> take payment and new customer
                    : const FeaturedRestaurantList(),
              ),
              if (viewmodel.isLoading)
                const Center(
                  child: CircularProgressIndicator(color: themeShade400),
                ),
            ],
          ),
        );
      },
    );
  }
}
