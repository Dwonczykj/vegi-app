import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/esc/escNewRating.dart';
import 'package:vegan_liverpool/models/restaurant/ESCExplanation.dart';

part 'esc_state.freezed.dart';
part 'esc_state.g.dart';

List<EscState> fromJsonEscStateList(dynamic json) =>
    fromSailsListOfObjectJson<EscState>(EscState.fromJson)(json);
EscState? fromJsonEscState(dynamic json) =>
    fromSailsObjectJson<EscState>(EscState.fromJson)(json);

@Freezed()
class EscState with _$EscState {
  @JsonSerializable()
  factory EscState({
    required Map<int, EscNewRating> ratings,
  }) = _EscState;

  const EscState._();

  factory EscState.fromJson(Map<String, dynamic> json) => tryCatchRethrowInline(
        () => _$EscStateFromJson(json),
      );

  factory EscState.initial() => EscState(
        ratings: {},
      );
}

class EscStateConverter
    implements JsonConverter<EscState, Map<String, dynamic>?> {
  const EscStateConverter();

  @override
  EscState fromJson(Map<String, dynamic>? json) => tryCatchRethrowInline(
        () => json != null ? EscState.fromJson(json) : EscState.initial(),
      );

  @override
  Map<String, dynamic> toJson(EscState instance) => instance.toJson();
}
