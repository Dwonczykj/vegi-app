// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendorDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VendorDTO _$$_VendorDTOFromJson(Map<String, dynamic> json) => _$_VendorDTO(
      id: json['id'] as int,
      name: json['name'] as String,
      type: $enumDecode(_$VendorTypeEnumMap, json['type']),
      phoneNumber: json['phoneNumber'] as String?,
      costLevel: json['costLevel'] as num?,
      rating: json['rating'] as num?,
      isVegan: json['isVegan'] as bool,
      status: $enumDecode(_$VendorStatusEnumMap, json['status']),
      walletAddress: json['walletAddress'] as String,
      pickupAddress: fromJsonAddressDTO(json['pickupAddress']),
      vendorCategories: fromJsonVendorCategoryList(json['vendorCategories']),
      productCategories: fromJsonProductCategoryList(json['productCategories']),
      minimumOrderAmount: json['minimumOrderAmount'] as num? ?? 0,
      platformFee: json['platformFee'] as num? ?? 0,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      deliveryPartner: fromJsonDeliveryPartnerDTO(json['deliveryPartner']),
      deliveryFulfilmentMethod:
          fromJsonFulfilmentMethodDTO(json['deliveryFulfilmentMethod']),
      collectionFulfilmentMethod:
          fromJsonFulfilmentMethodDTO(json['collectionFulfilmentMethod']),
      products: json['products'] == null
          ? const []
          : fromJsonProductDTOList(json['products']),
      fulfilmentPostalDistricts: json['fulfilmentPostalDistricts'] == null
          ? const []
          : fromJsonPostalDistrictList(json['fulfilmentPostalDistricts']),
    );

Map<String, dynamic> _$$_VendorDTOToJson(_$_VendorDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$VendorTypeEnumMap[instance.type]!,
      'phoneNumber': instance.phoneNumber,
      'costLevel': instance.costLevel,
      'rating': instance.rating,
      'isVegan': instance.isVegan,
      'status': _$VendorStatusEnumMap[instance.status]!,
      'walletAddress': instance.walletAddress,
      'pickupAddress': instance.pickupAddress?.toJson(),
      'vendorCategories':
          instance.vendorCategories.map((e) => e.toJson()).toList(),
      'productCategories':
          instance.productCategories.map((e) => e.toJson()).toList(),
      'minimumOrderAmount': instance.minimumOrderAmount,
      'platformFee': instance.platformFee,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'deliveryPartner': instance.deliveryPartner?.toJson(),
      'deliveryFulfilmentMethod': instance.deliveryFulfilmentMethod?.toJson(),
      'collectionFulfilmentMethod':
          instance.collectionFulfilmentMethod?.toJson(),
      'products': instance.products.map((e) => e.toJson()).toList(),
      'fulfilmentPostalDistricts':
          instance.fulfilmentPostalDistricts.map((e) => e.toJson()).toList(),
    };

const _$VendorTypeEnumMap = {
  VendorType.restaurant: 'restaurant',
  VendorType.shop: 'shop',
};

const _$VendorStatusEnumMap = {
  VendorStatus.active: 'active',
  VendorStatus.inactive: 'inactive',
  VendorStatus.draft: 'draft',
};
