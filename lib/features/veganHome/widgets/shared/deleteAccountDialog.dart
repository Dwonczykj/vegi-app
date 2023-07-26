import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/url.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

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
                'Delete account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'This is an irreversable operation!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Are you sure you wish to continue?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  // text: viewmodel.pplBalance,
                  children: [
                    TextSpan(
                      text: 'We hope you have enjoyed using vegi. Please '
                          'help us before you go by telling us ',
                      style: TextStyle(
                        color: Theme.of(context)
                            .dialogTheme
                            .contentTextStyle
                            ?.color,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: 'why you left here.',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          //Code to launch your URL
                          await launchUrl(VEGI_CONTACT_US_URL);
                        },
                      style: TextStyle(
                        color: Colors.blueAccent.shade400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'See you soon 👋',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onPressed: () async {
                  Navigator.pop(context);
                  (await reduxStore).dispatch(deleteUser());
                },
                label: 'Delete my account',
              )
            ],
          ),
        ),
      ),
    );
  }
}
