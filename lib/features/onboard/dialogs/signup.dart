import 'package:flutter/material.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/screens/webview_screen.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class SignUpDialog extends StatefulWidget {
  const SignUpDialog({Key? key}) : super(key: key);

  @override
  State<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    opacityAnimation = Tween<double>(begin: 0, end: 0.4).animate(
      CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
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
        content: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'vegi',
                          style: TextStyle(
                            color: themeShade850,
                            // fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' uses your phone number to authenticate you so that we can keep your account safe.',
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'We also use your email to provide an added layer of protection.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Your personal details are',
                        ),
                        TextSpan(
                          text: ' NEVER ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 220, 154, 11),
                            // fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'linked to payments or any other information, they are used at this point for authentication & security.',
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'vegi',
                          style: TextStyle(
                            color: themeShade850,
                            // fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' DOES NOT ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 220, 154, 11),
                            // fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'share this information with 3rd parties.',
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    I10n.of(context).for_more_info,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    focusColor: Theme.of(context).canvasColor,
                    highlightColor: Theme.of(context).canvasColor,
                    onTap: () => showModalBottomSheet<Widget>(
                      context: context,
                      builder: (_) => const WebViewScreen(
                        url: VEGI_PRIVACY_URL,
                        title: 'Legal',
                      ),
                    ),
                    child: const Text.rich(
                      TextSpan(
                        text: VEGI_PRIVACY_URL,
                        style: TextStyle(
                          color: Color(0xFF0076FF),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          // TextSpan(
                          //   text: ' ${Currency.PPL.name}',
                          //   style: TextStyle(
                          //     color: Colors.grey[700],
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ],
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: PrimaryButton(
                      label: I10n.of(context).ok_thanks,
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
