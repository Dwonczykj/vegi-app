import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/stackLine.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/app_log_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:redux/redux.dart';

@lazySingleton
class LogIt {
  LogIt(this.logger);

  Store<AppState>? store;

  Future<void> connectReduxLogs() async {
    store = await reduxStore;
  }

  // ~ lib/common/di/logger_di.dart:7
  final Logger logger;

  /// Log a message at level [Level.verbose].
  void verbose(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = false,
    String sentryHint = '',
  }) {
    final filteredStackTrace = stackTraceLines.isEmpty
        ? (stackTrace ?? StackTrace.current).filterCallStack(
            dontMatch: RegExp(
              r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(utils\/log\/)(log\.dart):(\d+):(\d+)\)',
            ),
            removeLinesContaining: [
              'log_it.dart',
              'vegi_debug_route_observer.dart',
            ],
          )
        : stackTraceLines;

    if (sentry) {
      // reduxStore.then((store) async {
      //   await Sentry.configureScope(
      //     (scope) => scope
      //       ..setContexts('user_state', store.state.userState.toJson())
      //       ..setContexts('message', message)
      //       ..setContexts(
      //           'filteredStack',
      //           filteredStackTrace.isNotEmpty
      //               ? filteredStackTrace.pretty()
      //               : (stackTrace ?? StackTrace.current)
      //                   .filterCallStack()
      //                   .pretty())
      //       ..setContexts('timestamp', '${DateTime.now()}'),
      //   );
      // });
      Sentry.captureMessage(
        '$message [${DateTime.now()}]',
      );
    }

    store!.dispatch(
      AddAppLog(
        message: message.toString(),
        additionalInfo: {},
      ),
    );

    if (kReleaseMode) {
      return;
    }

    logger.v(message, error, stackTrace ?? StackTrace.current);
  }

  /// Log a message at level [Level.debug].
  void debug(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = false,
    String sentryHint = '',
  }) {
    final filteredStackTrace = stackTraceLines.isEmpty
        ? (stackTrace ?? StackTrace.current).filterCallStack(
            dontMatch: RegExp(
              r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(utils\/log\/)(log\.dart):(\d+):(\d+)\)',
            ),
            removeLinesContaining: [
              'log_it.dart',
              'vegi_debug_route_observer.dart',
            ],
          )
        : stackTraceLines;

    if (sentry) {
      // reduxStore.then((store) async {
      //   await Sentry.configureScope(
      //     (scope) => scope
      //       ..setContexts('user_state', store.state.userState.toJson())
      //       ..setContexts('message', message)
      //       ..setContexts(
      //           'filteredStack',
      //           filteredStackTrace.isNotEmpty
      //               ? filteredStackTrace.pretty()
      //               : (stackTrace ?? StackTrace.current)
      //                   .filterCallStack()
      //                   .pretty())
      //       ..setContexts('timestamp', '${DateTime.now()}'),
      //   );
      // });
      Sentry.captureMessage(
        '$message [${DateTime.now()}]',
      );
    }

    store!.dispatch(
      AddAppLog(
        message: message.toString(),
        additionalInfo: {},
      ),
    );

    if (kReleaseMode) {
      return;
    }

    logger.d(message, error, stackTrace ?? StackTrace.current);
  }

  /// Log a message at level [Level.info].
  void info(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = false,
    String sentryHint = '',
  }) {
    final filteredStackTrace = stackTraceLines.isEmpty
        ? (stackTrace ?? StackTrace.current).filterCallStack(
            dontMatch: RegExp(
              r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(utils\/log\/)(log\.dart):(\d+):(\d+)\)',
            ),
            removeLinesContaining: [
              'log_it.dart',
              'vegi_debug_route_observer.dart',
            ],
          )
        : stackTraceLines;

    if (sentry) {
      // reduxStore.then((store) async {
      //   await Sentry.configureScope(
      //     (scope) => scope
      //       ..setContexts('user_state', store.state.userState.toJson())
      //       ..setContexts('message', message)
      //       ..setContexts(
      //           'filteredStack',
      //           filteredStackTrace.isNotEmpty
      //               ? filteredStackTrace.pretty()
      //               : (stackTrace ?? StackTrace.current)
      //                   .filterCallStack()
      //                   .pretty())
      //       ..setContexts('timestamp', '${DateTime.now()}'),
      //   );
      //   await Sentry.captureMessage(
      //     '* $message [${DateTime.now()}]',
      //   );
      // });
      Sentry.captureMessage(
        '$message [${DateTime.now()}]',
      );
    }

    store!.dispatch(
      AddAppLog(
        message: '🔵 $message',
        additionalInfo: {},
      ),
    );

    if (kReleaseMode) {
      return;
    }

    if (kDebugMode) {
      logger.i(
        '$message - ${filteredStackTrace.pretty(false)}',
        error,
      );
    } else {
      logger.i(message, error, stackTrace ?? StackTrace.current);
    }
  }

  Future<void> infoAsync(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = false,
    String sentryHint = '',
  }) async {
    final filteredStackTrace = stackTraceLines.isEmpty
        ? (stackTrace ?? StackTrace.current).filterCallStack(
            dontMatch: RegExp(
              r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(utils\/log\/)(log\.dart):(\d+):(\d+)\)',
            ),
            removeLinesContaining: [
              'log_it.dart',
              'vegi_debug_route_observer.dart',
            ],
          )
        : stackTraceLines;
    if (sentry) {
      // final store = await reduxStore;
      await Sentry.captureMessage(
        '* $message [${DateTime.now()}]',
        // withScope: (p0) async {
        //   await p0
        //     ..setContexts('user_state', store.state.userState.toJson())
        //     ..setContexts('message', message)
        //     ..setContexts(
        //         'filteredStack',
        //         filteredStackTrace.isNotEmpty
        //             ? filteredStackTrace.pretty()
        //             : (stackTrace ?? StackTrace.current)
        //                 .filterCallStack()
        //                 .pretty())
        //     ..setContexts('timestamp', '${DateTime.now()}');
        // },
      );
    }

    store!.dispatch(
      AddAppLog(
        message: '🔵 $message',
        additionalInfo: {},
      ),
    );

    if (kReleaseMode) {
      return;
    }

    if (kDebugMode) {
      logger.i(
        '$message - ${filteredStackTrace.pretty(false)}',
        error,
      );
    } else {
      logger.i(message, error, stackTrace ?? StackTrace.current);
    }
  }

  /// Log a message at level [Level.warning].
  void warn(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = true,
    String sentryHint = '',
  }) {
    final filteredStackTrace = stackTraceLines.isEmpty
        ? (stackTrace ?? StackTrace.current).filterCallStack(
            dontMatch: RegExp(
              r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(utils\/log\/)(log\.dart):(\d+):(\d+)\)',
            ),
            removeLinesContaining: [
              'log_it.dart',
              'vegi_debug_route_observer.dart',
            ],
          )
        : stackTraceLines;
    if (sentry) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace ?? StackTrace.current,
      );
      // reduxStore.then((store) async {
      //   await Sentry.configureScope(
      //     (scope) => scope
      //       ..setContexts('user_state', store.state.userState.toJson())
      //       ..setContexts('message', message)
      //       ..setContexts(
      //           'filteredStack',
      //           filteredStackTrace.isNotEmpty
      //               ? filteredStackTrace.pretty()
      //               : (stackTrace ?? StackTrace.current)
      //                   .filterCallStack()
      //                   .pretty())
      //       ..setContexts('timestamp', '${DateTime.now()}'),
      //   );
      // });
    }

    store!.dispatch(
      AddAppLog(
        message: '⚠️ $message',
        additionalInfo: {},
      ),
    );

    if (kReleaseMode) {
      return;
    }

    logger.w(message, error, stackTrace ?? StackTrace.current);
  }

  /// Log a message at level [Level.error].
  void error(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = true,
    String sentryHint = '',
  }) {
    final filteredStackTrace = stackTraceLines.isEmpty
        ? (stackTrace ?? StackTrace.current).filterCallStack(
            dontMatch: RegExp(
              r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(utils\/log\/)(log\.dart):(\d+):(\d+)\)',
            ),
            removeLinesContaining: [
              'log_it.dart',
              'vegi_debug_route_observer.dart',
            ],
          )
        : stackTraceLines;
    if (sentry) {
      Sentry.captureException(
        error,
        stackTrace: stackTrace ?? StackTrace.current,
      );
      // reduxStore.then((store) async {
      //   await Sentry.configureScope(
      //     (scope) => scope
      //       ..setContexts('user_state', store.state.userState.toJson())
      //       ..setContexts('message', message)
      //       ..setContexts(
      //           'filteredStack',
      //           filteredStackTrace.isNotEmpty
      //               ? filteredStackTrace.pretty()
      //               : (stackTrace ?? StackTrace.current)
      //                   .filterCallStack()
      //                   .pretty())
      //       ..setContexts('timestamp', '${DateTime.now()}'),
      //   );
      // });
    }

    store!.dispatch(
      AddAppLog(
        message: '❌ $message',
        additionalInfo: {},
      ),
    );

    if (kReleaseMode) {
      return;
    }

    logger.e(message, error, stackTrace ?? StackTrace.current);
  }

  /// Log a message at level [Level.wtf].
  void wtf(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    store!.dispatch(
      AddAppLog(
        message: '🚨 $message',
        additionalInfo: {},
      ),
    );

    if (kReleaseMode) {
      return;
    }

    logger.wtf(message, error, stackTrace ?? StackTrace.current);
  }
}
