import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:phone_number/phone_number.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/common/router/route_guards.dart';
import 'package:vegan_liverpool/common/router/routes.dart';
import 'package:vegan_liverpool/common/router/vegi_debug_route_observer.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/redux_state_viewer.dart';
import 'package:vegan_liverpool/initFirebaseEmulator.dart';
import 'package:vegan_liverpool/initFirebaseRemote.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/new_version.dart';
import 'package:vegan_liverpool/services/apis/fxService.dart';
import 'package:vegan_liverpool/services/apis/locationService.dart';
import 'package:vegan_liverpool/services/apis/peeplEats.dart';
import 'package:vegan_liverpool/services/apis/peeplPay2.dart';
import 'package:vegan_liverpool/services/apis/stripePay2.dart';
import 'package:vegan_liverpool/utils/connectionChecker.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/log/log_it.dart';
import 'package:vegan_liverpool/utils/onboard/Istrategy.dart';
import 'package:vegan_liverpool/utils/onboard/authentication.dart';
import 'package:vegan_liverpool/utils/onboard/firebase.dart';
import 'package:vegan_liverpool/utils/stripe.dart';
import 'package:redux/redux.dart';

import 'env_test.dart';
import 'initStore_for_test.dart';

Future<void> registerDependencies() async {
  // await configureDependencies(environment: Env.test);
  const envStr = EnvTest.activeEnv;
  expect(
    envStr,
    'test',
    reason: 'Running in a test environment should be reflected in Env variable',
  );
  await dotenv.load(fileName: EnvTest.envFile);
  final log = LogIt(Logger());
  final dio = Dio();
  final store = initStoreForTests();
  GetIt.instance.registerFactory<LogIt>(() => log);
  GetIt.instance.registerFactory<Dio>(() => dio);
  GetIt.instance.registerFactory<RootRouter>(() => RootRouterLogger(
        authGuard: AuthGuard(),
      ));
  // GetIt.instance.registerFactory<FuseWalletSDK>(() => FuseWalletSDK());
  GetIt.instance.registerFactory<LocationService>(() => LocationService(dio));
  GetIt.instance.registerFactory<FXService>(() => FXService(dio));
  GetIt.instance.registerFactory<PeeplEatsService>(() => PeeplEatsService(dio));
  GetIt.instance.registerFactoryAsync<Store<AppState>>(() => store);
  GetIt.instance.registerFactory<StripePayService>(() => StripePayService());
  GetIt.instance.registerFactory<PeeplPayService>(() => PeeplPayService());
  // GetIt.instance.registerFactory<FirebaseAuth>(() => FirebaseAuth());
  // GetIt.instance.registerFactory<FirebaseMessaging>(() => FirebaseMessaging());

  GetIt.instance.registerFactory<PhoneNumberUtil>(() => PhoneNumberUtil());
  // GetIt.instance.registerFactory<IOnBoardStrategy>(() => IOnBoardStrategy());
  GetIt.instance.registerFactory<FirebaseStrategy>(() => FirebaseStrategy());

  GetIt.instance.registerFactory<Authentication>(() => Authentication());

  GetIt.instance.registerFactory<StripeService>(() => StripeService());

  GetIt.instance.registerFactory<NewVersion>(
    () => NewVersion(
      iOSAppStoreCountry:
          'GB', // ~ https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      iOSId: PackageConstants.bundleIdentifierHardCoded,
      androidId: PackageConstants.bundleIdentifierHardCoded,
    ),
  );
  final ic = InternetConnectionChecker();
  GetIt.instance.registerFactory<InternetConnectionChecker>(() => ic);
  GetIt.instance.registerFactory<NetworkInfo>(() => NetworkInfo(ic));

  // * other services

  GetIt.instance.registerFactory<FuseWalletSDK>(
      () => FuseWalletSDK(Secrets.FUSE_WALLET_SDK_PUBLIC_KEY));
}
