import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

Future<void> connectToFirebaseEmulator() async {
  if (kDebugMode) {
    // Uncomment the following if want to use firestore db in firebase
    // try {
    //   FirebaseFire.instance.useFirestoreEmulator('localhost', 8080);
    // } catch (e, s) {
    //   log.error(
    //     'Failed to connect to firestore emulator on port 8080',
    //     error: e,
    //     stackTrace: s,
    //   );
    // }
    if (USE_FIREBASE_EMULATOR || DebugHelpers.isTest) {
      const firebaseAuthEmulatorPort = FIREBASE_AUTH_EMULATOR_PORT;
      try {
        // ~ https://firebase.google.com/codelabs/get-started-firebase-emulators-and-flutter#4
        log.info(
          'Connecting to FirebaseAuth emulator on port: [$firebaseAuthEmulatorPort]',
        );
        await FirebaseAuth.instance.useAuthEmulator(
          '10.0.2.2',
          firebaseAuthEmulatorPort,
        );
      } catch (e, s) {
        log.error(
          'Failed to connect to FirebaseAuth AuthEmulator on port $firebaseAuthEmulatorPort. Check that the emulators are running on this port `firebase emulators:start`',
          error: e,
          stackTrace: s,
        );
      }
    }
  }
}
