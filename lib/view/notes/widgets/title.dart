import 'package:flutter/material.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/constants/spaces.dart';

class Title_ extends StatelessWidget {
  const Title_({super.key, required this.searchState});
  final bool searchState;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
          SpacesConsts.screenPadding, 15, SpacesConsts.screenPadding, 0),
      sliver: SliverToBoxAdapter(
        child: AnimatedSwitcher(
          duration: AnimationConsts.defaultDuration,
          switchInCurve: AnimationConsts.curve,
          switchOutCurve: AnimationConsts.curve.flipped,
          layoutBuilder: (currentChild, previousChildren) => Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          ),
          transitionBuilder: (child, animation) => DualTransitionBuilder(
            animation: animation,
            forwardBuilder: (context, animation, child) => SlideTransition(
              position: animation.drive(
                Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero),
              ),
              child: child,
            ),
            reverseBuilder: (context, animation, child) => SlideTransition(
              position: animation.drive(
                Tween<Offset>(begin: Offset.zero, end: Offset(0, -0.2)),
              ),
              child: child,
            ),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: Text(
            searchState ? 'Search' : 'My Notes',
            key: ValueKey(searchState),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
