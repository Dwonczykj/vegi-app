import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
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
import 'package:fuse_wallet_sdk/fuse_wallet_sdk.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/app.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/common/network/web3auth.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/redux_state_viewer.dart';
import 'package:vegan_liverpool/initFirebaseEmulator.dart';
import 'package:vegan_liverpool/initFirebaseRemote.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/new_version.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/services/apis/fxService.dart';
import 'package:vegan_liverpool/services/apis/locationService.dart';
import 'package:vegan_liverpool/services/apis/peeplEats.dart';
import 'package:vegan_liverpool/services/apis/peeplPay2.dart';
import 'package:vegan_liverpool/services/apis/stripePay2.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/log/log_it.dart';
import 'package:vegan_liverpool/utils/onboard/Istrategy.dart';
import 'package:vegan_liverpool/utils/onboard/authentication.dart';
import 'package:vegan_liverpool/utils/onboard/firebase.dart';
import 'package:vegan_liverpool/utils/stripe.dart';
import 'package:redux/redux.dart';

import '../../env_test.dart';
import '../../firebase/firebase_test_mock.dart';
import '../../initStore_for_test.dart';
import '../../register_dependencies.dart';
// import '../../main_test.dart' as main_test;

/// ~ Taken from https://stackoverflow.com/a/74477245
/// TODO: we also need to remember how to start the firebase emulator instance before running tests
/// and in setup, there needs to be an expect() emulator is running on port
/// the emulator code may be in the nodejs lib...
/// ~ https://www.notion.so/gember/Firebase-Emulator-Setting-up-and-Using-64c59408e482499a9a1ed07548fe09ae
void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAnalyticsMocks();

  FirebaseApp? firebaseApp;
  FirebaseAnalytics? analytics;
  FirebaseMessaging? firebaseMessaging;
  FirebaseRemoteConfig? firebaseRemoteConfig;

  group('$FirebaseAnalytics', () {
    setUpAll(() async {
      firebaseApp = await Firebase.initializeApp();
      analytics = FirebaseAnalytics.instance;
      firebaseMessaging = FirebaseMessaging.instance;
      firebaseRemoteConfig = FirebaseRemoteConfig.instance;

      await registerDependencies();

      return firebaseApp;
    });

    setUp(() async {
      methodCallLog.clear();
    });

    tearDown(methodCallLog.clear);

    group('init firebase', () {
      test('firebase app is not null', () async {
        expect(firebaseApp, isNotNull);
        return;
      });
    });

    group('Emulator', () {
      test('connect to emulator', () async {
        await connectToFirebaseEmulator();
        expect(FirebaseAuth.instance.app, isNotNull);
      });
    });
  });
}
