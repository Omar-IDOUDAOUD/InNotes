import 'package:flutter/material.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/view/shared/loading_card_components.dart';

class LoadingCard extends StatefulWidget {
  const LoadingCard({super.key, required this.index});
  final int index;

  @override
  State<LoadingCard> createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationCtrl;

  @override
  void initState() {
    super.initState();
    _animationCtrl = AnimationController(
        vsync: this, duration: AnimationConsts.loadingDuration)
      ..addListener(() {
        setState(() {});
      });
    _animationCtrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: LoadingCardsComponents.getDecoratedBox(
          borderRadius: 15, colorLerpValue: _animationCtrl.value),
    );
  }
}
