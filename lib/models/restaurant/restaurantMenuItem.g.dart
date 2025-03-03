// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurantMenuItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RestaurantMenuItem _$$_RestaurantMenuItemFromJson(
        Map<String, dynamic> json) =>
    _$_RestaurantMenuItem(
      menuItemID: json['menuItemID'] as String,
      restaurantID: json['restaurantID'] as String,
      name: json['name'] as String,
      imageURL: json['imageURL'] as String,
      categoryName: json['categoryName'] as String,
      categoryId: json['categoryId'] as int,
      price: gbpxPriceFromJson(json['price']),
      description: json['description'] as String,
      extras: Map<String, int>.from(json['extras'] as Map),
      listOfProductOptionCategories: (json['listOfProductOptionCategories']
              as List<dynamic>)
          .map(
              (e) => ProductOptionsCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      isAvailable: json['isAvailable'] as bool,
      priority: json['priority'] as int,
      isFeatured: json['isFeatured'] as bool,
      status: $enumDecode(_$ProductDiscontinuedStatusEnumMap, json['status']),
      productBarCode: json['productBarCode'] as String,
      ingredients: json['ingredients'] as String?,
      vendorInternalId: json['vendorInternalId'] as String? ?? '',
      stockCount: json['stockCount'] as int? ?? 0,
      stockUnitsPerProduct: json['stockUnitsPerProduct'] as num? ?? 1,
      sizeInnerUnitValue: json['sizeInnerUnitValue'] as num? ?? 1,
      sizeInnerUnitType: json['sizeInnerUnitType'] as String? ?? '',
      supplier: json['supplier'] as String? ?? '',
      brandName: json['brandName'] as String? ?? '',
      taxGroup: json['taxGroup'] as String? ?? '',
      rating: json['rating'] == null
          ? null
          : ESCRating.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RestaurantMenuItemToJson(
        _$_RestaurantMenuItem instance) =>
    <String, dynamic>{
      'menuItemID': instance.menuItemID,
      'restaurantID': instance.restaurantID,
      'name': instance.name,
      'imageURL': instance.imageURL,
      'categoryName': instance.categoryName,
      'categoryId': instance.categoryId,
      'price': gbpxPriceToJson(instance.price),
      'description': instance.description,
      'extras': instance.extras,
      'listOfProductOptionCategories': instance.listOfProductOptionCategories
          .map((e) => e.toJson())
          .toList(),
      'isAvailable': instance.isAvailable,
      'priority': instance.priority,
      'isFeatured': instance.isFeatured,
      'status': _$ProductDiscontinuedStatusEnumMap[instance.status]!,
      'productBarCode': instance.productBarCode,
      'ingredients': instance.ingredients,
      'vendorInternalId': instance.vendorInternalId,
      'stockCount': instance.stockCount,
      'stockUnitsPerProduct': instance.stockUnitsPerProduct,
      'sizeInnerUnitValue': instance.sizeInnerUnitValue,
      'sizeInnerUnitType': instance.sizeInnerUnitType,
      'supplier': instance.supplier,
      'brandName': instance.brandName,
      'taxGroup': instance.taxGroup,
      'rating': instance.rating?.toJson(),
    };

const _$ProductDiscontinuedStatusEnumMap = {
  ProductDiscontinuedStatus.active: 'active',
  ProductDiscontinuedStatus.inactive: 'inactive',
};
