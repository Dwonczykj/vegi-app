import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class PeeplRewardsAppBar extends StatelessWidget {
  const PeeplRewardsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double top = 0;
    double width = 0;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 5,
      backgroundColor: Colors.white,
      pinned: true,
      toolbarHeight: 0,
      titleSpacing: 0,
      collapsedHeight: 40,
      expandedHeight: 50,
      primary: false,
      flexibleSpace: LayoutBuilder(
        builder: (_, constraints) {
          top = constraints.biggest.height;
          width = constraints.biggest.width;
          return FlexibleSpaceBar(
            expandedTitleScale: 1,
            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            title: AnimatedScale(
              scale: top == 50 ? 1.0 : 1.05,
              duration: const Duration(milliseconds: 200),
              child: Card(
                margin: top == 50
                    ? const EdgeInsets.symmetric(horizontal: 20)
                    : const EdgeInsets.symmetric(horizontal: 10),
                color: themeShade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: themeShade900,
                    width: 2,
                  ),
                ),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Padding(
                    padding: top == 50
                        ? const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          )
                        : const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${TokenDefinitions.greenBeanToken.name} Rewards Earned: ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        StoreConnector<AppState, double>(
                          converter: (store) {
                            return getGBTRewardsFromPence(
                              store.state.cartState.cartTotal.inGBPxValue,
                            );
                          },
                          builder: (context, vegiRewardsForBasket) {
                            return Text(
                              '${vegiRewardsForBasket.toStringAsFixed(2)} ${TokenDefinitions.greenBeanToken.symbol} '
                              '(£${getPoundValueFormattedFromGBT(vegiRewardsForBasket)})',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
