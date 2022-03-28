import 'package:bolc/ui/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({Key? key, required this.value, required this.onTap})
      : super(key: key);

  final bool value;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
            color: value ? themeData.colorScheme.primary : null,
            borderRadius: BorderRadius.circular(12),
            border: !value ? Border.all(color: secondaryTextColor) : null),
        child: value
            ? Icon(
                CupertinoIcons.checkmark_alt,
                color: themeData.colorScheme.onPrimary,
                size: 18,
              )
            : null,
      ),
    );
  }
}
