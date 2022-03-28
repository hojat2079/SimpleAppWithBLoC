import 'package:bolc/ui/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriorityItem extends StatelessWidget {
  const PriorityItem(
      {Key? key,
      required this.title,
      required this.color,
      required this.isChecked,
      required this.onTap})
      : super(key: key);

  final String title;
  final Color color;
  final bool isChecked;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: secondaryTextColor.withOpacity(0.2))),
        child: Stack(
          children: [
            Center(
                child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(8)),
                  child: isChecked
                      ? Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 12,
                        )
                      : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
