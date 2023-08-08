import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class LoggerDi {
  @lazySingleton
  Logger get logger => Logger(
      // ~ https://pub.dev/documentation/logger/latest/index.html
        printer: PrettyPrinter(
          noBoxingByDefault: true,
          excludeBox: {
            Level.info: true,
          },
          methodCount: 0, // Number of method calls to be displayed
          errorMethodCount:
              12, // Number of method calls if stacktrace is provided
          lineLength: 80, // Width of the output
          colors: false, // Colorful log messages
          printTime: true, // Should each log print contain a timestamp
        ),
        // filter: DevelopmentFilter,
        // output: ConsoleOutput
      );
}
