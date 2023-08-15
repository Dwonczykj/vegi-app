// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_driver/driver_extension.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:vegan_liverpool/app.dart';
// import 'package:vegan_liverpool/common/di/di.dart';
// import 'package:vegan_liverpool/common/network/web3auth.dart';
// import 'package:vegan_liverpool/initFirebaseEmulator.dart';
// import 'package:vegan_liverpool/initFirebaseRemote.dart';
// import 'package:vegan_liverpool/services.dart';
// import 'package:vegan_liverpool/utils/constants.dart';
// import 'package:vegan_liverpool/utils/log/log.dart';
// import 'package:vegan_liverpool/utils/stripe.dart';

// import '../test/main_test.dart';

// void main() async {
//   // enableFlutterDriverExtension();
//   print('RUNNING INTEGRATION TEST');
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   const envStr = EnvTest.activeEnv;

//   // if (DebugHelpers.inDebugMode) {
//   //   print('Loading secrets from ${Env.envFile} for Env: ${Env.activeEnv}');
//   // }
//   await dotenv.load(fileName: EnvTest.envFile);

//   StripeService()
//     ..init()
//     ..setTestMode(isTester: true);

//   await initWeb3AuthService();

//   await configureDependencies(environment: envStr);

//   await initFirebaseRemote();

//   if (kDebugMode && (USE_FIREBASE_EMULATOR || DebugHelpers.isTest)) {
//     // Dont put below condition in above as above is compile time and allows all this to be left out of production apps.
//     await connectToFirebaseEmulator();
//   }

//   await log.connectReduxStoreToLogs();

//   //Pass the store to the Main App which injects it into the entire tree.
//   final store = await reduxStore;

//   group('end-to-end test', () {
//     testWidgets('tap on the floating action button, verify counter',
//         (tester) async {

//       // Load app widget.
//       // runApp(MyApp(store));
//       await tester.pumpWidget(MyApp(store));

//       // Verify the counter starts at 0.
//       expect(find.text('0'), findsOneWidget);

//       // Finds the floating action button to tap on.
//       final Finder fab = find.byTooltip('Increment');

//       // Emulate a tap on the floating action button.
//       await tester.tap(fab);

//       // Trigger a frame.
//       await tester.pumpAndSettle();

//       // Verify the counter increments by 1.
//       expect(find.text('1'), findsOneWidget);
//     });
//   });
// }
