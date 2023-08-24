import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/stackLine.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/app_log_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:ansicolor/ansicolor.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/utils/constants.dart';

enum LogLevel { wtf, trace, verbose, debug, info, warn, error }

@lazySingleton
class LogIt {
  LogIt(this.logger);

  Store<AppState>? store;

  final LogLevel logLevel = Env.isProd ? LogLevel.wtf : LogLevel.wtf;

  Future<void> connectReduxStoreToLogs() async {
    store = await reduxStore;
    if (store == null) {
      return;
    }
    deviceMeta['identifier'] = store!.state.userState.identifier;
    deviceMeta['displayName'] = store!.state.userState.displayName;
    deviceMeta['deviceName'] = store!.state.userState.deviceName;
    deviceMeta['deviceOSName'] = store!.state.userState.deviceOSName;
    deviceMeta['deviceOSReleaseName'] =
        store!.state.userState.deviceReleaseName;
    deviceMeta['env'] = Env.activeEnv;
    deviceMeta['simulator'] =
        (await DebugHelpers.deviceIsSimulator()) ? 'simulator' : 'real device';
  }

  Map<String, String> deviceMeta = {};

  final AnsiPen _greenPen = AnsiPen()..green();
  final AnsiPen _greenBackGroundPen = AnsiPen()..green(bg: true);

  final AnsiPen _redTextBlueBackgroundPen = AnsiPen()
    ..blue(bg: true)
    ..red();

  final AnsiPen _boldPen = AnsiPen()..white(bold: true);

  final AnsiPen _someColorPen = AnsiPen()..rgb(r: .5, g: .2, b: .4);

  // ~ lib/common/di/logger_di.dart:7
  final Logger logger;

  void _writeLog(
    dynamic message, {
    LogLevel level = LogLevel.debug,
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = false,
    String sentryHint = '',
    bool dontLog = false,
    Map<String, dynamic> additionalDetails = const {},
  }) {
    if (logLevel.index > level.index) {
      return;
    }
    if (store == null) {
      connectReduxStoreToLogs();
    }
    // final filteredStackTrace = stackTraceLines.isEmpty
    //     ? (stackTrace ?? StackTrace.current).filterCallStack(
    //         dontMatch: RegExp(
    //           r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(utils\/log\/)(log\.dart):(\d+):(\d+)\)',
    //         ),
    //         removeLinesContaining: [
    //           'log_it.dart',
    //           'vegi_debug_route_observer.dart',
    //         ],
    //       )
    //     : stackTraceLines;
    try {
      if (stackTrace == null && stackTraceLines.isNotEmpty) {
        stackTrace = StackTraceFilter.fromStackLines(stackTraceLines);
      } else {
        stackTrace = StackTraceFilter.fromStackLines(
          StackTrace.current.filterCallStack(
            ignoreLastNCalls: 2,
          ),
        );
      }
    } catch (err) {
      if (!kReleaseMode) {
        logger.e('Unable to create stacktrace from stackLines: $err');
      }
    }
    String emoji = '';
    void Function(dynamic, [dynamic, StackTrace?]) logFn;
    AnsiPen pen = AnsiPen();
    switch (level) {
      case LogLevel.wtf:
        emoji = '🖕';
        logFn = logger.wtf;
        pen = AnsiPen()..yellow();
        break;
      case LogLevel.trace:
        emoji = '🕵️‍♀️';
        logFn = logger.v;
        pen = AnsiPen()..green();
        break;
      case LogLevel.verbose:
        emoji = '🧐';
        logFn = logger.v;
        pen = AnsiPen()..gray();
        break;
      case LogLevel.debug:
        emoji = '👾';
        logFn = logger.d;
        pen = AnsiPen()..magenta();
        break;
      case LogLevel.info:
        emoji = '🔵';
        logFn = logger.i;
        pen = AnsiPen()..blue();
        break;
      case LogLevel.warn:
        emoji = '🚧';
        logFn = logger.w;
        pen = AnsiPen()
          ..rgb(
            r: Colors.amber.red.toDouble() / 255.0,
            b: Colors.amber.blue.toDouble() / 255.0,
            g: Colors.amber.green.toDouble() / 255.0,
          );
        break;
      case LogLevel.error:
        emoji = '❌';
        logFn = logger.e;
        pen = AnsiPen()..red();
        break;
    }
    // if (sentry) {
    //   // reduxStore.then((store) async {
    //   //   await Sentry.configureScope(
    //   //     (scope) => scope
    //   //       ..setContexts('user_state', store.state.userState.toJson())
    //   //       ..setContexts('message', message)
    //   //       ..setContexts(
    //   //           'filteredStack',
    //   //           filteredStackTrace.isNotEmpty
    //   //               ? filteredStackTrace.pretty()
    //   //               : (stackTrace ?? StackTrace.current)
    //   //                   .filterCallStack()
    //   //                   .pretty())
    //   //       ..setContexts('timestamp', '${DateTime.now()}'),
    //   //   );
    //   //   await Sentry.captureMessage(
    //   //     '* $message [${DateTime.now()}]',
    //   //   );
    //   // });
    //   Sentry.captureMessage(
    //     '$message [${DateTime.now()}]',
    //   );
    // }
    if (!dontLog) {
      final ts = DateTime.now().toIso8601String();
      var logMetaData = {
        'stackTrace': stackTrace.toString(),
        'meta': deviceMeta,
        'level': level.name,
        'detail': additionalDetails,
        'timestamp': ts,
      };
      if (level == LogLevel.error) {
        logMetaData.addAll({'AppState': store?.state.toJson() ?? {}});
      }
      peeplEatsService.writeLog(
        message: '$emoji $message',
        details: logMetaData,
      );

      store?.dispatch(
        AddAppLog(
          message: '$emoji $message',
          additionalInfo: logMetaData,
        ),
      );
    }

    if (kReleaseMode) {
      return;
    }

    logFn(
      pen('$emoji $message'),
      error,
      stackTrace ??
          StackTraceFilter.fromStackLines(
            StackTrace.current.filterCallStack(
              ignoreLastNCalls: 2,
            ),
          ),
    );
  }

  /// Log a message at level [Level.verbose].
  void verbose(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = false,
    String sentryHint = '',
    bool dontLog = false,
    Map<String, dynamic> additionalDetails = const {},
  }) {
    _writeLog(
      message,
      level: LogLevel.verbose,
      error: error,
      stackTrace: stackTrace,
      stackTraceLines: stackTraceLines,
      sentry: sentry,
      sentryHint: sentryHint,
      dontLog: dontLog,
      additionalDetails: additionalDetails,
    );
  }

  /// Log a message at level [Level.debug].
  void debug(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = false,
    String sentryHint = '',
    bool dontLog = false,
    Map<String, dynamic> additionalDetails = const {},
  }) {
    _writeLog(
      message,
      error: error,
      stackTrace: stackTrace,
      stackTraceLines: stackTraceLines,
      sentry: sentry,
      sentryHint: sentryHint,
      dontLog: dontLog,
      additionalDetails: additionalDetails,
    );
  }

  /// Log a message at level [Level.info].
  void info(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = false,
    String sentryHint = '',
    bool dontLog = false,
    Map<String, dynamic> additionalDetails = const {},
  }) {
    _writeLog(
      message,
      level: LogLevel.info,
      error: error,
      stackTrace: stackTrace,
      stackTraceLines: stackTraceLines,
      sentry: sentry,
      sentryHint: sentryHint,
      dontLog: dontLog,
      additionalDetails: additionalDetails,
    );
  }

  Future<void> infoAsync(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = false,
    String sentryHint = '',
    bool dontLog = false,
    Map<String, dynamic> additionalDetails = const {},
  }) async {
    _writeLog(
      message,
      level: LogLevel.info,
      error: error,
      stackTrace: stackTrace,
      stackTraceLines: stackTraceLines,
      sentry: sentry,
      sentryHint: sentryHint,
      dontLog: dontLog,
      additionalDetails: additionalDetails,
    );
  }

  /// Log a message at level [Level.warning].
  void warn(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = true,
    String sentryHint = '',
    bool dontLog = false,
    Map<String, dynamic> additionalDetails = const {},
  }) {
    _writeLog(
      message,
      level: LogLevel.warn,
      error: error,
      stackTrace: stackTrace,
      stackTraceLines: stackTraceLines,
      sentry: sentry,
      sentryHint: sentryHint,
      dontLog: dontLog,
      additionalDetails: additionalDetails,
    );
  }

  /// Log a message at level [Level.error].
  void error(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = true,
    String sentryHint = '',
    bool dontLog = false,
    Map<String, dynamic> additionalDetails = const {},
  }) {
    _writeLog(
      message,
      level: LogLevel.error,
      error: error,
      stackTrace: stackTrace,
      stackTraceLines: stackTraceLines,
      sentry: sentry,
      sentryHint: sentryHint,
      dontLog: dontLog,
      additionalDetails: additionalDetails,
    );
  }

  /// Log a message at level [Level.wtf].
  void wtf(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    List<StackLine> stackTraceLines = const <StackLine>[],
    bool sentry = true,
    String sentryHint = '',
    bool dontLog = false,
    Map<String, dynamic> additionalDetails = const {},
  }) {
    _writeLog(
      message,
      level: LogLevel.wtf,
      error: error,
      stackTrace: stackTrace,
      stackTraceLines: stackTraceLines,
      sentry: sentry,
      sentryHint: sentryHint,
      dontLog: dontLog,
      additionalDetails: additionalDetails,
    );
  }
}
