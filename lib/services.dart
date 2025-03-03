import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/new_version.dart';
import 'package:vegan_liverpool/services/apis/fxService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:phone_number/phone_number.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/services/apis/blueBeaconService.dart';
import 'package:vegan_liverpool/services/apis/peeplEats.dart';
import 'package:vegan_liverpool/services/apis/locationService.dart';
import 'package:vegan_liverpool/services/apis/peeplPay2.dart';
import 'package:vegan_liverpool/services/apis/stripePay2.dart';
import 'package:vegan_liverpool/services/apis/vegiESCService.dart';
import 'package:vegan_liverpool/utils/onboard/Istrategy.dart';
import 'package:vegan_liverpool/utils/onboard/authentication.dart';
import 'package:vegan_liverpool/utils/onboard/firebase.dart';
import 'package:vegan_liverpool/utils/stripe.dart';
import 'package:redux/redux.dart';

final RootRouter rootRouter = getIt<RootRouter>();

// final FuseWalletSDK fuseWalletSDK = getIt<FuseWalletSDK>();
// final Future<FuseSDK> fuseWalletSDK = getIt.getAsync<FuseSDK>();
final FuseSDK fuseWalletSDK = getIt<FuseSDK>();

final LocationService locationService = getIt<LocationService>();

final FXService fxService = getIt<FXService>();

final PeeplEatsService peeplEatsService = getIt<PeeplEatsService>();

final VegiESCService vegiESCService = getIt<VegiESCService>();

final Future<Store<AppState>> reduxStore = getIt.getAsync<Store<AppState>>();

final StripePayService stripePayService = getIt<StripePayService>();

final PeeplPayService peeplPayService = getIt<PeeplPayService>();

// final BlueBeaconService beaconService = getIt<BlueBeaconService>();

final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();

final FirebaseMessaging firebaseMessaging = getIt<FirebaseMessaging>();

final FirebaseRemoteConfig firebaseRemoteConfig = getIt<FirebaseRemoteConfig>();

final FirebaseFirestore firebaseFirestore = getIt<FirebaseFirestore>();

final PhoneNumberUtil phoneNumberUtil = getIt<PhoneNumberUtil>();

final IOnBoardStrategy onBoardStrategy = getIt<IOnBoardStrategy>();

final FirebaseStrategy firebaseOnboarding = getIt<FirebaseStrategy>();

final Authentication authenticator = getIt<Authentication>();

final StripeService stripeService = getIt<StripeService>();

final NewVersion newVersion = getIt<NewVersion>();
