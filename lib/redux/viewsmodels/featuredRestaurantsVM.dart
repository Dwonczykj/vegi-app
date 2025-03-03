import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/cart/order.dart';
import 'package:vegan_liverpool/models/restaurant/orderDetails.dart';
import 'package:vegan_liverpool/models/restaurant/restaurantItem.dart';
import 'package:vegan_liverpool/models/restaurant/restaurantMenuItem.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/actions/home_page_actions.dart';

class FeaturedRestaurantsVM extends Equatable {
  const FeaturedRestaurantsVM({
    required this.isLoadingHomePage,
    required this.featuredRestaurants,
    required this.filterRestaurantsQuery,
    required this.filteredRestaurants,
    required this.filterMenuQuery,
    required this.filteredMenuItems,
    required this.avatarUrl,
    required this.changeOutCode,
    required this.refreshLocation,
    required this.userLocationEnabled,
    required this.userInVendorMode,
    required this.userIsVegiAdmin,
    required this.postalCodes,
    required this.isDelivery,
    required this.setIsDelivery,
    required this.globalSearchIsVisible,
    required this.showGlobalSearchBarField,
    required this.updateSelectedSearchPostalCode,
    required this.filterVendors,
    required this.listOfScheduledOrders,
    required this.refreshFeaturedRestaurants,
    required this.selectedSearchPostCode,
  });

  factory FeaturedRestaurantsVM.fromStore(Store<AppState> store) {
    return FeaturedRestaurantsVM(
      isLoadingHomePage: store.state.homePageState.isLoadingHomePage,
      featuredRestaurants: store.state.homePageState.featuredRestaurants,
      filterRestaurantsQuery: store.state.homePageState.filterRestaurantsQuery,
      filteredRestaurants: store.state.homePageState.filteredRestaurants,
      filterMenuQuery: store.state.homePageState.filterMenuQuery,
      filteredMenuItems: store.state.homePageState.filteredMenuItems,
      globalSearchIsVisible: store.state.homePageState.showGlobalSearchBarField,
      selectedSearchPostCode: store.state.homePageState.selectedSearchPostCode,
      avatarUrl: store.state.userState.avatarUrl,
      isDelivery: store.state.cartState.isDelivery,
      postalCodes: store.state.homePageState.postalCodes,
      listOfScheduledOrders: store.state.pastOrderState.listOfScheduledOrders,
      refreshLocation: () {
        store.dispatch(fetchFeaturedRestaurantsByUserLocation());
      },
      userLocationEnabled: store.state.userState.useLiveLocation,
      userInVendorMode: store.state.userState.isVendor,
      userIsVegiAdmin: store.state.userState.isVegiSuperAdmin,
      setIsDelivery: (isDelivery) {
        store
          ..dispatch(
            SetFulfilmentMethod(
              fulfilmentMethodType: isDelivery
                  ? FulfilmentMethodType.delivery
                  : FulfilmentMethodType.collection,
            ),
          )
          ..dispatch(computeCartTotals());
        // todo: dont fetch if he have already loaded delivery vendors for this outcode
        if (store.state.userState.useLiveLocation) {
          store.dispatch(fetchFeaturedRestaurantsByUserLocation());
        }
      },
      showGlobalSearchBarField: ({required bool makeVisible}) {
        store.dispatch(
          ShowGlobalSearchBarField(
            makeGlobalSearchVisible: makeVisible,
          ),
        );
      },
      refreshFeaturedRestaurants: () async {
        if (store.state.userState.useLiveLocation) {
          store.dispatch(fetchFeaturedRestaurantsByUserLocation());
        } else {
          store.dispatch(fetchFeaturedRestaurantsByPostCode(
              outCode: store.state.homePageState.selectedSearchPostCode,),);
        }
      },
      changeOutCode: (outCode) {
        store.dispatch(fetchFeaturedRestaurantsByPostCode(outCode: outCode));
      },
      updateSelectedSearchPostalCode: (String newPostalCode) {
        store.dispatch(
          UpdateSelectedSearchPostCode(
            selectedSearchPostCode: newPostalCode,
          ),
        );
      },
      filterVendors: ({required String query, required String outCode}) {
        store.dispatch(
          setGlobalSearchQuery(globalSearchQuery: query, outCode: outCode),
        );
      },
    );
  }
  final bool isLoadingHomePage;
  final List<RestaurantItem> featuredRestaurants;
  final String filterRestaurantsQuery;
  final List<RestaurantItem> filteredRestaurants;
  final String filterMenuQuery;
  final List<RestaurantMenuItem> filteredMenuItems;
  final bool globalSearchIsVisible;
  final String selectedSearchPostCode;
  final void Function(String outCode) changeOutCode;
  final void Function(String newPostalCode) updateSelectedSearchPostalCode;
  final void Function() refreshLocation;
  final String avatarUrl;
  final List<String> postalCodes;
  final bool isDelivery;
  final void Function(bool isDelivery) setIsDelivery;
  final Future<void> Function() refreshFeaturedRestaurants;
  final void Function({required bool makeVisible}) showGlobalSearchBarField;
  final bool userLocationEnabled;
  final bool userInVendorMode;
  final bool userIsVegiAdmin;

  final void Function({required String query, required String outCode})
      filterVendors;
  final List<Order> listOfScheduledOrders;

  @override
  List<Object> get props => [
        isLoadingHomePage,
        featuredRestaurants,
        filterRestaurantsQuery,
        filterMenuQuery,
        globalSearchIsVisible,
        selectedSearchPostCode,
        avatarUrl,
        postalCodes,
        isDelivery,
        userLocationEnabled,
        userInVendorMode,
        userIsVegiAdmin,
        listOfScheduledOrders,
      ];
}
