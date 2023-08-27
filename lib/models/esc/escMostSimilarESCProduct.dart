import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';

part 'escMostSimilarESCProduct.freezed.dart';
part 'escMostSimilarESCProduct.g.dart';

List<EscMostSimilarESCProduct> fromJsonEscMostSimilarESCProductList(dynamic json) =>
  fromSailsListOfObjectJson<EscMostSimilarESCProduct>(EscMostSimilarESCProduct.fromJson)(json);
EscMostSimilarESCProduct? fromJsonEscMostSimilarESCProduct(dynamic json) =>
  fromSailsObjectJson<EscMostSimilarESCProduct>(EscMostSimilarESCProduct.fromJson)(json);

@Freezed()
class EscMostSimilarESCProduct with _$EscMostSimilarESCProduct {
  @JsonSerializable()
  factory EscMostSimilarESCProduct({
    int? id,
    required String name,
    required String productBarCode,
    @Default('') String category,
    DateTime? dateOfBirth,
    @Default('') String description,
    @Default('') String imageURL,
    String? ingredients,
    @Default([]) List<String> keyWords,
    String? origin,
    String? packagingType,
    @Default('') String product_external_id_on_source,
    required int source,
    @Default(1) num stockUnitsPerProduct,
    @Default(1) num sizeInnerUnitValue,
    @Default('') String sizeInnerUnitType,
    @Default('') String supplier,
    @Default('') String brandName,
    @Default('') String taxGroup,
  }) = _EscMostSimilarESCProduct;

  const EscMostSimilarESCProduct._();

  factory EscMostSimilarESCProduct.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$EscMostSimilarESCProductFromJson(json),
      );
}
