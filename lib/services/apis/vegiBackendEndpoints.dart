import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/services/apis/places.dart';

class VegiBackendEndpoints {
  static const loginWithPhone = 'api/v1/admin/login-with-firebase';
  static const loginWithEmail = 'api/v1/admin/login-with-password';
  static const logout = 'api/v1/admin/logout';
  static const resetPassword = 'api/v1/admin/reset-password';
  static const isLoggedIn = 'api/v1/admin/logged-in';
  static const deregisterUser = 'api/v1/admin/deregister-user';
  static const deleteVegiAccountEntry = 'api/v1/admin/delete-account-entry';
  static String featuredRestaurants(String outCode) =>
      'api/v1/vendors?outcode=$outCode';
  static String fetchSingleRestaurant(int restaurantID) =>
      'api/v1/vendors/$restaurantID';
  static String fetchNearestRestaurants(
    Coordinates geoLocation,
    String distanceFromQueryParam,
    String fulfilmentMethodType,
  ) =>
      'api/v1/home/nearest-vendors?location=${geoLocation.lat},${geoLocation.lng}&fulfilmentMethodType=$fulfilmentMethodType$distanceFromQueryParam';
  static const createFusePaymentIntent = 'api/v1/payments/create-fuse-payment-intent';
  static const updateTransaction = 'api/v1/payments/update-transaction';
  static const updateOrderStatus = 'api/v1/orders/update-order-status';
}

class VegiESCServiceEndpoints {
  static const vegiUsers = 'vegi-users';
  static String rateVegiProduct({required int productId}) =>
      'rate-vegi-product/$productId';
  static String rateProductName({required String name}) =>
      'rate-vegi-product?name=$name';
  // TODO: Implement on Server
  static String getESCSource({required int sourceId}) => 'sources/$sourceId';
  // TODO: Implement on Server
  static String getESCExplanationsForRating({required int escRatingId}) =>
      'explanations?ratingId=$escRatingId';
}
