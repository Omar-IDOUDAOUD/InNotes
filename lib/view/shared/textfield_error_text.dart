import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:innotes/constants/animation.dart';

class TextFieldErrorText extends StatelessWidget {
  const TextFieldErrorText({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AnimationConsts.defaultDuration,
      curve: AnimationConsts.curve,
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).colorScheme.error),
            ),
          ),
          Icon(
            FluentIcons.error_circle_24_regular,
            color: Theme.of(context).colorScheme.error,
            size: 15,
          ),
        ],
      ),
    );
  }
}
