import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';

part 'log_event.freezed.dart';
part 'log_event.g.dart';

List<LogEvent> fromJsonLogEventList(dynamic json) =>
  fromSailsListOfObjectJson<LogEvent>(LogEvent.fromJson)(json);
LogEvent? fromJsonLogEvent(dynamic json) =>
  fromSailsObjectJson<LogEvent>(LogEvent.fromJson)(json);

@Freezed()
class LogEvent with _$LogEvent {
  @JsonSerializable()
  factory LogEvent({
    required String message,
    required Map<String,dynamic> information,
    required DateTime timestamp,
  }) = _LogEvent;

  const LogEvent._();

  factory LogEvent.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$LogEventFromJson(json),
      );
}
