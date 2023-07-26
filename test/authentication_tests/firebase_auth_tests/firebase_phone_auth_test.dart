// todo: test to check that firebase phone auth can be done from a test

// todo: then test to check that can run phone_auth using authenticator code whilst emulator is running

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Phone Authentication Test', () {
    FirebaseApp? firebaseApp;
    FirebaseAuth? auth;
    String? verificationId;

    setUp(() async {
      firebaseApp = await Firebase.initializeApp();
      auth = FirebaseAuth.instance;
    });

    testWidgets('can init firebase for app', (tester) async {
      expect(firebaseApp, isNotNull);
    });
    testWidgets('should send a verification code', (tester) async {
      // We are using a test phone number and a test code from Firebase docs for testing purposes.
      final phoneNumber = '+1 234-566-9420';
      final testCode = '133337';

      expect(auth, isNotNull);

      await auth!.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback won't be called because we're using a test phone number
        },
        verificationFailed: (FirebaseAuthException e) {
          fail('Failed to verify phone number: ${e.message}');
        },
        codeSent: (String verId, int? resendToken) {
          verificationId = verId;
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );

      expect(verificationId, isNotNull);

      // Sign in using the verification code
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: testCode,
      );

      final userCredential = await auth!.signInWithCredential(credential);

      expect(userCredential.user, isNotNull);
      expect(userCredential.user!.phoneNumber, phoneNumber);
    });
  });
}
