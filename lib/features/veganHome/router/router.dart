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

// final veganHomeTabs = [
//   VeganHomeScreen(),
//   RestaurantMenuScreen(),
//   OrderConfirmedScreen(),
//   // ProfileScreen(),
//   TopupScreen(),
//   AllOrdersRoute(),
//   ScheduledOrdersRoute(),
//   FAQScreen(),
//   AboutScreen(),
//   PreparingOrderRoute(),
//   // AutoRoute(
//   //   page: ShowUserMnemonicScreen.page,
//   //   name: 'showUserMnemonic',
//   //   // guards: [AuthGuard],
//   // ),
//   // AutoRoute(
//   //   page: VerifyUserMnemonic.page,
//   //   name: 'verifyUserMnemonic',
//   //   // guards: [AuthGuard],
//   // ),
//   CheckoutScreenPt2(),
//   GenerateQRFromCartScreen(),
//   ScanPaymentRecipientQR(),
//   ScanListedProductQRCodeScreen(),
// ];

/// ~ https://pub.dev/packages/auto_route#nested-navigation
/// STEP 1:
/// - To render/build nested routes we need an AutoRouter widget that works as an outlet or a nested router-view inside of our dashboard page. (~ https://pub.dev/packages/auto_route#nested-navigation:~:text=To%20render/build%20nested%20routes%20we%20need%20an%20AutoRouter%20widget%20that%20works%20as%20an%20outlet%20or%20a%20nested%20router%2Dview%20inside%20of%20our%20dashboard%20page.)
/// The key is including this nested AutoRouter widget in the home-screen empty page component so that AutoRoute can populate it
/// ```dart
/// Expanded(
///  // nested routes will be rendered here
///  child: AutoRouter(),
/// );
/// ```
/// within:
/// ```dart
/// class DashboardPage extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Row(
///       children: [
///         Column(
///           children: [
///             NavLink(label: 'Users', destination: const UsersRoute()),
///             NavLink(label: 'Posts', destination: const PostsRoute()),
///             NavLink(label: 'Settings', destination: const SettingsRoute()),
///           ],
///         ),
///         Expanded(
///           // nested routes will be rendered here
///           child: AutoRouter(),
///         )
///       ],
///     );
///   }
/// }
/// ```
///
/// Step 2:
/// To force showing child routes at vegi-home path, ->
/// we can simply do that by giving the child routes an empty path '' to make initial or by setting initial to true.
/// ~ https://pub.dev/packages/auto_route#nested-navigation:~:text=we%20can%20simply%20do%20that%20by%20giving%20the%20child%20routes%20an%20empty%20path%20%27%27%20to%20make%20initial%20or%20by%20setting%20initial%20to%20true.
/// or by using a RedirectRoute
/// ~ https://pub.dev/packages/auto_route#nested-navigation:~:text=or%20by%20using%20a%20RedirectRoute
final veganHomeTab = AutoRoute(
  path:
      'vegi', // ! AutoRouter -> FlutterError(Sub-paths can not start with a "/")
  // name: 'veganHomeTab',
  page: VegiHomeRoute
      .page, // needs to be defined from a widget screeen that contains an auto_route placeholder.
  children: [
    // Can either use a default route with an empty child path to make it the default first route
    // AutoRoute(
    //   initial: true,
    //   path: '', // * if want to show one of the child pages at /vegi-home default route
    //   page: VeganHomeScreen.page,
    //   // name: 'veganHomeScreen',
    //   // guards: [AuthGuard],
    // ),
    // alterntatively can use a redirect route and actual home route path with empty default child path to do the same and create the initiail child route
    RedirectRoute(
      path: '',
      redirectTo: 'home',
    ), // ! child routes do NOT have to start with a '/'
    AutoRoute(
      path:
          'home', // * if want to show one of the child pages at /vegi-home default route
      page: VeganHomeScreen.page,
      // name: 'veganHomeScreen',
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
