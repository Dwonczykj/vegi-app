import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vegan_liverpool/common/di/env.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/pay/dialogs/stripe_payment_confirmed_dialog.dart';
import 'package:vegan_liverpool/features/topup/dialogs/card_failed.dart';
import 'package:vegan_liverpool/features/topup/dialogs/minting_dialog.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/payments/live_payment.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/models/payments/stripe_payment_intent.dart';
import 'package:vegan_liverpool/models/payments/stripe_payment_intent_internal.dart';

import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/home_page_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/analytics.dart';
import 'package:vegan_liverpool/utils/config.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class StripeCustomResponse {
  StripeCustomResponse({
    required this.ok,
    this.msg = '',
  });
  final bool ok;
  final String? msg;
}

@lazySingleton
class StripeService extends IStripeService with _StripeServiceMixin {
  @override
  final Stripe instance = Stripe.instance;

  @override
  bool useTest =
      (Env.isDev || Env.isTest || Env.isQA) && STRIPE_LIVEMODE != 'true';

  @override
  void init() {
    Stripe.publishableKey =
        useTest ? Secrets.STRIPE_API_KEY_TEST : Secrets.STRIPE_API_KEY_LIVE;
    // if (Stripe.publishableKey.contains('live')) {
    //   final e = Exception('Stripe Instance not ready for production usage.');
    //   Sentry.captureException(
    //     e,
    //     stackTrace: StackTrace.current,
    //
    //   );
    //   throw e;
    // }
    Stripe.merchantIdentifier =
        useTest ? 'testmerchant.com.vegi' : 'merchant.com.vegi';
  }

  void setTestMode({required bool isTester}) {
    if (isTester ||
        ((Env.isDev || Env.isTest || Env.isQA) && STRIPE_LIVEMODE != 'true')) {
      useTest = true;
      Stripe.publishableKey = Secrets.STRIPE_API_KEY_TEST;
    } else {
      useTest = false;
      Stripe.publishableKey = Secrets.STRIPE_API_KEY_LIVE;
    }
  }
}

@lazySingleton
// class StripeTESTService with _StripeServiceMixin implements IStripeService {
class StripeTESTService extends IStripeService with _StripeServiceMixin {
  @override
  final Stripe instance = Stripe.instance;

  @override
  final bool useTest = true;

  @override
  void init() {
    Stripe.publishableKey = Secrets.STRIPE_API_KEY_TEST;
    Stripe.merchantIdentifier = 'testmerchant.com.vegi';
  }
}

abstract class IStripeService {
  abstract final Stripe instance;
  abstract final bool useTest;
  void init();

  Future<bool> handleStripeTopupForMintingCryptoByCard({
    required String recipientWalletAddress,
    required String senderWalletAddress,
    required int orderId,
    required int accountId,
    required String stripeCustomerId,
    required Money amount,
    required bool shouldPushToHome,
    required Store<AppState> store,
  });

  Future<bool> handleStripeCardPayment({
    required String recipientWalletAddress,
    required String senderWalletAddress,
    required int orderId,
    required int accountId,
    required String paymentIntentClientSecret,
    required String stripeCustomerId,
    required Money amount,
    required bool shouldPushToHome,
    required Store<AppState> store,
  });

  Future<bool> handleApplePay({
    required String productName,
    required String recipientWalletAddress,
    required String senderWalletAddress,
    required num orderId,
    required num accountId,
    required String? stripeCustomerId,
    required String paymentIntentClientSecret,
    required Money amount,
    required Store<AppState> store,
    required bool shouldPushToHome,
  });

  Future<bool> handleGooglePay({
    required String productName,
    required String recipientWalletAddress,
    required String senderWalletAddress,
    required num orderId,
    required num accountId,
    required String? stripeCustomerId,
    required String paymentIntentClientSecret,
    required Money amount,
    required Store<AppState> store,
    required bool shouldPushToHome,
  });
}

mixin _StripeServiceMixin on IStripeService {
  Future<bool> _handleStripeCardPaymentFlow({
    required Store<AppState> store,
    required StripePaymentIntentInternal paymentIntentClientSecret,
    required String ephemeralKey,
    required String publishableKey,
    required String stripeCustomerId,
    required String senderWalletAddress,
    required int orderId,
    required int accountId,
  }) async {
    log.verbose(
      '_handleStripeCardPaymentFlow called on $this using ${useTest ? 'test' : 'live'} keys',
      stackTrace: StackTrace.current,
    );
    // ~ https://docs.page/flutter-stripe/flutter_stripe/sheet#5-test-the-integration
    final dynamicUrl = '$VEGI_DYNAMIC_APP_URL${rootRouter.currentUrl}';

    final billingDetails = BillingDetails(
      name: store.state.cartState.order?.deliveryName,
      email: store.state.cartState.order?.deliveryEmail,
      phone: store.state.cartState.order?.deliveryPhoneNumber,
      address: Address(
        city: store.state.cartState.order?.deliveryAddressCity,
        country: store.state.cartState.order
            ?.deliveryAddressCountry, // ~ https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes
        line1: store.state.cartState.order?.deliveryAddressLineOne,
        line2: store.state.cartState.order?.deliveryAddressLineTwo,
        state: store.state.cartState.order?.deliveryAddressCity,
        postalCode: store.state.cartState.order?.deliveryAddressPostCode,
      ),
    );
    const customFlowBreaking = false;
    try {
      await instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          paymentIntentClientSecret: paymentIntentClientSecret.clientSecret,
          merchantDisplayName: Labels.stripeVegiProductName,
          // Customer keys
          customerEphemeralKeySecret: ephemeralKey,
          customerId: stripeCustomerId,
          // Extra options
          // primaryButtonLabel: 'Pay now',
          // applePay: PaymentSheetApplePay(
          //   merchantCountryCode: 'DE',
          // ),
          // googlePay: PaymentSheetGooglePay(
          //   merchantCountryCode: 'DE',
          //   testEnv: true,
          // ),
          // billingDetails, delayedPaymentMethods etc...
          returnURL: dynamicUrl,
          // billingDetails: BillingDetails(
          //   email: store.state.cartState.selectedDeliveryAddress?.email ??
          //       store.state.userState.email,
          //   phone: store.state.cartState.selectedDeliveryAddress?.phoneNumber ??
          //       store.state.userState.phoneNumber,
          //   name: store.state.cartState.selectedDeliveryAddress?.name ??
          //       store.state.userState.displayName,
          // ),
          style: ThemeMode.dark,
          allowsDelayedPaymentMethods: true,
          // appearance: PaymentSheetAppearance(
          //   colors: PaymentSheetAppearanceColors(
          //     background: Colors.lightBlue,
          //     primary: Colors.blue,
          //     componentBorder: Colors.red,
          //   ),
          //   shapes: PaymentSheetShape(
          //     borderWidth: 4,
          //     shadow: PaymentSheetShadowParams(color: Colors.red),
          //   ),
          //   primaryButton: PaymentSheetPrimaryButtonAppearance(
          //     shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
          //     colors: PaymentSheetPrimaryButtonTheme(
          //       light: PaymentSheetPrimaryButtonThemeColors(
          //         background: Color.fromARGB(255, 231, 235, 30),
          //         text: Color.fromARGB(255, 235, 92, 30),
          //         border: Color.fromARGB(255, 235, 92, 30),
          //       ),
          //     ),
          //   ),
          // ),
          billingDetails: billingDetails,
        ),
      );
      await instance.presentPaymentSheet(
        options: const PaymentSheetPresentOptions(
            // timeout: AppConfig.stripeCardPaymentFlowTimeOutMillis,
            ),
      );
    } on StripeException catch (e, s) {
      if (e.error.code != FailureCode.Canceled) {
        unawaited(
          Analytics.track(
            eventName: AnalyticsEvents.mint,
            properties: {
              'status': 'failure',
            },
          ),
        );
        log.error(
          'Stripe Payment ${e.error.code} with StripeErrorType.[${e.error.type}] because of stripe error code StripeErrorCode.[${e.error.stripeErrorCode}]: ${e.error.localizedMessage};',
          stackTrace: s,
        );
        store
          ..dispatch(SetPaymentButtonFlag(false))
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentFailed,
            ),
          )
          ..dispatch(
            cancelOrder(
              orderId: orderId,
              senderWalletAddress: senderWalletAddress,
            ),
          )
          ..dispatch(
            OrderCreationProcessStatusUpdate(
              status: OrderCreationProcessStatus.orderPaymentFailed,
              orderCreationStatusMessage: 'Order payment failed',
            ),
          );
        return false;
      } else {
        // payment cancelled handle
        store
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus
                  .paymentCancelled, // TODO: Hande this update and refactor apple pay stripe method to use this code too
            ),
          )
          ..dispatch(
            cancelOrder(
              orderId: orderId,
              senderWalletAddress: senderWalletAddress,
            ),
          )
          ..dispatch(
            OrderCreationProcessStatusUpdate(
              status: OrderCreationProcessStatus.orderCancelled,
              orderCreationStatusMessage: 'Order cancelled',
            ),
          )
          ..dispatch(SetPaymentButtonFlag(false));
        return false;
      }
    } on Exception catch (e, s) {
      store.dispatch(stopPaymentProcess());
      log.error(
        e,
        stackTrace: s,
      );
      return false;
    }

    // 4. Confirm the payment sheet.
    try {
      // * Check paymentIntentObject for existing payment methods
      bool preregisteredPaymentMethodUsedForThisIntent = false;
      if (store.state.cartState.paymentIntent != null &&
          store.state.cartState.paymentIntent!.paymentIntent.paymentMethodTypes
              .isNotEmpty &&
          customFlowBreaking) {
        preregisteredPaymentMethodUsedForThisIntent = store.state.cartState
            .paymentIntent!.paymentIntent.paymentMethodTypes.isNotEmpty;
      }
      // final newCardDetailsWereUsed = !preregisteredPaymentMethodUsedForThisIntent;
      if (preregisteredPaymentMethodUsedForThisIntent) {
        // pre-registered cards need confirmation, new card details are confirmed when input to stripe payment sheet.
        await instance.confirmPaymentSheetPayment().timeout(
              const Duration(
                seconds: 60 * 5 + 10,
              ),
            );
      }
    } on TimeoutException {
      store
        ..dispatch(SetTransferringPayment(flag: false))
        ..dispatch(
          StripePaymentStatusUpdate(
            status: StripePaymentStatus
                .paymentCancelled, // TODO: Hande this update and refactor apple pay stripe method to use this code too
          ),
        )
        ..dispatch(
          cancelOrder(
            orderId: orderId,
            senderWalletAddress: senderWalletAddress,
          ),
        )
        ..dispatch(
          OrderCreationProcessStatusUpdate(
            status: OrderCreationProcessStatus.orderCancelled,
            orderCreationStatusMessage: 'Order cancelled',
          ),
        )
        ..dispatch(SetPaymentButtonFlag(false));
      return false;
    } on StripeException catch (e, s) {
      if (e.error.code != FailureCode.Canceled) {
        unawaited(
          Analytics.track(
            eventName: AnalyticsEvents.mint,
            properties: {
              'status': 'failure',
            },
          ),
        );
        log.error(
          'Stripe Payment ${e.error.code} with StripeErrorType.[${e.error.type}] because of stripe error code StripeErrorCode.[${e.error.stripeErrorCode}]: ${e.error.localizedMessage};',
          stackTrace: s,
        );

        store
          ..dispatch(SetPaymentButtonFlag(false))
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentFailed,
            ),
          )
          ..dispatch(
            cancelOrder(
              orderId: orderId,
              senderWalletAddress: senderWalletAddress,
            ),
          )
          ..dispatch(
            OrderCreationProcessStatusUpdate(
              status: OrderCreationProcessStatus.orderPaymentFailed,
              orderCreationStatusMessage: 'Order payment failed',
            ),
          );
        return false;
      } else {
        // payment cancelled handle
        store
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus
                  .paymentCancelled, // TODO: Hande this update and refactor apple pay stripe method to use this code too
            ),
          )
          ..dispatch(
            cancelOrder(
              orderId: orderId,
              senderWalletAddress: senderWalletAddress,
            ),
          )
          ..dispatch(
            OrderCreationProcessStatusUpdate(
              status: OrderCreationProcessStatus.orderCancelled,
              orderCreationStatusMessage: 'Order cancelled',
            ),
          )
          ..dispatch(SetPaymentButtonFlag(false));
        return false;
      }
    } on Exception catch (e, s) {
      // TODO
      log.error(
        'stripe._handleStripeCardPayentFlow failed with Exception: $e',
        stackTrace: s,
      );
      return false;
    }
    store.dispatch(
      OrderPaymentAttemptCreated(
        orderId: orderId,
      ),
    );
    return true;
  }

  @override
  Future<bool> handleStripeTopupForMintingCryptoByCard({
    required String recipientWalletAddress,
    required String senderWalletAddress,
    required int orderId,
    required int accountId,
    required String stripeCustomerId,
    required Money amount,
    required bool shouldPushToHome,
    required Store<AppState> store,
  }) async {
    log.verbose(
      'handleStripeTopupForMintingCryptoByCard called on $this using ${useTest ? 'test' : 'live'} keys',
      stackTrace: StackTrace.current,
    );
    try {
      final currency = amount.currency;
      final paymentIntentClientSecret =
          await stripePayService.createStripePaymentIntent(
        //TODO: if walletAddress, then user stripePayService.createStripePaymentIntentForTopupFromBank or something
        amount: amount.value,
        currency: amount.currency.name.toLowerCase(),
        recipientWalletAddress: recipientWalletAddress,
        senderWalletAddress: senderWalletAddress,
        orderId: orderId,
        accountId: accountId,
        stripeCustomerId: stripeCustomerId,
        isTester: useTest,
      );
      if (paymentIntentClientSecret == null) {
        log.error(
          'Unable to create payment intent from $stripePayService',
          stackTrace: StackTrace.current,
        );
        store.dispatch(
          StripePaymentStatusUpdate(
            status: StripePaymentStatus.paymentFailed,
          ),
        );
        return false;
      } else if (currency != Currency.GBP && currency != Currency.GBPx) {
        log.error('Unable to use stripe for currency: $currency',
            stackTrace: StackTrace.current);
        store.dispatch(
          StripePaymentStatusUpdate(
            status: StripePaymentStatus.paymentFailed,
          ),
        );
        return false;
      }
      final stripePaymentFlowSucceeded = await _handleStripeCardPaymentFlow(
        store: store,
        paymentIntentClientSecret: paymentIntentClientSecret.paymentIntent,
        ephemeralKey: paymentIntentClientSecret.ephemeralKey,
        publishableKey: paymentIntentClientSecret.publishableKey,
        stripeCustomerId: stripeCustomerId,
        accountId: accountId,
        orderId: orderId,
        senderWalletAddress: senderWalletAddress,
      );
      if (!stripePaymentFlowSucceeded) {
        return false;
      }
      store
        ..dispatch(
          SetProcessingPayment(
            payment: LivePayment(
              amount: amount.value,
              currency: currency,
              status: PaymentProcessingStatus.started,
              technology: PaymentTechnology.stripeOnRamp,
              type: PaymentType.topup,
            ),
          ),
        )
        ..dispatch(
          StripePaymentStatusUpdate(
            status: StripePaymentStatus.mintingStarted,
          ),
        );
      return true;
    } on Exception catch (e, s) {
      log.error(
        e,
        stackTrace: s,
      );
      await Sentry.captureException(
        e,
        stackTrace: s,
      );
      store.dispatch(
        StripePaymentStatusUpdate(
          status: StripePaymentStatus.paymentFailed,
        ),
      );
      return false;
    }
  }

  @override
  Future<bool> handleStripeCardPayment({
    required String recipientWalletAddress,
    required String senderWalletAddress,
    required int orderId,
    required int accountId,
    required String paymentIntentClientSecret,
    required String stripeCustomerId,
    required Money amount,
    required bool shouldPushToHome,
    required Store<AppState> store,
  }) async {
    log.verbose(
      'handleStripeCardPayment called on $this using ${useTest ? 'test' : 'live'} keys',
      stackTrace: StackTrace.current,
    );
    try {
      store.dispatch(
        StripePaymentStatusUpdate(
          status: StripePaymentStatus.none,
        ),
      );
      final currency = amount.currency;
      // ! we remove the createStripePaymentIntent here unless we are mintingCrypto which doesnt go via the vegi backend and therefore doesnt create its own paymentIntent and so needs to be created here
      // ~ https://stripe.com/docs/payments/payment-intents#creating-a-paymentintent
      final paymentIntent = await stripePayService.startPaymentIntentCheck(
        paymentIntentID: store.state.cartState.paymentIntentID,
        paymentIntentClientSecret: paymentIntentClientSecret,
        isTester: useTest,
      );

      if (paymentIntent == null) {
        log.error(
          'Failed to fetch paymentIntent[${store.state.cartState.paymentIntentID}] from vegi server using paymentIntent client secret that was created on the order',
          stackTrace: StackTrace.current,
        );

        store
          ..dispatch(SetPaymentButtonFlag(false))
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentFailed,
            ),
          )
          ..dispatch(
            cancelOrder(
              orderId: orderId,
              senderWalletAddress: senderWalletAddress,
            ),
          )
          ..dispatch(
            OrderCreationProcessStatusUpdate(
              status: OrderCreationProcessStatus.orderPaymentFailed,
              orderCreationStatusMessage: 'Order payment failed',
            ),
          );
        return false;
      }

      final stripePaymentFlowSucceeded = await _handleStripeCardPaymentFlow(
        store: store,
        paymentIntentClientSecret: paymentIntent.paymentIntent,
        ephemeralKey: store.state.cartState.ephemeralKey,
        publishableKey: store.state.cartState.publishableKey,
        stripeCustomerId: stripeCustomerId,
        accountId: accountId,
        orderId: orderId,
        senderWalletAddress: senderWalletAddress,
      );
      if (!stripePaymentFlowSucceeded) {
        return false;
      }

      store
        ..dispatch(
          SetProcessingPayment(
            payment: LivePayment(
              amount: amount.value,
              currency: currency,
              status: PaymentProcessingStatus.succeeded,
            ),
          ),
        )
        ..dispatch(SetPaymentButtonFlag(false))
        ..dispatch(SetTransferringPayment(flag: false))
        ..dispatch(
          SetIsLoadingHttpRequest(
            isLoading: false,
          ),
        )
        ..dispatch(
          StripePaymentStatusUpdate(
            status: StripePaymentStatus.paymentConfirmed,
          ),
        );
      return true;
    } on StripeException catch (e, s) {
      if (e.error.code != FailureCode.Canceled) {
        unawaited(
          Analytics.track(
            eventName: AnalyticsEvents.mint,
            properties: {
              'status': 'failure',
            },
          ),
        );
        log.error(
          'Stripe Payment ${e.error.code} with StripeErrorType.[${e.error.type}] because of stripe error code StripeErrorCode.[${e.error.stripeErrorCode}]: ${e.error.localizedMessage};',
          stackTrace: s,
        );

        store
          ..dispatch(SetPaymentButtonFlag(false))
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentFailed,
            ),
          )
          ..dispatch(
            cancelOrder(
              orderId: orderId,
              senderWalletAddress: senderWalletAddress,
            ),
          )
          ..dispatch(
            OrderCreationProcessStatusUpdate(
              status: OrderCreationProcessStatus.orderPaymentFailed,
              orderCreationStatusMessage: 'Order payment failed',
            ),
          );
        return false;
      } else {
        // payment cancelled handle
        store
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus
                  .paymentCancelled, // TODO: Hande this update and refactor apple pay stripe method to use this code too
            ),
          )
          ..dispatch(
            cancelOrder(
              orderId: orderId,
              senderWalletAddress: senderWalletAddress,
            ),
          )
          ..dispatch(
            OrderCreationProcessStatusUpdate(
              status: OrderCreationProcessStatus.orderCancelled,
              orderCreationStatusMessage: 'Order cancelled',
            ),
          )
          ..dispatch(SetPaymentButtonFlag(false));
        return false;
      }
    } on Exception catch (e, s) {
      log.error(
        e,
        stackTrace: s,
      );
      await Sentry.captureException(
        e,
        stackTrace: s,
      );
      store.dispatch(
        StripePaymentStatusUpdate(
          status: StripePaymentStatus.paymentFailed,
        ),
      );
      return false;
    }
  }

  @override
  Future<bool> handleApplePay({
    required String productName,
    required String recipientWalletAddress,
    required String senderWalletAddress,
    required num orderId,
    required num accountId,
    required String? stripeCustomerId,
    required String paymentIntentClientSecret,
    required Money amount,
    required Store<AppState> store,
    required bool shouldPushToHome,
  }) async {
    log.verbose(
      'handleApplePay called on $this using ${useTest ? 'test' : 'live'} keys',
      stackTrace: StackTrace.current,
    );
    try {
      store.dispatch(
        StripePaymentStatusUpdate(
          status: StripePaymentStatus.none,
        ),
      );
      final currency = amount.currency;
      // 1. fetch Intent Client Secret from backend
      if (currency.isCrypto()) {
        final paymentIntentClientSecret =
            await stripePayService.createStripePaymentIntent(
          amount: amount.value,
          currency: amount.currency.name.toLowerCase(),
          recipientWalletAddress: recipientWalletAddress,
          senderWalletAddress: senderWalletAddress,
          orderId: orderId,
          accountId: accountId,
          stripeCustomerId: stripeCustomerId,
          isTester: useTest,
        );
        if (paymentIntentClientSecret == null) {
          log.error('Unable to create payment intent from $stripePayService');
          await Sentry.captureException(
            Exception(
              'Unable to create payment intent from $stripePayService',
            ),
            stackTrace: StackTrace.current, // from catch (err, s)
          );
          store.dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentFailed,
            ),
          );
          return false;
        } else if (currency != Currency.GBP && currency != Currency.GBPx) {
          log.error(
            'Unable to use apple pay via stripe for currency: $currency',
          );
          store.dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentFailed,
            ),
          );
          return false;
        }
      } else {
        // only need secret below so nothing to do...
      }

      // final billingDetails = BillingDetails(
      //   name: store.state.cartState.order?.deliveryName,
      //   email: store.state.cartState.order?.deliveryEmail,
      //   phone: store.state.cartState.order?.deliveryPhoneNumber,
      //   address: Address(
      //     city: store.state.cartState.order?.deliveryAddressCity,
      //     country: 'UK',
      //     line1: store.state.cartState.order?.deliveryAddressLineOne,
      //     line2: store.state.cartState.order?.deliveryAddressLineTwo,
      //     state: store.state.cartState.order?.deliveryAddressCity,
      //     postalCode: store.state.cartState.order?.deliveryAddressPostCode,
      //   ),
      // );

      // 2. Confirm apple pay payment
      await Stripe.instance.confirmPlatformPayPaymentIntent(
        clientSecret: paymentIntentClientSecret,
        confirmParams: PlatformPayConfirmParams.applePay(
          applePay: ApplePayParams(
            cartItems: [
              ApplePayCartSummaryItem.immediate(
                label: productName,
                amount: amount.inGBPValue.toStringAsFixed(2),
              )
            ],
            merchantCountryCode:
                amount.inGBP.currency.name.toLowerCase().substring(0, 2),
            currencyCode: amount.inGBP.currency.name.toLowerCase(),
          ),
        ),
      );

      if (currency.isCrypto()) {
        store
          ..dispatch(
            SetProcessingPayment(
              payment: LivePayment(
                amount: amount.value,
                currency: currency,
                status: PaymentProcessingStatus.started,
                technology: PaymentTechnology.stripeOnRamp,
                type: PaymentType.topup,
              ),
            ),
          )
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.mintingStarted,
            ),
          );
      } else {
        store
          ..dispatch(
            OrderPaymentAttemptCreated(
              orderId: orderId.round(),
            ),
          )
          ..dispatch(
            SetProcessingPayment(
              payment: LivePayment(
                amount: amount.value,
                currency: currency,
                status: PaymentProcessingStatus.succeeded,
                technology: PaymentTechnology.applePay,
              ),
            ),
          )
          ..dispatch(SetPaymentButtonFlag(false))
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(
            SetIsLoadingHttpRequest(
              isLoading: false,
            ),
          )
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentConfirmed,
            ),
          );
      }
      return true;
    } on Exception catch (e) {
      store.dispatch(
        StripePaymentStatusUpdate(
          status: StripePaymentStatus.paymentFailed,
        ),
      );
      if (e is StripeException) {
        if (e.error.code != FailureCode.Canceled) {
          unawaited(
            Analytics.track(
              eventName: AnalyticsEvents.mint,
              properties: {
                'status': 'failure',
              },
            ),
          );
          log.error(e.error.localizedMessage);
          return false;
        } else {
          return false;
        }
      } else {
        log.error(e);
        return false;
      }
    }
  }

  @override
  Future<bool> handleGooglePay({
    required String productName,
    required String recipientWalletAddress,
    required String senderWalletAddress,
    required num orderId,
    required num accountId,
    required String? stripeCustomerId,
    required String paymentIntentClientSecret,
    required Money amount,
    required Store<AppState> store,
    required bool shouldPushToHome,
  }) async {
    log.verbose(
      'handleGooglePay called on $this',
      stackTrace: StackTrace.current,
    );
    try {
      store.dispatch(
        StripePaymentStatusUpdate(
          status: StripePaymentStatus.none,
        ),
      );
      final currency = amount.currency;
      if (currency.isCrypto()) {
        final paymentIntentClientSecret =
            await stripePayService.createStripePaymentIntent(
          amount: amount.value,
          currency: amount.currency.name.toLowerCase(),
          recipientWalletAddress: recipientWalletAddress,
          senderWalletAddress: senderWalletAddress,
          orderId: orderId,
          accountId: accountId,
          stripeCustomerId: stripeCustomerId,
          isTester: useTest,
        );
        if (paymentIntentClientSecret == null) {
          log.error('Unable to create payment intent from $stripePayService');
          await Sentry.captureException(
            Exception(
              'Unable to create payment intent from $stripePayService',
            ),
            stackTrace: StackTrace.current, // from catch (err, s)
          );
          store.dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentFailed,
            ),
          );
          return false;
        } else if (currency != Currency.GBP && currency != Currency.GBPx) {
          log.error(
            'Unable to use google pay via stripe for currency: $currency',
          );
          await Sentry.captureException(
            Exception(
              'Unable to use google pay via stripe for currency: $currency',
            ),
            stackTrace: StackTrace.current, // from catch (err, s)
          );
          store.dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentFailed,
            ),
          );
          return false;
        }
      } else {
        // only need secret below so nothing to do...
      }
      // 2. Confirm apple pay payment
      await Stripe.instance.confirmPlatformPayPaymentIntent(
        clientSecret: paymentIntentClientSecret,
        confirmParams: PlatformPayConfirmParams.googlePay(
          googlePay: GooglePayParams(
            testEnv: Env.isDev || Env.isTest,
            merchantCountryCode:
                amount.inGBP.currency.name.toLowerCase().substring(0, 2),
            currencyCode: amount.inGBP.currency.name.toLowerCase(),
          ),
        ),
      );

      final mintingCrypto = currency == Currency.GBPx ||
          currency == Currency.PPL ||
          currency == Currency.GBT;
      if (mintingCrypto) {
        store
          ..dispatch(
            SetProcessingPayment(
              payment: LivePayment(
                amount: amount.value,
                currency: currency,
                status: PaymentProcessingStatus.started,
                technology: PaymentTechnology.stripeOnRamp,
                type: PaymentType.topup,
              ),
            ),
          )
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.mintingStarted,
            ),
          );
      } else {
        store
          ..dispatch(
            OrderPaymentAttemptCreated(
              orderId: orderId.round(),
            ),
          )
          ..dispatch(
            SetProcessingPayment(
              payment: LivePayment(
                amount: amount.value,
                currency: currency,
                status: PaymentProcessingStatus.succeeded,
                technology: PaymentTechnology.googlePay,
              ),
            ),
          )
          ..dispatch(SetPaymentButtonFlag(false))
          ..dispatch(SetTransferringPayment(flag: false))
          ..dispatch(
            SetIsLoadingHttpRequest(
              isLoading: false,
            ),
          )
          ..dispatch(
            StripePaymentStatusUpdate(
              status: StripePaymentStatus.paymentConfirmed,
            ),
          );
      }
      return true;
    } on Exception catch (e, s) {
      store.dispatch(
        StripePaymentStatusUpdate(
          status: StripePaymentStatus.paymentFailed,
        ),
      );
      if (e is StripeException) {
        if (e.error.code != FailureCode.Canceled) {
          unawaited(
            Analytics.track(
              eventName: AnalyticsEvents.mint,
              properties: {
                'status': 'failure',
              },
            ),
          );
          log.error(e.error.localizedMessage);
          await Sentry.captureException(
            e,
            stackTrace: s,
          );
          return false;
        } else {
          return false;
        }
      } else {
        log.error(e);
        await Sentry.captureException(
          e,
          stackTrace: s,
        );
        return false;
      }
    }
  }
}
