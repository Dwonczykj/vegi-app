import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  late void Function() logout;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller
      ..addListener(() {
        setState(() {});
      })
      ..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, void>(
      converter: (store) {
        logout = () {
          if (store.state.userState.hasSavedSeedPhrase) {
            store.dispatch(logoutRequest());
            context.router.replace(const OnBoardScreen());
            Analytics.track(eventName: AnalyticsEvents.logout);
          }
          context.router.pop();
          authenticator.logout();
        };
      },
      builder: (_, viewmodel) {
        return ScaleTransition(
          scale: scaleAnimation,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            content: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Are you sure you would like to logout?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // const Text(
                  //   'Your seed phrase can be found in the'
                  //   ' Account section. See you soon 👋',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  PrimaryButton(onPressed: () => logout(), label: 'Logout')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
