// integration_test/recording_test.dart
import 'package:patrol/patrol.dart';
import 'package:vegan_liverpool/app.dart';
import 'package:vegan_liverpool/services.dart';

import 'register_dependencies.dart';
// import 'tests_common.dart';

void main() {
  patrolTest(
    // patrolTest() instead of testWidgets()
    'records sounds and saves it to internal storage',
    ($) async {
      // PatrolTester instead of WidgetTester
      await registerDependencies();
      final store = await reduxStore;

      // tests = TestsCommon($.tester);
      // Run app
      await $.pumpWidget(MyApp(store));

      // await $('Record').tap(); // Patrol's custom finders syntax (optional)
      await $.native.grantPermissionWhenInUse();
    },
    nativeAutomation: true,
  );
}
