import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/esc/explanations_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/esc/rating_card.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/shimmerButton.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/restaurant/getProductResponse.dart';
import 'package:vegan_liverpool/redux/actions/menu_item_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/escExplanationsViewModel.dart';

@RoutePage()
class ESCExplainRatingScreen extends StatefulWidget {
  const ESCExplainRatingScreen({
    required this.productId,
    super.key,
  });

  final int productId;

  @override
  State<ESCExplainRatingScreen> createState() => _ESCExplainRatingScreenState();
}

class _ESCExplainRatingScreenState extends State<ESCExplainRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EscExplanationsViewModel>(
      onInit: (store) =>
          store.dispatch(loadProductDetails(productId: widget.productId)),
      distinct: true,
      converter: EscExplanationsViewModel.fromStore,
      builder: (_, viewmodel) {
        final productRating =
            viewmodel.getExplanationsForProduct(widget.productId);
        final productDetails = viewmodel.getProduct(widget.productId);

        final productName = productDetails?.product?.name ??
            productRating?.rating?.product_name ??
            'Product';
        return MyScaffold(
          title: '$productName research',
          // body: SingleChildScrollView(
          body: RefreshIndicator(
            onRefresh: () => viewmodel.refreshRatingsForProduct(
              productId: widget.productId,
              name: productName,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 30,
                  top: 10,
                ),
                child: Column(
                  children:
                      productRating == null || productRating.rating == null
                          ? [
                              Text('No ratings present. Pull down to refresh.'),
                            ]
                          : [
                              RatingCard(
                                rating: productRating.rating!,
                              ),
                              ...(productRating.explanations.map((explanation) {
                                return ExplanationsCard(
                                  explanation: explanation,
                                );
                              })),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ShimmerButton(
                                  buttonContent: const Center(
                                    child: Text(
                                      'Back',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  buttonAction: () {
                                    context.router.pop();
                                  },
                                  baseColor: Colors.grey[900]!,
                                  highlightColor: Colors.grey[800]!,
                                ),
                              )
                            ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
