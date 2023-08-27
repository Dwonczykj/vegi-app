import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/esc/escMostSimilarESCProduct.dart';
import 'package:vegan_liverpool/models/esc/escNewRating.dart';
import 'package:vegan_liverpool/models/restaurant/productCategory.dart';
import 'package:vegan_liverpool/models/restaurant/productDTO.dart';

part 'escRateProductResponse.freezed.dart';
part 'escRateProductResponse.g.dart';

List<EscRateProductResponse> fromJsonEscRateProductResponseList(dynamic json) =>
    fromSailsListOfObjectJson<EscRateProductResponse>(
        EscRateProductResponse.fromJson)(json);
EscRateProductResponse? fromJsonEscRateProductResponse(dynamic json) =>
    fromSailsObjectJson<EscRateProductResponse>(
        EscRateProductResponse.fromJson)(json);

@Freezed()
class EscRateProductResponse with _$EscRateProductResponse {
  @JsonSerializable()
  factory EscRateProductResponse({
    @JsonKey(fromJson: fromJsonProductCategory) ProductCategory? category,
    @JsonKey(fromJson: fromJsonEscMostSimilarESCProduct)
    EscMostSimilarESCProduct? most_similar_esc_product,
    @JsonKey(fromJson: fromJsonEscNewRating) EscNewRating? new_rating,
    // @JsonKey(fromJson: fromJsonProductDTO) ProductDTO? product,
  }) = _EscRateProductResponse;

  const EscRateProductResponse._();

  factory EscRateProductResponse.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$EscRateProductResponseFromJson(json),
      );
}
