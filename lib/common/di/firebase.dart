import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/firebase_options.dart';

@module
abstract class FirebaseInjectableModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @Environment(Env.dev)
  @Environment(Env.qa)
  @Environment(Env.prod)
  @Environment(Env.test)
  @preResolve
  Future<FirebaseApp> get firebaseApp => Env.isTest
      ? Firebase.initializeApp()
      : Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

  @lazySingleton
  FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance;

  @lazySingleton
  FirebaseRemoteConfig get firebaseRemoteConfig =>
      FirebaseRemoteConfig.instance;
}
