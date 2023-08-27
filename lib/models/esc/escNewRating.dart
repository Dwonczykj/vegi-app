import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/restaurant/ESCExplanation.dart';
import 'package:vegan_liverpool/models/restaurant/ESCRating.dart';

part 'escNewRating.freezed.dart';
part 'escNewRating.g.dart';

List<EscNewRating> fromJsonEscNewRatingList(dynamic json) =>
  fromSailsListOfObjectJson<EscNewRating>(EscNewRating.fromJson)(json);
EscNewRating? fromJsonEscNewRating(dynamic json) =>
  fromSailsObjectJson<EscNewRating>(EscNewRating.fromJson)(json);

@Freezed()
class EscNewRating with _$EscNewRating {
  @JsonSerializable()
  factory EscNewRating({
    @JsonKey(fromJson: fromJsonESCExplanationList)
    @Default([]) List<ESCExplanation> explanations,
    @JsonKey(fromJson: fromJsonESCRating) ESCRating? rating,
  }) = _EscNewRating;

  const EscNewRating._();

  factory EscNewRating.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$EscNewRatingFromJson(json),
      );
}
