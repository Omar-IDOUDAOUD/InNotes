import 'package:flutter/animation.dart';

abstract class AnimationConsts {
  static const Duration bottomSheetAnimationDuration =
      Duration(milliseconds: 300);
  static const Curve curve = Curves.linearToEaseOut;
  static const Duration defaultDuration = Duration(milliseconds: 300);

  static const Duration loadingDuration = Duration(milliseconds: 300);
}
