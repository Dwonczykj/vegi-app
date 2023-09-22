// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i58;

import 'package:auto_route/auto_route.dart' as _i54;
import 'package:flutter/cupertino.dart' as _i55;
import 'package:flutter/foundation.dart' as _i59;
import 'package:flutter/material.dart' as _i56;
import 'package:redux_dev_tools/redux_dev_tools.dart' as _i61;
import 'package:vegan_liverpool/constants/enums.dart' as _i57;
import 'package:vegan_liverpool/features/account/router/router.dart' as _i2;
import 'package:vegan_liverpool/features/account/screens/profile.dart' as _i22;
import 'package:vegan_liverpool/features/onboard/screens/create_email_password_screen.dart'
    as _i9;
import 'package:vegan_liverpool/features/onboard/screens/firebaseAuthLink.dart'
    as _i12;
import 'package:vegan_liverpool/features/onboard/screens/registerEmailOnboardingScreen.dart'
    as _i25;
import 'package:vegan_liverpool/features/onboard/screens/security_screen.dart'
    as _i8;
import 'package:vegan_liverpool/features/onboard/screens/set_email_onboarding_screen.dart'
    as _i31;
import 'package:vegan_liverpool/features/onboard/screens/show_user_mnemonic.dart'
    as _i32;
import 'package:vegan_liverpool/features/onboard/screens/signup_email_link_screen.dart'
    as _i33;
import 'package:vegan_liverpool/features/onboard/screens/signup_email_password_screen.dart'
    as _i35;
import 'package:vegan_liverpool/features/onboard/screens/signup_screen.dart'
    as _i34;
import 'package:vegan_liverpool/features/onboard/screens/username_screen.dart'
    as _i42;
import 'package:vegan_liverpool/features/onboard/screens/verify_screen.dart'
    as _i47;
import 'package:vegan_liverpool/features/onboard/screens/verify_user_mnemonic.dart'
    as _i48;
import 'package:vegan_liverpool/features/onboard/screens/verifyEmailLink.dart'
    as _i46;
import 'package:vegan_liverpool/features/onboard/screens/web3auth_example_login_screen.dart'
    as _i53;
import 'package:vegan_liverpool/features/pay/screens/generate_QR_from_cart_screen.dart'
    as _i13;
import 'package:vegan_liverpool/features/pay/screens/scan_payment_recipient_qr.dart'
    as _i29;
import 'package:vegan_liverpool/features/screens/app_log_list_view.dart' as _i5;
import 'package:vegan_liverpool/features/screens/appStateViewScreen.dart'
    as _i6;
import 'package:vegan_liverpool/features/screens/main_screen.dart' as _i16;
import 'package:vegan_liverpool/features/screens/on_board_screen.dart' as _i17;
import 'package:vegan_liverpool/features/screens/pincode_screen.dart' as _i19;
import 'package:vegan_liverpool/features/screens/splash_screen.dart' as _i36;
import 'package:vegan_liverpool/features/screens/viewJsonScreen.dart' as _i49;
import 'package:vegan_liverpool/features/topup/router/topup_router.dart'
    as _i39;
import 'package:vegan_liverpool/features/topup/screens/topup.dart' as _i41;
import 'package:vegan_liverpool/features/topup/screens/topup_explained.dart'
    as _i40;
import 'package:vegan_liverpool/features/veganHome/router/router.dart' as _i43;
import 'package:vegan_liverpool/features/veganHome/screens/aboutScreen.dart'
    as _i1;
import 'package:vegan_liverpool/features/veganHome/screens/allOrdersPage.dart'
    as _i4;
import 'package:vegan_liverpool/features/veganHome/screens/checkout_screen_2.dart'
    as _i7;
import 'package:vegan_liverpool/features/veganHome/screens/escExplainRatingScreen.dart'
    as _i10;
import 'package:vegan_liverpool/features/veganHome/screens/faqScreen.dart'
    as _i11;
import 'package:vegan_liverpool/features/veganHome/screens/imageFromGalleryEx.dart'
    as _i14;
import 'package:vegan_liverpool/features/veganHome/screens/orderConfirmed.dart'
    as _i18;
import 'package:vegan_liverpool/features/veganHome/screens/preparingOrderScreen.dart'
    as _i21;
import 'package:vegan_liverpool/features/veganHome/screens/restaurantMenuScreen.dart'
    as _i27;
import 'package:vegan_liverpool/features/veganHome/screens/scan_listed_product_qrcode.dart'
    as _i28;
import 'package:vegan_liverpool/features/veganHome/screens/scheduledOrdersPage.dart'
    as _i30;
import 'package:vegan_liverpool/features/veganHome/screens/suggestProductFunnel.dart'
    as _i37;
import 'package:vegan_liverpool/features/veganHome/screens/veganHome.dart'
    as _i44;
import 'package:vegan_liverpool/features/veganHome/screens/vegiHomePage.dart'
    as _i45;
import 'package:vegan_liverpool/features/veganHome/widgets/shared/redux_state_viewer.dart'
    as _i23;
import 'package:vegan_liverpool/features/waitingListFunnel/screens/addDiscountCodeScreen.dart'
    as _i3;
import 'package:vegan_liverpool/features/waitingListFunnel/screens/preLaunchPerksDetailsPage.dart'
    as _i20;
import 'package:vegan_liverpool/features/waitingListFunnel/screens/registerEmailNotificationsScreen.dart'
    as _i24;
import 'package:vegan_liverpool/features/waitingListFunnel/screens/surveyThanksScreen.dart'
    as _i38;
import 'package:vegan_liverpool/features/waitingListFunnel/screens/waitingListFunnel.dart'
    as _i50;
import 'package:vegan_liverpool/features/waitingListFunnel/screens/waitingListPositionInQueuePage.dart'
    as _i51;
import 'package:vegan_liverpool/features/waitingListFunnel/screens/waitingListSurveyQuestions.dart'
    as _i52;
import 'package:vegan_liverpool/models/app_state.dart' as _i62;
import 'package:vegan_liverpool/models/cart/order.dart' as _i60;
import 'package:vegan_liverpool/redux/viewsmodels/logoutApp.dart' as _i15;
import 'package:vegan_liverpool/redux/viewsmodels/reset_app.dart' as _i26;

abstract class $RootRouter extends _i54.RootStackRouter {
  $RootRouter({super.navigatorKey});

  @override
  final Map<String, _i54.PageFactory> pagesMap = {
    AboutScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AboutScreen(),
      );
    },
    AccountsRouter.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AccountsRouterPage(),
      );
    },
    AddDiscountCodeScreen.name: (routeData) {
      final args = routeData.argsAs<AddDiscountCodeScreenArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.AddDiscountCodeScreen(
          onVerifyDiscountCode: args.onVerifyDiscountCode,
          key: args.key,
        ),
      );
    },
    AllOrdersRoute.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AllOrdersPage(),
      );
    },
    AppLogListView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.AppLogListView(),
      );
    },
    AppStateViewScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.AppStateViewScreen(),
      );
    },
    CheckoutScreenPt2.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.CheckoutScreenPt2(),
      );
    },
    ChooseSecurityOption.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ChooseSecurityOption(),
      );
    },
    CreateWithEmailAndPasswordScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.CreateWithEmailAndPasswordScreen(),
      );
    },
    ESCExplainRatingScreen.name: (routeData) {
      final args = routeData.argsAs<ESCExplainRatingScreenArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.ESCExplainRatingScreen(
          productId: args.productId,
          key: args.key,
        ),
      );
    },
    FAQScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.FAQScreen(),
      );
    },
    FirebaseAuthLinkRoute.name: (routeData) {
      final args = routeData.argsAs<FirebaseAuthLinkRouteArgs>(
          orElse: () => const FirebaseAuthLinkRouteArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.FirebaseAuthLinkPage(
          recaptchaToken: args.recaptchaToken,
          deepLinkId: args.deepLinkId,
          key: args.key,
        ),
      );
    },
    GenerateQRFromCartScreen.name: (routeData) {
      final args = routeData.argsAs<GenerateQRFromCartScreenArgs>(
          orElse: () => const GenerateQRFromCartScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.GenerateQRFromCartScreen(key: args.key),
      );
    },
    ImageFromGalleryEx.name: (routeData) {
      final args = routeData.argsAs<ImageFromGalleryExArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.ImageFromGalleryEx(
          args.type,
          handleImagePicked: args.handleImagePicked,
          key: args.key,
        ),
      );
    },
    LogoutApp.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.LogoutApp(),
      );
    },
    MainScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.MainScreen(),
      );
    },
    OnBoardScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.OnBoardScreen(),
      );
    },
    OrderConfirmedScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.OrderConfirmedScreen(),
      );
    },
    PinCodeScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.PinCodeScreen(),
      );
    },
    PreLaunchPerksDetailsRoute.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.PreLaunchPerksDetailsPage(),
      );
    },
    PreparingOrderRoute.name: (routeData) {
      final args = routeData.argsAs<PreparingOrderRouteArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.PreparingOrderPage(
          order: args.order,
          key: args.key,
        ),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.ProfileScreen(),
      );
    },
    ReduxStateViewer.name: (routeData) {
      final args = routeData.argsAs<ReduxStateViewerArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.ReduxStateViewer(
          args.store,
          key: args.key,
          actionMaxLines: args.actionMaxLines,
          stateMaxLines: args.stateMaxLines,
        ),
      );
    },
    RegisterEmailNotificationsScreen.name: (routeData) {
      final args = routeData.argsAs<RegisterEmailNotificationsScreenArgs>(
          orElse: () => const RegisterEmailNotificationsScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.RegisterEmailNotificationsScreen(
          key: args.key,
          onSubmitEmail: args.onSubmitEmail,
        ),
      );
    },
    RegisterEmailOnBoardingScreen.name: (routeData) {
      final args = routeData.argsAs<RegisterEmailOnBoardingScreenArgs>(
          orElse: () => const RegisterEmailOnBoardingScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.RegisterEmailOnBoardingScreen(
          key: args.key,
          onSubmitEmail: args.onSubmitEmail,
        ),
      );
    },
    ResetApp.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.ResetApp(),
      );
    },
    RestaurantMenuScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.RestaurantMenuScreen(),
      );
    },
    ScanListedProductQRCodeScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.ScanListedProductQRCodeScreen(),
      );
    },
    ScanPaymentRecipientQR.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.ScanPaymentRecipientQR(),
      );
    },
    ScheduledOrdersRoute.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.ScheduledOrdersPage(),
      );
    },
    SetEmailOnboardingScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.SetEmailOnboardingScreen(),
      );
    },
    ShowUserMnemonicScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.ShowUserMnemonicScreen(),
      );
    },
    SignUpEmailLinkScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.SignUpEmailLinkScreen(),
      );
    },
    SignUpScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.SignUpScreen(),
      );
    },
    SignUpWithEmailAndPasswordScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.SignUpWithEmailAndPasswordScreen(),
      );
    },
    SplashScreen.name: (routeData) {
      final args = routeData.argsAs<SplashScreenArgs>(
          orElse: () => const SplashScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i36.SplashScreen(
          key: args.key,
          onLoginResult: args.onLoginResult,
        ),
      );
    },
    SuggestProductFunnelScreen.name: (routeData) {
      final args = routeData.argsAs<SuggestProductFunnelScreenArgs>(
          orElse: () => const SuggestProductFunnelScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i37.SuggestProductFunnelScreen(
          key: args.key,
          scannedQRCode: args.scannedQRCode,
        ),
      );
    },
    SurveyThanksScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.SurveyThanksScreen(),
      );
    },
    TopUpRouter.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i39.TopUpRouterPage(),
      );
    },
    TopupExplained.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i40.TopupExplained(),
      );
    },
    TopupScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i41.TopupScreen(),
      );
    },
    UserNameScreen.name: (routeData) {
      final args = routeData.argsAs<UserNameScreenArgs>(
          orElse: () => const UserNameScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i42.UserNameScreen(key: args.key),
      );
    },
    VeganHomeRouter.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i43.VeganHomeRouterPage(),
      );
    },
    VeganHomeScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i44.VeganHomeScreen(),
      );
    },
    VegiHomeRoute.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i45.VegiHomePage(),
      );
    },
    VerifyEmailLinkRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyEmailLinkRouteArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i46.VerifyEmailLinkPage(
          emailAddress: args.emailAddress,
          emailLinkFromVerificationEmail: args.emailLinkFromVerificationEmail,
          key: args.key,
        ),
      );
    },
    VerifyPhoneNumber.name: (routeData) {
      final args = routeData.argsAs<VerifyPhoneNumberArgs>(
          orElse: () => const VerifyPhoneNumberArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i47.VerifyPhoneNumber(
          key: args.key,
          verificationId: args.verificationId,
        ),
      );
    },
    VerifyUserMnemonic.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i48.VerifyUserMnemonic(),
      );
    },
    ViewJsonScreen.name: (routeData) {
      final args = routeData.argsAs<ViewJsonScreenArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i49.ViewJsonScreen(
          data: args.data,
          key: args.key,
        ),
      );
    },
    WaitingListFunnelScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i50.WaitingListFunnelScreen(),
      );
    },
    WaitingListPositionInQueueRoute.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i51.WaitingListPositionInQueuePage(),
      );
    },
    WaitingListSurveyQuestionsScreens.name: (routeData) {
      final args = routeData.argsAs<WaitingListSurveyQuestionsScreensArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i52.WaitingListSurveyQuestionsScreens(
          surveyCompleted: args.surveyCompleted,
          key: args.key,
        ),
      );
    },
    Web3AuthExampleLoginScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i53.Web3AuthExampleLoginScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AboutScreen]
class AboutScreen extends _i54.PageRouteInfo<void> {
  const AboutScreen({List<_i54.PageRouteInfo>? children})
      : super(
          AboutScreen.name,
          initialChildren: children,
        );

  static const String name = 'AboutScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AccountsRouterPage]
class AccountsRouter extends _i54.PageRouteInfo<void> {
  const AccountsRouter({List<_i54.PageRouteInfo>? children})
      : super(
          AccountsRouter.name,
          initialChildren: children,
        );

  static const String name = 'AccountsRouter';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddDiscountCodeScreen]
class AddDiscountCodeScreen
    extends _i54.PageRouteInfo<AddDiscountCodeScreenArgs> {
  AddDiscountCodeScreen({
    required void Function() onVerifyDiscountCode,
    _i55.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddDiscountCodeScreen.name,
          args: AddDiscountCodeScreenArgs(
            onVerifyDiscountCode: onVerifyDiscountCode,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddDiscountCodeScreen';

  static const _i54.PageInfo<AddDiscountCodeScreenArgs> page =
      _i54.PageInfo<AddDiscountCodeScreenArgs>(name);
}

class AddDiscountCodeScreenArgs {
  const AddDiscountCodeScreenArgs({
    required this.onVerifyDiscountCode,
    this.key,
  });

  final void Function() onVerifyDiscountCode;

  final _i55.Key? key;

  @override
  String toString() {
    return 'AddDiscountCodeScreenArgs{onVerifyDiscountCode: $onVerifyDiscountCode, key: $key}';
  }
}

/// generated route for
/// [_i4.AllOrdersPage]
class AllOrdersRoute extends _i54.PageRouteInfo<void> {
  const AllOrdersRoute({List<_i54.PageRouteInfo>? children})
      : super(
          AllOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllOrdersRoute';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i5.AppLogListView]
class AppLogListView extends _i54.PageRouteInfo<void> {
  const AppLogListView({List<_i54.PageRouteInfo>? children})
      : super(
          AppLogListView.name,
          initialChildren: children,
        );

  static const String name = 'AppLogListView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i6.AppStateViewScreen]
class AppStateViewScreen extends _i54.PageRouteInfo<void> {
  const AppStateViewScreen({List<_i54.PageRouteInfo>? children})
      : super(
          AppStateViewScreen.name,
          initialChildren: children,
        );

  static const String name = 'AppStateViewScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i7.CheckoutScreenPt2]
class CheckoutScreenPt2 extends _i54.PageRouteInfo<void> {
  const CheckoutScreenPt2({List<_i54.PageRouteInfo>? children})
      : super(
          CheckoutScreenPt2.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutScreenPt2';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ChooseSecurityOption]
class ChooseSecurityOption extends _i54.PageRouteInfo<void> {
  const ChooseSecurityOption({List<_i54.PageRouteInfo>? children})
      : super(
          ChooseSecurityOption.name,
          initialChildren: children,
        );

  static const String name = 'ChooseSecurityOption';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i9.CreateWithEmailAndPasswordScreen]
class CreateWithEmailAndPasswordScreen extends _i54.PageRouteInfo<void> {
  const CreateWithEmailAndPasswordScreen({List<_i54.PageRouteInfo>? children})
      : super(
          CreateWithEmailAndPasswordScreen.name,
          initialChildren: children,
        );

  static const String name = 'CreateWithEmailAndPasswordScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ESCExplainRatingScreen]
class ESCExplainRatingScreen
    extends _i54.PageRouteInfo<ESCExplainRatingScreenArgs> {
  ESCExplainRatingScreen({
    required int productId,
    _i56.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          ESCExplainRatingScreen.name,
          args: ESCExplainRatingScreenArgs(
            productId: productId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ESCExplainRatingScreen';

  static const _i54.PageInfo<ESCExplainRatingScreenArgs> page =
      _i54.PageInfo<ESCExplainRatingScreenArgs>(name);
}

class ESCExplainRatingScreenArgs {
  const ESCExplainRatingScreenArgs({
    required this.productId,
    this.key,
  });

  final int productId;

  final _i56.Key? key;

  @override
  String toString() {
    return 'ESCExplainRatingScreenArgs{productId: $productId, key: $key}';
  }
}

/// generated route for
/// [_i11.FAQScreen]
class FAQScreen extends _i54.PageRouteInfo<void> {
  const FAQScreen({List<_i54.PageRouteInfo>? children})
      : super(
          FAQScreen.name,
          initialChildren: children,
        );

  static const String name = 'FAQScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i12.FirebaseAuthLinkPage]
class FirebaseAuthLinkRoute
    extends _i54.PageRouteInfo<FirebaseAuthLinkRouteArgs> {
  FirebaseAuthLinkRoute({
    String? recaptchaToken,
    String? deepLinkId,
    _i56.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          FirebaseAuthLinkRoute.name,
          args: FirebaseAuthLinkRouteArgs(
            recaptchaToken: recaptchaToken,
            deepLinkId: deepLinkId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FirebaseAuthLinkRoute';

  static const _i54.PageInfo<FirebaseAuthLinkRouteArgs> page =
      _i54.PageInfo<FirebaseAuthLinkRouteArgs>(name);
}

class FirebaseAuthLinkRouteArgs {
  const FirebaseAuthLinkRouteArgs({
    this.recaptchaToken,
    this.deepLinkId,
    this.key,
  });

  final String? recaptchaToken;

  final String? deepLinkId;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FirebaseAuthLinkRouteArgs{recaptchaToken: $recaptchaToken, deepLinkId: $deepLinkId, key: $key}';
  }
}

/// generated route for
/// [_i13.GenerateQRFromCartScreen]
class GenerateQRFromCartScreen
    extends _i54.PageRouteInfo<GenerateQRFromCartScreenArgs> {
  GenerateQRFromCartScreen({
    _i56.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          GenerateQRFromCartScreen.name,
          args: GenerateQRFromCartScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'GenerateQRFromCartScreen';

  static const _i54.PageInfo<GenerateQRFromCartScreenArgs> page =
      _i54.PageInfo<GenerateQRFromCartScreenArgs>(name);
}

class GenerateQRFromCartScreenArgs {
  const GenerateQRFromCartScreenArgs({this.key});

  final _i56.Key? key;

  @override
  String toString() {
    return 'GenerateQRFromCartScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.ImageFromGalleryEx]
class ImageFromGalleryEx extends _i54.PageRouteInfo<ImageFromGalleryExArgs> {
  ImageFromGalleryEx({
    required _i57.ImageSourceType type,
    required void Function(_i58.File?) handleImagePicked,
    _i59.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          ImageFromGalleryEx.name,
          args: ImageFromGalleryExArgs(
            type: type,
            handleImagePicked: handleImagePicked,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ImageFromGalleryEx';

  static const _i54.PageInfo<ImageFromGalleryExArgs> page =
      _i54.PageInfo<ImageFromGalleryExArgs>(name);
}

class ImageFromGalleryExArgs {
  const ImageFromGalleryExArgs({
    required this.type,
    required this.handleImagePicked,
    this.key,
  });

  final _i57.ImageSourceType type;

  final void Function(_i58.File?) handleImagePicked;

  final _i59.Key? key;

  @override
  String toString() {
    return 'ImageFromGalleryExArgs{type: $type, handleImagePicked: $handleImagePicked, key: $key}';
  }
}

/// generated route for
/// [_i15.LogoutApp]
class LogoutApp extends _i54.PageRouteInfo<void> {
  const LogoutApp({List<_i54.PageRouteInfo>? children})
      : super(
          LogoutApp.name,
          initialChildren: children,
        );

  static const String name = 'LogoutApp';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i16.MainScreen]
class MainScreen extends _i54.PageRouteInfo<void> {
  const MainScreen({List<_i54.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          initialChildren: children,
        );

  static const String name = 'MainScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i17.OnBoardScreen]
class OnBoardScreen extends _i54.PageRouteInfo<void> {
  const OnBoardScreen({List<_i54.PageRouteInfo>? children})
      : super(
          OnBoardScreen.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i18.OrderConfirmedScreen]
class OrderConfirmedScreen extends _i54.PageRouteInfo<void> {
  const OrderConfirmedScreen({List<_i54.PageRouteInfo>? children})
      : super(
          OrderConfirmedScreen.name,
          initialChildren: children,
        );

  static const String name = 'OrderConfirmedScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i19.PinCodeScreen]
class PinCodeScreen extends _i54.PageRouteInfo<void> {
  const PinCodeScreen({List<_i54.PageRouteInfo>? children})
      : super(
          PinCodeScreen.name,
          initialChildren: children,
        );

  static const String name = 'PinCodeScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i20.PreLaunchPerksDetailsPage]
class PreLaunchPerksDetailsRoute extends _i54.PageRouteInfo<void> {
  const PreLaunchPerksDetailsRoute({List<_i54.PageRouteInfo>? children})
      : super(
          PreLaunchPerksDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PreLaunchPerksDetailsRoute';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i21.PreparingOrderPage]
class PreparingOrderRoute extends _i54.PageRouteInfo<PreparingOrderRouteArgs> {
  PreparingOrderRoute({
    required _i60.Order order,
    _i56.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          PreparingOrderRoute.name,
          args: PreparingOrderRouteArgs(
            order: order,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PreparingOrderRoute';

  static const _i54.PageInfo<PreparingOrderRouteArgs> page =
      _i54.PageInfo<PreparingOrderRouteArgs>(name);
}

class PreparingOrderRouteArgs {
  const PreparingOrderRouteArgs({
    required this.order,
    this.key,
  });

  final _i60.Order order;

  final _i56.Key? key;

  @override
  String toString() {
    return 'PreparingOrderRouteArgs{order: $order, key: $key}';
  }
}

/// generated route for
/// [_i22.ProfileScreen]
class ProfileScreen extends _i54.PageRouteInfo<void> {
  const ProfileScreen({List<_i54.PageRouteInfo>? children})
      : super(
          ProfileScreen.name,
          initialChildren: children,
        );

  static const String name = 'ProfileScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i23.ReduxStateViewer]
class ReduxStateViewer extends _i54.PageRouteInfo<ReduxStateViewerArgs> {
  ReduxStateViewer({
    required _i61.DevToolsStore<_i62.AppState> store,
    _i56.Key? key,
    int actionMaxLines = 2,
    int stateMaxLines = 5,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          ReduxStateViewer.name,
          args: ReduxStateViewerArgs(
            store: store,
            key: key,
            actionMaxLines: actionMaxLines,
            stateMaxLines: stateMaxLines,
          ),
          initialChildren: children,
        );

  static const String name = 'ReduxStateViewer';

  static const _i54.PageInfo<ReduxStateViewerArgs> page =
      _i54.PageInfo<ReduxStateViewerArgs>(name);
}

class ReduxStateViewerArgs {
  const ReduxStateViewerArgs({
    required this.store,
    this.key,
    this.actionMaxLines = 2,
    this.stateMaxLines = 5,
  });

  final _i61.DevToolsStore<_i62.AppState> store;

  final _i56.Key? key;

  final int actionMaxLines;

  final int stateMaxLines;

  @override
  String toString() {
    return 'ReduxStateViewerArgs{store: $store, key: $key, actionMaxLines: $actionMaxLines, stateMaxLines: $stateMaxLines}';
  }
}

/// generated route for
/// [_i24.RegisterEmailNotificationsScreen]
class RegisterEmailNotificationsScreen
    extends _i54.PageRouteInfo<RegisterEmailNotificationsScreenArgs> {
  RegisterEmailNotificationsScreen({
    _i56.Key? key,
    void Function()? onSubmitEmail,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          RegisterEmailNotificationsScreen.name,
          args: RegisterEmailNotificationsScreenArgs(
            key: key,
            onSubmitEmail: onSubmitEmail,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterEmailNotificationsScreen';

  static const _i54.PageInfo<RegisterEmailNotificationsScreenArgs> page =
      _i54.PageInfo<RegisterEmailNotificationsScreenArgs>(name);
}

class RegisterEmailNotificationsScreenArgs {
  const RegisterEmailNotificationsScreenArgs({
    this.key,
    this.onSubmitEmail,
  });

  final _i56.Key? key;

  final void Function()? onSubmitEmail;

  @override
  String toString() {
    return 'RegisterEmailNotificationsScreenArgs{key: $key, onSubmitEmail: $onSubmitEmail}';
  }
}

/// generated route for
/// [_i25.RegisterEmailOnBoardingScreen]
class RegisterEmailOnBoardingScreen
    extends _i54.PageRouteInfo<RegisterEmailOnBoardingScreenArgs> {
  RegisterEmailOnBoardingScreen({
    _i56.Key? key,
    void Function()? onSubmitEmail,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          RegisterEmailOnBoardingScreen.name,
          args: RegisterEmailOnBoardingScreenArgs(
            key: key,
            onSubmitEmail: onSubmitEmail,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterEmailOnBoardingScreen';

  static const _i54.PageInfo<RegisterEmailOnBoardingScreenArgs> page =
      _i54.PageInfo<RegisterEmailOnBoardingScreenArgs>(name);
}

class RegisterEmailOnBoardingScreenArgs {
  const RegisterEmailOnBoardingScreenArgs({
    this.key,
    this.onSubmitEmail,
  });

  final _i56.Key? key;

  final void Function()? onSubmitEmail;

  @override
  String toString() {
    return 'RegisterEmailOnBoardingScreenArgs{key: $key, onSubmitEmail: $onSubmitEmail}';
  }
}

/// generated route for
/// [_i26.ResetApp]
class ResetApp extends _i54.PageRouteInfo<void> {
  const ResetApp({List<_i54.PageRouteInfo>? children})
      : super(
          ResetApp.name,
          initialChildren: children,
        );

  static const String name = 'ResetApp';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i27.RestaurantMenuScreen]
class RestaurantMenuScreen extends _i54.PageRouteInfo<void> {
  const RestaurantMenuScreen({List<_i54.PageRouteInfo>? children})
      : super(
          RestaurantMenuScreen.name,
          initialChildren: children,
        );

  static const String name = 'RestaurantMenuScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i28.ScanListedProductQRCodeScreen]
class ScanListedProductQRCodeScreen extends _i54.PageRouteInfo<void> {
  const ScanListedProductQRCodeScreen({List<_i54.PageRouteInfo>? children})
      : super(
          ScanListedProductQRCodeScreen.name,
          initialChildren: children,
        );

  static const String name = 'ScanListedProductQRCodeScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i29.ScanPaymentRecipientQR]
class ScanPaymentRecipientQR extends _i54.PageRouteInfo<void> {
  const ScanPaymentRecipientQR({List<_i54.PageRouteInfo>? children})
      : super(
          ScanPaymentRecipientQR.name,
          initialChildren: children,
        );

  static const String name = 'ScanPaymentRecipientQR';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i30.ScheduledOrdersPage]
class ScheduledOrdersRoute extends _i54.PageRouteInfo<void> {
  const ScheduledOrdersRoute({List<_i54.PageRouteInfo>? children})
      : super(
          ScheduledOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScheduledOrdersRoute';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i31.SetEmailOnboardingScreen]
class SetEmailOnboardingScreen extends _i54.PageRouteInfo<void> {
  const SetEmailOnboardingScreen({List<_i54.PageRouteInfo>? children})
      : super(
          SetEmailOnboardingScreen.name,
          initialChildren: children,
        );

  static const String name = 'SetEmailOnboardingScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i32.ShowUserMnemonicScreen]
class ShowUserMnemonicScreen extends _i54.PageRouteInfo<void> {
  const ShowUserMnemonicScreen({List<_i54.PageRouteInfo>? children})
      : super(
          ShowUserMnemonicScreen.name,
          initialChildren: children,
        );

  static const String name = 'ShowUserMnemonicScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i33.SignUpEmailLinkScreen]
class SignUpEmailLinkScreen extends _i54.PageRouteInfo<void> {
  const SignUpEmailLinkScreen({List<_i54.PageRouteInfo>? children})
      : super(
          SignUpEmailLinkScreen.name,
          initialChildren: children,
        );

  static const String name = 'SignUpEmailLinkScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i34.SignUpScreen]
class SignUpScreen extends _i54.PageRouteInfo<void> {
  const SignUpScreen({List<_i54.PageRouteInfo>? children})
      : super(
          SignUpScreen.name,
          initialChildren: children,
        );

  static const String name = 'SignUpScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i35.SignUpWithEmailAndPasswordScreen]
class SignUpWithEmailAndPasswordScreen extends _i54.PageRouteInfo<void> {
  const SignUpWithEmailAndPasswordScreen({List<_i54.PageRouteInfo>? children})
      : super(
          SignUpWithEmailAndPasswordScreen.name,
          initialChildren: children,
        );

  static const String name = 'SignUpWithEmailAndPasswordScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i36.SplashScreen]
class SplashScreen extends _i54.PageRouteInfo<SplashScreenArgs> {
  SplashScreen({
    _i56.Key? key,
    void Function(bool)? onLoginResult,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          SplashScreen.name,
          args: SplashScreenArgs(
            key: key,
            onLoginResult: onLoginResult,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashScreen';

  static const _i54.PageInfo<SplashScreenArgs> page =
      _i54.PageInfo<SplashScreenArgs>(name);
}

class SplashScreenArgs {
  const SplashScreenArgs({
    this.key,
    this.onLoginResult,
  });

  final _i56.Key? key;

  final void Function(bool)? onLoginResult;

  @override
  String toString() {
    return 'SplashScreenArgs{key: $key, onLoginResult: $onLoginResult}';
  }
}

/// generated route for
/// [_i37.SuggestProductFunnelScreen]
class SuggestProductFunnelScreen
    extends _i54.PageRouteInfo<SuggestProductFunnelScreenArgs> {
  SuggestProductFunnelScreen({
    _i56.Key? key,
    String? scannedQRCode,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          SuggestProductFunnelScreen.name,
          args: SuggestProductFunnelScreenArgs(
            key: key,
            scannedQRCode: scannedQRCode,
          ),
          initialChildren: children,
        );

  static const String name = 'SuggestProductFunnelScreen';

  static const _i54.PageInfo<SuggestProductFunnelScreenArgs> page =
      _i54.PageInfo<SuggestProductFunnelScreenArgs>(name);
}

class SuggestProductFunnelScreenArgs {
  const SuggestProductFunnelScreenArgs({
    this.key,
    this.scannedQRCode,
  });

  final _i56.Key? key;

  final String? scannedQRCode;

  @override
  String toString() {
    return 'SuggestProductFunnelScreenArgs{key: $key, scannedQRCode: $scannedQRCode}';
  }
}

/// generated route for
/// [_i38.SurveyThanksScreen]
class SurveyThanksScreen extends _i54.PageRouteInfo<void> {
  const SurveyThanksScreen({List<_i54.PageRouteInfo>? children})
      : super(
          SurveyThanksScreen.name,
          initialChildren: children,
        );

  static const String name = 'SurveyThanksScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i39.TopUpRouterPage]
class TopUpRouter extends _i54.PageRouteInfo<void> {
  const TopUpRouter({List<_i54.PageRouteInfo>? children})
      : super(
          TopUpRouter.name,
          initialChildren: children,
        );

  static const String name = 'TopUpRouter';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i40.TopupExplained]
class TopupExplained extends _i54.PageRouteInfo<void> {
  const TopupExplained({List<_i54.PageRouteInfo>? children})
      : super(
          TopupExplained.name,
          initialChildren: children,
        );

  static const String name = 'TopupExplained';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i41.TopupScreen]
class TopupScreen extends _i54.PageRouteInfo<void> {
  const TopupScreen({List<_i54.PageRouteInfo>? children})
      : super(
          TopupScreen.name,
          initialChildren: children,
        );

  static const String name = 'TopupScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i42.UserNameScreen]
class UserNameScreen extends _i54.PageRouteInfo<UserNameScreenArgs> {
  UserNameScreen({
    _i56.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          UserNameScreen.name,
          args: UserNameScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UserNameScreen';

  static const _i54.PageInfo<UserNameScreenArgs> page =
      _i54.PageInfo<UserNameScreenArgs>(name);
}

class UserNameScreenArgs {
  const UserNameScreenArgs({this.key});

  final _i56.Key? key;

  @override
  String toString() {
    return 'UserNameScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i43.VeganHomeRouterPage]
class VeganHomeRouter extends _i54.PageRouteInfo<void> {
  const VeganHomeRouter({List<_i54.PageRouteInfo>? children})
      : super(
          VeganHomeRouter.name,
          initialChildren: children,
        );

  static const String name = 'VeganHomeRouter';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i44.VeganHomeScreen]
class VeganHomeScreen extends _i54.PageRouteInfo<void> {
  const VeganHomeScreen({List<_i54.PageRouteInfo>? children})
      : super(
          VeganHomeScreen.name,
          initialChildren: children,
        );

  static const String name = 'VeganHomeScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i45.VegiHomePage]
class VegiHomeRoute extends _i54.PageRouteInfo<void> {
  const VegiHomeRoute({List<_i54.PageRouteInfo>? children})
      : super(
          VegiHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'VegiHomeRoute';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i46.VerifyEmailLinkPage]
class VerifyEmailLinkRoute
    extends _i54.PageRouteInfo<VerifyEmailLinkRouteArgs> {
  VerifyEmailLinkRoute({
    required String emailAddress,
    required String emailLinkFromVerificationEmail,
    _i56.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          VerifyEmailLinkRoute.name,
          args: VerifyEmailLinkRouteArgs(
            emailAddress: emailAddress,
            emailLinkFromVerificationEmail: emailLinkFromVerificationEmail,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyEmailLinkRoute';

  static const _i54.PageInfo<VerifyEmailLinkRouteArgs> page =
      _i54.PageInfo<VerifyEmailLinkRouteArgs>(name);
}

class VerifyEmailLinkRouteArgs {
  const VerifyEmailLinkRouteArgs({
    required this.emailAddress,
    required this.emailLinkFromVerificationEmail,
    this.key,
  });

  final String emailAddress;

  final String emailLinkFromVerificationEmail;

  final _i56.Key? key;

  @override
  String toString() {
    return 'VerifyEmailLinkRouteArgs{emailAddress: $emailAddress, emailLinkFromVerificationEmail: $emailLinkFromVerificationEmail, key: $key}';
  }
}

/// generated route for
/// [_i47.VerifyPhoneNumber]
class VerifyPhoneNumber extends _i54.PageRouteInfo<VerifyPhoneNumberArgs> {
  VerifyPhoneNumber({
    _i56.Key? key,
    String? verificationId,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          VerifyPhoneNumber.name,
          args: VerifyPhoneNumberArgs(
            key: key,
            verificationId: verificationId,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyPhoneNumber';

  static const _i54.PageInfo<VerifyPhoneNumberArgs> page =
      _i54.PageInfo<VerifyPhoneNumberArgs>(name);
}

class VerifyPhoneNumberArgs {
  const VerifyPhoneNumberArgs({
    this.key,
    this.verificationId,
  });

  final _i56.Key? key;

  final String? verificationId;

  @override
  String toString() {
    return 'VerifyPhoneNumberArgs{key: $key, verificationId: $verificationId}';
  }
}

/// generated route for
/// [_i48.VerifyUserMnemonic]
class VerifyUserMnemonic extends _i54.PageRouteInfo<void> {
  const VerifyUserMnemonic({List<_i54.PageRouteInfo>? children})
      : super(
          VerifyUserMnemonic.name,
          initialChildren: children,
        );

  static const String name = 'VerifyUserMnemonic';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i49.ViewJsonScreen]
class ViewJsonScreen extends _i54.PageRouteInfo<ViewJsonScreenArgs> {
  ViewJsonScreen({
    required Map<String, dynamic> data,
    _i56.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          ViewJsonScreen.name,
          args: ViewJsonScreenArgs(
            data: data,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewJsonScreen';

  static const _i54.PageInfo<ViewJsonScreenArgs> page =
      _i54.PageInfo<ViewJsonScreenArgs>(name);
}

class ViewJsonScreenArgs {
  const ViewJsonScreenArgs({
    required this.data,
    this.key,
  });

  final Map<String, dynamic> data;

  final _i56.Key? key;

  @override
  String toString() {
    return 'ViewJsonScreenArgs{data: $data, key: $key}';
  }
}

/// generated route for
/// [_i50.WaitingListFunnelScreen]
class WaitingListFunnelScreen extends _i54.PageRouteInfo<void> {
  const WaitingListFunnelScreen({List<_i54.PageRouteInfo>? children})
      : super(
          WaitingListFunnelScreen.name,
          initialChildren: children,
        );

  static const String name = 'WaitingListFunnelScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i51.WaitingListPositionInQueuePage]
class WaitingListPositionInQueueRoute extends _i54.PageRouteInfo<void> {
  const WaitingListPositionInQueueRoute({List<_i54.PageRouteInfo>? children})
      : super(
          WaitingListPositionInQueueRoute.name,
          initialChildren: children,
        );

  static const String name = 'WaitingListPositionInQueueRoute';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i52.WaitingListSurveyQuestionsScreens]
class WaitingListSurveyQuestionsScreens
    extends _i54.PageRouteInfo<WaitingListSurveyQuestionsScreensArgs> {
  WaitingListSurveyQuestionsScreens({
    required bool surveyCompleted,
    _i56.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          WaitingListSurveyQuestionsScreens.name,
          args: WaitingListSurveyQuestionsScreensArgs(
            surveyCompleted: surveyCompleted,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'WaitingListSurveyQuestionsScreens';

  static const _i54.PageInfo<WaitingListSurveyQuestionsScreensArgs> page =
      _i54.PageInfo<WaitingListSurveyQuestionsScreensArgs>(name);
}

class WaitingListSurveyQuestionsScreensArgs {
  const WaitingListSurveyQuestionsScreensArgs({
    required this.surveyCompleted,
    this.key,
  });

  final bool surveyCompleted;

  final _i56.Key? key;

  @override
  String toString() {
    return 'WaitingListSurveyQuestionsScreensArgs{surveyCompleted: $surveyCompleted, key: $key}';
  }
}

/// generated route for
/// [_i53.Web3AuthExampleLoginScreen]
class Web3AuthExampleLoginScreen extends _i54.PageRouteInfo<void> {
  const Web3AuthExampleLoginScreen({List<_i54.PageRouteInfo>? children})
      : super(
          Web3AuthExampleLoginScreen.name,
          initialChildren: children,
        );

  static const String name = 'Web3AuthExampleLoginScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}
