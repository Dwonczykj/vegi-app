import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/cart/orderProductOptionValue.dart';
import 'package:vegan_liverpool/models/payments/money.dart';

part 'product.freezed.dart';
part 'product.g.dart';

List<Product> fromJsonProductList(dynamic json) =>
    fromSailsListOfObjectJson<Product>(Product.fromJson)(json);
Product fromJsonProduct(dynamic json) =>
    fromSailsObjectJson<Product>(Product.fromJson)(json) ?? Product.empty();

@Freezed()
class Product with _$Product {
  @JsonSerializable()
  factory Product({
    int? id,
    required String name,
    required int basePrice,
    // required List<OrderProductOptionValue> options,
    @JsonKey(fromJson: fromJsonOrderProductOptionValueList)
    @Default([])
    List<OrderProductOptionValue> options,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  const Product._();

  static Product empty() {
    return Product(
      name: 'n/a',
      basePrice: 0,
    );
  }

  //Section Getters
  Money get price => Money(currency: Currency.GBPx, value: basePrice);
  String get priceGBP => price.inGBP.formattedGBPPrice;

  Money get totalPrice => Money(
        currency: Currency.GBPx,
        value: basePrice + options.map((o) => o.priceModifier).sum(),
      );

  String get totalPriceFormatted => totalPrice.inGBP.formattedGBPPrice;
  // String get totalPriceFormatted {
  //   int optionTotal = 0;
  //   for (final product in options) {
  //     optionTotal = optionTotal + product.priceModifier;
  //   }
  //   return cFPrice(basePrice + optionTotal);
  // }
}
