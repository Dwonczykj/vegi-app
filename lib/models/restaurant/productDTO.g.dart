// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductDTO _$$_ProductDTOFromJson(Map<String, dynamic> json) =>
    _$_ProductDTO(
      id: json['id'] as int,
      name: json['name'] as String,
      basePrice: json['basePrice'] as int,
      isAvailable: json['isAvailable'] as bool,
      priority: json['priority'] as int,
      isFeatured: json['isFeatured'] as bool,
      status: $enumDecode(_$ProductDiscontinuedStatusEnumMap, json['status']),
      productBarCode: json['productBarCode'] as String,
      vendor: fromJsonVendorDTO(json['vendor']),
      category: fromJsonProductCategory(json['category']),
      description: json['description'] as String? ?? '',
      shortDescription: json['shortDescription'] as String? ?? '',
      imageURL: json['imageURL'] as String? ?? '',
      ingredients: json['ingredients'] as String?,
      vendorInternalId: json['vendorInternalId'] as String? ?? '',
      stockCount: json['stockCount'] as int? ?? 0,
      stockUnitsPerProduct: json['stockUnitsPerProduct'] as num? ?? 1,
      sizeInnerUnitValue: json['sizeInnerUnitValue'] as num? ?? 1,
      sizeInnerUnitType: json['sizeInnerUnitType'] as String? ?? '',
      supplier: json['supplier'] as String? ?? '',
      brandName: json['brandName'] as String? ?? '',
      taxGroup: json['taxGroup'] as String? ?? '',
      options: json['options'] == null
          ? const []
          : fromJsonProductOptionList(json['options']),
      rating: json['rating'] == null ? null : fromJsonESCRating(json['rating']),
    );

Map<String, dynamic> _$$_ProductDTOToJson(_$_ProductDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'basePrice': instance.basePrice,
      'isAvailable': instance.isAvailable,
      'priority': instance.priority,
      'isFeatured': instance.isFeatured,
      'status': _$ProductDiscontinuedStatusEnumMap[instance.status]!,
      'productBarCode': instance.productBarCode,
      'vendor': instance.vendor?.toJson(),
      'category': instance.category?.toJson(),
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'imageURL': instance.imageURL,
      'ingredients': instance.ingredients,
      'vendorInternalId': instance.vendorInternalId,
      'stockCount': instance.stockCount,
      'stockUnitsPerProduct': instance.stockUnitsPerProduct,
      'sizeInnerUnitValue': instance.sizeInnerUnitValue,
      'sizeInnerUnitType': instance.sizeInnerUnitType,
      'supplier': instance.supplier,
      'brandName': instance.brandName,
      'taxGroup': instance.taxGroup,
      'options': instance.options.map((e) => e.toJson()).toList(),
      'rating': instance.rating?.toJson(),
    };

const _$ProductDiscontinuedStatusEnumMap = {
  ProductDiscontinuedStatus.active: 'active',
  ProductDiscontinuedStatus.inactive: 'inactive',
};
