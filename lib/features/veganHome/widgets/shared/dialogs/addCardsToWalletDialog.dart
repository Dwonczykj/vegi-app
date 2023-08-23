import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/vegiDialog.dart';
import 'package:vegan_liverpool/features/veganHome/widgets/shared/vegiDialogButton.dart';
import 'package:vegan_liverpool/services.dart';

class AddCardsToWalletDialog extends StatefulWidget {
  const AddCardsToWalletDialog({
    this.cancelButtonName = 'Cancel',
    this.cancelButtonIcon = FontAwesomeIcons.ban,
    Key? key,
  }) : super(key: key);

  final String cancelButtonName;
  final IconData cancelButtonIcon;

  @override
  State<AddCardsToWalletDialog> createState() => _AddCardsToWalletDialogState();
}

class _AddCardsToWalletDialogState extends State<AddCardsToWalletDialog> {
  @override
  Widget build(BuildContext context) {
    return VegiDialog(
      storeConverter: (store) {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Set up Wallet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 15),
          VegiDialogButton(
            label: 'Ok',
            icon: FontAwesomeIcons.wallet,
            onPressed: () => stripeService.instance.openApplePaySetup(),
          ),
          // const SizedBox(height: 15),
          VegiDialogButton(
            label: widget.cancelButtonName,
            icon: widget.cancelButtonIcon,
            onPressed: () => context.router.pop(),
          ),
        ],
      ),
    );
  }
}
