import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/vegiDialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/vegiDialogButton.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/log_event.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/url.dart';

class AppLogDetailDialog extends StatelessWidget {
  const AppLogDetailDialog({
    required this.log,
    Key? key,
  }) : super(key: key);

  final LogEvent log;

  @override
  Widget build(BuildContext context) {
    return VegiDialog(
      storeConverter: (store) {},
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Log message',

              /// `textAlign` is a property of the `Text` widget in Flutter that determines how the text
              /// should be aligned within its container. It accepts a `TextAlign` enum value, which can
              /// be set to `TextAlign.left`, `TextAlign.right`, `TextAlign.center`, or
              /// `TextAlign.justify`.
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeAccent600,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              log.message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              '${log.timestamp}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                // fontSize: 20,
                // fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              child: Text(log.information.toString()),
              onTap: () => context.router.push(
                ViewJsonScreen(data: log.information,)
              ),
            ),
            // _dialogButton(
            //   context: context,
            //   label: instaDMContactVegiSupportUrlButtonLabel,
            //   icon: FontAwesomeIcons.instagram,
            //   onPressed: () => launchUrl(VEGI_INSTA_PROFILE_URL),
            // ),
          ],
        ),
      ),
    );
  }
}
