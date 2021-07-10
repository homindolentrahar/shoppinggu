import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppinggu/ui/themes/theme.dart';

class AppFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? initialValue;
  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextInputAction action;
  final TextInputType keyboardType;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const AppFormField({
    Key? key,
    this.focusNode,
    required this.hintText,
    this.initialValue,
    required this.icon,
    this.maxLines = 1,
    this.action = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.onSubmit,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 48,
            decoration: BoxDecoration(
              color: ColorPalette.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Icon(
              icon,
              color: ColorPalette.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              focusNode: focusNode,
              controller: controller,
              textInputAction: action,
              keyboardType: keyboardType,
              onFieldSubmitted: onSubmit,
              onEditingComplete: onEditingComplete,
              onSaved: onSaved,
              validator: validator,
              maxLines: maxLines,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: ColorPalette.dark.withOpacity(0.75)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
