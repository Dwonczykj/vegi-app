import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/helpers.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/viewsmodels/paymentSheet.dart';
import 'package:vegan_liverpool/utils/constants.dart';

class GBTChooseCashBackPicker extends StatefulWidget {
  const GBTChooseCashBackPicker({Key? key}) : super(key: key);

  @override
  State<GBTChooseCashBackPicker> createState() =>
      _GBTChooseCashBackPickerState();
}

class _GBTChooseCashBackPickerState extends State<GBTChooseCashBackPicker> {
  double _gbtSliderValue = 0;
  double _gbtBalance = 0;
  // double _gbpxSliderValue = 0;
  double _amountToBePaid = 0;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PeeplPaySheetViewModel>(
      converter: PeeplPaySheetViewModel.fromStore,
      distinct: true,
      onInit: (store) {
        _amountToBePaid = store
            .state.cartState.cartTotalWithoutGBTRewards.inGBPxValue
            .toDouble(); //in pence
        // _gbpxSliderValue =
        //     store.state.cartState.cartTotalWithoutGBTRewards.inGBPxValue.toDouble(); //in pence
        _gbtBalance = store.state.cashWalletState
            .tokens[TokenDefinitions.greenBeanToken.address]!
            .getAmountTokens();
        // todo: We _amountToBePaid to not have cash balance to be applied already discounted
        _gbtSliderValue = getGBTValueFromPence(_amountToBePaid) < _gbtBalance
            ? roundFloorGBP(getGBTValueFromPence(_amountToBePaid))
            : roundFloorGBP(store
                .state.cartState.selectedCashBackAppliedToCart.value
                .toDouble());
      },
      builder: (_, viewmodel) {
        final maxValue = getGBTValueFromPence(_amountToBePaid) <
                _gbtBalance // compare values in PPL terms //665 < 171.66 ? || 35 < 171.66
            ? roundFloorGBP(getGBTValueFromPence(_amountToBePaid))
            : roundFloorGBP(_gbtBalance);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (roundFloorGBP(_gbtSliderValue) <= 0) {
                          return;
                        }

                        final value = roundFloorGBP(math
                            .min(math.max(_gbtSliderValue - 100, 0), maxValue)
                            .toDouble());
                        setState(
                          () {
                            _gbtSliderValue = value;
                          },
                        );
                        viewmodel.selectCashBackToApply(value);
                      },
                      icon: Icon(
                        Icons.remove,
                        color: roundFloorGBP(_gbtSliderValue) <= 0
                            ? null
                            : Colors.black,
                      ),
                      disabledColor: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: const Border.symmetric(
                        vertical: BorderSide(color: Colors.grey),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        roundFloorGBP(_gbtSliderValue).round().toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(3, 0),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (roundFloorGBP(_gbtSliderValue) >= maxValue) {
                          return;
                        }
                        // final value2 = math
                        //     .min(math.max(_gbtSliderValue + 100, 0), maxValue)
                        //     .toDouble();
                        final value = roundFloorGBP(math
                            .min(math.max(_gbtSliderValue + 100, 0), maxValue)
                            .toDouble());
                        setState(
                          () {
                            _gbtSliderValue = value;
                          },
                        );
                        viewmodel.selectCashBackToApply(value);
                      },
                      icon: Icon(
                        Icons.add,
                        color: roundFloorGBP(_gbtSliderValue) >= maxValue
                            ? null
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 5,
                  trackShape: const RoundedRectSliderTrackShape(),
                  activeTrackColor: Colors.grey[800],
                  inactiveTrackColor: Colors.grey[400],
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 9,
                    pressedElevation: 8,
                  ),
                  thumbColor: Colors.white,
                  overlayColor: Colors.grey.withOpacity(0.2),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                ),
                child: Slider(
                  max: getGBTValueFromPence(_amountToBePaid) <
                          _gbtBalance // compare values in PPL terms //665 < 171.66 ? || 35 < 171.66
                      ? roundFloorGBP(getGBTValueFromPence(_amountToBePaid))
                      : roundFloorGBP(_gbtBalance),
                  value: _gbtSliderValue,
                  divisions: 100,
                  label:
                      getPoundValueFromGBT(_gbtSliderValue).formattedGBPPrice,
                  onChangeEnd: (value) {
                    // _gbpxSliderValue = _amountToBePaid -
                    //     value *
                    //         10; //converting the PPL slider value into pence again
                    setState(
                      () {
                        _gbtSliderValue = roundFloorGBP(value);
                      },
                    );
                    // setState(() {});
                    // viewmodel.updateSelectedValues(
                    //   _gbpxSliderValue / 100,
                    //   _gbtSliderValue,
                    // );
                    viewmodel.selectCashBackToApply(_gbtSliderValue);
                  },
                  onChanged: (value) {
                    setState(
                      () {
                        // _gbpxSliderValue = _amountToBePaid -
                        //     value *
                        //         10; //converting the PPL slider value into pence again
                        _gbtSliderValue = roundFloorGBP(value);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Use your green beans',
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Text(
              //   'Pay ${viewmodel.restaurantName}',
              //   style: TextStyle(
              //     color: Colors.grey[300],
              //     fontSize: 14,
              //     fontWeight: FontWeight.w200,
              //   ),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Text.rich(
              //   TextSpan(
              //     text:
              //         '${getPoundValueFromGBT(_gbtSliderValue).formattedGBPPrice},',
              //     // text: 'GBPx ${(_gbpxSliderValue / 100).toStringAsFixed(2)},',
              //     children: [
              //       TextSpan(
              //         text:
              //             ' (${greenBeanToken.symbol} ${_gbtSliderValue.toStringAsFixed(2)})',
              //         // text: ' PPL ${_gbtSliderValue.toStringAsFixed(2)}',
              //       )
              //     ],
              //   ),
              //   style: TextStyle(
              //     color: Colors.grey[300],
              //     fontSize: 25,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Text.rich(
              //   TextSpan(
              //     text: 'Total ${viewmodel.cartTotal.formattedGBPPrice} | ',
              //     children: [
              //       TextSpan(
              //         text:
              //             'Earn ${getGBTRewardsFromPence(_gbpxSliderValue).toStringAsFixed(2)} ',
              //       ),
              //       WidgetSpan(
              //         child: Image.asset(
              //           'assets/images/avatar-ppl-red.png',
              //           width: 25,
              //         ),
              //       )
              //     ],
              //   ),
              //   style: TextStyle(
              //     color: Colors.grey[300],
              //     fontSize: 16,
              //     fontWeight: FontWeight.w200,
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        );
      },
    );
  }
}
