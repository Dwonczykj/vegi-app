import 'package:redux_thunk/redux_thunk.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/esc/escNewRating.dart';
import 'package:redux/redux.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/log/log.dart';

class SetExplanationsForProduct {
  SetExplanationsForProduct({
    required this.productId,
    required this.newRating,
  });

  final int productId;
  final EscNewRating? newRating;

  @override
  String toString() {
    return 'SetExplanaionsForProduct : productId:"$productId"';
  }
}

ThunkAction<AppState> getRatingsForProduct({
  required int productId,
}) {
  return (Store<AppState> store) async {
    try {
      final productRating = await vegiESCService.rateProduct(
        productId: productId,
      );
      if (productRating == null) {
        return;
      }
      store.dispatch(
        SetExplanationsForProduct(
          productId: productId,
          newRating: productRating.new_rating,
        ),
      );
    } catch (e, s) {
      log.error('ERROR - getRatingsForProduct $e', stackTrace: s);
    }
  };
}

ThunkAction<AppState> getRatingsForProductName({
  required int productId,
  required String name,
}) {
  return (Store<AppState> store) async {
    try {
      final productRating = await vegiESCService.rateProductName(
        name: name,
      );
      if (productRating == null) {
        return;
      }
      store.dispatch(
        SetExplanationsForProduct(
          productId: productId,
          newRating: productRating.new_rating,
        ),
      );
    } catch (e, s) {
      log.error('ERROR - getRatingsForProduct $e', stackTrace: s);
    }
  };
}
