import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/restaurant/ESCRating.dart';

part 'ESCExplanation.freezed.dart';
part 'ESCExplanation.g.dart';

List<ESCExplanation> fromJsonESCExplanationList(dynamic json) =>
    fromSailsListOfObjectJson<ESCExplanation>(ESCExplanation.fromJson)(json);
ESCExplanation? fromJsonESCExplanation(dynamic json) =>
    fromSailsObjectJson<ESCExplanation>(ESCExplanation.fromJson)(json);

@Freezed()
class ESCExplanation with _$ESCExplanation {
  @JsonSerializable()
  factory ESCExplanation({
    required String evidence,
    required int id,
    required num measure,
    // required ESCRating escrating,
    required num rating,
    required int source,
    required String title,
    // required String description,
    required List<String> reasons,
    @Default('') String imageUrl,
  }) = _ESCExplanation;

  const ESCExplanation._();

  factory ESCExplanation.fromJson(Map<String, dynamic> json) =>
      _$ESCExplanationFromJson(json);
}
