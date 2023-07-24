import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class StackLine {
  StackLine({
    this.className,
    this.functionName,
    this.fileName,
    this.lineNumber,
    this.characterNumber,
  });

  final String? className;
  final String? functionName;
  final String? fileName;
  final String? lineNumber;
  final String? characterNumber;

  @override
  String toString() {
    return '$fileName [$lineNumber] (in $className.$functionName)';
  }
}

@lazySingleton
class LogIt {
  LogIt(this.logger);

  final Logger logger;

  /// Log a message at level [Level.verbose].
  void verbose(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) {
      return;
    }

    logger.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void debug(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    bool sentry = false,
    String sentryHint = '',
  }) {
    if (sentry) {
      unawaited(
        Sentry.captureMessage(
          '$message',
          hint: sentryHint.isNotEmpty ? sentryHint : 'WARNING - $message',
        ),
      );
    }

    if (kReleaseMode) {
      return;
    }

    logger.d(message, error, stackTrace);
  }

  String filterStackTrace(
    StackTrace stackTrace, {
    RegExp? dontMatch,
  }) {
    final filterThisPackage = _filterStackTrace(
      stackTrace,
      dontMatch: dontMatch,
    );
    
    if (filterThisPackage.isEmpty) {
      return '[Unable to parse stack trace]';
    }

    return filterThisPackage.join('\n\t');
  }

  List<StackLine> _filterStackTrace(
    StackTrace stackTrace, {
    RegExp? dontMatch,
    int? returnLine,
    int? removeFirstNLines,
  }) {
    final lines = stackTrace.toString().split('\n');
    if (removeFirstNLines != null && lines.length < removeFirstNLines) {
      print('Unable to remove first $removeFirstNLines most recent function call');
      return [];
    }

    final regex_vegan_liverpool_only = RegExp(
      r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/([A-Za-z0-9_\/]+\/)?([A-Za-z0-9_]+\.dart):(\d+):(\d+)\)',
    );
    final filterThisPackage = lines
        .where(
      (e) =>
          regex_vegan_liverpool_only.hasMatch(e.trim()) &&
          regex_vegan_liverpool_only.firstMatch(e.trim())?.groupCount == 7 &&
          (dontMatch == null || dontMatch.hasMatch(e.trim()) == false),
    )
        .map(
      (e) {
        final match = regex_vegan_liverpool_only.firstMatch(e.trim());
        return StackLine(
          className: match?.group(1),
          functionName: match?.group(2),
          fileName: match?.group(5),
          lineNumber: match?.group(6),
          characterNumber: match?.group(7),
        );
      },
    ).toList();

    return filterThisPackage;
  }

  /// Log a message at level [Level.info].
  void info(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    bool sentry = false,
    String sentryHint = '',
  }) {
    if (sentry) {
      unawaited(
        Sentry.captureMessage(
          '$message',
          hint: sentryHint.isNotEmpty ? sentryHint : 'WARNING - $message',
        ),
      );
    }

    if (kReleaseMode) {
      return;
    }

    if (kDebugMode) {
      final filteredStackTrace = filterStackTrace(
        stackTrace ?? StackTrace.current,
        dontMatch: RegExp(
            r'([A-Za-z_]+)\.([A-Za-z_. <>]+)\s\((package:vegan_liverpool)\/(utils\/log\/)(log\.dart):(\d+):(\d+)\)'),
      );

      logger.i('$message - [$filteredStackTrace]', error);
    } else {
      logger.i(message, error, stackTrace);
    }
  }

  /// Log a message at level [Level.warning].
  void warn(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    bool sentry = true,
    String sentryHint = '',
  }) {
    if (sentry) {
      unawaited(
        Sentry.captureException(
          error ?? Exception('WARNING: $message'),
          stackTrace: stackTrace ?? StackTrace.current, // from catch (e, s)
          hint: sentryHint.isNotEmpty ? sentryHint : 'WARNING - $message',
        ),
      );
    }

    if (kReleaseMode) {
      return;
    }

    logger.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void error(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
    bool sentry = true,
    String sentryHint = '',
  }) {
    if (sentry) {
      unawaited(
        Sentry.captureException(
          error,
          stackTrace: stackTrace ?? StackTrace.current, // from catch (e, s)
          hint: sentryHint.isNotEmpty ? sentryHint : 'ERROR - $message',
        ),
      );
    }

    if (kReleaseMode) {
      return;
    }

    logger.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (kReleaseMode) {
      return;
    }

    logger.wtf(message, error, stackTrace);
  }
}
