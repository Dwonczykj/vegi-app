import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/common/di/package_info.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/url.dart';

import 'package:auto_route/annotations.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'About Us',
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Image.asset('assets/images/Vegi-Logo-horizontal.png'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'We are vegi, your local vegan shopping app!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Buy groceries, takeaways and plant-based products'
                        ' from independent businesses using your vegi wallet.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Follow our journey on our website $VEGI_BASE_URL'
                        ' or on our Instagram ($VEGI_INSTA_HANDLE) or Tiktok ($VEGI_TIKTOK_HANDLE)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Spacer(),
                      SizedBox(
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
                              onPressed: () => launchUrl(
                                VEGI_TIKTOK_PROFILE_URL,
                              ),
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
                      Text(
                        'Version ${packageInfo.version},'
                        ' Build ${packageInfo.buildNumber},'
                        ' Env ${Env.activeEnv}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
