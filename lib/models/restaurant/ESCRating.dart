import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/cart/product.dart';
import 'package:vegan_liverpool/models/restaurant/ESCExplanation.dart';

part 'ESCRating.freezed.dart';
part 'ESCRating.g.dart';

List<ESCRating> fromJsonESCRatingList(dynamic json) =>
    fromSailsListOfObjectJson<ESCRating>(ESCRating.fromJson)(json);
ESCRating? fromJsonESCRating(dynamic json) =>
    fromSailsObjectJson<ESCRating>(ESCRating.fromJson)(json);

@Freezed()
class ESCRating with _$ESCRating {
  @JsonSerializable()
  factory ESCRating({
    required int id,
    @JsonKey(
      fromJson: jsonToTimeStampNullable,
      toJson: timeStampToJsonStringNullable,
      name: 'calculated_on',
    )
    required DateTime? calculatedOn,
    // required double createdAt,
    // required Product product,
    required int product,
    // required String productPublicId,
    required String product_id,
    required String product_name,
    required num rating,
    // @Default({}) Object evidence,
    // @Default([]) List<ESCExplanation> explanations,
  }) = _ESCRating;

  const ESCRating._();

  factory ESCRating.fromJson(Map<String, dynamic> json) =>
      _$ESCRatingFromJson(json);
}
