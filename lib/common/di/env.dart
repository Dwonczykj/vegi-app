import 'package:vegan_liverpool/utils/constants.dart';

abstract class Env {
  static const dev = 'dev';
  static const test = 'test';
  static const qa = 'qa';
  static const prod = 'production';
  static bool get isDev => Env.activeEnv == Env.dev;
  static bool get isProd => Env.activeEnv == Env.prod;
  static bool get isTest => Env.activeEnv == Env.test;
  static bool get isQA => Env.activeEnv == Env.qa;
  static final activeEnv = ENV == 'development'
      ? dev
      : ENV == 'qa'
          ? qa
          : ENV == 'test' || DebugHelpers.isTest
              ? test
              : prod;
  static final _envFile = activeEnv == dev
      ? '.env_dev'
      : activeEnv == qa
          ? '.env_qa'
          : activeEnv == test
              ? '.env_test'
              : '.env';
  static final envFile = 'environment/$_envFile';
}
