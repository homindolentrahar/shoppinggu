import 'package:flutter/material.dart';
import 'package:shoppinggu/ui/themes/theme.dart';

class PrimaryActionButton extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;

  const PrimaryActionButton({
    Key? key,
    required this.text,
    this.iconData,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      highlightElevation: 0,
      height: 64,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconData != null
              ? Row(
                  children: [
                    Icon(iconData, color: ColorPalette.dark),
                    const SizedBox(width: 16)
                  ],
                )
              : const SizedBox.shrink(),
          Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
