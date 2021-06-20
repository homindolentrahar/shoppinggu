import 'package:flutter/material.dart';

class SecondaryActionButton extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final VoidCallback onPressed;

  const SecondaryActionButton({
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
      color: Colors.transparent,
      splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconData != null
              ? Row(
                  children: [
                    Icon(
                      iconData,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 16)
                  ],
                )
              : const SizedBox.shrink(),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
