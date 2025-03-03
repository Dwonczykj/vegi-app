import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:phone_number/phone_number.dart';
import 'package:uuid/uuid.dart';
import 'package:vegan_liverpool/common/router/routes.gr.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/admin/surveyQuestion.dart';
import 'package:vegan_liverpool/models/admin/uploadProductSuggestionImageResponse.dart';
import 'package:vegan_liverpool/models/admin/postVegiResponse.dart';
import 'package:vegan_liverpool/models/admin/vegiAccount.dart';
import 'package:vegan_liverpool/models/admin/vegiConfigDTO.dart';
import 'package:vegan_liverpool/models/admin/vegiSession.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/cart/createOrderForDelivery.dart';
import 'package:vegan_liverpool/models/cart/createOrderForFulfilment.dart';
import 'package:vegan_liverpool/models/cart/createOrderResponse.dart';
import 'package:vegan_liverpool/models/cart/discount.dart';
import 'package:vegan_liverpool/models/cart/getOrdersResponse.dart';
import 'package:vegan_liverpool/models/cart/order.dart' as OrderModel;
import 'package:vegan_liverpool/models/cart/orderStatus.dart';
import 'package:vegan_liverpool/models/cart/productSuggestion.dart';
import 'package:vegan_liverpool/models/discounts/acceptVoucherResponse.dart';
import 'package:vegan_liverpool/models/payments/money.dart';
import 'package:vegan_liverpool/models/payments/transaction_item.dart';
import 'package:vegan_liverpool/models/restaurant/cartItem.dart';
import 'package:vegan_liverpool/models/restaurant/deliveryAddresses.dart';
import 'package:vegan_liverpool/models/restaurant/deliveryPartnerDTO.dart';
import 'package:vegan_liverpool/models/restaurant/getProductResponse.dart';
import 'package:vegan_liverpool/models/restaurant/productCategory.dart';
import 'package:vegan_liverpool/models/restaurant/productDTO.dart';
import 'package:vegan_liverpool/models/restaurant/productOptionValue.dart';
import 'package:vegan_liverpool/models/restaurant/productOptionsCategory.dart';
import 'package:vegan_liverpool/models/restaurant/productRating.dart';
import 'package:vegan_liverpool/models/restaurant/restaurantItem.dart';
import 'package:vegan_liverpool/models/restaurant/restaurantMenuItem.dart';
import 'package:vegan_liverpool/models/restaurant/time_slot.dart';
import 'package:vegan_liverpool/models/restaurant/userDTO.dart';
import 'package:vegan_liverpool/models/restaurant/vendorDTO.dart';
import 'package:vegan_liverpool/models/waitingListFunnel/waitingListEntry.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/services/abstract_apis/httpService.dart';
import 'package:vegan_liverpool/services/apis/places.dart';
import 'package:vegan_liverpool/services/apis/vegiBackendEndpoints.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/log/log.dart';
import 'package:redux/redux.dart';

@lazySingleton
class PeeplEatsService extends HttpService {
  PeeplEatsService(Dio dio) : super(dio, Secrets.VEGI_EATS_BACKEND) {
    dio.options.baseUrl = Secrets.VEGI_EATS_BACKEND;
    dio.options.headers = Map.from({'Content-Type': 'application/json'});
    reduxStore.then(
      (store) {
        final cookie = store.state.userState.vegiSessionCookie;
        if (cookie != null && cookie.isNotEmpty) {
          setSessionCookie(cookie);
        }
      },
    );
  }

  bool _authenticating = false;

  bool get authenticating => _authenticating;

  String? _getResponseExitName(Response<dynamic> response) =>
      response.headers.value('X-Exit');

  String? _getResponseExitDescription(Response<dynamic> response) =>
      response.headers.value('X-Exit-Description');

  bool responseHasErrorStatus(
    Response<dynamic> response, [
    List<int> expectErrCodes = const [],
  ]) {
    if (response.statusCode != null && response.statusCode! >= 400) {
      if (expectErrCodes.isNotEmpty &&
          expectErrCodes.contains(response.statusCode)) {
        // dont log but return true;
        log.verbose(
            'Received expected erroneous response: (status: ${response.statusMessage}) from sails vegi backend [${response.requestOptions.uri}]');
        return true;
      }
      final responseExitName = _getResponseExitName(response);
      if (responseExitName != null) {
        log.error(
          'Received a "exits.$responseExitName" exit (status: ${response.statusMessage}) from sails vegi backend [${response.requestOptions.uri}] with message: "${_getResponseExitDescription(response)}"',
        );
      } else if (response.extra.containsKey('message') &&
          response.extra['message'] is String) {
        if (!response.extra['message'].toString().contains('Stale session')) {
          log.warn(
              'Handling erroneous response [${response.requestOptions.uri}] with message: "${response.extra['message']}"');
        }
        return true;
      } else {
        log.error(
          'Received an empty response (status: ${response.statusMessage}) from sails vegi backend [${response.requestOptions.uri}] with message: "${_getResponseExitDescription(response)}"',
        );
      }
      return true;
    }
    return false;
  }

  RestaurantItem _vendorJsonToRestaurantItem(Map<String, dynamic> element) {
    try {
      final List<Map<String, dynamic>> postalCodes = List.from(
        element['fulfilmentPostalDistricts'] as Iterable<dynamic>,
      );

      final List<String> deliversTo = [];

      for (final element in postalCodes) {
        deliversTo.add((element['outcode'] as String? ?? '').toUpperCase());
      }

      final vendor = VendorDTO.fromJson(element);

      return vendor.toRestaurantItem();

      // return RestaurantItem(
      //   restaurantID: element['id'].toString(),
      //   name: element['name'] as String? ?? '',
      //   description: element['description'] as String? ?? '',
      //   phoneNumber: element['phoneNumber'] as String? ?? '',
      //   status: element['status'] as String? ?? 'draft',
      //   deliveryRestrictionDetails: deliversTo,
      //   imageURL: element['imageUrl'] as String? ?? '',
      //   category: 'Category',
      //   costLevel: element['costLevel'] as int? ?? 2,
      //   rating: element['rating'] as int? ?? 2,
      //   address: DeliveryAddresses.fromJson(
      //     element['pickupAddress'] as Map<String, dynamic>,
      //   ),
      //   deliveryPartner: element.containsKey('deliveryPartner')
      //       ? DeliveryPartnerDTO.fromJson(
      //           element['deliveryPartner'] as Map<String, dynamic>,
      //         )
      //       : null,
      //   walletAddress: element['walletAddress'] as String? ?? '',
      //   listOfMenuItems: [],
      //   productCategories: [],
      //   isVegan: element['isVegan'] as bool? ?? false,
      //   minimumOrderAmount: element['minimumOrderAmount'] as int? ?? 0,
      //   platformFee: element['platformFee'] as int? ?? 0,
      // );
    } on Exception catch (e) {
      log.error(e);
      rethrow;
    }
  }

  // User Details

  @override
  bool get hasCookieStored => dio.options.headers.containsKey('Cookie');

  Future<bool> checkVegiSessionIsStillValid({
    void Function()? sessionIsStaleCallback,
  }) async {
    if (!hasCookieStored) {
      final cookie = (await reduxStore).state.userState.vegiSessionCookie;
      if (cookie == null || cookie.isEmpty) {
        sessionIsStaleCallback?.call();
        return false;
      }
      await setSessionCookie(cookie);
    }
    try {
      final Response<dynamic> response = await dioGet(
        VegiBackendEndpoints.isLoggedIn,
        sendWithAuthCreds: true,
      );

      if (responseHasErrorStatus(response)) {
        throw Exception(
          'Bad response returned when trying to checkVegiSessionIsStillValid: $response',
        );
      }

      final validSession = response.data!['authenticated'] as bool;

      log.info(
        'admin/logged-in -> authenticated = $validSession',
        sentry: true,
      );
      if (!validSession) {
        sessionIsStaleCallback?.call();
      }

      return validSession;
    } on DioException catch (dioErr, s) {
      final onRealDevice = await DebugHelpers.deviceIsNotSimulator();
      if ((dioErr.message?.contains('Connection refused') ?? false) &&
          onRealDevice) {
        log.warn(
          'Unable to reverse proxy from physical device back to localhost vegi server.',
        );
      } else {
        log.error(dioErr, stackTrace: s);
      }
      return false;
    } catch (e, s) {
      log.error(e, stackTrace: s);
      return false;
    }
  }

  Future<VegiSession> loginWithPhone({
    required String phoneNoCountry,
    required int? phoneCountryCode,
    required String firebaseSessionToken,
    bool rememberMe = true,
  }) async {
    if (phoneCountryCode == null) {
      log.error(
        'Unable to login to vegi using a null country code with phone: "$phoneNoCountry"',
        stackTrace: StackTrace.current,
      );
    }
    if (hasCookieStored) {
      //todo: Dont login again if have user details already and isCookieExpired is false...
      // if(await isCookieExpired()){

      // }
      await deleteSessionCookie();
    }
    _authenticating = true;
    try {
      final Response<dynamic> response = await dioPost(
        VegiBackendEndpoints.loginWithPhone,
        sendWithAuthCreds: false,
        data: {
          'phoneNoCountry': phoneNoCountry,
          'phoneCountryCode': phoneCountryCode,
          'firebaseSessionToken': firebaseSessionToken,
          'rememberMe': rememberMe
        },
      );

      // Capture session cookie to send with requests from nowon in a VegiSession object that we save to the singleton instance of the peeplEats service?...
      if (responseHasErrorStatus(response)) {
        _authenticating = false;
        throw Exception(
          'Bad response returned when trying to loginWithPhone: $response',
        );
      } else if (response.headers.value('set-cookie') == null) {
        _authenticating = false;
        log.error(
          'No set-cookie returned in response headers when trying to loginWithPhone with:\n\t responseHeaders: ${response.headers} & response: $response',
        );
      }

      final userDetails =
          UserDTO.fromJson(response.data['user'] as Map<String, dynamic>);

      final cookie = response.headers.value('set-cookie');
      if (cookie != null) {
        await setSessionCookie(cookie);
        (await reduxStore)
          ..dispatch(
            SetVegiSessionCookie(
              cookie: cookie,
            ),
          )
          ..dispatch(
            SetVegiUserId(
              id: userDetails.id,
            ),
          )
          ..dispatch(
            SetUserRoleOnVegi(
              userRole: userDetails.role,
              isSuperAdmin: userDetails.isSuperAdmin,
              isTester: userDetails.isTester,
            ),
          );
        if (userDetails.email != null) {
          (await reduxStore).dispatch(
            SetEmail(
              userDetails.email!,
            ),
          );
        }
      }
      _authenticating = false;
      log.info(
        'Successfully logged in to vegi with phone',
        sentry: true,
      );
      return VegiSession(
        sessionCookie: cookie ?? '',
        user: userDetails,
      );
    } on Exception catch (e, s) {
      _authenticating = false;
      log.error(
        e,
        stackTrace: s,
      );
      return VegiSession(
        sessionCookie: '',
      );
    }
  }

  Future<VegiSession> loginWithEmail({
    required String emailAddress,
    required String firebaseSessionToken,
    bool rememberMe = true,
  }) async {
    if (hasCookieStored) {
      //todo: Dont login again if have user details already and isCookieExpired is false...
      // if(await isCookieExpired()){

      // }
      await deleteSessionCookie();
    }
    final Response<dynamic> response = await dioPost(
      VegiBackendEndpoints.loginWithEmail,
      sendWithAuthCreds: false,
      data: {
        'emailAddress': emailAddress,
        'firebaseSessionToken': firebaseSessionToken,
        'rememberMe': rememberMe
      },
    );

    // Capture session cookie to send with requests from nowon in a VegiSession object that we save to the singleton instance of the peeplEats service?...
    if (responseHasErrorStatus(response)) {
      _authenticating = false;
      throw Exception(
        'Bad response returned when trying to loginWithEmail: $response',
      );
    } else if (response.headers.value('set-cookie') == null) {
      _authenticating = false;
      throw Exception(
        'No set-cookie returned in response headers when trying to loginWithPhone: $response',
      );
    }

    final userDetails =
        UserDTO.fromJson(response.data['user'] as Map<String, dynamic>);

    final cookie = response.headers.value('set-cookie');
    if (cookie != null) {
      await setSessionCookie(cookie);
      (await reduxStore)
        ..dispatch(
          SetVegiSessionCookie(
            cookie: cookie,
          ),
        )
        ..dispatch(
          SetVegiUserId(
            id: userDetails.id,
          ),
        )
        ..dispatch(
          SetUserRoleOnVegi(
            userRole: userDetails.role,
            isSuperAdmin: userDetails.isSuperAdmin,
            isTester: userDetails.isTester,
          ),
        );
      if (userDetails.email != null) {
        (await reduxStore).dispatch(
          SetEmail(
            userDetails.email!,
          ),
        );
      }
      if (userDetails.phoneNoCountry.isNotEmpty &&
          userDetails.phoneNoCountry.replaceAll("0", "").isNotEmpty &&
          userDetails.phoneNoCountry != "0000000000" &&
          userDetails.phoneCountryCode != 0 &&
          userDetails.phoneNoCountry.length > 1) {
        final phoneDetails = await getPhoneDetails(
          countryCodeString: '${userDetails.phoneCountryCode}',
          phoneNoCountry: userDetails.phoneNoCountry,
        );
        (await reduxStore).dispatch(
          phoneDetails,
        );
      }
    }
    _authenticating = false;
    log.info(
      'Successfully logged in to vegi with email',
      sentry: true,
    );
    return VegiSession(
      sessionCookie: cookie ?? '',
      user: userDetails,
    );
  }

  Future<void> logOut() async {
    await dioGet<dynamic>(
      VegiBackendEndpoints.logout,
    );
    await logoutSession();
  }

  Future<void> isLoggedIn() async {
    if (onboardingAuthRoutesOrder.contains(rootRouter.current.name)) {
      log.warn(
        'vegi backend service isLoggedIn request as currently in onbaording auth screens for now.',
      );
      return;
    } else if (_authenticating) {
      log.warn(
        'vegi backend service is already authenticating, not calling isLoggedIn for now.',
      );
      return;
    }
    await checkVegiSessionIsStillValid(
      sessionIsStaleCallback: () async {
        final store = await reduxStore;
        store.dispatch(
          SetUserAuthenticationStatus(
            vegiStatus: VegiAuthenticationStatus.unauthenticated,
          ),
        );
        await rootRouter.replaceAll([const SignUpScreen()]);
      },
    );
  }

  Future<VegiConfigDTO?> getVegiConfigDetails() async {
    try {
      final Response<dynamic> response = await dioGet(
        '/api/v1/admin/get-config-details',
        sendWithAuthCreds: true,
      );
      if (responseHasErrorStatus(response)) {
        log.error(response.statusMessage ?? 'Unknown Error');
        return null;
      } else {
        final result =
            VegiConfigDTO.fromJson(response.data as Map<String, dynamic>);
        return result;
      }
    } on Exception catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 404) {
          return null;
        }
      }
      rethrow;
    }
  }

  Future<String?> requestPasswordResetForEmail({
    required String email,
  }) async {
    final response = await dioPost<dynamic>(
      VegiBackendEndpoints.resetPassword,
      data: {
        'emailAddress': email,
      },
    );
    if (response.data == null || response.statusCode != 200) {
      return null;
    }
    return '${response.data}';
  }

  Future<bool> deleteAllUserDetails() async {
    final store = await reduxStore;
    log.info(
      'Delete all user details from vegi backend',
      sentry: true,
    );
    final Response<dynamic> response = await dioPost(
      VegiBackendEndpoints.deregisterUser,
      sendWithAuthCreds: false,
      data: {
        'id': store.state.userState.vegiUserId,
        'email': store.state.userState.email,
        'phone': store.state.userState.phoneNumber,
      },
      allowStatusCodes: [302],
    );

    if ((response.statusCode ?? 0) == 302) {
      log.info(
        'peeplEatsService.deleteAllUserDetails received a redirect response',
        sentry: true,
      );
      return true;
    }
    if (responseHasErrorStatus(response)) {
      log.error(
        'Bad response returned when trying to deregister user and delete all their data: $response',
      );
      return false;
    }
    log.info(
      'Deleted all user details from vegi backend successfully',
      sentry: true,
    );
    return true;
  }

  Future<bool> deleteWalletAddressDetailsFromAccountsList() async {
    final store = await reduxStore;
    log.info(
      'Deleted all wallet credentials from vegi backend successfully',
      sentry: true,
    );
    final Response<dynamic> response = await dioPost(
      VegiBackendEndpoints.deleteVegiAccountEntry,
      sendWithAuthCreds: false,
      data: {
        'walletAddress': store.state.userState.walletAddress,
      },
    );

    if (responseHasErrorStatus(response)) {
      log.error(
        'Bad response returned when trying to deregister user and delete all their data: $response',
      );
      return false;
    }
    log.info(
      'Deleted all wallet credentials from vegi backend successfully',
      sentry: true,
    );
    return true;
  }

  Future<List<RestaurantItem>> featuredRestaurants(
    String outCode, {
    bool dontRoute = false,
  }) async {
    final Response<dynamic> response = await dioGet<dynamic>(
      VegiBackendEndpoints.featuredRestaurants(outCode),
      dontRoute: dontRoute,
    );
    // .timeout(
    //   const Duration(seconds: 5),
    //   onTimeout: () {
    //     return Response(
    //       data: {'vendors': List<RestaurantItem>.empty()},
    //       requestOptions: RequestOptions(),
    //     );
    //   },
    // ).onError((error, stackTrace) {
    //   log.error(error, stackTrace: stackTrace);
    //   if (error is DioException &&
    //       (error.message?.startsWith('SocketException:') ?? false) &&
    //       dio.options.baseUrl.startsWith('http://localhost')) {
    //     log.warn(
    //       'If running from real_device, cant connect to localhost on running machine...',
    //     );
    //   }
    //   return Response(
    //     data: {'vendors': List<RestaurantItem>.empty()},
    //     requestOptions: RequestOptions(),
    //   );
    // });

    final List<Map<String, dynamic>> results =
        List.from(response.data['vendors'] as Iterable<dynamic>);

    final List<RestaurantItem> restaurantsActive = [];

    for (final Map<String, dynamic> element in results) {
      if (element['status'] == 'active') {
        restaurantsActive.add(
          _vendorJsonToRestaurantItem(element),
        );
      }
    }

    return restaurantsActive;
  }

  Future<RestaurantItem?> fetchSingleRestaurant({
    required int restaurantID,
  }) async {
    final Response<dynamic> response = await dioGet<dynamic>(
      VegiBackendEndpoints.fetchSingleRestaurant(restaurantID),
    ).onError((error, stackTrace) {
      log.error(error, stackTrace: stackTrace);
      return Response(
        data: {'vendor': null},
        requestOptions: RequestOptions(),
      );
    });

    final element = response.data['vendor'] as Map<String, dynamic>?;

    if (element != null) {
      return _vendorJsonToRestaurantItem(element);
    } else {
      return null;
    }
  }

  Future<VendorDTO?> _fetchSingleRestaurantAsVendorDTO({
    required int vendorId,
  }) async {
    final Response<dynamic> response = await dioGet<dynamic>(
      VegiBackendEndpoints.fetchSingleRestaurant(vendorId),
    ).onError((error, stackTrace) {
      log.error(
        error,
        stackTrace: stackTrace,
      );
      return Response(
        data: {'vendor': null},
        requestOptions: RequestOptions(),
      );
    });

    final element = response.data['vendor'] as Map<String, dynamic>?;

    if (element != null) {
      return VendorDTO.fromJson(element);
    } else {
      return null;
    }
  }

  Future<List<RestaurantItem>> getRestaurantsByLocation({
    required Coordinates geoLocation,
    required num? distanceFromLocationAllowedInKm,
    required FulfilmentMethodType fulfilmentMethodTypeName,
    bool dontRoute = false,
  }) async {
    final distanceFromQueryParam = distanceFromLocationAllowedInKm == null
        ? ''
        : '&distance=$distanceFromLocationAllowedInKm';
    final fulfilmentMethodType =
        fulfilmentMethodTypeName != FulfilmentMethodType.none
            ? fulfilmentMethodTypeName.name
            : FulfilmentMethodType.collection.name;
    final Response<dynamic> response = await dioGet<dynamic>(
      VegiBackendEndpoints.fetchNearestRestaurants(
        geoLocation,
        distanceFromQueryParam,
        fulfilmentMethodType,
      ),
      dontRoute: dontRoute,
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return Response(
          data: {'vendors': List<RestaurantItem>.empty()},
          requestOptions: RequestOptions(),
        );
      },
    ).onError(
      (error, stackTrace) => Response(
        data: {'vendors': List<RestaurantItem>.empty()},
        requestOptions: RequestOptions(),
      ),
    );

    final List<Map<String, dynamic>> results =
        List.from(response.data['vendors'] as Iterable<dynamic>);

    final List<RestaurantItem> restaurantsActive = [];

    for (final Map<String, dynamic> element in results) {
      if (element['status'] == 'active') {
        final List<Map<String, dynamic>> postalCodes = List.from(
          element['fulfilmentPostalDistricts'] as Iterable<dynamic>,
        );

        final List<String> deliversTo = [];

        for (final element in postalCodes) {
          deliversTo.add((element['outcode'] as String? ?? '').toUpperCase());
        }

        restaurantsActive.add(
          RestaurantItem(
            restaurantID: element['id'].toString(),
            name: element['name'] as String? ?? '',
            description: element['description'] as String? ?? '',
            phoneNumber: element['phoneNumber'] as String? ?? '',
            status: element['status'] as String? ?? 'draft',
            deliveryRestrictionDetails: deliversTo,
            imageURL: element['imageUrl'] as String? ?? '',
            category: 'Category',
            costLevel: element['costLevel'] as int? ?? 2,
            rating: element['rating'] as int? ?? 2,
            // address: DeliveryAddresses.fromVendorJson(element),
            address: DeliveryAddresses.fromJson(
              element['pickupAddress'] as Map<String, dynamic>,
            ),
            deliveryPartner: element.containsKey('deliveryPartner')
                ? DeliveryPartnerDTO.fromJson(
                    element['deliveryPartner'] as Map<String, dynamic>,
                  )
                : null,
            walletAddress: element['walletAddress'] as String? ?? '',
            listOfMenuItems: [],
            productCategories: [],
            isVegan: element['isVegan'] as bool? ?? false,
            minimumOrderAmount: element['minimumOrderAmount'] as int? ?? 0,
            platformFee: element['platformFee'] as int? ?? 0,
          ),
        );
      }
    }

    return restaurantsActive;
  }

  Future<List<RestaurantItem>> getFilteredRestaurants({
    required String outCode,
    required String globalSearchQuery,
  }) async {
    final Response<dynamic> response = await dio
        .get<dynamic>(
      'api/v1/vendors?outcode=$outCode&search=$globalSearchQuery',
    )
        .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return Response(
          data: {'vendors': List<RestaurantItem>.empty()},
          requestOptions: RequestOptions(),
        );
      },
    ).onError(
      (error, stackTrace) => Response(
        data: {'vendors': List<RestaurantItem>.empty()},
        requestOptions: RequestOptions(),
      ),
    );

    final List<Map<String, dynamic>> results =
        List.from(response.data['vendors'] as Iterable<dynamic>);

    final List<RestaurantItem> restaurantsActive = [];

    for (final Map<String, dynamic> element in results) {
      if (element['status'] == 'active') {
        final List<Map<String, dynamic>> postalCodes = List.from(
          element['fulfilmentPostalDistricts'] as Iterable<dynamic>,
        );

        final List<String> deliversTo = [];

        for (final element in postalCodes) {
          deliversTo.add((element['outcode'] as String? ?? '').toUpperCase());
        }

        restaurantsActive.add(
          RestaurantItem(
            restaurantID: element['id'].toString(),
            name: element['name'] as String? ?? '',
            description: element['description'] as String? ?? '',
            phoneNumber: element['phoneNumber'] as String? ?? '',
            status: element['status'] as String? ?? 'draft',
            deliveryRestrictionDetails: deliversTo,
            imageURL: element['imageUrl'] as String? ?? '',
            category: 'Category',
            costLevel: element['costLevel'] as int? ?? 2,
            rating: element['rating'] as int? ?? 2,
            // address: DeliveryAddresses.fromVendorJson(element),
            address: DeliveryAddresses.fromJson(
              element['pickupAddress'] as Map<String, dynamic>,
            ),
            deliveryPartner: element.containsKey('deliveryPartner')
                ? DeliveryPartnerDTO.fromJson(
                    element['deliveryPartner'] as Map<String, dynamic>,
                  )
                : null,
            walletAddress: element['walletAddress'] as String? ?? '',
            listOfMenuItems: [],
            productCategories: [],
            isVegan: element['isVegan'] as bool? ?? false,
            minimumOrderAmount: element['minimumOrderAmount'] as int? ?? 0,
            platformFee: element['platformFee'] as int? ?? 0,
          ),
        );
      }
    }

    return restaurantsActive;
  }

  Future<List<RestaurantMenuItem>> getRestaurantMenuItems(
    String restaurantID, {
    bool dontRoute = false,
  }) async {
    final Response<dynamic> response = await dioGet(
      'api/v1/vendors/$restaurantID',
      dontRoute: dontRoute,
    ); // BUG Taking too long

    final List<Map<String, dynamic>> results =
        List.from(response.data['vendor']['products'] as Iterable<dynamic>);

    final List<RestaurantMenuItem> menuItems = [];

    for (final Map<String, dynamic> element in results) {
      if (element['isAvailable'] as bool) {
        menuItems.add(
          RestaurantMenuItem(
            isFeatured: element['isFeatured'] as bool? ?? false,
            menuItemID: element['id'].toString(),
            restaurantID: restaurantID,
            name: element['name'] as String? ?? '',
            imageURL: element['imageUrl'] as String? ?? '',
            categoryName: element['category']['name'] as String? ?? '',
            categoryId: element['category']['id'] as int? ?? 0,
            price: Money(
              currency: Currency.GBPx,
              value: element['basePrice'] as int? ?? 0,
            ),
            description: element['description'] as String? ?? '',
            extras: {},
            listOfProductOptionCategories: [],
            priority: element['priority'] as int? ?? 0,
            isAvailable: element['isAvailable'] as bool? ?? false,
            vendorInternalId: element['vendorInternalId'] as String? ?? '',
            ingredients: element['ingredients'] as String? ?? '',
            productBarCode: element['productBarCode'] as String? ?? '',
            status: EnumHelpers.enumFromString(
                  ProductDiscontinuedStatus.values,
                  element['status'] as String,
                ) ??
                ProductDiscontinuedStatus.inactive,
            stockCount: element['stockCount'] as int? ?? 0,
            sizeInnerUnitValue: element['sizeInnerUnitValue'] as num? ?? 1,
            sizeInnerUnitType: element['sizeInnerUnitType'] as String? ?? 'g',
            stockUnitsPerProduct: element['stockUnitsPerProduct'] as num? ?? 1,
            brandName: element['brandName'] as String? ?? '',
            supplier: element['supplier'] as String? ?? '',
            taxGroup: element['taxGroup'] as String? ?? '',
          ),
        );
      }
    }

    menuItems.sort((a, b) => a.priority.compareTo(b.priority));

    return menuItems;
  }

  // Future<RestaurantMenuItem?> getRestaurantMenuItemByQrCode({
  //   required String restaurantID,
  //   required String barCode,
  // }) async {
  //   Response<Map<String, dynamic>?> response;
  //   try {
  //     // final Response<Map<String, dynamic>?> response =
  //     response = await dioGet<Map<String, dynamic>>(
  //       'api/v1/products/get-product-by-qrcode',
  //       queryParameters: <String, dynamic>{
  //         'qrCode': barCode,
  //         'vendor': restaurantID
  //       },
  //     );
  //   } catch (e, s) {
  //     log.error(e);
  //     rethrow;
  //   }

  //   final element = response.data;
  //   if (element == null) {
  //     return null;
  //   }
  //   final pos = await getProductOptions(element['id'].toString());
  //   // List<ProductOptionsCategory> selectProductOptionsCategories =
  //   //     <ProductOptionsCategory>[];
  //   // for (final prodOptCat in pos) {
  //   //   for (final pov in prodOptCat.listOfOptions) {
  //   //     if (pov.productBarCode == barCode) {
  //   //       selectProductOptionsCategories = pos
  //   //           .where(
  //   //             (element) => element.name != prodOptCat.name,
  //   //           )
  //   //           .map(
  //   //             (element) => element.copyWith(
  //   //               listOfOptions: [element.listOfOptions[0]],
  //   //             ),
  //   //           )
  //   //           .toList()
  //   //         ..add(prodOptCat.copyWith(listOfOptions: [pov]));
  //   //       // selectProductOptionsCategories.add(
  //   //       //   prodOptCat.copyWith(
  //   //       //     listOfOptions: pos
  //   //       //         .where(
  //   //       //           (element) => element.name != prodOptCat.name,
  //   //       //         )
  //   //       //         .map((element) =>
  //   //       //             element.copyWith(listOfOptions: element.listOfOptions[0]))
  //   //       //         .toList()
  //   //       //       ..add(pov),
  //   //       //   ),
  //   //       // );
  //   //     }
  //   //   }
  //   // }
  //   return RestaurantMenuItem(
  //     isFeatured: element['isFeatured'] as bool? ?? false,
  //     menuItemID: element['id'].toString(),
  //     restaurantID: restaurantID,
  //     name: element['name'] as String? ?? '',
  //     imageURL: element['imageUrl'] as String? ?? '',
  //     categoryName: element['category']['name'] as String? ?? '',
  //     categoryId: element['category']['id'] as int? ?? 0,
  //     price: element['basePrice'] as int? ?? 0,
  //     description: element['description'] as String? ?? '',
  //     extras: {},
  //     listOfProductOptionCategories: pos,
  //     // listOfProductOptionCategories: selectProductOptionsCategories,
  //     priority: element['priority'] as int? ?? 0,
  //   );
  // }

  Future<List<RestaurantMenuItem>> getFilteredRestaurantMenu({
    required String restaurantID,
    required String searchQuery,
  }) async {
    final Response<dynamic> response =
        await dioGet('api/v1/vendors/$restaurantID?search=$searchQuery');

    final List<Map<String, dynamic>> results =
        List.from(response.data['vendor']['products'] as Iterable<dynamic>);

    final List<RestaurantMenuItem> menuItems = [];

    for (final Map<String, dynamic> element in results) {
      if (element['isAvailable'] as bool) {
        menuItems.add(
          RestaurantMenuItem(
            isFeatured: element['isFeatured'] as bool? ?? false,
            menuItemID: element['id'].toString(),
            restaurantID: restaurantID,
            name: element['name'] as String? ?? '',
            imageURL: element['imageUrl'] as String? ?? '',
            categoryName: element['category']['name'] as String? ?? '',
            categoryId: element['category']['id'] as int? ?? 0,
            price: Money(
              currency: Currency.GBPx,
              value: element['basePrice'] as int? ?? 0,
            ),
            description: element['description'] as String? ?? '',
            extras: {},
            listOfProductOptionCategories: [],
            priority: element['priority'] as int? ?? 0,
            isAvailable: element['isAvailable'] as bool? ?? false,
            vendorInternalId: element['vendorInternalId'] as String? ?? '',
            ingredients: element['ingredients'] as String? ?? '',
            productBarCode: element['productBarCode'] as String? ?? '',
            status: EnumHelpers.enumFromString(
                  ProductDiscontinuedStatus.values,
                  element['status'] as String,
                ) ??
                ProductDiscontinuedStatus.inactive,
            stockCount: element['stockCount'] as int? ?? 0,
            sizeInnerUnitValue: element['sizeInnerUnitValue'] as num? ?? 1,
            sizeInnerUnitType: element['sizeInnerUnitType'] as String? ?? 'g',
            stockUnitsPerProduct: element['stockUnitsPerProduct'] as num? ?? 1,
            brandName: element['brandName'] as String? ?? '',
            supplier: element['supplier'] as String? ?? '',
            taxGroup: element['taxGroup'] as String? ?? '',
          ),
        );
      }
    }

    menuItems.sort((a, b) => a.priority.compareTo(b.priority));

    return menuItems;
  }

  /// vegiRelUri is the relative uri in the orders sub directory (i.e. currently just the id of the order)
  Future<OrderModel.Order?> getOrderFromUri({
    required String vegiRelUri,
  }) async {
    final response = await dioGet<Map<String, dynamic>>(vegiRelUri);

    if (response.data != null &&
        response.data is Map<String, dynamic> &&
        response.data!.containsKey('order')) {
      return OrderModel.Order.fromJson(
        response.data!['order'] as Map<String, dynamic>,
      );
    } else {
      return null;
    }
  }

  Future<GetProductResponse?> getProduct(
    int productId, {
    bool dontRoute = false,
  }) async {
    final Response<dynamic> response = await dioGet(
      '/api/v1/products/${productId}',
    );

    if (responseHasErrorStatus(response) ||
        !(response.data as Map).containsKey('product') ||
        !(response.data as Map).containsKey('category')) {
      log.error('Unable to fetch product details for id: [${productId}]');
      return null;
    }

    return GetProductResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<ProductCategory>> getProductCategoriesForVendor(
    int vendorId, {
    bool dontRoute = false,
  }) async {
    final Response<dynamic> response = await dioGet(
      'api/v1/vendors/product-categories?vendor=$vendorId',
      dontRoute: dontRoute,
    );

    final List<dynamic> productCategories =
        response.data['productCategories'] as List<dynamic>;

    return productCategories
        .map(
          (e) => ProductCategory.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Future<List<ProductOptionsCategory>> getProductOptions(
    String itemID, {
    bool dontRoute = false,
  }) async {
    final Response<dynamic> response = await dioGet(
      'api/v1/products/get-product-options/$itemID?',
      dontRoute: dontRoute,
    );

    final List<Map<String, dynamic>> results =
        List.from(response.data as Iterable<dynamic>);

    final List<ProductOptionsCategory> listOfProductOptionCategories = [];

    for (final Map<String, dynamic> category in results) {
      final List<ProductOptionValue> listOfOptions = [];

      final List<Map<String, dynamic>> options =
          List.from(category['values'] as Iterable<dynamic>);

      for (final Map<String, dynamic> option in options) {
        listOfOptions.add(ProductOptionValue.fromJson(option));
      }

      if (options.isEmpty) continue;

      listOfProductOptionCategories.add(
        ProductOptionsCategory(
          categoryID: category['id'] as int? ?? 0,
          name: category['name'] as String? ?? '',
          listOfOptions: listOfOptions,
        ),
      );
    }

    return listOfProductOptionCategories;
  }

  Future<Map<String, ProductRating>> getProductRatings({
    required List<String> productBarcodes,
  }) async {
    final Response<dynamic> response = await dioGet(
      'api/v1/products/get-product-rating',
      queryParameters: {
        'productBarcodes': productBarcodes,
      },
    );

    final responseDataMap = response.data as Map<String, dynamic>;
    final ratingsByBarcode = Map.fromEntries(
      responseDataMap.entries.map(
        (e) => MapEntry(
          e.key,
          ProductRating.fromJson(
            e.value as Map<String, dynamic>,
          ),
        ),
      ),
    );

    return ratingsByBarcode;
  }

  Future<UploadProductSuggestionImageResponse?>
      uploadImageForProductSuggestion({
    required String deviceSuggestionUID,
    required File image,
    required void Function(UploadProductSuggestionImageResponse) onSuccess,
    required void Function(String error, ProductSuggestionUploadErrCode errCode)
        onError,
    required ProgressCallback onReceiveProgress,
  }) async {
    try {
      final response = await dioPostFile<Map<String, dynamic>>(
        'api/v1/products/upload-product-suggestion-image',
        file: image,
        formDataCreator: ({required MultipartFile file}) => FormData.fromMap({
          'uid': const Uuid().v4(),
          'image': file,
        }),
        errorResponseData: {'image': ''},
        onError: (error, errCode) {
          switch (errCode) {
            case FileUploadErrCode.imageTooLarge:
              return onError(
                error,
                ProductSuggestionUploadErrCode.imageTooLarge,
              );
            case FileUploadErrCode.imageEncodingError:
              return onError(
                error,
                ProductSuggestionUploadErrCode.imageEncodingError,
              );
            case FileUploadErrCode.unknownError:
              return onError(
                error,
                ProductSuggestionUploadErrCode.unknownError,
              );
          }
        },
        // options: Options? ,
        // cancelToken: CancelToken?,
        // onSendProgress: ProgressCallback?,
        onReceiveProgress: (count, total) =>
            onReceiveProgress != null ? onReceiveProgress(count, total) : null,
      );

      if (responseHasErrorStatus(response)) {
        var errCode = ProductSuggestionUploadErrCode.unknownError;
        if (response.statusCode == 404) {
          errCode = ProductSuggestionUploadErrCode.productNotFound;
        } else if (response.statusCode == 500) {
          errCode = ProductSuggestionUploadErrCode.connectionIssue;
        }
        onError(
          response.statusMessage ?? 'Unknown Error',
          errCode,
        );
        return null;
      } else {
        final answer = UploadProductSuggestionImageResponse.fromJson(
          response.data as Map<String, dynamic>,
        );

        onSuccess(answer);

        return answer;
      }
    } catch (err, st) {
      log.error(err, stackTrace: st);
    }
    return null;
  }

  Future<String> setRandomAvatar({
    required int userId,
    required void Function(String error) onError,
  }) async {
    try {
      final Response<dynamic> response = await dioPost(
        '/api/v1/users/set-random-avatar',
        data: {'userId': userId},
        sendWithAuthCreds: true,
      );

      final results = response.data as Map<String, dynamic>;

      return results['imageUrl'] as String? ?? '';
    } on Exception catch (e, s) {
      // TODO
      log.error(
        e,
        stackTrace: s,
      );
      onError(e.toString());
      return '';
    }
  }

  Future<String?> uploadImageForUserAvatar({
    required File image,
    required int userId,
    required void Function(String error, ProductSuggestionUploadErrCode errCode)
        onError,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dioPostFile<Map<String, dynamic>>(
        'api/v1/users/upload-user-avatar',
        file: image,
        sendWithAuthCreds: true,
        formDataCreator: ({required MultipartFile file}) => FormData.fromMap({
          // 'uid': const Uuid().v4(),
          'image': file,
          'accountId': userId
        }),
        errorResponseData: {'imageUrl': ''},
        onError: (error, errCode) {
          switch (errCode) {
            case FileUploadErrCode.imageTooLarge:
              return onError(
                error,
                ProductSuggestionUploadErrCode.imageTooLarge,
              );
            case FileUploadErrCode.imageEncodingError:
              return onError(
                error,
                ProductSuggestionUploadErrCode.imageEncodingError,
              );
            case FileUploadErrCode.unknownError:
              return onError(
                error,
                ProductSuggestionUploadErrCode.unknownError,
              );
          }
        },
        // options: Options? ,
        // cancelToken: CancelToken?,
        // onSendProgress: ProgressCallback?,
        onReceiveProgress: (count, total) =>
            onReceiveProgress?.call(count, total),
      );

      // if (responseHasErrorStatus(response)) {
      //   var errCode = ProductSuggestionUploadErrCode.unknownError;
      //   if (response.statusCode == 404) {
      //     errCode = ProductSuggestionUploadErrCode.productNotFound;
      //   } else if (response.statusCode == 500) {
      //     errCode = ProductSuggestionUploadErrCode.connectionIssue;
      //   }
      //   onError(
      //     response.statusMessage ?? 'Unknown Error',
      //     errCode,
      //   );
      //   return null;
      // } else {
      //   final results = response.data as Map<String, dynamic>;

      //   return results['imageUrl'] as String? ?? '';
      // }
      final results = response.data as Map<String, dynamic>;

      return results['imageUrl'] as String? ?? '';
    } catch (err, st) {
      log.error(err, stackTrace: st);
    }
    return null;
  }

  Future<UploadProductSuggestionImageResponse?> tryUploadImage({
    required File image,
    required void Function(UploadProductSuggestionImageResponse) onSuccess,
    required void Function(String error, ProductSuggestionUploadErrCode errCode)
        onError,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dioPostFile<Map<String, dynamic>>(
        'api/v1/products/upload-product-suggestion-image',
        file: image,
        formDataCreator: ({required MultipartFile file}) => FormData.fromMap({
          'uid': const Uuid().v4(),
          'image': file,
        }),
        errorResponseData: {'image': ''},
        onError: (error, errCode) {
          switch (errCode) {
            case FileUploadErrCode.imageTooLarge:
              return onError(
                error,
                ProductSuggestionUploadErrCode.imageTooLarge,
              );
            case FileUploadErrCode.imageEncodingError:
              return onError(
                error,
                ProductSuggestionUploadErrCode.imageEncodingError,
              );
            case FileUploadErrCode.unknownError:
              return onError(
                error,
                ProductSuggestionUploadErrCode.unknownError,
              );
          }
        },
        // options: Options? ,
        // cancelToken: CancelToken?,
        // onSendProgress: ProgressCallback?,
        onReceiveProgress: (count, total) =>
            onReceiveProgress != null ? onReceiveProgress(count, total) : null,
      );

      if (responseHasErrorStatus(response)) {
        var errCode = ProductSuggestionUploadErrCode.unknownError;
        if (response.statusCode == 404) {
          errCode = ProductSuggestionUploadErrCode.productNotFound;
        } else if (response.statusCode == 500) {
          errCode = ProductSuggestionUploadErrCode.connectionIssue;
        }
        onError(
          response.statusMessage ?? 'Unknown Error',
          errCode,
        );
        return null;
      } else {
        final answer = UploadProductSuggestionImageResponse.fromJson(
          response.data as Map<String, dynamic>,
        );

        onSuccess(answer);

        return answer;
      }
    } catch (err, st) {
      log.error(err, stackTrace: st);
    }
    return null;
  }

  Future<void> uploadProductSuggestion(
    ProductSuggestion suggestion,
    void Function() onSuccess,
    void Function(String error, ProductSuggestionUploadErrCode errCode) onError,
  ) async {
    final Response<dynamic> response = await dio
        .post(
      'api/v1/products/upload-product-suggestion',
      data: suggestion.toJsonUpload(),
    )
        .onError((error, stackTrace) {
      log.error(error, stackTrace: stackTrace);
      if (error is Map<String, dynamic> && error.containsKey('response')) {
        if (error['response'] is Response) {
          final Response resp = (error as Map<String, Response>)['response']!;
          final wm = resp.toString();
          return resp;
        } else {
          log.error((error as Map<String, Response>)['response']!.toString());
        }
      } else if (error is DioException) {
        log.error((error as Map<String, Response>)['response']!.toString());
      }
      return Response(
        data: {},
        statusCode: 500,
        requestOptions: RequestOptions(),
      );
    });

    if (responseHasErrorStatus(response)) {
      var errCode = ProductSuggestionUploadErrCode.unknownError;
      if (response.statusCode == 404) {
        errCode = ProductSuggestionUploadErrCode.productNotFound;
      } else if (response.statusCode == 400) {
        errCode = ProductSuggestionUploadErrCode.wrongVendor;
      } else if (response.statusCode == 500) {
        errCode = ProductSuggestionUploadErrCode.connectionIssue;
      }
      onError(
        response.statusMessage ?? 'Unknown Error',
        errCode,
      );
    } else {
      onSuccess();
    }

    return;
  }

  Future<int> checkDiscountCode(String discountCode) async {
    final Response<dynamic> response =
        await dioGet('api/v1/discounts/check-discount-code/$discountCode?');

    final results =
        Discount.fromJson(response.data['discount'] as Map<String, dynamic>);

    return results.value as int? ?? 0;
  }

  Future<AcceptVoucherResponse?> acceptDiscountCode({
    required String discountCode,
    required int vegiAccountId,
    int? vendorId,
  }) async {
    var inputs = {
      'vegiAccountId': vegiAccountId,
      'discountCode': discountCode,
    };
    if (vendorId != null) {
      inputs = inputs
        ..addAll({
          'vendorId': vendorId,
        });
    }
    final Response<dynamic> response = await dioPost(
      'api/v1/discounts/accept-discount-code',
      data: inputs,
    );

    final result = AcceptVoucherResponse.fromJson(
        response.data['codeAcceptanceStatus'] as Map<String, dynamic>);
    return result;
  }

  Future<Discount?> validateFixedDiscountCode({
    required String code,
    required String walletAddress,
    int? vendor,
  }) async {
    // final store = await reduxStore;
    final Response<dynamic> response = await dioPost(
      '/api/v1/admin/validate-discount-code',
      data: {
        'code': code,
        'isGlobalPercentageCode': false,
        'walletAddress': walletAddress,
        'vendor': vendor,
      },
    );

    if (responseHasErrorStatus(response)) {
      log.error(
        'Unable to validate fixed discount code with response: ${response.statusMessage}',
      );
      return null;
    }
    if (response.data == false) {
      log.error(
        'No discount codes found for vendor[$vendor] and wallet: "$walletAddress" with code: "$code"',
      );
      return null;
    }
    final data = response.data as Map<String, dynamic>;
    final vendorKVP = data['vendor'];
    if (vendorKVP is int) {
      final vendorDetails = await _fetchSingleRestaurantAsVendorDTO(
        vendorId: vendorKVP,
      );
      data['vendor'] = vendorDetails?.toJson();
    }
    return Discount.fromJson(data);
  }

  Future<Map<String, List<TimeSlot>>> getFulfilmentSlots({
    required String vendorID,
    required String dateRequired,
  }) async {
    final Response<dynamic> response = await dioGet(
      'api/v1/vendors/get-fulfilment-slots?vendor=$vendorID&date=$dateRequired',
    );

    final List<dynamic> availableSlots =
        response.data['slots'] as List<dynamic>;

    final List<TimeSlot> collectionSlots = [];
    final List<TimeSlot> deliverySlots = [];

    for (final slot in availableSlots) {
      if (slot['fulfilmentMethod']['methodType'] == 'delivery') {
        deliverySlots.add(TimeSlot.fromJsonApi(slot as Map<String, dynamic>));
      } else {
        collectionSlots.add(TimeSlot.fromJsonApi(slot as Map<String, dynamic>));
      }
    }

    return {'collectionSlots': collectionSlots, 'deliverySlots': deliverySlots};
  }

  Future<List<String>> getAvaliableDates({
    required String vendorID,
    required bool isDelivery,
  }) async {
    final Response<dynamic> response = await dio
        .get('api/v1/vendors/get-eligible-order-dates?vendor=$vendorID');

    final Map<String, dynamic> collectionDates =
        response.data['collection'] as Map<String, dynamic>;
    final Map<String, dynamic> deliveryDates =
        response.data['delivery'] as Map<String, dynamic>;

    if (isDelivery) {
      return List<String>.from(deliveryDates.keys);
    } else {
      return List<String>.from(collectionDates.keys);
    }
  }

  Future<Map<String, TimeSlot?>> getNextAvaliableSlot({
    required String vendorID,
  }) async {
    final Response<dynamic> response = await dioGet(
      'api/v1/vendors/get-next-fulfilment-slot?vendor=$vendorID',
    );

    final Map<String, dynamic> collectionSlotJson =
        response.data['slot']['collection'] as Map<String, dynamic>? ?? {};
    final Map<String, dynamic> deliverySlotJson =
        response.data['slot']['delivery'] as Map<String, dynamic>? ?? {};

    final Map<String, TimeSlot?> nextSlots = {};

    if (collectionSlotJson.isNotEmpty) {
      final TimeSlot collectionSlot = TimeSlot.fromJsonApi(collectionSlotJson);
      nextSlots['collectionSlot'] = collectionSlot;
    } else {
      nextSlots['collectionSlot'] = null;
    }
    if (deliverySlotJson.isNotEmpty) {
      final TimeSlot deliverySlot = TimeSlot.fromJsonApi(deliverySlotJson);
      nextSlots['deliverySlot'] = deliverySlot;
    } else {
      nextSlots['deliverySlot'] = null;
    }

    return nextSlots;
  }

  Future<VegiAccount?> getVegiAccountForWalletAddress(
    String walletAddress,
    void Function(String error) onError,
  ) async {
    final Response<dynamic> response = await dioGet(
      'api/v1/admin/user-for-wallet-address',
      queryParameters: {
        'walletAddress': walletAddress,
        'accountType': Secrets.FUSE_WALLET_SDK_PUBLIC_KEY.startsWith('pk_test_')
            ? 'fuse_spark'
            : 'fuse',
      },
      sendWithAuthCreds: true,
    );

    if (responseHasErrorStatus(response)) {
      onError(response.statusMessage ?? 'Unknown Error');
      return null;
    } else {
      final result = VegiAccount.fromJson(
        response.data['account'] as Map<String, dynamic>,
      );
      return result;
    }
  }

  Future<UserDTO?> getUserDetails(
    // String email,
    // String phoneNoCountry,
    int userId,
    void Function(String error) onError,
  ) async {
    // if (email.toLowerCase().trim().isEmpty) {
    //   log.warn('Ignoring user-details request as email is blank',
    //       stackTrace: StackTrace.current);
    //   return null;
    // }
    // else if (phoneNoCountry.isEmpty ||
    //     phoneNoCountry.replaceAll("0", "").isEmpty) {
    //   log.warn('Ignoring user-details request as phone number is blank',
    //       stackTrace: StackTrace.current);
    //   return null;
    // }

    try {
      final Response<dynamic> response = await dioGet(
        '/api/v1/admin/user-details',
        queryParameters: {
          // 'email': email.toLowerCase(),
          // 'phoneNoCountry': phoneNoCountry,
          'userId': userId,
        },
        sendWithAuthCreds: true,
        allowStatusCodes: [404],
      );
      if (responseHasErrorStatus(response)) {
        if (response.statusCode! == 404) {
          log.info(
            'Expected 404 response for user details request for not internal vegi user',
          );
          return null;
        }
        onError(response.statusMessage ?? 'Unknown Error');
        return null;
      } else {
        final result = UserDTO.fromJson(response.data as Map<String, dynamic>);
        if (DebugHelpers.inDebugMode) {
          log.info(result);
        }
        return result;
      }
    } on Exception catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 404) {
          return null;
        }
      }
      rethrow;
    }
  }

  Future<String?> updateUserDetails({
    required String phoneNoCountry,
    required int userId,
    int phoneCountryCode = 44,
    String? email,
    String? name,
    bool? marketingEmailContactAllowed,
    bool? marketingPhoneContactAllowed,
    bool? marketingPushContactAllowed,
    // void Function(String error)? onError,
  }) async {
    final params = <String, dynamic>{
      'userId': userId,
      'phoneNoCountry': phoneNoCountry,
      'phoneCountryCode': phoneCountryCode,
    };
    if (email != null) {
      params['email'] = email;
    }
    if (name != null) {
      params['name'] = name;
    }
    if (marketingEmailContactAllowed != null) {
      params['marketingEmailContactAllowed'] = marketingEmailContactAllowed;
    }
    if (marketingPhoneContactAllowed != null) {
      params['marketingPhoneContactAllowed'] = marketingPhoneContactAllowed;
    }
    if (marketingPushContactAllowed != null) {
      params['marketingPushContactAllowed'] = marketingPushContactAllowed;
    }

    final Response<dynamic> response = await dioPost(
      '/api/v1/users/update-user-self',
      data: params,
      // allowStatusCodes: [
      //   400,
      // ],
      allowErrorMessage: RegExp(
        "Unable to update user[[0-9]+]'s email as another user[[0-9]+] already has email|bad email passed",
      ),
    );

    if (responseHasErrorStatus(response)) {
      // onError?.call(response.statusMessage ?? 'Unknown Error');
      return response.extra.containsKey('errorMessage')
          ? response.extra['errorMessage'].toString()
          : response.extra.containsKey('message')
              ? response.extra['message'].toString()
              : response.statusMessage ?? 'Unknown Error';
    } else if (response.extra.containsKey('errorMessage')) {
      return response.extra['errorMessage'].toString();
    }
    return null;
  }

  Future<void> getAccountIsVendor(
    String walletAddress,
    void Function(bool isVendor, int? vendorId) onSuccess,
    void Function(String error) onError,
  ) async {
    if (walletAddress.isEmpty ||
        !RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(walletAddress)) {
      return onError(
        'Invalid Wallet Address passed to check if vendor. "$walletAddress"',
      );
    }
    final Response<dynamic> response = await dioGet(
      'api/v1/admin/account-is-vendor',
      queryParameters: {
        'walletAddress': walletAddress,
      },
    );

    if (responseHasErrorStatus(response)) {
      onError(response.statusMessage ?? 'Unknown Error');
    } else {
      final data = response.data as Map<String, dynamic>;
      onSuccess(data['isVendor'] as bool, data['vendorId'] as int?);
    }
  }

  Future<WaitingListEntry?> updateEmailForWaitingListEntry({
    required String email,
    required int waitingListEntryId,
    required void Function(String error) onError,
  }) async {
    final Response<dynamic> response = await dioPost(
      'api/v1/admin/update-waiting-list-entry',
      data: {
        'id': waitingListEntryId,
        'emailAddress': email.toLowerCase(),
      },
    );

    if (responseHasErrorStatus(response)) {
      onError(response.statusMessage ?? 'Unknown Error');
      return null;
    } else {
      final entry =
          WaitingListEntry.fromJson(response.data as Map<String, dynamic>);
      (await reduxStore)
          .dispatch(SetPositionInWaitingList(positionInQueue: entry.order));
      return entry;
    }
  }

  Future<WaitingListEntry?> registerEmailToWaitingList(
    String email,
    Store<AppState> store,
  ) async {
    final Response<dynamic> response = await dioPost(
      'api/v1/admin/register-email-to-waiting-list',
      data: {
        'emailAddress': email.toLowerCase(),
        'origin': kIsWeb ? 'guide' : 'mobile',
      },
    );

    if (responseHasErrorStatus(response)) {
      log.error(
        'Failed to registerEmailToWaitingList with response: ${response.statusMessage}',
        stackTrace: StackTrace.current,
      );
      return null;
    } else {
      final entry =
          WaitingListEntry.fromJson(response.data as Map<String, dynamic>);
      store.dispatch(SetPositionInWaitingList(positionInQueue: entry.order));
      return entry;
    }
  }

  Future<WaitingListEntry?> subscribeToWaitingListEmails({
    required String email,
    required bool receiveUpdates,
  }) async {
    final Response<dynamic> response = await dioPost(
      'api/v1/admin/subscribe-waitlist-email-notifications',
      data: {
        'emailAddress': email.toLowerCase(),
        'receiveUpdates': receiveUpdates,
        'firebaseRegistrationToken': await firebaseMessaging.getToken()
      },
    );

    if (responseHasErrorStatus(response)) {
      log.error(
        'Failed to subscribeToWaitingListEmails with response: ${response.statusMessage}',
        stackTrace: StackTrace.current,
      );
      return null;
    } else {
      return WaitingListEntry.fromJson(response.data as Map<String, dynamic>);
    }
  }

  Future<int> getPositionInWaitingList(
    String email,
    void Function(String error) onError,
  ) async {
    final Response<dynamic> response = await dioGet(
      '/api/v1/admin/get-position-in-waitinglist',
      queryParameters: {
        'emailAddress': email,
      },
    );

    if (responseHasErrorStatus(response)) {
      onError(response.statusMessage ?? 'Unknown Error');
    }

    return response.data['position'] as int;
  }

  // Future<void> backupUserSK(
  //   String privateKey,
  // ) async {
  //   final Response<dynamic> response = await dioPost(
  //     'api/v1/admin/backup',
  //     data: {
  //       'privateKey': privateKey,
  //     },
  //     sendWithAuthCreds: true,
  //   );

  //   if (responseHasErrorStatus(response)) {
  //     throw Exception(response.statusMessage ?? 'Unknown Error');
  //   }

  //   return;
  // }

  // Future<bool> isUserSKBackedUp({
  //   required String smartWalletAddress,
  // }) async {
  //   final Response<dynamic> response = await dioGet(
  //     'api/v1/admin/is-backed-up',
  //     queryParameters: {
  //       'smartWalletAddress': smartWalletAddress,
  //     },
  //     sendWithAuthCreds: true,
  //   );

  //   if (responseHasErrorStatus(response)) {
  //     return false;
  //   } else if (response.data != null) {
  //     return response.data == true;
  //   }

  //   return false;
  // }

  Future<void> submitSurveyResponse(
    String email,
    String question,
    String answer,
    void Function() onSuccess,
    void Function(String error) onError,
  ) async {
    final Response<dynamic> response = await dioPost(
      'api/v1/admin/submit-survey-response',
      data: {
        'emailAddress': email,
        'question': question,
        'answer': answer,
      },
    );

    if (responseHasErrorStatus(response)) {
      onError(response.statusMessage ?? 'Unknown Error');
    } else {
      onSuccess();
    }

    return;
  }

  Future<List<SurveyQuestion>> getSurveyQuestions() async {
    final Response<dynamic> response = await dioGet(
      'api/v1/admin/get-survey-questions',
    );

    return (response.data as List<dynamic>)
        .map(
          (question) => SurveyQuestion.fromJson(
            question as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<CreateOrderResponse?> createOrder<T extends CreateOrderForFulfilment>(
    T orderObject,
  ) async {
    final store = await reduxStore;
    final response = await dioPost<Map<String, dynamic>>(
      'api/v1/orders/create-order',
      data: await orderObject.toUploadJson(),
      handleErrorCodes: (errCode) {
        switch (errCode) {
          case 'noItemsFound':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.noItemsFound,
                orderCreationStatusMessage:
                    'No items found in basket, please try again.',
              ),
            );
            break;
          case 'invalidVendor':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.invalidVendor,
                orderCreationStatusMessage:
                    'This vendor has been removed or has stopped serving today.',
              ),
            );
            break;
          case 'invalidFulfilmentMethod':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.invalidFulfilmentMethod,
                orderCreationStatusMessage:
                    'This vendor is not currently accepting ${store.state.cartState.fulfilmentMethod.name}',
              ),
            );
            break;
          case 'invalidProduct':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.invalidProduct,
                orderCreationStatusMessage:
                    'Order creation failed due to an invalid product',
              ),
            );
            break;
          case 'invalidProductOption':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.invalidProductOption,
                orderCreationStatusMessage:
                    'Order creation failed due to an invalid option chosen on a product',
              ),
            );
            break;
          case 'invalidUserAddress':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.invalidUserAddress,
                orderCreationStatusMessage:
                    "Order creation failed as we couldn't validate your delivery address",
              ),
            );
            break;
          case 'deliveryPartnerUnavailable':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.deliveryPartnerUnavailable,
                orderCreationStatusMessage:
                    'Unable to create order as no delivery partners are available at this time',
              ),
            );
            break;
          case 'allItemsUnavailable':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.allItemsUnavailable,
                orderCreationStatusMessage:
                    'All items from your order are unavailable. Please clear your basket and start again',
              ),
            );
            break;
          case 'minimumOrderAmount':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.minimumOrderAmount,
                orderCreationStatusMessage:
                    "Your order is below the vendor's minimum order amount. Please add more to order.",
              ),
            );
            break;
          case 'badItemsRequest':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.badItemsRequest,
                orderCreationStatusMessage:
                    'Some items in the order are unavailable, please start again.',
              ),
            );
            break;
          case 'invalidPostalDistrict':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.invalidPostalDistrict,
                orderCreationStatusMessage:
                    'Whoops, vendor doesn\'t deliver to "${store.state.cartState.selectedDeliveryAddress?.postalCode ?? 'the selected postcode'}", please choose a different delivery address or change to collection',
              ),
            );
            break;
          case 'invalidSlot':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.invalidSlot,
                orderCreationStatusMessage:
                    'Whoops, over-subscribed delivery slot, please pick a new slot',
              ),
            );
            break;
          case 'invalidDiscountCode':
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.invalidDiscountCode,
                orderCreationStatusMessage:
                    'the order contained an invalid discount code',
              ),
            );
            break;
          default:
            break;
        }
      },
    ).timeout(
      const Duration(seconds: inDebugMode ? 300 : 10),
      onTimeout: () {
        return Response(
          data: {},
          statusCode: 500,
          requestOptions: RequestOptions(path: 'api/v1/orders/create-order'),
        );
      },
    );

    if ((response.data?.isEmpty ?? true) ||
        !CreateOrderResponse.canParse(response.data!)) {
      if (response.data != null &&
          response.data!.isNotEmpty &&
          response.data!.containsKey('error')) {
        if (response.data!['error']!
            .toString()
            .contains('Failed to retrieve stripe from customerId')) {
          store.dispatch(
            OrderCreationProcessStatusUpdate(
              status: OrderCreationProcessStatus.stripeServiceFailedOnServer,
              orderCreationStatusMessage: 'Stripe failed',
            ),
          );
          log.error('Failed to retrieve stripe from customerId');
          return null;
        } else {
          store.dispatch(
            OrderCreationProcessStatusUpdate(
              status: OrderCreationProcessStatus.sendOrderCallServerError,
              orderCreationStatusMessage: response.data!['error']!.toString(),
            ),
          );
        }
      }
      if (response.extra.isNotEmpty &&
          response.extra.containsKey('errorCode')) {
        // * handled in the handleErrorCodeHandler above.
        log.error(
          'peeplEats.createOrder returning null as response.extra contains errorCode key',
          additionalDetails: {
            'response.extra': response.extra,
          },
          stackTrace: StackTrace.current,
        );
        return null;
      }
      if (response.extra.isNotEmpty &&
          response.extra.containsKey('errorMessage')) {
        if (response.extra['errorMessage'] is Map) {
        } else if (response.extra['errorMessage'] is String) {
          final errorMessage = response.extra['errorMessage'].toString();
          if (errorMessage.toLowerCase().contains('Invalid slot')) {
            store.dispatch(
              OrderCreationProcessStatusUpdate(
                status: OrderCreationProcessStatus.invalidSlot,
                orderCreationStatusMessage:
                    'Whoops, over-subscribed delivery slot, please pick a new slot',
              ),
            );
          }
        }
      }
      store.dispatch(
        OrderCreationProcessStatusUpdate(
          status: OrderCreationProcessStatus.sendOrderCallServerError,
          orderCreationStatusMessage:
              'Order creation failed, please try again later.',
        ),
      );
      return null;
    }
    final result = CreateOrderResponse.fromJson(response.data!);
    if (result.order.transactions.isEmpty) {
      // result.order.transactions.add(
      //   TransactionItem(
      //     amount: orderObject.total,
      //     currency: orderObject.currency,
      //     order: result.order.id,
      //     payer: -1,
      //     receiver: -2,
      //     timestamp: DateTime.now(),
      //   ),
      // );
      result.order.transactions.addAll([
        TransactionItem(
          timestamp: result.order.orderedDateTime,
          amount: orderObject.total,
          currency: orderObject.currency,
          receiver: -2,
          payer: store.state.userState.vegiAccountId ?? -1,
          order: result.order.id,
        ),
        TransactionItem(
          timestamp: result.order.orderedDateTime,
          amount: store.state.cartState.selectedCashBackAppliedToCart.value,
          currency:
              store.state.cartState.selectedCashBackAppliedToCart.currency,
          receiver: -2,
          payer: store.state.userState.vegiAccountId ?? -1,
          order: result.order.id,
        ),
      ]);
    }
    return result;
  }

  Future<bool?> cancelOrder({
    required int orderId,
    required String senderWalletAddress,
  }) async {
    final response = await dioPost<dynamic>(
      'api/v1/orders/cancel-order',
      data: {
        'orderId': orderId,
        'senderWalletAddress': senderWalletAddress,
      },
      sendWithAuthCreds: true,
    ).timeout(
      const Duration(seconds: inDebugMode ? 300 : 10),
      onTimeout: () {
        return Response(
          data: {},
          statusCode: 500,
          requestOptions: RequestOptions(path: 'api/v1/orders/cancel-order'),
        );
      },
    );
    if (responseHasErrorStatus(response)) {
      return null;
    }
    final data = response.data as Map<String, dynamic>;
    // final result = CreateOrderResponse.fromJson(response.data!);
    // if (result.order.transactions.isEmpty) {
    //   result.order.transactions.add(
    //     TransactionItem(
    //       amount: orderObject.total,
    //       currency: Currency.GBPx,
    //       order: result.order.id,
    //       payer: -1,
    //       receiver: -2,
    //       timestamp: DateTime.now(),
    //     ),
    //   );
    // }
    final completedFlag = data['completedFlag'] as String;
    if (completedFlag != 'cancelled') {
      log.warn(
        'cancel-order request failed and returned an order with completedFlag: $completedFlag',
      );
    }
    return completedFlag == 'cancelled';
  }

  String getOrderFullUri(String orderID) =>
      '${baseUrl}api/v1/orders/get-order-details?orderId=$orderID';

  String getOrderRelUri(String orderID) =>
      'api/v1/orders/get-order-details?orderId=$orderID';

  Future<OrderStatus> checkOrderStatus(String orderID) async {
    final Response<dynamic> response =
        await dioGet('api/v1/orders/get-order-status?orderId=$orderID');

    final Map<String, dynamic> orderStatus =
        response.data as Map<String, dynamic>;

    return OrderStatus.fromJson(orderStatus);
  }

  Future<GetOrdersResponse> getOrdersForWallet(
    String walletAddress, {
    bool dontRoute = false,
  }) async {
    try {
      final Response<dynamic> response = await dioGet(
        'api/v1/orders?walletId=$walletAddress',
        dontRoute: dontRoute,
      );
      final scheduledOrders =
          (response.data['scheduledOrders'] as List<dynamic>)
              .map(
                (order) =>
                    OrderModel.Order.fromJson(order as Map<String, dynamic>),
              )
              .toList();
      final ongoingOrders = (response.data['ongoingOrders'] as List<dynamic>)
          .map(
            (order) => OrderModel.Order.fromJson(order as Map<String, dynamic>),
          )
          .toList();
      final pastOrders = (response.data['pastOrders'] as List<dynamic>)
          .map(
            (order) => OrderModel.Order.fromJson(order as Map<String, dynamic>),
          )
          .toList()
          .reversed
          .toList();
      final unpaidOrders = (response.data['unpaidOrders'] as List<dynamic>)
          .map(
            (order) => OrderModel.Order.fromJson(order as Map<String, dynamic>),
          )
          .toList()
          .reversed
          .toList();
      final allMyOrders = (response.data['allMyOrders'] as List<dynamic>)
          .map(
            (order) => OrderModel.Order.fromJson(order as Map<String, dynamic>),
          )
          .toList()
          .reversed
          .toList();
      return GetOrdersResponse(
        ongoingOrders: ongoingOrders,
        scheduledOrders: scheduledOrders,
        pastOrders: pastOrders,
        unpaidOrders: unpaidOrders,
        allMyOrders: allMyOrders,
      );
    } catch (e, stackTrace) {
      log.error(
        'Order parsing threw with stackTrace: $stackTrace & error: $e',
      );
      throw Exception(e);
    }
  }

  Future<TransactionItem?> createFusePaymentIntent({
    required num amountTokens,
    required String payerWalletAddress,
    required String receiverWalletAddress,
    required int orderId,
  }) async {
    final Response<dynamic> response = await dioPost(
        VegiBackendEndpoints.createFusePaymentIntent,
        dontRoute: true,
        data: {
          "amountTokens": amountTokens,
          "payerWalletAddress": payerWalletAddress,
          "receiverWalletAddress": receiverWalletAddress,
          "currency": Currency.GBT.name,
          "metadata": {
            "orderId": orderId,
          }
        });

    if (responseHasErrorStatus(response)) {
      log.error(
        'Bad response returned when trying to createFusePaymentIntent: $response',
      );
      return null;
    }
    print(response.data);
    return TransactionItem.fromJson(
        response.data['transaction'] as Map<String, dynamic>);
  }

  Future<TransactionItem?> updateTransaction({
    required int transactionId,

    /// this is the remote job id assigned to the transaction by web3Auth lib via fuse SDK
    String? remoteJobId,
    String? status,
    int? orderId,
  }) async {
    Map<String, dynamic> data = {
      "transactionId": transactionId,
    };
    if (remoteJobId != null && remoteJobId.isNotEmpty) {
      data['remoteJobId'] = remoteJobId;
    }
    if (status != null && status.isNotEmpty) {
      data['status'] = status;
    }
    if (orderId != null && orderId > 0) {
      data['orderId'] = orderId;
    }
    final Response<dynamic> response = await dioPost(
      VegiBackendEndpoints.updateTransaction,
      dontRoute: true,
      data: data,
    );

    if (responseHasErrorStatus(response)) {
      log.error(
        'Bad response returned when trying to updateTransaction: $response',
      );
      return null;
    }

    return TransactionItem.fromJson(
        response.data['transaction'] as Map<String, dynamic>);
  }

  Future<OrderModel.Order?> updateOrderStatus({
    required int orderId,
    required PaymentStatus paymentStatus,
  }) async {
    Map<String, dynamic> data = {
      "orderId": orderId,
      "paymentStatus": paymentStatus.name,
    };
    
    final Response<dynamic> response = await dioPost(
      VegiBackendEndpoints.updateOrderStatus,
      dontRoute: true,
      data: data,
      sendWithAuthCreds: true,
    );

    if (responseHasErrorStatus(response)) {
      log.error(
        'Bad response returned when trying to update-order-status: $response',
      );
      return null;
    }

    return OrderModel.Order.fromJson(
        response.data['order'] as Map<String, dynamic>);
  }

  Future<List<String>> getPostalCodes({
    bool dontRoute = false,
  }) async {
    final Response<dynamic> response = await dioGet(
      'api/v1/postal-districts/get-all-postal-districts',
      dontRoute: dontRoute,
    );

    final List<String> outCodes = [];

    final List<Map<String, dynamic>> data =
        List.from(response.data['postalDistricts'] as Iterable<dynamic>);

    for (final Map<String, dynamic> outcode in data) {
      outCodes.add((outcode['outcode'] as String? ?? '').toUpperCase());
    }

    return outCodes;
  }

  Future<void> writeLog({
    required String message,
    Map<String, dynamic> details = const {},
  }) async {
    final Response<dynamic> response = await dioPost(
      'api/v1/logging/log',
      data: {
        'message': message,
        'details': details,
      },
      customHeaders: {
        'api-key': Secrets.VEGI_SERVICE_API_KEY,
        'api-secret': Secrets.VEGI_SERVICE_API_SECRET,
      },
      dontLog: true,
    );

    if (responseHasErrorStatus(response)) {
      log.error(
        'Failed to writeLog to vegi backend with response: ${response.statusMessage}',
        stackTrace: StackTrace.current,
      );
      return;
    }
    return;
  }
}
