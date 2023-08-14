abstract class EnvTest {
  static const dev = 'dev';
  static const test = 'test';
  static const qa = 'qa';
  static const prod = 'production';
  static bool get isDev => EnvTest.activeEnv == EnvTest.dev;
  static bool get isProd => EnvTest.activeEnv == EnvTest.prod;
  static bool get isTest => EnvTest.activeEnv == EnvTest.test;
  static bool get isQA => EnvTest.activeEnv == EnvTest.qa;
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
