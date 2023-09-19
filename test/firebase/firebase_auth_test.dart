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
import 'package:mockito/mockito.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/app.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/redux_state_viewer.dart';
import 'package:vegan_liverpool/initFirebaseEmulator.dart';
import 'package:vegan_liverpool/initFirebaseRemote.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/log/log_it.dart';
import 'package:vegan_liverpool/utils/stripe.dart';

import 'firebase_auth/firebase_auth_test.dart';
import 'firebase_auth/mock.dart';

import 'firebase_test_mock.dart';

import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_auth_platform_interface/src/method_channel/method_channel_firebase_auth.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// ~ Taken from https://stackoverflow.com/a/74477245
/// TODO: we also need to remember how to start the firebase emulator instance before running tests
/// and in setup, there needs to be an expect() emulator is running on port
/// the emulator code may be in the nodejs lib...
/// ~ https://www.notion.so/gember/Firebase-Emulator-Setting-up-and-Using-64c59408e482499a9a1ed07548fe09ae
void main() {
  setupFirebaseAuthMocks();

  late FirebaseAuth auth;

  const String kMockActionCode = '12345';
  const String kMockEmail = 'test@example.com';
  const String kMockPassword = 'passw0rd';
  const String kMockIdToken = '12345';
  const String kMockAccessToken = '67890';
  const String kMockGithubToken = 'github';
  const String kMockCustomToken = '12345';
  const String kMockPhoneNumber = '5555555555';
  const String kMockVerificationId = '12345';
  const String kMockSmsCode = '123456';
  const String kMockLanguage = 'en';
  const String kMockOobCode = 'oobcode';
  const String kMockURL = 'http://www.example.com';
  const String kMockHost = 'www.example.com';
  const int kMockPort = 31337;

  final TestAuthProvider testAuthProvider = TestAuthProvider();
  final int kMockCreationTimestamp =
      DateTime.now().subtract(const Duration(days: 2)).millisecondsSinceEpoch;
  final int kMockLastSignInTimestamp =
      DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch;

  final kMockUser = PigeonUserDetails(
    userInfo: PigeonUserInfo(
      uid: '12345',
      displayName: 'displayName',
      creationTimestamp: kMockCreationTimestamp,
      lastSignInTimestamp: kMockLastSignInTimestamp,
      isAnonymous: true,
      isEmailVerified: false,
    ),
    providerData: [
      {
        'providerId': 'firebase',
        'uid': '12345',
        'displayName': 'Flutter Test User',
        'photoUrl': 'http://www.example.com/',
        'email': 'test@example.com',
      }
    ],
  );

  MockUserPlatform? mockUserPlatform;
  MockUserCredentialPlatform? mockUserCredPlatform;
  MockConfirmationResultPlatform? mockConfirmationResultPlatform;
  MockRecaptchaVerifier? mockVerifier;
  AdditionalUserInfo? mockAdditionalUserInfo;
  EmailAuthCredential? mockCredential;

  MockFirebaseAuth mockAuthPlatform = MockFirebaseAuth();

  FirebaseApp? firebaseApp;
  FirebaseAnalytics? analytics;
  FirebaseAuth? firebaseAuth;
  FirebaseMessaging? firebaseMessaging;
  FirebaseRemoteConfig? firebaseRemoteConfig;

  group('$FirebaseAuth', () {
    PigeonUserDetails user;
    // used to generate a unique application name for each test
    var testCount = 0;

    setUp(() async {
      FirebaseAuthPlatform.instance = mockAuthPlatform = MockFirebaseAuth();

      // Each test uses a unique FirebaseApp instance to avoid sharing state
      final app = await Firebase.initializeApp(
        name: '$testCount',
        options: const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
        ),
      );

      auth = FirebaseAuth.instanceFor(app: app);
      user = kMockUser;

      mockUserPlatform = MockUserPlatform(
          mockAuthPlatform, TestMultiFactorPlatform(mockAuthPlatform), user,);
      mockConfirmationResultPlatform = MockConfirmationResultPlatform();
      mockAdditionalUserInfo = AdditionalUserInfo(
        isNewUser: false,
        username: 'flutterUser',
        providerId: 'testProvider',
        profile: <String, dynamic>{'foo': 'bar'},
      );
      mockCredential = EmailAuthProvider.credential(
        email: 'test',
        password: 'test',
      ) as EmailAuthCredential;
      mockUserCredPlatform = MockUserCredentialPlatform(
        FirebaseAuthPlatform.instance,
        mockAdditionalUserInfo!,
        mockCredential!,
        mockUserPlatform!,
      );
      mockVerifier = MockRecaptchaVerifier();

      when(mockAuthPlatform.signInAnonymously())
          .thenAnswer((_) async => mockUserCredPlatform!);

      when(mockAuthPlatform.signInWithCredential(any)).thenAnswer(
          (_) => Future<UserCredentialPlatform>.value(mockUserCredPlatform),);

      when(mockAuthPlatform.currentUser).thenReturn(mockUserPlatform);

      when(mockAuthPlatform.instanceFor(
        app: anyNamed('app'),
        pluginConstants: anyNamed('pluginConstants'),
      ),).thenAnswer((_) => mockUserPlatform);

      when(mockAuthPlatform.delegateFor(
        app: anyNamed('app'),
      ),).thenAnswer((_) => mockAuthPlatform);

      when(mockAuthPlatform.setInitialValues(
        currentUser: anyNamed('currentUser'),
        languageCode: anyNamed('languageCode'),
      ),).thenAnswer((_) => mockAuthPlatform);

      when(mockAuthPlatform.createUserWithEmailAndPassword(any, any))
          .thenAnswer((_) async => mockUserCredPlatform!);

      when(mockAuthPlatform.getRedirectResult())
          .thenAnswer((_) async => mockUserCredPlatform!);

      when(mockAuthPlatform.signInWithCustomToken(any))
          .thenAnswer((_) async => mockUserCredPlatform!);

      when(mockAuthPlatform.signInWithEmailAndPassword(any, any))
          .thenAnswer((_) async => mockUserCredPlatform!);

      when(mockAuthPlatform.signInWithEmailLink(any, any))
          .thenAnswer((_) async => mockUserCredPlatform!);

      when(mockAuthPlatform.signInWithPhoneNumber(any, any))
          .thenAnswer((_) async => mockConfirmationResultPlatform!);

      when(mockVerifier!.delegate).thenReturn(mockVerifier!.mockDelegate);

      when(mockAuthPlatform.signInWithPopup(any))
          .thenAnswer((_) async => mockUserCredPlatform!);

      when(mockAuthPlatform.signInWithRedirect(any))
          .thenAnswer((_) async => mockUserCredPlatform);

      when(mockAuthPlatform.authStateChanges()).thenAnswer((_) =>
          Stream<UserPlatform>.fromIterable(<UserPlatform>[mockUserPlatform!]),);

      when(mockAuthPlatform.idTokenChanges()).thenAnswer((_) =>
          Stream<UserPlatform>.fromIterable(<UserPlatform>[mockUserPlatform!]),);

      when(mockAuthPlatform.userChanges()).thenAnswer((_) =>
          Stream<UserPlatform>.fromIterable(<UserPlatform>[mockUserPlatform!]),);

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(MethodChannelFirebaseAuth.channel,
              (call) async {
        return <String, dynamic>{'user': user};
      });
    });

    // incremented after tests completed, in case a test may want to use this
    // value for an assertion (toString)
    tearDown(() => testCount++);
    String? verificationId;

    setUpAll(() async {
      firebaseApp = await Firebase.initializeApp();
      analytics = FirebaseAnalytics.instance;
      firebaseMessaging = FirebaseMessaging.instance;
      firebaseRemoteConfig = FirebaseRemoteConfig.instance;
      firebaseAuth = FirebaseAuth.instance;
      // await configureDependencies(environment: Env.test);
      final dependencyInjection = GetIt.instance;
      dependencyInjection.registerFactory<LogIt>(() => LogIt(Logger()));
      return firebaseApp;
    });

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

    group('verifyPhoneNumber()', () {
      test('should call delegate method', () async {
        // Necessary as we otherwise get a "null is not a Future<void>" error
        when(mockAuthPlatform.verifyPhoneNumber(
          autoRetrievedSmsCodeForTesting:
              anyNamed('autoRetrievedSmsCodeForTesting'),
          codeAutoRetrievalTimeout: anyNamed('codeAutoRetrievalTimeout'),
          codeSent: anyNamed('codeSent'),
          forceResendingToken: anyNamed('forceResendingToken'),
          phoneNumber: anyNamed('phoneNumber'),
          timeout: anyNamed('timeout'),
          verificationCompleted: anyNamed('verificationCompleted'),
          verificationFailed: anyNamed('verificationFailed'),
        ),).thenAnswer((i) async {});

        verificationCompleted(PhoneAuthCredential phoneAuthCredential) {}
        verificationFailed(FirebaseAuthException authException) {}
        codeSent(String verificationId, [int? forceResendingToken]) async {}
        autoRetrievalTimeout(String verificationId) {}

        await auth.verifyPhoneNumber(
          phoneNumber: kMockPhoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: autoRetrievalTimeout,
        );

        // this just checks that the verifyPhoneNumber method was called on the auth (FirebaseAuth object)
        verify(
          mockAuthPlatform.verifyPhoneNumber(
            phoneNumber: kMockPhoneNumber,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: autoRetrievalTimeout,
          ),
        );
        return;
      });
    });

    group('auth', () {
      testWidgets('should send a verification code', (tester) async {
        // We are using a test phone number and a test code from Firebase docs for testing purposes.
        const phoneNumber = '+1 234-566-9420';
        const testCode = '133337';

        expect(firebaseAuth, isNotNull);

        await firebaseAuth!.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // This callback won't be called because we're using a test phone number
            print('WILL NOT BE CALLED');
          },
          verificationFailed: (FirebaseAuthException e) {
            fail('Failed to verify phone number: ${e.message}');
          },
          codeSent: (String verId, int? resendToken) {
            print('Code sent: with verificationId to be used of: "$verId"');
            verificationId = verId;
          },
          codeAutoRetrievalTimeout: (String verId) {
            print('Code sent: with verificationId to be used of: "$verId"');
            verificationId = verId;
          },
        );

        expect(verificationId, isNotNull);

        // Sign in using the verification code
        final credential = PhoneAuthProvider.credential(
          verificationId: verificationId!,
          smsCode: testCode,
        );

        final userCredential =
            await firebaseAuth!.signInWithCredential(credential);

        expect(userCredential.user, isNotNull);
        expect(userCredential.user!.phoneNumber, phoneNumber);
      });
    });
  });
}
