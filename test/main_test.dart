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
import 'package:vegan_liverpool/features/veganHome/widgets/shared/redux_state_viewer.dart';
import 'package:vegan_liverpool/initFirebaseEmulator.dart';
import 'package:vegan_liverpool/initFirebaseRemote.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/stripe.dart';

import 'env_test.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);

  const envStr = EnvTest.activeEnv;
  expect(
    envStr,
    'test',
    reason: 'Running in a test environment should be reflected in Env variable',
  );

  // if (DebugHelpers.inDebugMode) {
  //   print('Loading secrets from ${Env.envFile} for Env: ${Env.activeEnv}');
  // }
  await dotenv.load(fileName: EnvTest.envFile);

  StripeService().init();

  //todo: Init firebase_core for use in test
  // ~ see solution https://stackoverflow.com/a/74477245
  await configureDependencies(environment: envStr);

  // await initFirebaseRemote();

  if (kDebugMode || USE_FIREBASE_EMULATOR) {
    // Dont put below condition in above as above is compile time and allows all this to be left out of production apps.
    await connectToFirebaseEmulator();
  }
}
