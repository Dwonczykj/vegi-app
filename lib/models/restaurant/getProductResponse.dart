import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/restaurant/productCategory.dart';
import 'package:vegan_liverpool/models/restaurant/productDTO.dart';

part 'getProductResponse.freezed.dart';
part 'getProductResponse.g.dart';

List<GetProductResponse> fromJsonGetProductResponseList(dynamic json) =>
  fromSailsListOfObjectJson<GetProductResponse>(GetProductResponse.fromJson)(json);
GetProductResponse? fromJsonGetProductResponse(dynamic json) =>
  fromSailsObjectJson<GetProductResponse>(GetProductResponse.fromJson)(json);

@Freezed()
class GetProductResponse with _$GetProductResponse {
  @JsonSerializable()
  factory GetProductResponse({
    @JsonKey(fromJson: fromJsonProductDTO) required ProductDTO? product,
    @JsonKey(fromJson: fromJsonProductCategory) required ProductCategory? cateogory,
  }) = _GetProductResponse;

  const GetProductResponse._();

  factory GetProductResponse.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$GetProductResponseFromJson(json),
      );
}
