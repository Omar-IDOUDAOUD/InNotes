import 'dart:math';

import 'package:flutter/material.dart';

abstract class LoadingCardsComponents {
  static Widget getLoadingBox({
    double borderRadius = 5,
    double height = 10,
    required double widthFraction,
    required double colorLerpValue,
    Alignment alignment = Alignment.topLeft,
  }) {
    return FractionallySizedBox(
      widthFactor: widthFraction,
      alignment: alignment,
      child: SizedBox(
        height: height,
        child: getDecoratedBox(
          colorLerpValue: colorLerpValue,
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  static Widget getDecoratedBox(
      {double borderRadius = 5, required double colorLerpValue}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Color.lerp(
          Colors.grey.shade300,
          Colors.grey.shade400,
          colorLerpValue,
        ),
      ),
    );
  }

  static double generateWidthFraction({maxFraction = 1}) {
    late double w;
    do {
      w = Random.secure().nextDouble() * maxFraction;
    } while (w < 0.3);

    return w;
  }
}
