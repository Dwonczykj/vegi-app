import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/user_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/backup.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    this.onLoginResult,
  }) : super(key: key);
  final void Function(bool isLoggedIn)? onLoginResult;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Flushbar<bool> flush;

  bool isRouting = false;
  double? _opacity;
  bool _loaded = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          // _opacity = 1.0;
          _opacity = 0.0;
        });
      }
    });
    super.initState();
  }

  Future<void> finishAppStart(
    BuildContext context, {
    required Store<AppState> store,
  }) async {
    log.info('finishAppStart() called from SplashScreen');
    final String privateKey = store.state.userState.privateKey;
    final String jwtToken = store.state.userState.jwtToken;
    final bool isLoggedOut = store.state.userState.hasNotOnboarded ||
        !store.state.userState.isLoggedIn;
    if (privateKey.isEmpty || jwtToken.isEmpty || isLoggedOut) {
      log.info(
          'Push OnBoardScreen() from ${rootRouter.current.name} at splash_screen.dart');
      const navTo = OnBoardScreen();
      if (mounted) {
        await context.router.push(navTo);
      } else {
        await rootRouter.push(navTo);
      }
      widget.onLoginResult?.call(false);
      return;
    }
    final UserState userState = store.state.userState;
    if (userState.isLoggedIn && userState.authType != BiometricAuth.none) {
      const navTo = PinCodeScreen();
      if (mounted) {
        await context.router.push(navTo);
      } else {
        await rootRouter.push(navTo);
      }
      log.info(
        'User is already authenticated so push the PinCodeScreen and check user details on vegi backend',
        sentry: true,
      );
      store
          // ..dispatch(getUserDetails())
          .dispatch(getVegiWalletAccountDetails());
    } else {
      const navTo = OnBoardScreen();
      if (mounted) {
        await context.router.push(navTo);
      } else {
        await rootRouter.push(navTo);
      }
      log.info(
        'Navigate to OnBoardScreen from splash_screen because user has authState: ${store.state.userState.authState} and biometricAuth: [${userState.authType}]',
        sentry: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LockScreenViewModel>(
      onInit: (store) {
        // unawaited(finishAppStart(context, store: store));
        Future.delayed(const Duration(seconds: 1), () {
          finishAppStart(context, store: store);
        });
      },
      converter: LockScreenViewModel.fromStore,
      distinct: true,
      // onWillChange: (previousViewModel, newViewModel) async {
      //   if (isRouting) {
      //     return;
      //   }
      //   if (newViewModel.fuseAuthenticationStatus ==
      //           FuseAuthenticationStatus.authenticated &&
      //       previousViewModel?.fuseAuthenticationStatus !=
      //           FuseAuthenticationStatus.authenticated) {
      //     return _handleFuseAuthenticationSucceeded();
      //   }
      //   final checked = checkAuth(
      //     oldViewModel: previousViewModel,
      //     newViewModel: newViewModel,
      //     routerContext: context,
      //   );
      //   await checked.runNavigationIfNeeded();
      // },
      builder: (context, viewModel) {
        // final store = StoreProvider.of<AppState>(context);
        // finishAppStart(context, store: store);
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      ImagePaths.onboardingTextureBelowBackgroundBrightCream,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    248,
                    251,
                    244,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      ImagePaths.onboardingPage1Background,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   left: -30,
              //   top: 0,
              //   child: CustomPaint(
              //     size: const Size(
              //       200,
              //       200 * 0.9019230769230769,
              //     ),
              //     painter: Shape1(),
              //   ),
              // ),
              // AnimatedPositioned(
              //   curve: Curves.fastLinearToSlowEaseIn,
              //   left: _left ?? MediaQuery.of(context).size.width * 0.2,
              //   top: _top ?? MediaQuery.of(context).size.height * 0.3,
              //   duration: const Duration(seconds: 2),
              //   onEnd: () {
              //     setState(() {
              //       _opacity = 1;
              //     });
              //   },
              //   child: CustomPaint(
              //     size: Size(_width, _width * 1.1484641638225255),
              //     painter: PeamanPainter(),
              //   ),
              // ),
              AnimatedOpacity(
                // curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 1),
                opacity: _opacity ?? 0,
                child: Align(
                  child: Image.asset(
                    // 'assets/images/Vegi-Logo-horizontal.png',
                    ImagePaths.onboardingPage1VegiText,
                    width: MediaQuery.of(context).size.width * .4,
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
