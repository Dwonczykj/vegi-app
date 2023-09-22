import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:vegan_liverpool/common/router/route_guards.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/features/account/router/router.dart';
import 'package:vegan_liverpool/features/topup/router/topup_router.dart';
import 'package:vegan_liverpool/features/veganHome/router/router.dart';
// import 'package:vegan_liverpool/features/account/screens/profile.dart';
// import 'package:vegan_liverpool/features/onboard/screens/createWalletFirstScreen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/create_email_password_screen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/firebaseAuthLink.dart';
// import 'package:vegan_liverpool/features/onboard/screens/registerEmailOnboardingScreen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/restore_wallet_screen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/security_screen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/set_email_onboarding_screen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/show_user_mnemonic.dart';
// import 'package:vegan_liverpool/features/onboard/screens/signup_email_link_screen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/signup_email_password_screen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/signup_screen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/username_screen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/verifyEmailLink.dart';
// import 'package:vegan_liverpool/features/onboard/screens/verify_screen.dart';
// import 'package:vegan_liverpool/features/onboard/screens/verify_user_mnemonic.dart';
// import 'package:vegan_liverpool/features/screens/appStateViewScreen.dart';
// import 'package:vegan_liverpool/features/screens/app_log_list_view.dart';
// import 'package:vegan_liverpool/features/screens/main_screen.dart';
// import 'package:vegan_liverpool/features/screens/on_board_screen.dart';
// import 'package:vegan_liverpool/features/screens/pincode_screen.dart';
// import 'package:vegan_liverpool/features/screens/splash_screen.dart';
// import 'package:vegan_liverpool/features/screens/viewJsonScreen.dart';
// import 'package:vegan_liverpool/features/topup/router/topup_router.dart';
// import 'package:vegan_liverpool/features/veganHome/router/router.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/suggestProductFunnel.dart';
// import 'package:vegan_liverpool/features/veganHome/screens/imageFromGalleryEx.dart';
// import 'package:vegan_liverpool/features/veganHome/widgets/shared/redux_state_viewer.dart';
// import 'package:vegan_liverpool/features/waitingListFunnel/screens/addDiscountCodeScreen.dart';
// import 'package:vegan_liverpool/features/waitingListFunnel/screens/preLaunchPerksDetailsPage.dart';
// import 'package:vegan_liverpool/features/waitingListFunnel/screens/registerEmailNotificationsScreen.dart';
// import 'package:vegan_liverpool/features/waitingListFunnel/screens/surveyQuestionScreen.dart';
// import 'package:vegan_liverpool/features/waitingListFunnel/screens/surveyThanksScreen.dart';
// import 'package:vegan_liverpool/features/waitingListFunnel/screens/waitingListFunnel.dart';
// import 'package:vegan_liverpool/features/waitingListFunnel/screens/waitingListPositionInQueuePage.dart';
// import 'package:vegan_liverpool/features/waitingListFunnel/screens/waitingListSurveyQuestions.dart';
// import 'package:vegan_liverpool/redux/viewsmodels/logoutApp.dart';
// import 'package:vegan_liverpool/redux/viewsmodels/reset_app.dart';

export 'routes.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class RootRouter extends $RootRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashScreen.page, path: '/'),
    AutoRoute(page: ResetApp.page),
    AutoRoute(page: LogoutApp.page),
    AutoRoute(page: AppLogListView.page),
    AutoRoute(page: AppStateViewScreen.page),
    AutoRoute(page: ViewJsonScreen.page),
    AutoRoute(page: ChooseSecurityOption.page),
    AutoRoute(page: VerifyEmailLinkRoute.page),
    AutoRoute(
        page: FirebaseAuthLinkRoute.page,
        path:
            '/firebaseauth/link'), // routes at the route of the router have to start with a '/'
    AutoRoute(page: PinCodeScreen.page),
    // AutoRoute(page: RestoreFromBackupScreen.page),
    AutoRoute(page: OnBoardScreen.page),
    AutoRoute(page: ProfileScreen.page),
    AutoRoute(page: SignUpScreen.page),
    AutoRoute(page: SignUpWithEmailAndPasswordScreen.page),
    AutoRoute(page: SignUpEmailLinkScreen.page),
    AutoRoute(page: Web3AuthExampleLoginScreen.page),
    AutoRoute(page: SetEmailOnboardingScreen.page),
    AutoRoute(page: CreateWithEmailAndPasswordScreen.page),
    AutoRoute(page: VerifyPhoneNumber.page),
    AutoRoute(page: UserNameScreen.page),
    AutoRoute(page: WaitingListFunnelScreen.page),
    AutoRoute(page: RegisterEmailOnBoardingScreen.page),
    AutoRoute(page: RegisterEmailNotificationsScreen.page),
    // AutoRoute(page: CreateWalletFirstOnboardingScreen.page),
    AutoRoute(page: WaitingListSurveyQuestionsScreens.page),
    AutoRoute(page: PreLaunchPerksDetailsRoute.page),
    AutoRoute(page: WaitingListPositionInQueueRoute.page),
    AutoRoute(page: AddDiscountCodeScreen.page),
    AutoRoute(page: SurveyThanksScreen.page),
    AutoRoute(page: SuggestProductFunnelScreen.page),
    AutoRoute(page: ImageFromGalleryEx.page),
    AutoRoute(page: ESCExplainRatingScreen.page),
    if (kDebugMode) AutoRoute(page: ReduxStateViewer.page),
    AutoRoute(
        page: MainScreen.page,
        // guards: [AuthGuard],
        children: [
          // AutoRoute(page: VeganHomeRouter.page),
          veganHomeTab,
          topUpRoute,
        ]),
    AutoRoute(
      page: ShowUserMnemonicScreen.page,
      // guards: [AuthGuard]
    ),
    AutoRoute(
      page: VerifyUserMnemonic.page,
      // guards: [AuthGuard],
    ),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
