import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/payments/stripe_payment_intent.dart';
import 'package:vegan_liverpool/models/payments/stripe_payment_intent_check.dart';
import 'package:vegan_liverpool/models/payments/stripe_payment_intent_internal.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

@lazySingleton
class StripePayService {
  // StripePayService(this.dio) {
  //   dio.options.baseUrl = Secrets.VEGI_EATS_BACKEND;
  //   dio.options.headers = Map.from({'Content-Type': 'application/json'});
  // }
  // final Dio dio;
  StripePayService();
  Dio get dio => peeplEatsService.dio;

  Future<StripePaymentIntentCheck?> startPaymentIntentCheck({
    required String paymentIntentID,
    required String paymentIntentClientSecret,
    bool isTester = false,
  }) async {
    try {
      final Response<dynamic> response = await peeplEatsService.dioGet(
        '/api/v1/payments/check-stripe-payment-intent/$paymentIntentID',
        sendWithAuthCreds: true,
        dontRoute: true,
        queryParameters: {
          // 'client_secret': paymentIntentClientSecret,
          'isTester': isTester,
        },
      );

      final store = await reduxStore;
      log.info(
        'startPaymentIntentCheck called for ${isTester ? 'tester' : 'live'} user "${store.state.userState.email}" ',
        stackTrace: StackTrace.current,
      );

      final Map<String, dynamic> result = response.data as Map<String, dynamic>;

      log.verbose(
        'Payment Intent check Result',
        stackTrace: StackTrace.current,
        additionalDetails: result,
      );

      if (result.isNotEmpty && result.containsKeyAndNotNull('paymentIntent')) {
        result['paymentIntent']['client_secret'] = paymentIntentClientSecret;
      }
      if (result.isNotEmpty && result.containsKeyAndNotNull('id')) {
        result['paymentIntent']['id'] = paymentIntentID;
      }

      final paymentIntent = tryCatchRethrowInline(
        () => StripePaymentIntentCheck.fromJson(result),
      );

      return paymentIntent;
    } catch (e, s) {
      log.info(
        'Error: startPaymentIntentCheck $e',
        stackTrace: s,
      );
      return null;
    }
  }

  Future<StripePaymentIntent?> createStripePaymentIntent({
    required num amount,
    required String recipientWalletAddress,
    required String senderWalletAddress,
    required num orderId,
    required num accountId,
    String? stripeCustomerId,
    String currency = 'gbp',
    bool isTester = false,
  }) async {
    try {
      final Response<dynamic> response = await peeplEatsService.dioPost(
        '/api/v1/payments/create-stripe-payment-intent',
        data: {
          'amount': amount,
          'currency': currency,
          'customerId': stripeCustomerId ?? '',
          'vendorDisplayName': Labels.stripeVegiProductName,
          // 'walletAddress': walletAddress,
          'recipientWalletAddress': recipientWalletAddress,
          'senderWalletAddress': senderWalletAddress,
          'orderId': orderId,
          'accountId': accountId,
          'isTester': isTester,
        },
        sendWithAuthCreds: true,
        dontRoute: true,
      );

      final store = await reduxStore;
      log.info(
        'createStripePaymentIntent called for ${isTester ? 'tester' : 'live'} user "${store.state.userState.email}" ',
        stackTrace: StackTrace.current,
      );

      return StripePaymentIntent.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e, s) {
      log.info(
        'Error createStripePaymentIntent $e',
        stackTrace: s,
      );
      return null;
    }
  }

  Future<void> makePayment({
    required int paymentType,
    required int amount,
    required String currency,
    bool isTester = false,
  }) async {
    throw UnimplementedError();
  }
}
