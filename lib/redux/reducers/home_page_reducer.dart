import 'package:redux/redux.dart';
import 'package:vegan_liverpool/models/home_page_state.dart';
import 'package:vegan_liverpool/models/user_state.dart';
import 'package:vegan_liverpool/redux/actions/home_page_actions.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';

final homePageReducers = combineReducers<HomePageState>(
  [
    TypedReducer<HomePageState, ResetAppState>(_resetApp).call,
    TypedReducer<HomePageState, UpdateFeaturedRestaurants>(
      _getFeaturedRestaurants,
    ).call,
    TypedReducer<HomePageState, UpdateRestaurant>(
      _updateRestaurant,
    ).call,
    TypedReducer<HomePageState, SetIsLoadingHomePage>(_setIsLoadingHomePage).call,
    TypedReducer<HomePageState, SetIsLoadingHttpRequest>(
        _setIsLoadingHttpRequest,).call,
    TypedReducer<HomePageState, UpdatePostalCodes>(_updatePostalCodes).call,
    TypedReducer<HomePageState, UpdateSelectedSearchPostCode>(
        _updateSelectedSearchPostCode,).call,
    TypedReducer<HomePageState, ShowGlobalSearchBarField>(
      _showGlobalSearchBarField,
    ).call,
    TypedReducer<HomePageState, SetGlobalSearchQuerySuccess>(
        _setGlobalSearchQuery,).call,
    TypedReducer<HomePageState, SetMenuSearchQuerySuccess>(_setMenuSearchQuery).call,
    TypedReducer<HomePageState, ShowRestaurantMenuSearchBarField>(
      _showMenuSearchBarField,
    ).call,
  ],
);

HomePageState _resetApp(
  HomePageState state,
  ResetAppState action,
) {
  return HomePageState.initial();
}

HomePageState _getFeaturedRestaurants(
  HomePageState state,
  UpdateFeaturedRestaurants action,
) {
  return state.copyWith(featuredRestaurants: action.listOfFeaturedRestaurants);
}

HomePageState _updateRestaurant(
  HomePageState state,
  UpdateRestaurant action,
) {
  return state.copyWith(
    featuredRestaurants: state.featuredRestaurants
        .where(
          (element) => element.restaurantID != action.restaurant.restaurantID,
        )
        .toList()
      ..add(action.restaurant),
  );
}

HomePageState _showGlobalSearchBarField(
  HomePageState state,
  ShowGlobalSearchBarField action,
) {
  return state.copyWith(
    showGlobalSearchBarField: action.makeGlobalSearchVisible,
  );
}

HomePageState _setGlobalSearchQuery(
  HomePageState state,
  SetGlobalSearchQuerySuccess action,
) {
  return state.copyWith(
    filteredRestaurants: action.filteredRestaurants,
    filterRestaurantsQuery: action.searchQuery,
  );
}

HomePageState _showMenuSearchBarField(
  HomePageState state,
  ShowRestaurantMenuSearchBarField action,
) {
  return state.copyWith(
    showMenuSearchBarField: action.makeMenuSearchVisible,
  );
}

HomePageState _setMenuSearchQuery(
  HomePageState state,
  SetMenuSearchQuerySuccess action,
) {
  return state.copyWith(
    filteredMenuItems: action.filteredMenuItems,
    filterMenuQuery: action.searchQuery,
  );
}

HomePageState _setIsLoadingHomePage(
  HomePageState state,
  SetIsLoadingHomePage action,
) {
  return state.copyWith(isLoadingHomePage: action.isLoading);
}

HomePageState _setIsLoadingHttpRequest(
  HomePageState state,
  SetIsLoadingHttpRequest action,
) {
  return state.copyWith(isLoadingHttpRequest: action.isLoading);
}

HomePageState _updatePostalCodes(
  HomePageState state,
  UpdatePostalCodes action,
) {
  return state.copyWith(postalCodes: action.postalCodes);
}

HomePageState _updateSelectedSearchPostCode(
  HomePageState state,
  UpdateSelectedSearchPostCode action,
) {
  if (!state.postalCodes.contains(action.selectedSearchPostCode)) {
    return state.copyWith(
      postalCodes: state.postalCodes..add(action.selectedSearchPostCode),
      selectedSearchPostCode: action.selectedSearchPostCode,
    );
  }
  return state.copyWith(selectedSearchPostCode: action.selectedSearchPostCode);
}
