import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/menu/suggestProductDialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/deleteAccountDialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/helpDialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/logoutDialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/userAvatar.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/vegiAvatar.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/viewsmodels/drawer.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/url.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    const avatarSquareSize = 50.0;
    return StoreConnector<AppState, DrawerViewModel>(
      distinct: true,
      converter: DrawerViewModel.fromStore,
      builder: (_, viewmodel) {
        return Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: themeShade300,
                ),
                child: Column(
                  children: [
                    // if (viewmodel.avatarUrl == '')
                    //   const CircleAvatar(
                    //     backgroundImage: AssetImage('assets/images/anom.png'),
                    //     radius:
                    //         avatarSquareSize / 2.0 + (avatarSquareSize * 0.1),
                    //   )
                    // else
                    //   UserAvatar(
                    //     avatarUrl: viewmodel.avatarUrl,
                    //     avatarSquareSize: avatarSquareSize,
                    //     showAdminBanner: viewmodel.isSuperAdmin,
                    //     isUpdating: false,
                    //   ),
                    const VegiAvatar(
                      isEditable: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 8,
                      ),
                      child: Text(
                        'Hi ${viewmodel.firstName()}!',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Row(
                          
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (viewmodel.scheduledOrders.isNotEmpty)
                        ListTile(
                          leading: const Icon(Icons.timer_outlined),
                          title: const Text('Scheduled Orders'),
                          onTap: () {
                            Analytics.track(
                                eventName: AnalyticsEvents.viewSchOrders,);
                            context.router.push(const ScheduledOrdersPage());
                          },
                        ),
                      if (DebugHelpers.inDebugMode)
                        ListTile(
                          leading: const Icon(Icons.money),
                          title: const Text('Top Up Wallet [Debug]'),
                          onTap: () {
                            context.router.push(const TopUpScreen());
                          },
                        ),
                      ListTile(
                        leading: const Icon(Icons.local_offer),
                        title: const Text('Add vouchers'),
                        onTap: () {
                          context.router.push(
                            AddDiscountCodeScreen(
                              onVerifyDiscountCode: () {
                                context.router.pop();
                              },
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(FontAwesomeIcons.clockRotateLeft),
                        title: const Text('My Orders'),
                        onTap: () {
                          Analytics.track(
                              eventName: AnalyticsEvents.viewAllOrders,);
                          context.router.push(const AllOrdersPage());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Account'),
                        onTap: () {
                          Analytics.track(
                              eventName: AnalyticsEvents.viewAccount,);
                          context.router.push(const ProfileScreen());
                        },
                      ),
                      // ListTile(
                      //   leading: const Icon(Icons.lock),
                      //   title: const Text('Security'),
                      //   onTap: () {
                      //     Analytics.track(
                      //         eventName: AnalyticsEvents.securityScreen);
                      //     context.router.push(const ChooseSecurityOption());
                      //   },
                      // ),
                      ListTile(
                        leading: const Icon(Icons.quiz),
                        title: const Text('FAQs'),
                        onTap: () {
                          Analytics.track(eventName: AnalyticsEvents.viewFAQ);
                          context.router.push(const FAQScreen());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.headset_mic),
                        title: const Text('Contact Us'),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => const HelpDialog(),
                        ).then((value) {}),
                      ),
                      ListTile(
                        leading: const Icon(Icons.help_sharp),
                        title: const Text('About vegi'),
                        onTap: () {
                          Analytics.track(eventName: AnalyticsEvents.viewAbout);
                          context.router.push(const AboutScreen());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.exit_to_app),
                        title: const Text('Logout'),
                        onTap: () => showDialog<Widget>(
                          context: context,
                          builder: (context) => const LogoutDialog(),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete_forever),
                        title: const Text('Delete Account'),
                        onTap: () => showDialog<Widget>(
                          context: context,
                          builder: (context) => const DeleteAccountDialog(),
                        ),
                      ),
                      if (kDebugMode)
                        ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: const Text('DevTools'),
                          onTap: () => rootRouter.push(
                            ReduxStateViewer(
                              store: getIt<DevToolsStore<AppState>>(),
                            ),
                          ),
                        ),
                      if (kDebugMode && viewmodel.isSuperAdmin)
                        ListTile(
                          leading: const Icon(Icons.qr_code_scanner),
                          title: const Text('QR scan (DEV)'),
                          onTap: () => showDialog<Widget>(
                            context: context,
                            builder: (context) => const SuggestProductDialog(),
                          ),
                        ),
                      ListTile(
                        leading: const Icon(Icons.note),
                        title: const Text('Logs'),
                        onTap: () => rootRouter.push(const AppLogListView()),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () => launchUrl(
                          VEGI_INSTA_PROFILE_URL,
                        ),
                        icon: Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.grey[400],
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () => launchUrl(VEGI_TIKTOK_PROFILE_URL),
                        icon: Icon(
                          FontAwesomeIcons.tiktok,
                          color: Colors.grey[400],
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: () => launchUrl(VEGI_BASE_URL),
                        icon: Icon(
                          Icons.launch,
                          color: Colors.grey[400],
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
