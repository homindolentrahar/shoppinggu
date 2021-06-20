import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shoppinggu/ui/themes/theme.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: ColorPalette.black.withOpacity(0.75),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: ColorPalette.dark.withOpacity(0.5),
        highlightColor: ColorPalette.dark.withOpacity(0.3),
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Ionicons.arrow_back,
            color: ColorPalette.light,
          ),
        ),
      ),
    );
  }
}
