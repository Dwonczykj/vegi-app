import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/esc/escNewRating.dart';
import 'package:vegan_liverpool/models/restaurant/getProductResponse.dart';
import 'package:vegan_liverpool/redux/actions/esc_actions.dart';
import 'package:vegan_liverpool/services.dart';

class EscExplanationsViewModel extends Equatable {
  const EscExplanationsViewModel({
    required this.ratings,
    required this.refreshRatingsForProduct,
    required this.products,
  });

  factory EscExplanationsViewModel.fromStore(Store<AppState> store) {
    return EscExplanationsViewModel(
        ratings: store.state.escState.ratings,
        products: store.state.menuItemState.productsPurchased,
        refreshRatingsForProduct: ({
          required int productId,
          required String name,
        }) async {
          store.dispatch(
            getRatingsForProductName(
              productId: productId,
              name: name,
            ),
          );
        });
  }

  final Map<int, EscNewRating> ratings;
  final Future<void> Function({
    required int productId,
    required String name,
  }) refreshRatingsForProduct;
  final Map<int, GetProductResponse> products;

  EscNewRating? getExplanationsForProduct(int productId) => ratings[productId];
  GetProductResponse? getProduct(int productId) => products[productId];

  @override
  List<Object?> get props => [
        ratings,
      ];
}
