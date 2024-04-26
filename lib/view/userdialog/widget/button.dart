import 'package:flutter/material.dart';

class ButtonTile extends StatelessWidget {
  const ButtonTile(
      {super.key,
      required this.prefix,
      required this.child,
      this.suffix,
      this.onTap});
  final Widget prefix;
  final Widget child;
  final Widget? suffix;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: prefix,
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          child,
          if (suffix != null) suffix!,
        ],
      ),
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        iconColor: MaterialStatePropertyAll(Theme.of(context).hintColor),
        // iconSize: MaterialStatePropertyAll(30),

        textStyle:
            MaterialStatePropertyAll(Theme.of(context).textTheme.bodyMedium),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 15,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
    // MaterialButton(
    //   onPressed: onTap,
    //   shape:,
    // );
  }
}
