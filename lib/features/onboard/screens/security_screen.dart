import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/screens/set_up_pincode.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/viewsmodels/security.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/biometric_local_auth.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

import 'package:auto_route/annotations.dart';

@RoutePage()
class ChooseSecurityOption extends StatefulWidget {
  const ChooseSecurityOption({Key? key}) : super(key: key);

  @override
  State<ChooseSecurityOption> createState() => _ChooseSecurityOptionState();
}

class _ChooseSecurityOptionState extends State<ChooseSecurityOption> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BiometricAuth>(
      future: BiometricUtils.getAvailableBiometrics(),
      builder: (context, AsyncSnapshot<BiometricAuth> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return MyScaffold(
            title: I10n.of(context).protect_wallet,
            body: SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        SvgPicture.asset(ImagePaths.lock),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            I10n.of(context).choose_lock_method,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        StoreConnector<AppState, SecurityViewModel>(
                          distinct: true,
                          converter: SecurityViewModel.fromStore,
                          builder: (_, viewModel) {
                            return Container(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      InkWell(
                                        focusColor:
                                            Theme.of(context).canvasColor,
                                        highlightColor:
                                            Theme.of(context).canvasColor,
                                        child: Container(
                                          height: 60,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .8,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ],
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(11),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                    'assets/images/${BiometricAuth.faceID.name == snapshot.requireData.name ? 'face_id' : 'fingerprint'}.svg',
                                                    color: Theme.of(context)
                                                        .canvasColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    BiometricUtils
                                                        .getBiometricString(
                                                      snapshot.requireData,
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .canvasColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                    ImagePaths
                                                        .securityLockInfoBlack,
                                                    color: Theme.of(context)
                                                        .canvasColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    I10n.of(context)
                                                        .recommended,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .canvasColor,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () async {
                                          final String biometric =
                                              BiometricUtils.getBiometricString(
                                            snapshot.requireData,
                                          );
                                          await BiometricUtils
                                              .showDefaultPopupCheckBiometricAuth(
                                            message:
                                                'Please use $biometric to unlock!',
                                            callback: (bool result) {
                                              if (result) {
                                                viewModel
                                                    .setBiometricallyAuthenticated(
                                                  isBiometricallyAuthenticated:
                                                      true,
                                                );
                                                Analytics.track(
                                                  eventName: AnalyticsEvents
                                                      .securityScreen,
                                                  properties: {
                                                    'auth_type': snapshot
                                                        .requireData
                                                        .toString()
                                                  },
                                                );
                                                viewModel.setSecurityType(
                                                  snapshot.requireData,
                                                );
                                                log.info(
                                                  'rootRouter.replaceAll with MainScreen from BiometricUtils.showDefaultPopupCheckBiometricAuth popup on completion',
                                                  sentry: true,
                                                );
                                                rootRouter.replaceAll(
                                                  [const MainScreen()],
                                                );
                                                Analytics.track(
                                                  eventName: AnalyticsEvents
                                                      .onboardingCompleted,
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      InkWell(
                                        focusColor:
                                            Theme.of(context).canvasColor,
                                        highlightColor:
                                            Theme.of(context).canvasColor,
                                        child: Container(
                                          height: 60,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .8,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(11),
                                            ),
                                            color: Color(0xFFF7F7F7),
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                ImagePaths.pincode,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                I10n.of(context).pincode,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          Analytics.track(
                                            eventName:
                                                AnalyticsEvents.securityScreen,
                                            properties: {
                                              'auth_type': 'pincode'
                                            },
                                          );
                                          log.info(
                                            'Navigator.push construct inline MaterialPageRoute for SetUpPinCodeScreen component to set a pincode',
                                            sentry: true,
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<
                                                SetUpPinCodeScreen>(
                                              builder: (context) =>
                                                  SetUpPinCodeScreen(
                                                onSuccess: () {
                                                  log.info(
                                                    'rootRouter.replaceAll with MainScreen from SetUpPinCodeScreen [inline route within ChooseSecurityOption]',
                                                    sentry: true,
                                                  );
                                                  viewModel
                                                      .setBiometricallyAuthenticated(
                                                    isBiometricallyAuthenticated:
                                                        true,
                                                  );
                                                  rootRouter.replaceAll(
                                                    [const MainScreen()],
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                          Analytics.track(
                                            eventName: AnalyticsEvents
                                                .onboardingCompleted,
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                // margin: EdgeInsets.only(left: 28, right: 28),
              ),
            ],
          );
        }
      },
    );
  }
}
