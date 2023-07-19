import 'dart:async';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/app.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/common/network/web3auth.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/redux_state_viewer.dart';
import 'package:vegan_liverpool/initFirebaseEmulator.dart';
import 'package:vegan_liverpool/initFirebaseRemote.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/log/log_it.dart';
import 'package:vegan_liverpool/utils/stripe.dart';

import 'firebase_test_mock.dart';

/// ~ Taken from https://stackoverflow.com/a/74477245
/// TODO: we also need to remember how to start the firebase emulator instance before running tests
/// and in setup, there needs to be an expect() emulator is running on port
/// the emulator code may be in the nodejs lib...
/// ~ https://www.notion.so/gember/Firebase-Emulator-Setting-up-and-Using-64c59408e482499a9a1ed07548fe09ae
void main() {
  setupFirebaseAnalyticsMocks();

  FirebaseAnalytics? analytics;

  group('$FirebaseAnalytics', () {
    setUpAll(() async {
      await Firebase.initializeApp();
      analytics = FirebaseAnalytics.instance;
      await FirebaseMessaging.instance;
      await FirebaseRemoteConfig.instance;
    });

    setUp(() async {
      // await configureDependencies(environment: Env.test);
      final dependency_injection = GetIt.instance;
      dependency_injection.registerFactory<LogIt>(() => LogIt(Logger()));
      methodCallLog.clear();
    });

    tearDown(methodCallLog.clear);

    group('Emulator', () {
      test('connect to emulator', () async {
        await connectToFirebaseEmulator();
        expect(FirebaseAuth.instance.app != null, true);
      });
    });

    group('logEvent', () {
      test('reject events with reserved names', () async {
        expect(
          analytics!.logEvent(name: 'app_clear_data'),
          throwsArgumentError,
        );
      });

      test('reject events with reserved prefix', () async {
        expect(analytics!.logEvent(name: 'firebase_foo'), throwsArgumentError);
      });

      test('custom event with correct parameters', () async {
        await analytics!.logEvent(
          name: 'test-event',
          parameters: {'a': 'b'},
        );
        expect(
          methodCallLog,
          <Matcher>[
            isMethodCall(
              'Analytics#logEvent',
              arguments: {
                'eventName': 'test-event',
                'parameters': {'a': 'b'},
              },
            )
          ],
        );
      });
    });
  });
}
