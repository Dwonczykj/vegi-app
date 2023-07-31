import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/constants/CustomPainterWidgets/customButton1.dart';
import 'package:vegan_liverpool/constants/CustomPainterWidgets/customButton2.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/onboard/widgets/firstOnboardingPage.dart';
import 'package:vegan_liverpool/features/onboard/widgets/on_boarding_page.dart';
import 'package:vegan_liverpool/features/onboard/widgets/sign_up_buttons.dart';
import 'package:vegan_liverpool/features/waitingListFunnel/screens/waitingListBetaEligibilityScreen.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  static const _kDuration = Duration(milliseconds: 2000);
  static const _kCurve = Curves.ease;

  Color screenColor = Colors.white;

  double _bottomRowOpacity = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final tween = MovieTween();

  @override
  Widget build(BuildContext context) {
    final List<Widget> welcomeScreens = [
      const FirstOnboardingPage(),
      const OnBoardingScreenGeneric(
        title: CopyWrite.onboardingScreenHeading1,
        subTitle: CopyWrite.onboardingScreenSubHeading1,
        iconName: ImagePaths.onboardingPage2HeadingImage1,
        backgroundImageOverlayPath: ImagePaths.onboardingPage2Background,
        backgroundTexturePath:
            ImagePaths.onboardingTextureBelowBackgroundDarkGreen,
        headingColour: themeShade1000,
        subHeadingColour: Colors.black,
      ),
      const OnBoardingScreenGeneric(
        title: CopyWrite.onboardingScreenHeading2,
        subTitle: CopyWrite.onboardingScreenSubHeading2,
        iconName: ImagePaths.onboardingPage3HeadingImage2,
        backgroundImageOverlayPath: ImagePaths.onboardingPage3Background,
        backgroundTexturePath:
            ImagePaths.onboardingTextureBelowBackgroundDarkGreen,
        headingColour: themeShade400,
        subHeadingColour: themeShade200,
      ),
      const OnBoardingScreenGeneric(
        title: CopyWrite.onboardingScreenHeading3,
        subTitle: CopyWrite.onboardingScreenSubHeading3,
        iconName: ImagePaths.onboardingPage4HeadingImage3,
        backgroundImageOverlayPath: ImagePaths.onboardingPage4Background,
        backgroundTexturePath:
            ImagePaths.onboardingTextureBelowBackgroundDarkGreen,
        headingColour: themeShade400,
        subHeadingColour: themeShade200,
      ),
      // const SignUpButtons()
      // const WaitingListBetaEligibilityScreen(),
    ];

    void gotoPage(int page) {
      _pageController.animateToPage(
        page,
        duration: _kDuration,
        curve: _kCurve,
      );
    }

    void nextPage() {
      if (_pageController.positions.isNotEmpty &&
          _pageController.page != null &&
          _pageController.page! > (welcomeScreens.length - 2)) {
        authenticator.appIsAuthenticated().then(
          (isAuthenticated) {
            if (isAuthenticated) {
              reduxStore.then((store) {
                store
                  ..dispatch(getUserDetails())
                  ..dispatch(getVegiWalletAccountDetails());
                if (store.state.userState.hasOnboarded) {
                  log.info(
                      '🚀 Push PinCodeScreen from on_board_screen as already  completed onboarding and userState.isLoggedIn');
                  rootRouter.push(const PinCodeScreen());
                } else {
                  log.info(
                      '🚀 Push next onboarding flow screen from on_board_screen as need to complete onboarding flow though userState.isLoggedIn');
                  // authenticated but never completed onboarding so complete onboarding flow.
                  store
                    ..dispatch(getUserDetails(
                      onComplete: onBoardStrategy.nextOnboardingPage,
                      onFailed: onBoardStrategy.nextOnboardingPage,
                    ))
                    ..dispatch(getVegiWalletAccountDetails());
                }
              });
            } else {
              rootRouter.push(const SignUpScreen());
              reduxStore.then((store) {
                log.info(
                    'Navigate to SignUpScreen from on_board_screen because user has authState: ${store.state.userState.authState}');
              });
            }
          },
        );
      } else {
        // if (kDebugMode) {
        //   print(_pageController.positions);
        //   print(_pageController.page);
        // }
      }

      if (_pageController.page!.toInt() == 4) {
        return;
      }
      _pageController.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    }

    void previousPage() {
      if (_pageController.page!.toInt() == 0) {
        return;
      }
      _pageController.previousPage(
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    }

    final _tween = MovieTween()
      ..scene(begin: Duration.zero, duration: const Duration(seconds: 1)).tween(
        screenColor,
        ColorTween(begin: themeShade200, end: themeShade700),
      )
      ..scene(
        begin: const Duration(seconds: 1),
        end: const Duration(seconds: 3),
      ).tween(
        screenColor,
        ColorTween(begin: themeShade700, end: themeShade1100),
      )
      ..scene(
        begin: const Duration(seconds: 3),
        duration: const Duration(seconds: 1),
      ).tween(
        screenColor,
        ColorTween(begin: themeShade1100, end: themeShade1200),
      );
    final buttonsPaddingFromSideEdge = MediaQuery.of(context).size.width * 0.01;
    // const buttonsPaddingFromBottomEdge = 25.0;
    // final buttonsPaddingFromBottomEdge = MediaQuery.of(context).size.height * 0.2;
    const buttonsPaddingFromBottomEdge = 110.0;
    const dotSize = 11.0;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 20,
            child: CustomAnimationBuilder(
              tween: _tween, // Pass in tween
              duration: _tween.duration, // Obtain duration
              builder: (_, Movie value, child) {
                return ColoredBox(
                  color: _bottomRowOpacity > 0
                      ? value.get(screenColor)
                      : Colors.grey[350] ?? Colors.grey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            PageView.builder(
                              // onPageChanged: (page) {
                              //   if (page == (welcomeScreens.length - 1)) {
                              //     setState(() {
                              //       _bottomRowOpacity = 0;
                              //     });
                              //   } else {
                              //     setState(() {
                              //       _bottomRowOpacity = 1;
                              //     });
                              //   }
                              // },
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: welcomeScreens.length,
                              controller: _pageController,
                              itemBuilder: (BuildContext context, int index) =>
                                  welcomeScreens[index % welcomeScreens.length],
                            ),
                            Positioned(
                              bottom: buttonsPaddingFromBottomEdge,
                              left: buttonsPaddingFromSideEdge,
                              right: buttonsPaddingFromSideEdge,
                              child: AnimatedOpacity(
                                duration: const Duration(seconds: 1),
                                opacity: _bottomRowOpacity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    arrowButton(
                                      context,
                                      isPointingRight: false,
                                      onTap: previousPage,
                                      hide: _pageController
                                              .positions.isNotEmpty &&
                                          _pageController.page == 0,
                                    ),
                                    const Spacer(),
                                    // SizedBox(
                                    //   width: MediaQuery.of(context).size.width *
                                    //       0.075,
                                    // ),
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Center(
                                        child: SmoothPageIndicator(
                                          controller: _pageController,
                                          count: welcomeScreens.length,
                                          effect: CustomizableEffect(
                                            dotDecoration: DotDecoration(
                                              color: Color.fromARGB(
                                                255,
                                                245,
                                                254,
                                                223,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              dotBorder: DotBorder(
                                                color: Colors.black,
                                                width: 3.0,
                                                padding: 0.0,
                                                type: DotBorderType.solid,
                                              ),
                                              height: dotSize,
                                              width: dotSize,
                                            ),
                                            activeDotDecoration: DotDecoration(
                                              color: Color.fromARGB(
                                                255,
                                                168,
                                                200,
                                                112,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              dotBorder: DotBorder(
                                                color: Colors.black,
                                                width: 3.0,
                                                padding: 0.0,
                                                type: DotBorderType.solid,
                                              ),
                                              height: dotSize,
                                              width: dotSize,
                                            ),
                                          ),
                                          // effect: const JumpingDotEffect(
                                          //   dotWidth: 9,
                                          //   dotHeight: 9,
                                          //   strokeWidth: 3.0,
                                          //   paintStyle: PaintingStyle.fill,
                                          //   activeDotColor: Color.fromARGB(
                                          //     255,
                                          //     168,
                                          //     200,
                                          //     112,
                                          //   ),
                                          //   dotColor: Color.fromARGB(
                                          //     255,
                                          //     245,
                                          //     254,
                                          //     223,
                                          //   ),
                                          //   // activeDotColor: Color(0xFF696B6D),
                                          // ),
                                          onDotClicked: gotoPage,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: MediaQuery.of(context).size.width *
                                    //       // 0.075,
                                    //       0.175,
                                    // ),
                                    const Spacer(),
                                    arrowButton(
                                      context,
                                      isPointingRight: true,
                                      onTap: nextPage,
                                      // hide: _pageController
                                      //         .positions.isNotEmpty &&
                                      //     _pageController.page ==
                                      //         welcomeScreens.length,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget arrowButton(
    BuildContext context, {
    required bool isPointingRight,
    void Function()? onTap,
    bool hide = false,
  }) =>
      GestureDetector(
        onTap: onTap,
        // child: CustomPaint(
        //   painter: CustomButton2(),
        //   child: const SizedBox(
        //     width: 75,
        //     height: 75 * 0.6551102204408818,
        //     child: Center(
        //       child: Text(
        //         'Next',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontFamily: 'Fat Cheeks',
        //           fontSize: 22,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        child: Container(
          height: 100,
          width: 100,
          decoration: hide
              ? null
              : BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      isPointingRight
                          ? ImagePaths.nextScreenArrowOnboardingButton
                          : ImagePaths.previousScreenArrowOnboardingButton,
                    ),
                  ),
                ),
        ),
      );
}
