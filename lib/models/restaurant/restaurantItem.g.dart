// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurantItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RestaurantItem _$$_RestaurantItemFromJson(Map<String, dynamic> json) =>
    _$_RestaurantItem(
      restaurantID: json['restaurantID'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      description: json['description'] as String,
      deliveryRestrictionDetails:
          (json['deliveryRestrictionDetails'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      imageURL: json['imageURL'] as String,
      category: json['category'] as String,
      costLevel: json['costLevel'] as int,
      rating: json['rating'] as int,
      address:
          DeliveryAddresses.fromJson(json['address'] as Map<String, dynamic>),
      listOfMenuItems: (json['listOfMenuItems'] as List<dynamic>)
          .map((e) => RestaurantMenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      productCategories: (json['productCategories'] as List<dynamic>)
          .map((e) => ProductCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletAddress: json['walletAddress'] as String,
      status: json['status'] as String,
      isVegan: json['isVegan'] as bool,
      minimumOrderAmount: json['minimumOrderAmount'] as int,
      platformFee: json['platformFee'] as int,
      deliveryPartner: json['deliveryPartner'] == null
          ? null
          : DeliveryPartnerDTO.fromJson(
              json['deliveryPartner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RestaurantItemToJson(_$_RestaurantItem instance) =>
    <String, dynamic>{
      'restaurantID': instance.restaurantID,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'description': instance.description,
      'deliveryRestrictionDetails': instance.deliveryRestrictionDetails,
      'imageURL': instance.imageURL,
      'category': instance.category,
      'costLevel': instance.costLevel,
      'rating': instance.rating,
      'address': instance.address.toJson(),
      'listOfMenuItems':
          instance.listOfMenuItems.map((e) => e.toJson()).toList(),
      'productCategories':
          instance.productCategories.map((e) => e.toJson()).toList(),
      'walletAddress': instance.walletAddress,
      'status': instance.status,
      'isVegan': instance.isVegan,
      'minimumOrderAmount': instance.minimumOrderAmount,
      'platformFee': instance.platformFee,
      'deliveryPartner': instance.deliveryPartner?.toJson(),
    };
