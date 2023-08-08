import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/restaurant/restaurantItem.dart';
import 'package:vegan_liverpool/models/restaurant/restaurantMenuItem.dart';

part 'home_page_state.freezed.dart';
part 'home_page_state.g.dart';

@Freezed()
class HomePageState with _$HomePageState {
  @JsonSerializable()
  factory HomePageState({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<RestaurantItem> featuredRestaurants,
    @Default([]) List<RestaurantItem> filteredRestaurants,
    @Default('') String filterRestaurantsQuery,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool showGlobalSearchBarField,
    @Default([]) List<RestaurantMenuItem> filteredMenuItems,
    @Default('') String filterMenuQuery,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool showMenuSearchBarField,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isLoadingHomePage,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isLoadingHttpRequest,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<String> postalCodes,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('L1')
    String selectedSearchPostCode,
  }) = _HomePageState;

  const HomePageState._();

  factory HomePageState.initial() => HomePageState(
        featuredRestaurants: [],
        filteredRestaurants: [],
        filteredMenuItems: [],
        postalCodes: [],
      );

  factory HomePageState.fromJson(Map<String, dynamic> json) =>
      tryCatchRethrowInline(
        () => _$HomePageStateFromJson(json),
      );
}

class HomePageStateConverter
    implements JsonConverter<HomePageState, Map<String, dynamic>?> {
  const HomePageStateConverter();

  @override
  HomePageState fromJson(Map<String, dynamic>? json) => tryCatchRethrowInline(
        () => json != null
            ? HomePageState.fromJson(json)
            : HomePageState.initial(),
      );

  @override
  Map<String, dynamic> toJson(HomePageState instance) => instance.toJson();
}
