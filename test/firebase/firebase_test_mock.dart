// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_analytics_platform_interface/firebase_analytics_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

typedef Callback = void Function(MethodCall call);

final List<MethodCall> methodCallLog = <MethodCall>[];

void setupFirebaseAnalyticsMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();

  MethodChannelFirebaseAnalytics.channel
      .setMockMethodCallHandler((MethodCall methodCall) async {
    methodCallLog.add(methodCall);
    switch (methodCall.method) {
      case 'Analytics#getAppInstanceId':
        return 'ABCD1234';

      default:
        return false;
    }
  });
}

// class MockFirebaseAuth extends FirebaseAuth {
//   MockFirebaseAuth.instanceFor({required FirebaseApp app})
//       : super.instanceFor(app: app);

//   String testVerificationId = 'test_verification_id';
//   String testPhoneNumber = '+1 650-555-3434';
//   String testCode = '123456';

//   @override
//   Future<void> verifyPhoneNumber({
//     String? phoneNumber,
//     PhoneMultiFactorInfo? multiFactorInfo,
//     required PhoneVerificationCompleted verificationCompleted,
//     required PhoneVerificationFailed verificationFailed,
//     required PhoneCodeSent codeSent,
//     required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
//     String? autoRetrievedSmsCodeForTesting,
//     Duration timeout = const Duration(seconds: 30),
//     int? forceResendingToken,
//     MultiFactorSession? multiFactorSession,
//   }) async {
//     if (phoneNumber == testPhoneNumber) {
//       codeSent(testVerificationId, 1);
//       codeAutoRetrievalTimeout(testVerificationId);
//     } else {
//       verificationFailed(FirebaseAuthException(
//         code: 'invalid-phone-number',
//         message: 'The provided phone number is not valid.',
//       ));
//     }
//   }

//   @override
//   Future<UserCredential> signInWithCredential(AuthCredential credential) async {
//     if (credential is PhoneAuthCredential) {
//       if (credential.verificationId == testVerificationId &&
//           credential.smsCode == testCode) {
//         throw Error();
//         // return UserCredential(platform: this, user: User(this, {... /* Add the necessary user fields here. */ }));
//       }
//     }
//     throw FirebaseAuthException(
//       code: 'invalid-credential',
//       message: 'The provided credential is not valid.',
//     );
//   }
// }

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   group('Phone Authentication Test', () {
//     FirebaseAuth? auth;
//     String? verificationId;

//     setUp(() {
//       auth = MockFirebaseAuth();
//     });

//     testWidgets('should send a verification code', (tester) async {
//       // We are using a test phone number and a test code from MockFirebaseAuth.
//       final phoneNumber = '+1 650-555-3434';
//       final testCode = '123456';

//       await auth?.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           // This callback won't be called because we're using a test phone number
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           fail('Failed to verify phone number: ${e.message}');
//         },
//         codeSent: (String verId, int? resendToken) {
//           verificationId = verId;
//         },
//         codeAutoRetrievalTimeout: (String verId) {
//           verificationId = verId;
//         },
//       );

//       expect(verificationId, isNotNull);

//       // Sign in using the verification code
//       final credential = PhoneAuthProvider.credential(
//         verificationId: verificationId!,
//         smsCode: testCode,
//       );

//       final userCredential = await auth?.signInWithCredential(credential);

//       expect(userCredential?.user, isNotNull);
//       expect(userCredential?.user?.phoneNumber, phoneNumber);
//     });
//   });
// }
