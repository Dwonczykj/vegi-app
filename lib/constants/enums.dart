// ignore_for_file: lines_longer_than_80_chars, constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

enum ImageSourceType { gallery, camera }

enum BiometricAuth {
  faceID,
  touchID,
  pincode,
  none,
}

enum OnboardStrategy {
  firebase,
  sms,
  none,
}

enum FulfilmentMethodType {
  collection,
  delivery,
  inStore,
  none,
}

enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

enum OrderAcceptanceStatus {
  accepted,
  declined,
  partiallyFulfilled,
  cancelledByUser,
  pending,
  outForDelivery,
  delivered,
  collected,
}

enum OrderCreationStatus {
  confirmed,
  failed,
}

enum OrderCompletedFlag {
  none,
  completed,
  cancelled,
  refunded,
  partiallyRefunded,
  voided,
}

enum RestaurantAcceptanceStatus {
  accepted,
  rejected,
  pending,
  partiallyFulfilled,
  cancelledByUser,
}

enum DeliveryOrderCreationStatus {
  confirmed,
  failed,
}

enum ProductDiscontinuedStatus {
  active,
  inactive,
}

enum Currency {
  GBP,
  USD,
  EUR,
  GBPx,
  PPL,
  GBT,
  FUSE,
  percent,
}

enum CurrencyFiatOnly {
  GBP,
  USD,
  EUR,
}

extension CurrencyAmountFormatter on Currency {
  String formatAmountWithSymbol(num amount) {
    switch (this) {
      case Currency.GBP:
        return '£$amount';
      case Currency.USD:
        return '\$$amount';
      case Currency.EUR:
        return '€$amount';
      case Currency.GBPx:
      case Currency.PPL:
      case Currency.GBT:
      case Currency.FUSE:
        return '$amount $name';
      case Currency.percent:
        return '${(amount * 100.0).toStringAsPrecision(2)}%';
    }
  }

  bool isCrypto() => [
        Currency.GBPx,
        Currency.FUSE,
        Currency.PPL,
        Currency.GBT,
      ].contains(this);
}

extension CurrencyFiatOnlyAmountFormatter on CurrencyFiatOnly {
  String formatAmountWithSymbol(num amount) {
    switch (this) {
      case CurrencyFiatOnly.GBP:
        return '£$amount';
      case CurrencyFiatOnly.USD:
        return '\$$amount';
      case CurrencyFiatOnly.EUR:
        return '€$amount';
    }
  }
}

enum DiscountType {
  percentage,
  fixed,
}

enum DiscountCodeAcceptanceStatus {
  accepted,
  rejected,
  already_accepted,
}

enum VegiAccountType {
  ethereum,
  bank,
  fuse,
  fuse_spark,
}

enum VegiRole {
  admin,
  vendor,
  deliveryPartner,
  consumer,
  service,
}

enum VendorType {
  restaurant,
  shop,
}

enum VendorStatus {
  active,
  inactive,
  draft,
}

enum SignUpErrCode {
  invalidCredentials,
  invalidVerificationId,
  wrongPassword,
  userNotFound,
  weakPassword,
  emailAlreadyInUse,
  sessionExpired,
  failedToFetchFuseWallet,
  signonMethodNotImplemented,
  invalidEmail,
  userDisabled,
  emailLinkExpired,
  unauthorizedDomain,
  serverError,
  fuseWalletSDKFailedAuthentication,
  fuseWalletSDKFailedAuthenticationAsMissingUserDetailsToAuthFuseWallet,
  fuseWalletSDKFailedCreateLocalAccountPrivateKey,
  fuseWalletSDKFailedCreate,
  fuseWalletSDKFailedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt,
  fuseWalletSDKFailedFetch,
}

extension SignUpErrCodeHelpers on SignUpErrCode {
  static SignUpErrCode? fromFuseErrCode(
    FuseAuthenticationStatus fuseAuthenticationStatus,
  ) {
    switch (fuseAuthenticationStatus) {
      case FuseAuthenticationStatus.failedAuthentication:
        return SignUpErrCode.fuseWalletSDKFailedAuthentication;
      case FuseAuthenticationStatus
            .failedAuthenticationAsMissingUserDetailsToAuthFuseWallet:
        return SignUpErrCode
            .fuseWalletSDKFailedAuthenticationAsMissingUserDetailsToAuthFuseWallet;
      case FuseAuthenticationStatus.failedCreateLocalAccountPrivateKey:
        return SignUpErrCode.fuseWalletSDKFailedCreateLocalAccountPrivateKey;
      case FuseAuthenticationStatus.failedCreate:
        return SignUpErrCode.fuseWalletSDKFailedCreate;
      case FuseAuthenticationStatus
            .failedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt:
        return SignUpErrCode
            .fuseWalletSDKFailedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt;
      case FuseAuthenticationStatus.failedFetch:
        return SignUpErrCode.fuseWalletSDKFailedFetch;
      case FuseAuthenticationStatus.loading:
        return null;
      case FuseAuthenticationStatus.unauthenticated:
        return null;
      case FuseAuthenticationStatus.authenticated:
        return null;
      case FuseAuthenticationStatus.createWalletForEOA:
        return null;
      case FuseAuthenticationStatus.creationStarted:
        return null;
      case FuseAuthenticationStatus.creationSucceeded:
        return null;
      case FuseAuthenticationStatus.created:
        return null;
      case FuseAuthenticationStatus.fetched:
        return null;
      case FuseAuthenticationStatus.creationTransactionHash:
        return null;
    }
  }
}

enum CartErrCode {
  failedToRegisterEmailToWaitingList,
  invalidDiscountCode,
  failedToRegisterDiscountCode,
  failedToCheckPositionInWaitingList,
  failedToRegisterEmailForNotifications,
}

extension OrderCompletedFlagHelpers on OrderCompletedFlag {
  static OrderCompletedFlag enumValueFromString(String other) {
    switch (other) {
      case 'cancelled':
        return OrderCompletedFlag.cancelled;
      case 'none':
        return OrderCompletedFlag.none;
      case 'completed':
        return OrderCompletedFlag.completed;
      case 'partiallyRefunded':
        return OrderCompletedFlag.partiallyRefunded;
      case 'refunded':
        return OrderCompletedFlag.refunded;
      case 'voided':
        return OrderCompletedFlag.voided;
      case '':
        return OrderCompletedFlag.none;
      default:
        return OrderCompletedFlag.none;
    }
  }
}

extension RestaurantAcceptedStatusHelpers on RestaurantAcceptanceStatus {
  OrderAcceptanceStatus toOrderAcceptanceStatus() {
    switch (this) {
      case RestaurantAcceptanceStatus.accepted:
        return OrderAcceptanceStatus.accepted;

      case RestaurantAcceptanceStatus.partiallyFulfilled:
        return OrderAcceptanceStatus.partiallyFulfilled;
      case RestaurantAcceptanceStatus.cancelledByUser:
        return OrderAcceptanceStatus.cancelledByUser;

      case RestaurantAcceptanceStatus.rejected:
        return OrderAcceptanceStatus.declined;

      case RestaurantAcceptanceStatus.pending:
        return OrderAcceptanceStatus.pending;
    }
  }

  static RestaurantAcceptanceStatus enumValueFromString(String other) {
    switch (other) {
      case 'accepted':
        return RestaurantAcceptanceStatus.accepted;

      case 'partially fulfilled':
        return RestaurantAcceptanceStatus.partiallyFulfilled;

      case 'cancelled by user':
        return RestaurantAcceptanceStatus.cancelledByUser;

      case 'rejected':
        return RestaurantAcceptanceStatus.rejected;

      case 'pending':
        return RestaurantAcceptanceStatus.pending;

      default:
        return RestaurantAcceptanceStatus.pending;
    }
  }
}

extension DeliveryOrderCreationStatusHelpers on DeliveryOrderCreationStatus {
  static DeliveryOrderCreationStatus enumValueFromString(String other) {
    switch (other) {
      case 'confirmed':
        return DeliveryOrderCreationStatus.confirmed;

      case 'failed':
        return DeliveryOrderCreationStatus.failed;

      default:
        return DeliveryOrderCreationStatus.failed;
    }
  }

  String get imageTitle {
    switch (this) {
      case DeliveryOrderCreationStatus.confirmed:
        return ImagePaths.orderConfirmedCollection;

      case DeliveryOrderCreationStatus.failed:
        return ImagePaths.orderAcceptedDelivery;
    }
  }
}

enum CollectionOrderCreationStatus {
  confirmed,
  failed,
}

extension CollectionOrderCreationStatusHelpers
    on CollectionOrderCreationStatus {
  static CollectionOrderCreationStatus enumValueFromString(String other) {
    switch (other) {
      case 'confirmed':
        return CollectionOrderCreationStatus.confirmed;

      case 'failed':
        return CollectionOrderCreationStatus.failed;

      default:
        return CollectionOrderCreationStatus.failed;
    }
  }

  String get imageTitle {
    switch (this) {
      case CollectionOrderCreationStatus.confirmed:
        return ImagePaths.orderConfirmedCollection;

      case CollectionOrderCreationStatus.failed:
        return ImagePaths.orderAcceptedCollection;
    }
  }
}

extension OrderAcceptanceStatusHelpers on OrderAcceptanceStatus {
  static OrderAcceptanceStatus enumValueFromString(String other) {
    switch (other) {
      case 'accepted':
        return OrderAcceptanceStatus.accepted;

      case 'outForDelivery':
        return OrderAcceptanceStatus.outForDelivery;

      case 'partially fulfilled':
        return OrderAcceptanceStatus.partiallyFulfilled;

      case 'cancelled by user':
        return OrderAcceptanceStatus.cancelledByUser;

      case 'delivered':
        return OrderAcceptanceStatus.delivered;

      case 'declined':
        return OrderAcceptanceStatus.declined;

      case 'collected':
        return OrderAcceptanceStatus.collected;

      default:
        return OrderAcceptanceStatus.declined;
    }
  }

  String get displayTitle {
    switch (this) {
      case OrderAcceptanceStatus.pending:
        return 'is awaiting confirmation';

      case OrderAcceptanceStatus.accepted:
        return 'is being prepared';

      case OrderAcceptanceStatus.declined:
        return 'has been declined, sorry!';

      case OrderAcceptanceStatus.outForDelivery:
        return 'is out for delivery!';

      case OrderAcceptanceStatus.partiallyFulfilled:
        return 'has been partially fulfilled, please review!';

      case OrderAcceptanceStatus.cancelledByUser:
        return 'has been cancelled!';

      case OrderAcceptanceStatus.delivered:
        return 'has been delivered!';

      case OrderAcceptanceStatus.collected:
        return 'has been collected!';
    }
  }

  String get imageTitle {
    switch (this) {
      case OrderAcceptanceStatus.pending:
        return 'videos/order-pending.gif';

      case OrderAcceptanceStatus.accepted:
        return 'videos/order-accepted.gif';

      case OrderAcceptanceStatus.declined:
        return 'videos/order-declined.gif';

      case OrderAcceptanceStatus.outForDelivery:
        return 'videos/order-out-for-delivery.gif';

      case OrderAcceptanceStatus.partiallyFulfilled:
        return 'videos/order-pending.gif';

      case OrderAcceptanceStatus.cancelledByUser:
        return 'videos/order-declined.gif';

      case OrderAcceptanceStatus.delivered:
        return 'videos/order-delivered.gif';

      case OrderAcceptanceStatus.collected:
        return 'videos/order-delivered.gif';
    }
  }

  String descriptionText(String orderID) {
    switch (this) {
      case OrderAcceptanceStatus.pending:
        return 'Your order #$orderID has been sent and is awaiting confirmation. We will notify you when the order status changes.\nIf you need help please contact support via the FAQ page.';

      case OrderAcceptanceStatus.accepted:
        return 'Your order #$orderID has been confirmed and is being prepared!\nIf you need help please contact support via the FAQ page.';

      case OrderAcceptanceStatus.declined:
        return 'Unfortunately your order #$orderID has been declined by the merchant.  Please try again or for help contact support via the FAQ page.';

      case OrderAcceptanceStatus.outForDelivery:
        return 'Your order #$orderID is out for delivery!';

      case OrderAcceptanceStatus.partiallyFulfilled:
        return 'Your order #$orderID has been partially fulfilled! Please review in the orders section or for help contact support via the FAQ page.!';

      case OrderAcceptanceStatus.cancelledByUser:
        return 'Your order #$orderID has been cancelled!';

      case OrderAcceptanceStatus.delivered:
        return 'Your order #$orderID has been delivered!';

      case OrderAcceptanceStatus.collected:
        return 'Your order #$orderID has been collected!';
    }
  }
}

extension RestaurantAcceptanceStatusHelpers on RestaurantAcceptanceStatus {
  static RestaurantAcceptanceStatus enumValueFromString(String other) {
    switch (other) {
      case 'accepted':
        return RestaurantAcceptanceStatus.accepted;

      case 'partially fulfilled':
        return RestaurantAcceptanceStatus.partiallyFulfilled;
      case 'cancelled by user':
        return RestaurantAcceptanceStatus.cancelledByUser;

      case 'declined':
      case 'rejected':
        return RestaurantAcceptanceStatus.rejected;

      default:
        return RestaurantAcceptanceStatus.rejected;
    }
  }

  String get displayTitle {
    switch (this) {
      case RestaurantAcceptanceStatus.pending:
        return 'is awaiting confirmation';

      case RestaurantAcceptanceStatus.accepted:
        return 'is being prepared';

      case RestaurantAcceptanceStatus.rejected:
        return 'has been declined, sorry!';

      case RestaurantAcceptanceStatus.partiallyFulfilled:
        return 'has been partially fulfilled, please review!';
      case RestaurantAcceptanceStatus.cancelledByUser:
        return 'has been partially cancelled!';
    }
  }

  String get imageTitle {
    switch (this) {
      case RestaurantAcceptanceStatus.pending:
        return 'videos/order-pending.gif';

      case RestaurantAcceptanceStatus.accepted:
        return 'videos/order-accepted.gif';

      case RestaurantAcceptanceStatus.rejected:
        return 'videos/order-declined.gif';

      case RestaurantAcceptanceStatus.partiallyFulfilled:
        return 'videos/order-pending.gif';

      case RestaurantAcceptanceStatus.cancelledByUser:
        return 'videos/order-declined.gif';
    }
  }

  String descriptionText(String orderID) {
    switch (this) {
      case RestaurantAcceptanceStatus.pending:
        return 'Your order #$orderID has been sent and is awaiting confirmation. We will notify you when the order status changes.\nIf you need help please contact support via the FAQ page.';

      case RestaurantAcceptanceStatus.accepted:
        return 'Your order #$orderID has been confirmed and is being prepared!\nIf you need help please contact support via the FAQ page.';

      case RestaurantAcceptanceStatus.rejected:
        return 'Unfortunately your order #$orderID has been declined by the merchant.  Please try again or for help contact support via the FAQ page.';

      case RestaurantAcceptanceStatus.partiallyFulfilled:
        return 'Your order #$orderID has been partially fulfilled! Please review in the orders section or for help contact support via the FAQ page.!';

      case RestaurantAcceptanceStatus.cancelledByUser:
        return 'Your order #$orderID has been cancelled!';
    }
  }
}

enum DeliveryAddressLabel { home, work, hotel, Store }

extension DeliveryAddressLabelHelpers on DeliveryAddressLabel {
  IconData get icon {
    switch (this) {
      case DeliveryAddressLabel.home:
        return FontAwesomeIcons.house;
      case DeliveryAddressLabel.work:
        return FontAwesomeIcons.building;
      case DeliveryAddressLabel.hotel:
        return FontAwesomeIcons.hotel;
      case DeliveryAddressLabel.Store:
        return FontAwesomeIcons.store;
    }
  }

  static DeliveryAddressLabel fromString(String value) {
    switch (value.toLowerCase()) {
      case 'home':
        return DeliveryAddressLabel.home;
      case 'work':
        return DeliveryAddressLabel.work;
      case 'hotel':
        return DeliveryAddressLabel.hotel;
      case 'Store':
        return DeliveryAddressLabel.Store;
      default:
        return DeliveryAddressLabel.home;
    }
  }
}

enum PreferredSignonMethod {
  phone,
  emailAndPassword,
  emailLink,
  google,
  apple,
}

enum OrderPaidStatus {
  paid,
  unpaid,
  failed,
}

enum PaymentStatus {
  succeeded,
  failed,
  confirmed,
}

enum PaymentProcessingStatus {
  started,
  none,
  succeeded,
  failed,
}

enum PaymentType {
  topup,
  cardPayment,
  refund,
}

enum PaymentTechnology {
  applePay,
  googlePay,
  card,
  fuse,
  stripeOnRamp,
}

enum PaymentNetworkType {
  peepl_fuse,
  vegi_fuse,
  stripe,
}

enum FetchOrdersVegiResponseEnum {
  noOrders,
  unauthorised,
  badRequest,
  error,
  success
}

enum SurveyResponseType {
  boolean,
  string,
  multiline,
  number,
}

enum QRCodeScanErrCode {
  productNotFound,
  multipleMatchesFound,
  connectionIssue,
  couldntScan,
  unknown,
}

enum VegiBackendResponseErrCode {
  connectionIssue,
  unknownError,
}

enum FileUploadErrCode {
  imageTooLarge,
  imageEncodingError,
  unknownError,
}

enum ProductSuggestionUploadErrCode {
  productNotFound,
  wrongVendor,
  multipleMatchesFound,
  connectionIssue,
  imageTooLarge,
  imageEncodingError,
  unknownError,
}

enum ProductSuggestionImageType {
  barCode,
  frontOfPackage,
  ingredientInfo,
  nutritionalInfo,
  teachUsMore,
}

enum FirebaseMessagingCategoriesEnum {
  payment_confirmed,
  payment_succeeded,
  payment_failed,
  unknown_message,
}

extension FirebaseMessagingCategoriesEnumHelpers
    on FirebaseMessagingCategoriesEnum {
  static FirebaseMessagingCategoriesEnum fromString(String value) {
    switch (value.toLowerCase()) {
      case 'payment_confirmed':
        return FirebaseMessagingCategoriesEnum.payment_confirmed;
      case 'payment_succeeded':
        return FirebaseMessagingCategoriesEnum.payment_succeeded;
      case 'payment_failed':
        return FirebaseMessagingCategoriesEnum.payment_failed;
      default:
        log.warn('Unknown firebase message send with category: "$value"');
        return FirebaseMessagingCategoriesEnum.unknown_message;
    }
  }
}

enum OrderCreationProcessStatus {
  none,
  needToSelectATimeSlot,
  needToSelectADeliveryAddress,
  vendorNotAcceptingOrders,
  orderIsBelowVendorMinimumOrder,
  sendOrderCallServerError,
  sendOrderCallTimedOut,
  paymentIntentAmountDoesntMatchCartTotal,
  success,
  sendOrderCallClientError,
  orderCancelled,
  orderPaymentFailed,
  orderAlreadyBeingCreated,
  paymentIntentCheckNotFound,
  unableToGetStripeCustomerIdFromCreateOrderRequest,
  orderPaymentAttemptCreated,
  stripeServiceFailedOnServer,
  invalidSlot,
  invalidPostalDistrict,
  invalidDiscountCode,
  badItemsRequest,
  allItemsUnavailable,
  minimumOrderAmount,
  noItemsFound,
  invalidVendor,
  invalidFulfilmentMethod,
  invalidProduct,
  invalidProductOption,
  invalidUserAddress,
  deliveryPartnerUnavailable,
}

enum StripePaymentStatus {
  none,
  paymentFailed,
  topupSucceeded,
  paymentConfirmed,
  mintingStarted,
  mintingSucceeded,
  mintingFailed,
  paymentCancelled,
  paymentAttemptCreated,
  paymentMethodNotSupportedOnDevice,
}

enum StripePaymentMethodType {
  acss_debit,
  affirm,
  afterpay_clearpay,
  alipay,
  au_becs_debit,
  bacs_debit,
  bancontact,
  blik,
  boleto,
  card,
  card_present,
  cashapp,
  customer_balance,
  eps,
  fpx,
  giropay,
  grabpay,
  ideal,
  interac_present,
  klarna,
  konbini,
  link,
  oxxo,
  p24,
  paynow,
  paypal,
  pix,
  promptpay,
  sepa_debit,
  sofort,
  us_bank_account,
  wechat_pay,
  zip,
}

enum StripePaymentMethodCardChecks {
  pass,
  fail,
  unavailable,
  unchecked,
}

enum FirebaseAuthenticationStatus {
  unauthenticated,
  loading,
  reauthenticationFailed,
  authenticated,
  expired,
  phoneAuthReauthenticationFailed,
  phoneAuthFailed,
  phoneAuthTFAFailed,
  phoneAuthNoPhoneNumberSet,
  phoneAuthVerificationCodeTimedOut,
  phoneAuthVerificationFailed,
  phoneAuthCredentialHasNoVerificationId,
  phoneAuthTimedOut,
  phoneAuthFailedTooManyRequests,
  invalidPhoneNumber,
  emailAlreadyInUseWithOtherAccount,
  updateEmailUsingVerificationFailed,
  userGetIdTokenFailed,
  invalidCredentials,
  invalidVerificationId,
  beginAuthentication,
  // firebaseAuthenticationSucceededAndVegiLoginFailed,
  // firebaseAuthenticationSucceededAndVegiLoginSucceeded,
  // authenticatedWithFuse,
}

extension FirebaseAuthenticationStatusHelpers on FirebaseAuthenticationStatus {
  bool isNewFailureStatus(FirebaseAuthenticationStatus oldStatus) {
    return [
          FirebaseAuthenticationStatus.phoneAuthNoPhoneNumberSet,
          FirebaseAuthenticationStatus.phoneAuthReauthenticationFailed,
          FirebaseAuthenticationStatus.phoneAuthFailed,
          FirebaseAuthenticationStatus.phoneAuthTimedOut,
          FirebaseAuthenticationStatus.phoneAuthFailedTooManyRequests,
          FirebaseAuthenticationStatus.invalidPhoneNumber,
          FirebaseAuthenticationStatus.invalidCredentials,
          FirebaseAuthenticationStatus.invalidVerificationId,
          // FirebaseAuthenticationStatus.emailAlreadyInUseWithOtherAccount, // * removed as still want to see main screen in this case,
          FirebaseAuthenticationStatus.updateEmailUsingVerificationFailed,
          FirebaseAuthenticationStatus.userGetIdTokenFailed,
          FirebaseAuthenticationStatus.reauthenticationFailed,
          FirebaseAuthenticationStatus.phoneAuthTFAFailed,
          FirebaseAuthenticationStatus.expired,
          FirebaseAuthenticationStatus.phoneAuthVerificationCodeTimedOut,
          FirebaseAuthenticationStatus.phoneAuthVerificationFailed,
          FirebaseAuthenticationStatus.phoneAuthCredentialHasNoVerificationId,
          // FirebaseAuthenticationStatus.unauthenticated,
        ].contains(this) &&
        oldStatus != this;
  }
}

enum VegiAuthenticationStatus {
  unauthenticated,
  loading,
  authenticated,
  failed,
}

extension VegiAuthenticationStatusHelpers on VegiAuthenticationStatus {
  bool isNewFailureStatus(VegiAuthenticationStatus oldStatus) {
    return [
          VegiAuthenticationStatus.failed,
          // VegiAuthenticationStatus.unauthenticated,
        ].contains(this) &&
        oldStatus != this;
  }
}

enum FuseAuthenticationStatus {
  unauthenticated,
  loading,
  authenticated,
  createWalletForEOA,
  creationStarted,
  creationSucceeded,
  created,
  fetched,
  failedCreateLocalAccountPrivateKey,
  failedCreate,
  failedAuthentication,
  failedAuthenticationAsMissingUserDetailsToAuthFuseWallet,
  failedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt,
  failedFetch,
  creationTransactionHash,
}

extension FuseAuthenticationStatusHelpers on FuseAuthenticationStatus {
  bool isNewFailureStatus(FuseAuthenticationStatus oldStatus) {
    return [
          FuseAuthenticationStatus.failedCreateLocalAccountPrivateKey,
          FuseAuthenticationStatus.failedCreate,
          FuseAuthenticationStatus.failedAuthentication,
          FuseAuthenticationStatus
              .failedAuthenticationAsMissingUserDetailsToAuthFuseWallet,
          FuseAuthenticationStatus
              .failedToAuthenticateWalletSDKWithJWTTokenAfterInitialisationAttempt,
          FuseAuthenticationStatus.failedFetch,
          // FuseAuthenticationStatus.unauthenticated,
        ].contains(this) &&
        oldStatus != this;
  }
}
