import 'package:flutter/material.dart';
import 'package:vegan_liverpool/constants/theme.dart';

class VegiDialogButton extends StatelessWidget {
  const VegiDialogButton({
    required this.label, required this.onPressed, Key? key,
    this.icon,
    this.disabled = false,
    this.dangerButton = false,
  }) : super(key: key);

  final String label;
  final IconData? icon;
  final void Function() onPressed;
  final bool disabled;
  final bool dangerButton;

  @override
  Widget build(BuildContext context) {
    final buttonLabelColour =
        disabled ? const Color(0xFF797979) : Colors.white;
    const buttonLabelFontSize = 30.0;
    final buttonBackgroundColor = dangerButton
        ? disabled
            ? themeShade800
            : themeAccent600
        : disabled
            ? themeShade900
            : Theme.of(context).colorScheme.primary;
    return Container(
      width: 255,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: disabled ? () {} : onPressed,
        style: dangerButton
            ? ElevatedButton.styleFrom(backgroundColor: themeShade1100)
            : ElevatedButton.styleFrom(backgroundColor: themeShade600),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: buttonLabelColour,
                    fontSize: buttonLabelFontSize * 0.75,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            // const SizedBox(
            //   width: 16,
            // ),
            if(icon != null)
              Icon(
                icon, //Icons.sms
                color: buttonLabelColour,
                size: buttonLabelFontSize,
              ),
          ],
        ),
      ),
    );
  }
}
