// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vegan_liverpool/loadAppState.dart';
import 'package:vegan_liverpool/main.dart';
import 'package:vegan_liverpool/redux/reducers/app_reducer.dart';
import 'package:vegan_liverpool/utils/storage.dart';
import 'package:redux/redux.dart';

import 'package:vegan_liverpool/app.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // todo: instead we should use main_test init code
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final Persistor<AppState> persistor = Persistor<AppState>(
      storage: SecureStorage(storage = storage),
      serializer: JsonSerializer<AppState>(AppState.fromJson),
      debug: kDebugMode,
    );
    final initialState = await loadState(persistor, false);
    final List<Middleware<AppState>> wms = [
      thunkMiddleware,
      persistor.createMiddleware(),
    ];
    final Store<AppState> store = Store<AppState>(
      appReducer,
      initialState: initialState,
      middleware: wms,
    );
    await tester.pumpWidget(MyApp(store));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
