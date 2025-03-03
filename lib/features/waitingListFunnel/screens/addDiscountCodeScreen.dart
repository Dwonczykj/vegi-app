import 'package:auto_route/annotations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan_liverpool/constants/enums.dart';
import 'package:vegan_liverpool/constants/theme.dart';
import 'package:vegan_liverpool/features/onboard/dialogs/signup.dart';
import 'package:vegan_liverpool/features/shared/widgets/my_scaffold.dart';
import 'package:vegan_liverpool/features/shared/widgets/primary_button.dart';
import 'package:vegan_liverpool/features/shared/widgets/snackbars.dart';
import 'package:vegan_liverpool/features/veganHome/Helpers/extensions.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/dialogs/backHomeDialog.dart';
import 'package:vegan_liverpool/features/waitingListFunnel/widgets/continueWithoutDiscountCodeDialog.dart';
import 'package:vegan_liverpool/generated/l10n.dart';
import 'package:vegan_liverpool/models/app_state.dart';
import 'package:vegan_liverpool/redux/actions/user_actions.dart';
import 'package:vegan_liverpool/redux/viewsmodels/waitingListFunnel/addDiscountCodeViewModel.dart';
import 'package:vegan_liverpool/services.dart';
import 'package:vegan_liverpool/utils/constants.dart';
import 'package:vegan_liverpool/utils/url.dart';

typedef AddDiscountCode = void Function(
  String,
  void Function() onSuccess,
  void Function(dynamic error) onError,
);

@RoutePage()
class AddDiscountCodeScreen extends StatefulWidget {
  const AddDiscountCodeScreen({
    required this.onVerifyDiscountCode,
    Key? key,
  }) : super(key: key);

  final void Function() onVerifyDiscountCode;

  @override
  State<AddDiscountCodeScreen> createState() => _AddDiscountCodeScreenState();
}

class _AddDiscountCodeScreenState extends State<AddDiscountCodeScreen>
    with SingleTickerProviderStateMixin {
  final discountCodeController = TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();

  bool notifyMeWhenLaunch = true;

  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    opacityAnimation = Tween<double>(begin: 0, end: 0.4).animate(
      CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
    );
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller
      ..addListener(() {
        setState(() {});
      })
      ..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Add voucher',
      body: StoreConnector<AppState, AddDiscountCodeViewModel>(
        onInit: (store) {},
        distinct: true,
        onWillChange: (previousViewModel, newViewModel) {
          if (newViewModel.cartErrorDetails != null &&
              newViewModel.cartErrorDetails !=
                  previousViewModel?.cartErrorDetails) {
            final err = newViewModel.cartErrorDetails!;
            if (err.code != null) {
              if (err.code == CartErrCode.invalidDiscountCode) {
                showErrorSnack(
                  context: context,
                  title: err.title,
                  message: err.message,
                );
              } else if (err.code == CartErrCode.failedToRegisterDiscountCode) {
                showErrorSnack(
                  context: context,
                  title: err.title,
                  message: err.message,
                );
              } else if (err.code ==
                  CartErrCode.failedToRegisterEmailForNotifications) {
                showErrorSnack(
                  context: context,
                  title: Messages.unableToRegisterEmailForNotifications,
                );
              }
            }
          } else if (newViewModel.voucherPotValue.value !=
              previousViewModel?.voucherPotValue.value) {
            discountCodeController.clear();
            showInfoSnack(
              context,
              title: 'Voucher applied',
              backgroundColor: themeShade500,
            );
            showDialog<BackHomeDialog>(
              context: context,
              builder: (context) => const BackHomeDialog(
                cancelButtonIcon: FontAwesomeIcons.pencil,
                cancelButtonName: 'Add more',
              ),
            );
          }
        },
        converter: AddDiscountCodeViewModel.fromStore,
        builder: (context, viewModel) {
          final deviceSize = MediaQuery.of(context).size;
          return ColoredBox(
            color: Colors.grey[300]!,
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        // color: Colors.blue,
                        // width: 300.0,
                        height: 200,
                        padding: const EdgeInsets.only(
                          top: 20,
                          right: 20,
                          left: 20,
                        ),
                        alignment: Alignment.topRight,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                viewModel.fetchBalance();
                              },
                              child: Container(
                                //Change to FractionallySized

                                width: (deviceSize.aspectRatio <= 1
                                        ? deviceSize.width
                                        : deviceSize.height) *
                                    0.4,
                                height: (deviceSize.aspectRatio <= 1
                                        ? deviceSize.width
                                        : deviceSize.height) *
                                    0.4,
                                decoration: const BoxDecoration(
                                  color: themeShade600,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        AutoSizeText(
                                          // viewModel.voucherPotValue
                                          //     .formattedPriceNoDecimals,
                                          viewModel.gbtTokens.getFiatBalanceFormatted(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 80,
                                            fontFamily: Fonts.fatFace,
                                          ),
                                          maxLines: 1,
                                          maxFontSize: 100,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        AutoSizeText(
                                          '${viewModel.gbtBalanceFormatted} GBT',
                                          style: TextStyle(
                                            color: Colors.green[900] ??
                                                Colors.green,
                                            fontSize: 30,
                                            fontFamily: Fonts.fatFace,
                                          ),
                                          maxLines: 1,
                                          maxFontSize: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: AutoSizeText(
                              Messages.addVoucherCode,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color ??
                                    Colors.black,
                                // color: Theme.of(context).textTheme.bodySmall?.color ??
                                //     Colors.white,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 30,
                              right: 30,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: 280,
                                    // decoration: BoxDecoration(
                                    //   border: Border(
                                    //     bottom: BorderSide(
                                    //       color: Theme.of(context)
                                    //           .colorScheme
                                    //           .onSurface,
                                    //       width: 2,
                                    //     ),
                                    //   ),
                                    // ),
                                    child: ScaleTransition(
                                      scale: scaleAnimation,
                                      child: TextFormField(
                                        controller: discountCodeController,
                                        keyboardType: TextInputType.text,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        autofocus: true,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        onTapOutside: (event) {
                                          FocusScope.of(context).unfocus();
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return Messages
                                                .addVoucherCodeCodeCantBeEmpty;
                                          }
                                          return null;
                                        },
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .labelMedium
                                                  ?.color ??
                                              Colors.black,
                                        ),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 20,
                                            horizontal: 10,
                                          ),
                                          hintText: Messages.voucherCode,
                                          // hintStyle: TextStyle(
                                          //   decorationStyle: TextAlign.center,
                                          // ),
                                          fillColor: themeLightShade300,
                                          // border: InputBorder.none,
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          errorStyle: TextStyle(
                                            color: themeRedShadeErrText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  PrimaryButton(
                                    label: Labels.submit,
                                    preload: viewModel.cartIsLoading,
                                    disabled: viewModel.cartIsLoading,
                                    onPressed: () {
                                      final isValid =
                                          _formKey.currentState!.validate();
                                      if (!isValid) {
                                        return;
                                      }
                                      final String code =
                                          discountCodeController.text;
                                      if (code.isNotEmpty) {
                                        if (viewModel.voucherAlreadyApplied(
                                          code: code,
                                        )) {
                                          showErrorSnack(
                                            context: context,
                                            title: 'Voucher already applied',
                                            message: '',
                                          );
                                          return;
                                        }
                                        viewModel.acceptVoucherCode(
                                          code: code,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          // const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: AutoSizeText.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: CopyWrite.collectCreditForEcoProducts,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[850],
                                    ),
                                  ),
                                ],
                              ),
                              minFontSize: 16,
                              maxFontSize: 20,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => launchUrl(VEGI_FAQs_URL),
                            child: const Text(
                              Labels.fullDetailsAndFAQsLinkLabel,
                              style: TextStyle(
                                color: themeAccent600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ColoredBox(
                            color: Colors.transparent,
                            child: CupertinoFormRow(
                              prefix: Row(
                                children: <Widget>[
                                  Icon(
                                    // Wifi icon is updated based on switch value.
                                    notifyMeWhenLaunch
                                        ? Icons.notification_add
                                        : Icons.notifications_off,
                                    color: notifyMeWhenLaunch
                                        ? CupertinoColors.systemGreen
                                        : CupertinoColors.systemGrey,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    notifyMeWhenLaunch
                                        ? Labels.notifyMeWhenYouRelease
                                        : Labels.dontNotifyMeWhenYouRelease,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              helper: Text(
                                notifyMeWhenLaunch
                                    ? Messages.willEmailOnceLive
                                    : '',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              child: CupertinoSwitch(
                                // This bool value toggles the switch.
                                value: notifyMeWhenLaunch,
                                thumbColor: notifyMeWhenLaunch
                                    ? themeShade600
                                    : themeShade600.withOpacity(0.5),
                                trackColor: notifyMeWhenLaunch
                                    ? CupertinoColors.systemGrey
                                        .withOpacity(0.95)
                                    : CupertinoColors.systemGrey
                                        .withOpacity(0.15),
                                activeColor: themeShade650.withOpacity(0.50),
                                onChanged: (bool? value) {
                                  // This is called when the user toggles the switch
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    notifyMeWhenLaunch = value;
                                  });
                                  viewModel.subscribeToEmailToNotifications(
                                    receiveNotifications: value,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
