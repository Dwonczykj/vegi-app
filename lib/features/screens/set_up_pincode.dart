import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vegan_liverpool/constants/analytics_events.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/utils/analytics.dart';

class SetUpPinCodeScreen extends StatefulWidget {
  const SetUpPinCodeScreen({
    required this.onSuccess,
    Key? key,
  }) : super(key: key);
  final void Function() onSuccess;
  @override
  State<SetUpPinCodeScreen> createState() => _SetUpPinCodeScreenState();
}

class _SetUpPinCodeScreenState extends State<SetUpPinCodeScreen> {
  final textEditingController = TextEditingController(text: '');
  final formKey = GlobalKey<FormState>();
  late StreamController<ErrorAnimationType> errorController;
  late String lastPinCode;
  bool isRetype = false;
  String currentText = '';
  FocusNode textNode = FocusNode();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    textNode = FocusNode();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).pincode,
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.height * .5,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 150,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    isRetype
                        ? I10n.of(context).re_type_passcode
                        : I10n.of(context).create_passcode,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: formKey,
                    child: SizedBox(
                      width: 250,
                      child: PinCodeTextField(
                        key: ValueKey("SetUpPincodeTextField"),
                        length: 6,
                        showCursor: false,
                        appContext: context,
                        enableActiveFill: true,
                        obscureText: true,
                        enablePinAutofill: false,
                        autoFocus: true,
                        focusNode: textNode,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        controller: textEditingController,
                        errorAnimationController: errorController,
                        pinTheme: PinTheme(
                          borderWidth: 4,
                          shape: PinCodeFieldShape.underline,
                          inactiveColor: const Color(0xFFDDDDDD),
                          inactiveFillColor: Theme.of(context).canvasColor,
                          selectedFillColor: Theme.of(context).canvasColor,
                          disabledColor: Theme.of(context).primaryColor,
                          selectedColor:
                              Theme.of(context).colorScheme.onSurface,
                          activeColor: Theme.of(context).colorScheme.onSurface,
                          activeFillColor: Theme.of(context).canvasColor,
                        ),
                        onCompleted: (pin) {
                          Analytics.track(
                            eventName: AnalyticsEvents.pincodeScreen,
                          );
                          if (isRetype && pin == lastPinCode) {
                            StoreProvider.of<AppState>(context)
                              ..dispatch(
                                SetSecurityType(
                                  biometricAuth: BiometricAuth.pincode,
                                ),
                              )
                              ..dispatch(SetPincodeSuccess(pin))
                              ..dispatch(
                                SetBiometricallyAuthenticated(
                                  isBiometricallyAuthenticated: true,
                                ),
                              )
                              ..dispatch(
                                SetCompletedOnboardingSuccess(
                                  onboardingCompleted: true,
                                ),
                              );
                            widget.onSuccess();
                          } else {
                            setState(() {
                              isRetype = true;
                              lastPinCode = pin;
                            });
                            textEditingController.clear();
                            textNode.requestFocus();
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
