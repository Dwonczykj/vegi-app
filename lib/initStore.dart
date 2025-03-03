import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:logging/logging.dart' as logging;
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/loadAppState.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/app_log_actions.dart';
import 'package:vegan_liverpool/redux/reducers/app_reducer.dart';
import 'package:vegan_liverpool/scan_network.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:vegan_liverpool/utils/storage.dart';
import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';

@module
abstract class RegisterModule {
  @singleton
  Future<Store<AppState>> store() async {
    final prefs = await SharedPreferences.getInstance();

    final hasLoggedIn = prefs.getInt('hasLoggedIn');

    final firstLogin = hasLoggedIn != 1;
    if (firstLogin) {
      await prefs.setInt('hasLoggedIn', 1);
    }

    final Persistor<AppState> persistor = Persistor<AppState>(
      storage: SecureStorage(const FlutterSecureStorage()),
      serializer: JsonSerializer<AppState>(AppState.fromJsonForPersistor),
      debug: DebugHelpers.isVerboseDebugMode,
    );

    // ~ https://pub.dev/documentation/redux_logging/latest/redux_logging/LoggingMiddleware-class.html
    // Create your own Logger
    final logger = logging.Logger(
      'Redux Logger',
    );

    // Create a formatter that only prints out the dispatched action
    String onlyLogActionFormatter<State>(
      State state,
      dynamic action,
      DateTime timestamp,
    ) {
      // print(action.runtimeType);
      if (action is AddAppLog) {
        return '';
      }
      return '{ts: ${timestamp.formatToHHmmss}, Action: $action}';
    }

    // Create your middleware using the formatter.
    final reduxLoggingMiddleware = LoggingMiddleware(
      formatter: onlyLogActionFormatter<AppState>,
      logger: logger,
    );
    // Note: The LoggingMiddleware needs be the LAST middleware in the list.
    final List<Middleware<AppState>> wms = [
      thunkMiddleware,
      persistor.createMiddleware(),
      // LoggingMiddleware.printer().call,
      reduxLoggingMiddleware.call,
    ];

    // Note: One quirk about listening to a logger instance is that you're
    // actually listening to the Singleton instance of *all* loggers.
    logger.onRecord
        // Filter down to [LogRecord]s sent to your logger instance
        .where((record) => record.loggerName == logger.name)
        // Print them out (or do something more interesting!)
        .listen((loggingMiddlewareRecord) => print(loggingMiddlewareRecord));

    late final Store<AppState> store;

    if (Env.isDev) {
      if (DebugHelpers.isVerboseDebugMode) {
        wms.add(LoggingMiddleware<AppState>.printer().call);
      }
      final notSim = await DebugHelpers.deviceIsNotSimulator();
      if (kDebugMode && notSim) {
        // ~ https://github.com/MichaelMarner/dart-redux-remote-devtools , https://stackoverflow.com/a/56078898
        final ips = await scanNetwork();
        if (ips.isNotEmpty) {
          final devMachineHost = ips.first;
          // ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
          // const devMachineHost =
          //     '10.0.0.209';
          const devMachinePort = '8000';
          final remoteDevtools = RemoteDevToolsMiddleware<dynamic>(
            '$devMachineHost:$devMachinePort',
          );

          await remoteDevtools.connect();
          wms.add(remoteDevtools.call);

          final devStore = DevToolsStore<AppState>(
            appReducer,
            initialState: await loadState(persistor, firstLogin),
            middleware: wms,
          );

          store = devStore;

          remoteDevtools.store = store;
          getIt.registerSingleton<DevToolsStore<AppState>>(devStore);
        } else {
          final devStore = DevToolsStore<AppState>(
            appReducer,
            initialState: await loadState(persistor, firstLogin),
            middleware: wms,
          );

          store = devStore;
          getIt.registerSingleton<DevToolsStore<AppState>>(devStore);
        }
      } else {
        final devStore = DevToolsStore<AppState>(
          appReducer,
          initialState: await loadState(persistor, firstLogin),
          middleware: wms,
        );

        store = devStore;
        getIt.registerSingleton<DevToolsStore<AppState>>(devStore);
      }

      // getIt.registerSingleton<Store<AppState>>(store);
    } else if (Env.isTest) {
      store = DevToolsStore<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: [thunkMiddleware],
      );
    } else {
      final AppState initialState = await loadState(persistor, firstLogin);
      store = Store<AppState>(
        appReducer,
        initialState: initialState,
        middleware: wms,
      );
      // getIt.registerSingleton<Store<AppState>>(store);
    }
    // peeplEatsService.store = store;

    // await reauthenticateServices(store, initialState);

    return store;
  }
}
