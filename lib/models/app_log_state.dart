import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/log_event.dart';

part 'app_log_state.freezed.dart';
part 'app_log_state.g.dart';

List<AppLogState> fromJsonAppLogStateList(dynamic json) =>
    fromSailsListOfObjectJson<AppLogState>(AppLogState.fromJson)(json);
AppLogState? fromJsonAppLogState(dynamic json) =>
    fromSailsObjectJson<AppLogState>(AppLogState.fromJson)(json);

@Freezed()
class AppLogState with _$AppLogState {
  @JsonSerializable()
  factory AppLogState({
    required List<LogEvent> logs,
  }) = _AppLogState;

  const AppLogState._();

  factory AppLogState.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$AppLogStateFromJson(json),
      );

  factory AppLogState.initial() => AppLogState(
        logs: [],
      );
}

class AppLogStateConverter
    implements JsonConverter<AppLogState, Map<String, dynamic>?> {
  const AppLogStateConverter();

  @override
  AppLogState fromJson(Map<String, dynamic>? json) => tryCatchRethrowInline(
        () => json != null ? AppLogState.fromJson(json) : AppLogState.initial(),
      );

  @override
  Map<String, dynamic> toJson(AppLogState instance) => instance.toJson();
}
