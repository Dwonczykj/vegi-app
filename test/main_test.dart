import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/app.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/network/web3auth.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/redux_state_viewer.dart';
import 'package:vegan_liverpool/initFirebaseEmulator.dart';
import 'package:vegan_liverpool/initFirebaseRemote.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/stripe.dart';

abstract class Env {
  static const dev = 'dev';
  static const test = 'test';
  static const qa = 'qa';
  static const prod = 'production';
  static bool get isDev => Env.activeEnv == Env.dev;
  static bool get isProd => Env.activeEnv == Env.prod;
  static bool get isTest => Env.activeEnv == Env.test;
  static bool get isQA => Env.activeEnv == Env.qa;
  static const activeEnv = test;
  static const _envFile = activeEnv == dev
      ? '.env_dev'
      : activeEnv == qa
          ? '.env_qa'
          : activeEnv == test
              ? '.env_dev'
              : '.env';
  static const envFile = 'environment/$_envFile';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  const envStr = Env.activeEnv;
  expect(
    envStr,
    'test',
    reason: 'Running in a test environment should be reflected in Env variable',
  );

  // if (DebugHelpers.inDebugMode) {
  //   print('Loading secrets from ${Env.envFile} for Env: ${Env.activeEnv}');
  // }
  await dotenv.load(fileName: Env.envFile);

  StripeService().init();

  await initWeb3AuthService();

  //todo: Init firebase_core for use in test
  // ~ see solution https://stackoverflow.com/a/74477245
  await configureDependencies(environment: envStr);

  await initFirebaseRemote();

  if (kDebugMode || USE_FIREBASE_EMULATOR) {
    // Dont put below condition in above as above is compile time and allows all this to be left out of production apps.
    await connectToFirebaseEmulator();
  }

  await runZonedGuarded(() async {
    await SentryFlutter.init(
      (options) {
        options
          ..debug = (!kReleaseMode && DebugHelpers.isVerboseDebugMode)
          ..dsn = '' //dotenv.env['SENTRY_DSN']
          ..environment = Env.activeEnv;
      },
    );

    // final store = await reduxStore;
    // //Pass the store to the Main App which injects it into the entire tree.
    // if (Env.isDev) {
    //   runApp(
    //     ReduxDevToolsContainer(
    //       store: store,
    //       child: MyApp(
    //         store,
    //       ),
    //     ),
    //   );
    // } else {
    //   runApp(MyApp(store));
    // }
    if (Platform.isIOS) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }
  }, (e, s) async {
    if (kReleaseMode) {
      await Sentry.captureException(e, stackTrace: s);
    } else {
      log.error('FlutterError exception: $e', stackTrace: s);
    }
  });
}
