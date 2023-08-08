// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderItem _$$_OrderItemFromJson(Map<String, dynamic> json) => _$_OrderItem(
      id: json['id'] as int,
      product: fromJsonProduct(json['product']),
      unfulfilled: json['unfulfilled'] as bool?,
    );

Map<String, dynamic> _$$_OrderItemToJson(_$_OrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product.toJson(),
      'unfulfilled': instance.unfulfilled,
    };
