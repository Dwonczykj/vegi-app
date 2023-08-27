// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escMostSimilarESCProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EscMostSimilarESCProduct _$$_EscMostSimilarESCProductFromJson(
        Map<String, dynamic> json) =>
    _$_EscMostSimilarESCProduct(
      id: json['id'] as int?,
      name: json['name'] as String,
      productBarCode: json['productBarCode'] as String,
      category: json['category'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      description: json['description'] as String? ?? '',
      imageURL: json['imageURL'] as String? ?? '',
      ingredients: json['ingredients'] as String?,
      keyWords: (json['keyWords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      origin: json['origin'] as String?,
      packagingType: json['packagingType'] as String?,
      product_external_id_on_source:
          json['product_external_id_on_source'] as String? ?? '',
      source: json['source'] as int,
      stockUnitsPerProduct: json['stockUnitsPerProduct'] as num? ?? 1,
      sizeInnerUnitValue: json['sizeInnerUnitValue'] as num? ?? 1,
      sizeInnerUnitType: json['sizeInnerUnitType'] as String? ?? '',
      supplier: json['supplier'] as String? ?? '',
      brandName: json['brandName'] as String? ?? '',
      taxGroup: json['taxGroup'] as String? ?? '',
    );

Map<String, dynamic> _$$_EscMostSimilarESCProductToJson(
        _$_EscMostSimilarESCProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productBarCode': instance.productBarCode,
      'category': instance.category,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'description': instance.description,
      'imageURL': instance.imageURL,
      'ingredients': instance.ingredients,
      'keyWords': instance.keyWords,
      'origin': instance.origin,
      'packagingType': instance.packagingType,
      'product_external_id_on_source': instance.product_external_id_on_source,
      'source': instance.source,
      'stockUnitsPerProduct': instance.stockUnitsPerProduct,
      'sizeInnerUnitValue': instance.sizeInnerUnitValue,
      'sizeInnerUnitType': instance.sizeInnerUnitType,
      'supplier': instance.supplier,
      'brandName': instance.brandName,
      'taxGroup': instance.taxGroup,
    };
