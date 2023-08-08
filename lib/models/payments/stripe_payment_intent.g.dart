// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_payment_intent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StripePaymentIntent _$$_StripePaymentIntentFromJson(
        Map<String, dynamic> json) =>
    _$_StripePaymentIntent(
      ephemeralKey: json['ephemeralKey'] as String,
      publishableKey: json['publishableKey'] as String,
      paymentIntent: StripePaymentIntentInternal.fromJson(
          json['paymentIntent'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : StripeCustomer.fromJson(json['customer'] as Map<String, dynamic>),
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
              ?.map((e) => StripePaymentMethodInternal.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_StripePaymentIntentToJson(
        _$_StripePaymentIntent instance) =>
    <String, dynamic>{
      'ephemeralKey': instance.ephemeralKey,
      'publishableKey': instance.publishableKey,
      'paymentIntent': instance.paymentIntent.toJson(),
      'customer': instance.customer?.toJson(),
      'paymentMethods': instance.paymentMethods.map((e) => e.toJson()).toList(),
    };
