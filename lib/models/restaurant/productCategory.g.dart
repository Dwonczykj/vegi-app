// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductCategory _$$_ProductCategoryFromJson(Map<String, dynamic> json) =>
    _$_ProductCategory(
      categoryGroup: json['categoryGroup'] as int?,
      id: json['id'] as int?,
      imageUrl: json['imageUrl'] as String? ?? '',
      name: json['name'] as String,
      vendor: fromJsonVendorDTO(json['vendor']),
    );

Map<String, dynamic> _$$_ProductCategoryToJson(_$_ProductCategory instance) =>
    <String, dynamic>{
      'categoryGroup': instance.categoryGroup,
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'vendor': instance.vendor?.toJson(),
    };
