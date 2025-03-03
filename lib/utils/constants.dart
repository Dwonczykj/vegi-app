// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/common/di/package_info.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/addresses.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/screens/webview_screen.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/actions/actions.dart';
import 'package:vegan_liverpool/models/tokens/token.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vegan_liverpool/utils/url.dart';
import 'package:vegan_liverpool/version.dart';

const onboardingAuthRoutesOrder = [
  SignUpScreen.name,
  SignUpWithEmailAndPasswordScreen.name,
  VerifyPhoneNumber.name,
];
const onboardingRoutesOrder = [
  ...onboardingAuthRoutesOrder,
  SetEmailOnboardingScreen.name,
  UserNameScreen.name,
  ChooseSecurityOption.name,
  MainScreen.name,
];

const LoadingScaffold = MyScaffold(
  title: '',
  body: Center(child: CircularProgressIndicator()),
);

const String wethTokenAddress = '0xa722c13135930332eb3d749b2f0906559d2c5b99';
const String wbtcTokenAddress = '0x33284f95ccb7b948d9d352e1439561cf83d8d00d';
const String wfuseTokenAddress = '0x0be9e53fd7edac9f859882afdda116645287c629';

// final Token gbpxToken = Token(
//   name: 'GBPx',
//   symbol: 'GBPX',
//   // imageUrl: "https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-dollar.png",
//   decimals: 18,
//   address: Addresses.gbpxTokenAddress,
//   timestamp: 0,
//   amount: BigInt.from(0.0),
//   walletActions: WalletActions.initial(),
// );

// final Token pplToken = Token(
//   name: 'Peepl',
//   symbol: 'PPL',
//   // imageUrl: 'https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-token.png',
//   decimals: 18,
//   address: Addresses.gbtTokenAddress,
//   timestamp: 0,
//   amount: BigInt.from(0.0),
//   walletActions: WalletActions.initial(),
// );

class TokenDefinitions {
  static Token fuseToken = Token(
    name: 'Fuse',
    symbol: 'FUSE',
    imageUrl: 'https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-token.png',
    decimals: 18,
    address: Addresses.zeroAddress,
    isNative: true,
    timestamp: 0,
    amount: BigInt.from(0.0),
    walletActions: WalletActions.initial(),
  );
  static Token fuseSparkToken = Token(
    name: 'Spark',
    symbol: 'SPARK',
    imageUrl: 'https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-token.png',
    decimals: 18,
    address: Addresses.fuseSparkTokenAddress,
    isNative: true,
    timestamp: 0,
    amount: BigInt.from(0.0),
    walletActions: WalletActions.initial(),
  );
  // static Token gbpxToken = gbpxToken;
  // static Token pplToken = pplToken;
  static Token greenBeanToken = Token(
    name: 'Green Beans',
    symbol: 'GBT',
    // imageUrl: 'https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-token.png',
    imageUrl: ImagePaths.vegiBeanMan,
    decimals: 18,
    address: Addresses.gbtTokenAddress,
    timestamp: 0,
    amount: BigInt.from(0.0),
    walletActions: WalletActions.initial(),
  );
  static Token fuseDollarToken = Token(
    name: 'Fuse Dollar',
    symbol: 'fUSD',
    imageUrl: 'https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-dollar.png',
    decimals: 18,
    address: Addresses.fusdTokenAddress,
    timestamp: 0,
    amount: BigInt.from(0.0),
    walletActions: WalletActions.initial(),
  );
}

class CurrencyRateConstants {
  static const rewardsPcntDelivery = 0.01;
  static const rewardsPcntPoS = 0.01;
  static const numberOfGBTInOneGBP = 1 / GBTPoundPegValue;
  static const gbtPenceValue = 1 / numberOfGBTInOneGBP;
  static const gbtPoundValue = gbtPenceValue / 100.0;
  static const minESCRating = 0.0;
  static const maxESCRating = 5.0;

  /// Description placeholder
  /// @date 25/05/2023 - 09:15:53
  ///
  /// @type {0.01}
  ///
  /// @value of 1 GBT in GBP
  static const GBTPoundPegValue = 0.01;

  /// Description placeholder
  /// @date 25/05/2023 - 09:15:53
  ///
  /// @type {0.01}
  ///
  /// @value of 1 GBPx in GBP
  static const GBPxPoundPegValue = 0.01;

  /// Description placeholder
  /// @date 25/05/2023 - 09:15:53
  ///
  /// @type {0.01}
  ///
  /// @value of 1 PPL in GBP
  static const PPLPoundPegValue = 0.1;
}

/// Static class of DotEnv Secrets
class Secrets {
  // Make Constructor Private to force Static Intellisense use
  const Secrets._();

  static String get SENTRY_DSN => dotenv.env['SENTRY_DSN']!;
  static String get CURRENCY_CONVERTER_API_KEY =>
      dotenv.env['CURRENCY_CONVERTER_API_KEY']!;

  static String get ON_BOARDING_STRATEGY => dotenv.env['ON_BOARDING_STRATEGY']!;

  // static String get PEEPL_PAY_BACKEND => dotenv.env['PEEPL_PAY_BACKEND']!;
  static String get VEGI_EATS_BACKEND => dotenv.env['VEGI_EATS_BACKEND']!;
  static String get VEGI_ESC_BACKEND => dotenv.env['VEGI_ESC_BACKEND']!;

  static String get CHARGE_API_KEY => dotenv.env['CHARGE_API_KEY']!;

  static String get FIREBASE_USER_DETAILS_COLLECTION_ID =>
      dotenv.env['FIREBASE_USER_DETAILS_COLLECTION_ID']!;
  static String get FIREBASE_USER_DETAILS_COLLECTION_FIELD1 =>
      dotenv.env['FIREBASE_USER_DETAILS_COLLECTION_FIELD1']!;
  static String get FIREBASE_USER_DETAILS_COLLECTION_FIELD2 =>
      dotenv.env['FIREBASE_USER_DETAILS_COLLECTION_FIELD2']!;

  static String get FUSE_CHAIN_ID =>
      dotenv.env['FUSE_CHAIN_ID']!;
  static String get FUSE_WALLET_SDK_PUBLIC_KEY =>
      dotenv.env['FUSE_WALLET_SDK_PK']!;
  static String? get FUSE_WALLET_SDK_PRIVATE_CREDENTIAL_FOR_UNIT_TEST_ONLY =>
      dotenv.env['FUSE_WALLET_SDK_PRIVATE_CREDENTIAL_FOR_UNIT_TEST_ONLY'];
  static String get FUSE_WALLET_SDK_SK => dotenv.env['FUSE_WALLET_SDK_SK']!;
  static String get FOREIGN_NETWORK_ID => dotenv.env['FOREIGN_NETWORK_ID']!;

  static String get WEB3AUTH_CLIENT_ID => dotenv.env['WEB3AUTH_CLIENT_ID']!;

  static String get MAP_API_KEY_IOS => dotenv.env['MAP_API_KEY_IOS']!;
  static String get MAP_API_KEY_ANDROID => dotenv.env['MAP_API_KEY_ANDROID']!;
  static String get MAP_API_KEY_SIM => dotenv.env['MAP_API_KEY_SIM']!;

  static String get STRIPE_PAY_URL => dotenv.env['STRIPE_PAY_URL']!;
  static String get STRIPE_API_KEY_LIVE => dotenv.env['STRIPE_API_KEY_LIVE']!;
  static String get STRIPE_API_KEY_TEST => dotenv.env['STRIPE_API_KEY_TEST']!;

  static String get mode => dotenv.env['mode']!;

  static String get amazonS3BucketUrl => dotenv.env['amazonS3BucketUrl']!;
  static String get amazonS3Region => dotenv.env['amazonS3Region']!;
  static String get amazonS3Bucket => dotenv.env['amazonS3Bucket']!;
  static String get amazonS3Secret => dotenv.env['amazonS3Secret']!;
  static String get amazonS3AccessKey => dotenv.env['amazonS3AccessKey']!;

  // static String get testPhoneNumber => DebugHelpers.inDebugMode && !Env.isProd ? dotenv.env['testPhoneNumber']! : 'TEST_PHONE_NUMBER_NOT_IN_DEBUG';
  // static String get testPhoneNumberCountryCode => DebugHelpers.inDebugMode && !Env.isProd ? dotenv.env['testPhoneNumberCountryCode']! : 'TEST_PHONE_NUMBER_COUNTRY_CODE_NOT_IN_DEBUG';
  // static String get testFirebaseSMSVerificationCode => DebugHelpers.inDebugMode && !Env.isProd ? dotenv.env['testFirebaseSMSVerificationCode']! : 'TEST_FIREBASE_SMS_VERIFICATION_CODE_NOT_IN_DEBUG';
  // static String get testFirebaseSessionToken => DebugHelpers.inDebugMode && !Env.isProd ? dotenv.env['testFirebaseSessionToken']! : 'TEST_FIREBASE_SESSION_TOKEN_NOT_IN_DEBUG';
  static String get testPhoneNumberCountryCode =>
      dotenv.env['testPhoneNumberCountryCode']!;
  static List<String> get testPhoneNumbers =>
      dotenv.env['testPhoneNumbers']!.split(',');
  static List<String> get testEmails => dotenv.env['testEmails']!.split(',');
  static List<String> get testEmailPasswords =>
      dotenv.env['testerEmailPasswords']!.split(',');
  static List<String> get testPhoneNumberE164s =>
      testPhoneNumbers.map((p) => '$testPhoneNumberCountryCode$p').toList();
  static List<String> get testFirebaseSMSVerificationCodes =>
      dotenv.env['testFirebaseSMSVerificationCodes']!.split(',');
  static Map<String, String> get testFirebaseSMSVerificationCodesByNumber =>
      testPhoneNumbers.length == testFirebaseSMSVerificationCodes.length
          ? Map.fromEntries(
              testPhoneNumbers.mapIndexed(
                (index, element) =>
                    MapEntry(element, testFirebaseSMSVerificationCodes[index]),
              ),
            )
          : {};
  static Map<String, String> get testEmailByNumber =>
      testPhoneNumbers.length == testEmails.length
          ? Map.fromEntries(
              testPhoneNumbers.mapIndexed(
                (index, element) => MapEntry(element, testEmails[index]),
              ),
            )
          : {};
  static Map<String, String> get testEmailPasswordsByNumber =>
      testPhoneNumbers.length == testEmailPasswords.length
          ? Map.fromEntries(
              testPhoneNumbers.mapIndexed(
                (index, element) =>
                    MapEntry(element, testEmailPasswords[index]),
              ),
            )
          : {};
  static String get testFirebaseSessionToken =>
      dotenv.env['testFirebaseSessionToken']!;

  static bool isTestPhoneDetails({
    required String countryCode,
    required String phoneNumber,
  }) =>
      countryCode == Secrets.testPhoneNumberCountryCode &&
      Secrets.testPhoneNumbers.contains(phoneNumber);

  static bool isTestEmailCredentials({
    required String email,
    required String password,
  }) =>
      Secrets.testEmails.contains(email) &&
      Secrets.testEmailPasswords.contains(password);

  static String get VEGI_SERVICE_API_KEY => dotenv.env['VEGI_SERVICE_API_KEY']!;
  static String get VEGI_SERVICE_API_SECRET =>
      dotenv.env['VEGI_SERVICE_API_SECRET']!;
}

const STRIPE_MERCHANT_ID_CONST_DONT_CHANGE = 'merchant.com.vegi';

const EMAIL_NOT_PROVIDED = 'email@notprovided.com';

const VEGI_DOMAIN = 'vegiapp.co.uk';
const VEGI_BASE_URL = 'https://$VEGI_DOMAIN';
const VEGI_DYNAMIC_APP_URL = 'vegi://$VEGI_DOMAIN';
const VEGI_PRIVACY_URL = '$VEGI_BASE_URL/terms';
const VEGI_CONTACT_US_URL = '$VEGI_BASE_URL/contact-us';
const VEGI_FAQs_URL = '$VEGI_BASE_URL/FAQs';
const VEGI_INSTA_HANDLE = 'wearevegi';
const VEGI_TIKTOK_HANDLE = '@$VEGI_INSTA_HANDLE';
const VEGI_TIKTOK_PROFILE_URL = 'https://www.tiktok.com/@$VEGI_TIKTOK_HANDLE';
const VEGI_INSTA_PROFILE_URL = 'https://www.instagram.com/$VEGI_INSTA_HANDLE/';
const VEGICATION_INSTA_PROFILE_URL = 'https://www.instagram.com/vegication/';
const VEGI_BRANDS_INSTA_PROFILE_URL =
    'https://www.instagram.com/veganliverpool/';

// const THE_GUIDE_LIVERPOOL_IOS_LINK = 'https://apps.apple.com/app/id1600049497';
// const THE_GUIDE_LIVERPOOL_GOOGLEPS_LINK =
//     'https://play.google.com/store/apps/details?id=com.theguideliverpool.theguideapp';
const THE_GUIDE_LIVERPOOL_LINKTREE = 'https://qrco.de/bdNuyp';
const THE_GUIDE_LIVERPOOL_IOS_LINK = THE_GUIDE_LIVERPOOL_LINKTREE;
const THE_GUIDE_LIVERPOOL_GOOGLEPS_LINK = THE_GUIDE_LIVERPOOL_LINKTREE;
const VEGI_SUPPORT_PHONE_NUMBER = '+447917787967';
const VEGI_SUPPORT_EMAIL = 'support@vegi.co.uk';

Future<Uri?> getAppStoreLink() async {
  if (Platform.isAndroid || Platform.isIOS) {
    final appId = Platform.isAndroid
        ? PackageConstants.androidBundleIdentifier
        : PackageConstants.isTestFlightVersion &&
                (await canLaunchUrlString('itms-beta://'))
            ? PackageConstants.iosAppIdVegiTest
            : PackageConstants.iosAppIdVegiProd;
    final url = Uri.parse(
      Platform.isAndroid
          // ? "market://details?id=$appId"
          ? 'https://play.google.com/store/apps/details?id=$appId'
          : packageInfo.appName.contains('test') &&
                  (await canLaunchUrlString(
                    'itms-beta://',
                  )) // ~ https://stackoverflow.com/a/32960501
              ? 'https://beta.itunes.apple.com/v1/app/$appId' // 1643896043
              : 'https://apps.apple.com/app/id$appId',
    );
    return url;
  } else {
    return null;
  }
}

String getGuideLiverpoolLink() {
  return 'https://qrco.de/bdNuyp';
  // return Platform.isIOS
  //     ? THE_GUIDE_LIVERPOOL_IOS_LINK
  //     : THE_GUIDE_LIVERPOOL_GOOGLEPS_LINK;
}

const showWaitingListFunnel = false;

class Fonts {
  static const String fatFace = 'Fat Cheeks';
  // static const String gelica = 'Gelica';
  static const String gelica = 'Europa';
  static const String europa = 'Europa';
}

class Messages {
  static String whatsappMessageSupportTemplate(String message) => '$message'
      ' Technicals: Version ${packageInfo.version},'
      ' Build (${packageInfo.buildNumber}).\n';
  static String emailMessageSupportTemplate(String message) => '$message'
      ' Technicals: Version ${packageInfo.version},'
      ' Build (${packageInfo.buildNumber}).\n';

  static const String email = 'Email Address';
  static const String voucherCode = 'Voucher';
  static const String enterEmail =
      'Please enter your email to be first to receive an update when we launch.';

  static const checkoutSuccessThankyouForOrdering =
      'Thank you for ordering with vegi 💚';
  static String checkoutSuccessOrderReceivedButNotConfirmed(String orderId) =>
      'Your order #$orderId has been received '
      "and will be confirmed shortly. We'll send you a text "
      'with an update once they respond! \n ';
  static const onboardingThankyouForRegistering =
      'Thank you for registering with vegi 💚';

  static const _vegiPrivacyTnCs = 'By signing up, you agree to the vegi'
      ' Terms & Conditions';
  static InkWell vegiPrivacyTnCsAnchorLink(BuildContext context) => InkWell(
        focusColor: Theme.of(context).canvasColor,
        highlightColor: Theme.of(context).canvasColor,
        // onTap: () => showModalBottomSheet<Widget>(
        //   context: context,
        //   builder: (_) => const WebViewScreen(
        //     url: VEGI_PRIVACY_URL,
        //     title: 'Legal',
        //   ),
        // ),
        onTap: () => launchUrl(VEGI_PRIVACY_URL),
        child: const Text.rich(
          TextSpan(
            text: _vegiPrivacyTnCs,
            style: TextStyle(
              color: themeShade800,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: ' which can be found ',
              ),
              TextSpan(
                text: 'here ⬇️',
                style: TextStyle(
                  color: themeShade800,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static const String emailRegisteredThankYou = 'Thank you for registering';
  static const String failedToRegisterEmailToWaitingList =
      'Registration failed';
  static const String failedToCheckPositionInWaitingList =
      'Failed to check position in waiting list.';
  static const String emailPleaseRegisterForLaunchNotifications =
      'Enter your email to be notified when we launch';
  static const String emailPleaseEnterToHelpProtectYourAccount =
      'Please enter your email to help us protect your account';
  static const String wellBeInTouchSoon = 'We will be in touch soon!';
  static const String pleaseEnterEmail = 'Please enter your email';

  static const String createNewAccount = 'New Account';
  static const String checkWaitingListError = 'Unable to check waitinglist';

  static String loginSuccess(BuildContext context) =>
      '${I10n.of(context).login} success!';

  static const String invalidEmail = 'Invalid Email';
  static const String invalidDiscountCode = 'Invalid voucher code';
  static const String newSupportRequestSubjectHeader = 'New Support Request';
  static const String thanksForRegisteringEmailWaitList =
      'Thank you for registering with vegi 💚';
  static const String signUpForTheGuideToAccessTheBeta =
      'Sign up to the pre-release version of vegi via The Guide Liverpool';
  static const String byRegisteringEmailWaitListReason =
      "By registering, you'll be the first to know when we launch.";
  static const String pullDownToRefresh = 'Pull down to refresh';
  static const String unsubscribeAtAnyTime =
      'You can unsubscribe any time, no funny business.';

  static const String walletLoadedSnackbarMessage = 'Wallet loaded';
  static const String walletSignedOutSnackbarMessage = 'Wallet signed out';
  static const String walletNotBackedUpSnackbarMessage = 'Wallet not backed up';

  static const String answerYNQuestionsToBumpQueue =
      'Answer 3 yes/no questions to move up the queue';
  static const String unableToRegisterEmailForNotifications =
      'Unable to register email for notifications';

  static const String addVoucherCode = 'Add a voucher code';
  static const String addVoucherCodeInvalidCode = 'Invalid code';
  static const String addVoucherCodeCodeCantBeEmpty =
      "Discount code can't be empty";
  static const String permissionDenied = 'Permission denied';
  static const String removeVoucherCodeNotAllowed =
      'Existing vouchers cannot be removed.';

  static const String willEmailOnceLive =
      "We'll send you an email when we are live and you can spend your credit!";

  static const String unableToFetchOrders = 'Unable to fetch latest orders';
  static const String unableToCheckWaitingListQueue =
      'Unable to check queue at this time. Please check back later.';
  static const String noUpcomingOrders = 'You have no upcoming orders… yet!';
  static const String noUpcomingOrdersSubtitle =
      'If this is incorrect, please contact support '
      ' for assistance. Details are in our FAQ section.';
  static const String connectionError = 'Connection error';
  static const String operationFailed = 'Operation failed';

  static const String searchVegiPlaceholder = 'Search vegi...';
  static const String searchVendorPlaceholder = 'Search vendor...';

  static const String signInFailed = 'Sign-in failed';
  static const String signInFailedEmailLinkMessage =
      'Unable to signup with email links at this time';
}

class CopyWrite {
  static const String onboardingScreenHeading1 = 'Shop plant-based';
  static const String onboardingScreenSubHeading1 =
      'Find plant-based, planet-kind and ethical '
      'products from local businesses and growers.';
  static const String onboardingScreenHeading2 = 'Shop local';
  static const String onboardingScreenSubHeading2 =
      'Use vegi to support independent businesses and keep more money in our local economy.';
  static const String onboardingScreenHeading3 = 'Earn rewards';
  static const String onboardingScreenSubHeading3 =
      'Enjoy cash-back when you use vegi to spend again next time you shop.';
  static const String continueWithoutDiscountCode =
      'Continue without voucher code?';
  static const String preLaunchPerksHeadingPart1 = 'Shop local, get rewards';
  static const String preLaunchPerksHeadingPart2 = ' ...even before we launch!';
  static final String preLaunchPerksCreditsExplanation =
      'Get £1 credit for every shop in Purple Carrot that includes an item '
      'from a local business this ${DateFormat('MMMM').format(DateTime.now())}';
  static const String startCollectingFreeCreditNow =
      'Start collecting free credit now';
  static const String collectCreditForEcoProducts =
      'Collect credit when you purchase a product made by a local business '
      'from Purple Carrot';

  static const String patientSnailLabel = 'Patient Snail';
  static const List<String> patientSnailMessage = [
    'Get notified when ',
    "we're ready!"
  ];
  static const String earlyBirdLabel = 'Early Bird';
  static const List<String> earlyBirdMessage = [
    'Join our beta app to use',
    'vegi now!'
  ];
}

class ImagePaths {
  static const String vegiHorizontalLogo =
      'assets/images/Vegi-Logo-horizontal.png';
  static const String vegiSquareLogo = 'assets/images/Vegi-Logo-square.png';
  static const String vegiBeanMan = 'assets/images/beanman.jpg';
  static const String veganOnlyIcon = 'assets/images/vegan-only-icon.png';
  static const String fuseLogo = 'assets/images/fuse/fuse-logo.png';
  static const String fuseIconGreen = 'assets/images/fuse/fuse-icon-green.png';
  static const String fuseIconFilledGreen =
      'assets/images/fuse/fuse-icon-filled-green.png';
  static const String firbebaseLogo = 'assets/images/firebase-logo.svg';
  static const String pplAvatar35width = 'assets/images/avatar-ppl-red.png';
  static const String vegiBeanManNSEW = 'assets/images/beanman-nsew.png';
  static const String anomAvatar = 'assets/images/anom.png';
  static const String lock = 'assets/images/lock.svg';
  static const String securityLockInfoBlack = 'assets/images/info_black.svg';
  static const String avatarPlaceholder = 'assets/images/username.svg';
  static const String pincode = 'assets/images/pincode.svg';

  static const String usernamePlaceholder = 'assets/images/username.svg';

  static const String orderConfirmedDelivery = 'assets/images/herobean.png';
  static const String orderConfirmedCollection = 'assets/images/herobean.png';
  static const String orderAcceptedDelivery =
      'assets/images/order-accepted.gif';
  static const String orderAcceptedCollection =
      'assets/images/order-accepted.gif';

  static const String avatarPPLRed = 'assets/images/avatar-ppl-red.png';
  static const String onboardingPage2HeadingImage1 = 'plant-icon.svg';
  static const String onboardingPage3HeadingImage2 = 'local-icon.svg';
  static const String onboardingPage4HeadingImage3 = 'rewards-icon.svg';
  static const String onboardingTextureBelowBackgroundDarkGreen =
      'assets/images/design/onboarding_bg_dark_green.jpg';
  static const String onboardingTextureBelowBackgroundBrightCream =
      'assets/images/design/onboarding_bg_bright_cream.jpg';
  static const String onboardingPage1Background =
      'assets/images/design/1_intro_img.png';
  static const String onboardingPage2Background =
      'assets/images/design/Vegi-Onboardingshop-plant-based-copy.png';
  static const String onboardingPage3Background =
      'assets/images/design/Vegi-Onboardingshop-local.png';
  static const String onboardingPage4Background =
      'assets/images/design/Vegi-Onboardingearn-rewards.png';
  static const String onboardingPage5Background =
      'assets/images/design/5_outro_img.png';
  static const String onboardingPage5Card =
      'assets/images/design/5_outro_card.png';
  static const String onboardingPage5CardSnail =
      'assets/images/design/5_outro_card_snail.png';

  static const String onboardingPage1VegiText =
      'assets/images/design/1_intro_text.png';
  static const String previousScreenArrowOnboardingButton =
      'assets/images/design/previous_screen_arrow_button_onboarding.png';
  static const String nextScreenArrowOnboardingButton =
      'assets/images/design/next_screen_arrow_button_onboarding.png';
}

class Labels {
  static const String registerEmailOnboardingScreenTitle = 'Email';
  static const String registerEmailWaitingListNotificationsScreenTitle =
      'Register';
  static const String homeScreenRouteLabel = 'Home';
  static const String stripeVegiProductName = 'vegi';
  static const String stripeVegiMerchantName = "vegiapp ltd";
  static const String launchAppStore = 'Open AppStore';
  static const String cancelButtonLabel = 'Cancel';

  static const vegiPrivacyTnCs = 'Terms & Conditions';

  static const String submit = 'Submit';
  static const String signupButtonLabelViewAccount = 'View account';
  static const String signupButtonLabelCreateAccount = 'Create account';
  static String Function(BuildContext) signupButtonLabelLogin =
      (BuildContext context) => I10n.of(context).login;
  static String Function(BuildContext) signupButtonLabelLogout =
      (BuildContext context) => I10n.of(context).logout;
  static String Function(BuildContext) signupButtonLabelSignUp =
      (BuildContext context) => I10n.of(context).sign_up;
  static const String signupButtonLabelResetSurvey = 'Reset survey';
  static const String signupButtonLabelReAuthenticate = 'Re-authenticate';
  static String Function({required bool isWhiteListedAccount})
      signupScreenTitle = ({required bool isWhiteListedAccount}) =>
          isWhiteListedAccount ? 'Welcome' : 'Waitlist';
  static String Function({required bool isWhiteListedAccount})
      signupScreenSubTitle = ({required bool isWhiteListedAccount}) =>
          isWhiteListedAccount
              ? ''
              : "We'll be in touch as soon as you're off the waitlist list!";
  static String Function(BuildContext) surveyThanksButtonRestoreBackupWallet =
      (BuildContext context) => I10n.of(context).restore_from_backup;

  static const String fullDetailsAndFAQsLinkLabel = 'Full details & FAQs';

  static const String notifyMeWhenYouRelease = 'Notify me when you launch';
  static const String dontNotifyMeWhenYouRelease =
      "Don't notify me when you launch";

  static String vegiPay({required bool vendorMode}) =>
      vendorMode ? 'Take vegiPayment' : 'vegiPay';

  static const String googleSignonLabel = 'Google';
  static const String appleSignonLabel = 'Apple';
  static const String emailAndPasswordSignonLabel = 'Email and Password';
  static const String emailLinkSignonLabel = 'Email link';
  static const String phoneSignonLabel = 'Phone';
}

const ENV = String.fromEnvironment('ENV', defaultValue: 'production');
const STRIPE_LIVEMODE =
    String.fromEnvironment('stripe_live_mode', defaultValue: 'false');
const USE_FIREBASE_EMULATOR = bool.fromEnvironment(
  'USE_FIREBASE_EMULATOR',
);
// Uncomment the following if want to use firestore db in firebase
// const FIRESTORE_EMULATOR_PORT =
//     int.fromEnvironment('FIRESTORE_EMULATOR_PORT', defaultValue: 8080);
const FIREBASE_AUTH_EMULATOR_PORT =
    int.fromEnvironment('FIREBASE_AUTH_EMULATOR_PORT', defaultValue: 9099);

const defaultDisplayName = 'Anom';

const postcodeIoBaseUrl = 'https://api.postcodes.io/';
const postcodeIoGetPostcodeDetailRelUrl =
    '/postcodes'; // ~ https://postcodes.io/#:~:text=Get%20nearest%20postcodes%20for%20a%20given%20longitude%20%26%20latitude

const noVendorsFoundCopyTitle = "Pretty empty here, isn't it?";
const noVendorsFoundCopyEmoji = '😐';
final noVendorsFoundCopyMessage =
    (String location) => "We aren't currently delivering to $location, but "
        'we will in the future, so check back later!';

final scanQRCodeProductNotFoundPleaseSendUsDetails = (String nextButtonLabel) =>
    'This product was not found in our data. '
    'Please help us improve our service to you by sending us the product information so that we can tell you all about it. '
    'Click $nextButtonLabel to continue.';

final suggestProductPhotoDirector =
    (String photoLabel) => 'Please take a photo of the $photoLabel';
final suggestProductPhotoDirectorConfirm =
    (String photoLabel) => 'Please confirm your photo of the $photoLabel';

const suggestProductPhotoDirectorLabel1 = 'barcode';
const suggestProductPhotoDirectorLabel2 = 'front of the product';
const suggestProductPhotoDirectorLabel3 = 'nutritional info label';
const suggestProductPhotoDirectorLabel4 = 'ingredients list';
// const suggestProductPhotoDirectorLabelMap =
//     <String, ProductSuggestionImageType>{
//   suggestProductPhotoDirectorLabel1: ProductSuggestionImageType.barCode,
//   suggestProductPhotoDirectorLabel2: ProductSuggestionImageType.frontOfPackage,
//   suggestProductPhotoDirectorLabel3: ProductSuggestionImageType.nutritionalInfo,
//   suggestProductPhotoDirectorLabel4: ProductSuggestionImageType.ingredientInfo,
// };
const suggestProductPhotoDirectorLabelMap =
    <ProductSuggestionImageType, String>{
  ProductSuggestionImageType.barCode: suggestProductPhotoDirectorLabel1,
  ProductSuggestionImageType.frontOfPackage: suggestProductPhotoDirectorLabel2,
  ProductSuggestionImageType.nutritionalInfo: suggestProductPhotoDirectorLabel3,
  ProductSuggestionImageType.ingredientInfo: suggestProductPhotoDirectorLabel4,
  ProductSuggestionImageType.teachUsMore: 'Teach us more',
};

const productSuggestionAdditionalInfoRequestText =
    'Any additional information about the product to help us rate it';
const photoPickImageFromGalleryText = 'Pick Image from Gallery';
const photoTakePhotoWithCameraText = 'Take Photo with Camera';
const imageFromCameraText = 'Image from Camera';
const imageFromLibraryText = 'Image from Gallery';
const int cameraPreferredImageQuality =
    100; // % of image quality retained from original
const fileUploadVegiMaxSizeMB = 1; // 1MB

const inDebugMode = kDebugMode;

Future<bool> thisDeviceIsSimulator() async {
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    if (!iosInfo.isPhysicalDevice) {
      return true;
    }
  } else if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    if (!androidInfo.isPhysicalDevice) {
      return true;
    }
  }
  return false;
}

Future<bool> thisDeviceIsNotSimulator() async {
  return !(await thisDeviceIsSimulator());
}

Future<bool> thisDeviceIsIosSimulator() async =>
    Platform.isIOS && (await thisDeviceIsSimulator());

class DebugHelpers {
  static final isTest = Platform.environment.containsKey('FLUTTER_TEST');
  static const bool inDebugMode = kDebugMode;
  static bool isVerboseDebugMode =
      kDebugMode && const String.fromEnvironment('verbose').isNotEmpty;
  static const packageName =
      'vegan_liverpool'; // There is no way to get this from runtime.
  static Future<bool> deviceIsSimulator() => thisDeviceIsSimulator();
  static Future<bool> deviceIsNotSimulator() => thisDeviceIsNotSimulator();
  static Future<bool> deviceIsIosSimulator() => thisDeviceIsIosSimulator();
}

class PackageConstants {
  static const String iosAppIdVegiTest = '1643896043'; // i.e. 1600049497
  static const String iosAppIdVegiProd = '1608208174'; // i.e. 1600049497

  static const String androidAppIdVegiProd =
      'com.vegi.vegiAppTest'; // i.e. 1600049497
  static String iosBuildVersion =
      '${packageInfo.version}.${packageInfo.buildNumber}';
  static Version? buildVersionInfo =
      Version.tryParse(iosBuildVersion); // i.e. 1.5.202
  static String androidBuildVersion =
      '${packageInfo.version}+${packageInfo.buildNumber}'; // i.e. 1.5.0+202
  static String buildVersionMajor = packageInfo.version;
  static String buildVersionMinor = packageInfo.buildNumber;
  static String versionString = 'Version ${packageInfo.version},'
      ' Build ${packageInfo.buildNumber},'
      ' Env ${Env.activeEnv}';
  static bool isTestFlightVersion =
      packageInfo.appName.toLowerCase().contains('test');
  static String buildVersion() => Platform.isIOS
      ? PackageConstants.iosBuildVersion
      : Platform.isAndroid
          ? PackageConstants.androidBuildVersion
          : '';

  static const String bundleIdentifierHardCoded =
      'com.vegi.vegiAppTest'; // Runner.xcodeproj/project.pbxproj => PRODUCT_BUNDLE_IDENTIFIER = com.example.appname;
  static String iosBundleIdentifier = packageInfo
      .packageName; // Runner.xcodeproj/project.pbxproj => PRODUCT_BUNDLE_IDENTIFIER = com.example.appname;

  static String androidBundleIdentifier = packageInfo
      .packageName; // AndroidManifest => manifest xmlns:android="http://schemas.android.com/apk/res/android"
  // static final packageNameHardCoded =
  //     Env.isProd ? 'com.vegi.vegiApp' : 'com.vegi.vegiAppTest';
  // static Future<String> buildVersion() => Platform.isIOS
  //     ? PackageConstants.iosBuildVersion
  //     : Platform.isAndroid
  //         ? PackageConstants.androidBuildVersion
  //         : Future.value('');
  // static Future<String> get iosBuildVersion async =>
  //     '${(await PackageInfo.fromPlatform()).version}.${(await PackageInfo.fromPlatform()).buildNumber}';
  // static Future<String> get androidBuildVersion async =>
  //     '${(await PackageInfo.fromPlatform()).version}.${(await PackageInfo.fromPlatform()).buildNumber}';
  // static Future<String> get appName async =>
  //     (await PackageInfo.fromPlatform()).appName;
  // static Future<String> get iosBundleIdentifier async => (await PackageInfo
  //         .fromPlatform())
  //     .packageName; // com.vegi.vegiAppTest // Runner.xcodeproj/project.pbxproj => PRODUCT_BUNDLE_IDENTIFIER = com.example.appname;

  // static Future<String> get androidBundleIdentifier async => (await PackageInfo
  //         .fromPlatform())
  //     .packageName; // com.vegi.vegiAppTest // AndroidManifest => manifest xmlns:android="http://schemas.android.com/apk/res/android"
  static const String webBundleIdentifier = 'vegiapp.co.uk';
}
