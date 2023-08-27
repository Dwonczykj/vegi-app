import 'package:redux/redux.dart';
import 'package:vegan_liverpool/models/auth_state.dart';
import 'package:vegan_liverpool/models/esc_state.dart';
import 'package:vegan_liverpool/redux/actions/auth_actions.dart';
import 'package:vegan_liverpool/redux/actions/esc_actions.dart';

final escReducer = combineReducers<EscState>([
  TypedReducer<EscState, SetExplanationsForProduct>(_setExplanationsForProduct)
      .call,
]);

EscState _setExplanationsForProduct(
  EscState state,
  SetExplanationsForProduct action,
) {
  final newMap = action.newRating == null ? state.ratings : state.ratings
    ..removeWhere((key, value) => key == action.productId)
    ..addAll({
      action.productId: action.newRating!,
    });
  return state.copyWith(
    ratings: newMap,
  );
}
