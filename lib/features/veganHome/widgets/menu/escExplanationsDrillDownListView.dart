import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/models/restaurant/productOptionsCategory.dart';
import 'package:vegan_liverpool/redux/actions/menu_item_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/detailMenuItem.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class ESCExplanationsDrillDownListView extends StatefulWidget {
  const ESCExplanationsDrillDownListView({
    Key? key,
    required this.productOptionsCategory,
  }) : super(key: key);

  final ProductOptionsCategory productOptionsCategory;

  @override
  State<ESCExplanationsDrillDownListView> createState() =>
      _ESCExplanationsDrillDownListViewState();
}

class _ESCExplanationsDrillDownListViewState
    extends State<ESCExplanationsDrillDownListView> {
  int _selectedIndex = 0;

  final Map<String, Map<String, String>> dummyExplanations = {
    'Independence': {
      'Estimate':
          'SME with < 10 employees and supply chain contained in NW of England',
    },
    'CO2e': {
      'Estimate':
          'Based on similar product X taken from Y.com, we estimate a cost of 0.01 tonnes CO2e per product manufactured'
    },
    'Water usage': {
      'No information':
          'No information has been inferred or found for this product or brand as a whole regarding the water used to produce the product',
    },
    'Brand ethics': {
      'Charity':
          'Monthly donations to UK school meals as reported by XXX on twitter in dd/m/yyyy',
    },
    'Land usage': {
      'Claim':
          'A reported 3000 Ha of land used annually to meet annual production volumes historically at circa 1 million. Sourced from `company blog`.',
    },
  };

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DetailMenuItem>(
      converter: DetailMenuItem.fromStore,
      builder: (_, viewmodel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.productOptionsCategory.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dummyExplanations.length,
              itemBuilder: (_, index) => ListTile(
                onTap: () => setState(() {
                  _selectedIndex = index;
                }),
                selected: _selectedIndex == index,
                selectedTileColor: themeShade100,
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(
                  dummyExplanations.entries.elementAt(index).key,
                  style: TextStyle(color: Colors.grey[800]),
                ),
                subtitle: AutoSizeText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: dummyExplanations.entries
                            .elementAt(index)
                            .value
                            .entries
                            .first
                            .key,
                        style: TextStyle(
                          fontSize: 16,
                          // color: subHeadingColour,
                          fontFamily: Fonts.gelica,
                        ),
                      ),
                    ],
                  ),
                  minFontSize: 16,
                  maxFontSize: 20,
                  textAlign: TextAlign.center,
                ),
                trailing: Text(
                  widget.productOptionsCategory.listOfOptions[index].priceGBPx
                      .inGBPValue.formattedGBPPrice,
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ),
              separatorBuilder: (context, index) =>
                  const Padding(padding: EdgeInsets.only(bottom: 5)),
            )
          ],
        );
      },
    );
  }
}
