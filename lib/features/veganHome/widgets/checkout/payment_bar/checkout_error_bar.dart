import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/viewsmodels/checkout/payment_method_vm.dart';

class CheckoutErrorBar extends StatelessWidget {
  const CheckoutErrorBar({
    Key? key,
    required this.displayHeight,
  }) : super(key: key);

  final double? displayHeight;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return StoreConnector<AppState, PaymentMethodViewModel>(
      converter: PaymentMethodViewModel.fromStore,
      builder: (context, viewmodel) {
        return Positioned(
          bottom: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: themeLightShade900,
              border: Border(
                top: BorderSide(color: themeShade200),
              ),
              // borderRadius:
              //     const BorderRadius.vertical(top: Radius.circular(10)),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.shade800,
              //     offset: const Offset(0, -2),
              //     blurRadius: 5,
              //   )
              // ],
            ),
            child: SizedBox(
              width: width,
              height: displayHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        viewmodel.orderCreationStatusMessage.isNotEmpty
                            ? viewmodel.orderCreationStatusMessage
                            : viewmodel.orderCreationProcessStatus.name
                                .capitalizeFirstWordFromLowerCamelCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                        // softWrap: false,
                        // maxLines: 1,
                      ),
                    ),
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
