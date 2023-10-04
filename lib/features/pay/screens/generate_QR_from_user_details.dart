import 'dart:math' as Math;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/cart_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/generateQRFromUserDetailsViewModel.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/copy.dart';

@RoutePage()
class GenerateQRFromUserDetails extends StatefulWidget {
  const GenerateQRFromUserDetails({Key? key}) : super(key: key);

  @override
  _GenerateQRFromUserDetailsState createState() =>
      _GenerateQRFromUserDetailsState();
}

class _GenerateQRFromUserDetailsState extends State<GenerateQRFromUserDetails> {
  // String qrData = "https://github.com/ChinmayMunje";
  final qrdataFeed = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Scan-in',
      body: StoreConnector<AppState, GenerateQRFromUserDetailsViewModel>(
        distinct: true,
        converter: GenerateQRFromUserDetailsViewModel.fromStore,
        onInit: (store) {
          store
            ..dispatch(SetTransferringPayment(flag: false))
            ..dispatch(SetPaymentButtonFlag(false))
            ..dispatch(
              UpdateSelectedAmounts(
                gbpxAmount:
                    store.state.cartState.cartTotal.inGBPxValue.toDouble(),
                pplAmount: 0,
              ),
            );
        },
        builder: (_, viewmodel) {
          final qrImage = Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor.withAlpha(0),
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(16),
              //   topRight: Radius.circular(16),
              //   bottomLeft: Radius.circular(16),
              //   bottomRight: Radius.circular(16),
              // ),
            ),
            child: QrImage(
              data: viewmodel.encodedUserId,
              backgroundColor: Theme.of(context).canvasColor,
              embeddedImage: Image.asset(
                ImagePaths.vegiSquareLogo,
              ).image,
              foregroundColor: themeShade1200,
              size: Math.min(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ) *
                  0.8,
            ),
          );
          return Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              //Scroll view given to Column
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Show a QR Code that a consumer or vendor can scan to transfer basket information
                  if (viewmodel.isSimulator)
                    GestureDetector(
                      child: qrImage,
                      onTap: () async {
                        await copyToClipboard(
                          viewmodel.encodedUserId,
                        );
                        await showInfoSnack(
                          context,
                          title: 'User Details copied to clipboard',
                        );
                      },
                    )
                  else
                    qrImage,
                  // SizedBox(height: 20),
                  // Text(
                  //   "Generate QR Code",
                  //   style: TextStyle(fontSize: 20),
                  // ),

                  // //TextField for input link
                  // TextField(
                  //   decoration:
                  //       InputDecoration(hintText: "Enter your link here..."),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   //Button for generating QR code
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors
                  //           .white, // ~ The backgroundColor and foregroundColor properties were introduced in Flutter 3.3. Prior to that, they were called primary and onPrimary.
                  //       foregroundColor: Colors.black,
                  //       fixedSize: const Size(120, 40),
                  //       textStyle:
                  //           const TextStyle(fontWeight: FontWeight.w900),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       padding: const EdgeInsets.all(15),
                  //     ),
                  //     onPressed: () async {
                  //       //a little validation for the textfield
                  //       if (qrdataFeed.text.isEmpty) {
                  //         setState(() {
                  //           qrData = "";
                  //         });
                  //       } else {
                  //         setState(() {
                  //           qrData = qrdataFeed.text;
                  //         });
                  //       }
                  //     },
                  //     //Title given on Button
                  //     child: Text(
                  //       "Generate QR Code",
                  //       style: TextStyle(
                  //         color: Colors.indigo[900],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
