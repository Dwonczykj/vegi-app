import 'package:auto_route/auto_route.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
// import 'package:auto_route/empty_router_widgets.dart';
// import 'package:vegan_liverpool/common/router/route_// guards.dart';
// import 'package:vegan_liverpool/features/account/screens/profile.dart';
// import 'package:vegan_liverpool/features/onboard/screens/show_user_mnemonic.dart';
// import 'package:vegan_liverpool/features/onboard/screens/verify_user_mnemonic.dart';
// import 'package:vegan_liverpool/features/pay/screens/generate_QR_from_cart_screen.dart';
// import 'package:vegan_liverpool/features/pay/screens/scan_payment_recipient_qr.dart';
// import 'package:vegan_liverpool/features/topup/screens/topup.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/aboutScreen.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/allOrdersPage.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/checkout_screen_2.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/faqScreen.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/orderConfirmed.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/preparingOrderScreen.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/restaurantMenuScreen.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/scan_listed_product_qrcode.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/scheduledOrdersPage.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/veganHome.dart';

@RoutePage(name: 'VeganHomeRouter')
class VeganHomeRouterPage extends AutoRouter {}

final veganHomeTab = AutoRoute(
  path: 'vegi-home',
  // name: 'veganHomeTab',
  page: VeganHomeRouter.page,
  children: [
    AutoRoute(
      initial: true,
      page: VeganHomeScreen.page,
      // name: 'veganHomeScreen',
      path: 'home',
      // guards: [AuthGuard],
    ),
    CustomRoute(
      page: RestaurantMenuScreen.page,
      // name: 'restaurantMenuScreen',
      // guards: [AuthGuard],
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    ),
    CustomRoute(
      page: OrderConfirmedScreen.page,
      // name: 'orderConfirmedScreen',
      // guards: [AuthGuard],
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    // AutoRoute(
    //   page: ProfileScreen,
    //   name: 'profileScreen',
    //   // guards: [AuthGuard],
    // ),
    AutoRoute(
      page: TopupScreen.page,
      // name: 'TopUpScreen',
      // guards: [AuthGuard],
    ),
    AutoRoute(
      page: AllOrdersRoute.page,
      // name: 'AllOrdersPage',
      // guards: [AuthGuard],
    ),
    AutoRoute(
      page: ScheduledOrdersRoute.page,
      // name: 'ScheduledOrdersPage',
      // guards: [AuthGuard],
    ),
    AutoRoute(
      page: FAQScreen.page,
      // name: 'FAQScreen',
      // guards: [AuthGuard],
    ),
    AutoRoute(
      page: AboutScreen.page,
      // name: 'aboutScreen',
      // guards: [AuthGuard],
    ),
    CustomRoute(
      page: PreparingOrderRoute.page,
      // name: 'PreparingOrderPage',
      // guards: [AuthGuard],
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    // AutoRoute(
    //   page: ShowUserMnemonicScreen.page,
    //   name: 'showUserMnemonic',
    //   // guards: [AuthGuard],
    // ),
    // AutoRoute(
    //   page: VerifyUserMnemonic.page,
    //   name: 'verifyUserMnemonic',
    //   // guards: [AuthGuard],
    // ),
    AutoRoute(
      page: CheckoutScreenPt2.page,
      // name: 'checkoutScreenPt2',
      // guards: [AuthGuard],
    ),
    AutoRoute(
      page: GenerateQRFromCartScreen.page,
      // name: 'generateQRFromCartScreen',
      // guards: [AuthGuard],
    ),
    AutoRoute(
      page: ScanPaymentRecipientQR.page,
      // name: 'scanPaymentRecipientQR',
      // guards: [AuthGuard],
    ),
    AutoRoute(
      page: ScanListedProductQRCodeScreen.page,
      // name: 'scanProductQRCode',
      // guards: [AuthGuard(<params>)],
    ),
  ],
);
