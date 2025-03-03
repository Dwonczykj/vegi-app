import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/models/payments/stripe_payment_intent.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

@lazySingleton
class StripePayService {
  StripePayService(this.dio) {
    dio.options.baseUrl = Secrets.STRIPE_PAY_URL;
    dio.options.headers = Map.from({'Content-Type': 'application/json'});
  }
  final Dio dio;

  Future<Map<dynamic, dynamic>> startPaymentIntentCheck(
    String paymentIntentID,
  ) async {
    try {
      final Response<dynamic> response =
          await dio.get('api/v1/payment_intents/$paymentIntentID');

      final Map<String, dynamic> result = response.data as Map<String, dynamic>;

      log.info(
        'Payment Intent Result $result',
        stackTrace: StackTrace.current,
      );

      return result;
    } catch (e, s) {
      log.info('Error: startPaymentIntentCheck $e', stackTrace: s,);
      return {};
    }
  }

  Future<String> createStripePaymentIntent({
    required int amount,
    required String currency,
    required String walletAddress,
  }) async {
    try {
      final Response<dynamic> response = await dio.post(
        '/stripe/createPaymentIntent',
        data: {
          'amount': amount,
          'currency': currency,
          'walletAddress': walletAddress,
        },
      );

      return response.data['data']['paymentIntent']['clientSecret'] as String;
    } catch (e, s) {
      log.info('Error createStripePaymentIntent $e', stackTrace: s,);
      return e.toString();
    }
  }

  Future<void> makePayment({
    required int paymentType,
    required int amount,
    required String currency,
  }) async {
    throw UnimplementedError();
  }
}
