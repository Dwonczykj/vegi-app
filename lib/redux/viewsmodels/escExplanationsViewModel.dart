import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/esc/escNewRating.dart';
import 'package:vegan_liverpool/redux/actions/esc_actions.dart';

class EscExplanationsViewModel extends Equatable {
  const EscExplanationsViewModel({
    required this.ratings,
    required this.refreshRatingsForProduct,
  });

  factory EscExplanationsViewModel.fromStore(Store<AppState> store) {
    return EscExplanationsViewModel(
        ratings: store.state.escState.ratings,
        refreshRatingsForProduct: ({required int productId}) async {
          store.dispatch(
            getRatingsForProduct(
              productId: productId,
            ),
          );
        });
  }

  final Map<int, EscNewRating> ratings;
  final Future<void> Function({required int productId})
      refreshRatingsForProduct;

  EscNewRating? getExplanationsForProduct(int productId) => ratings[productId];

  @override
  List<Object?> get props => [
        ratings,
      ];
}
