import 'package:flutter/material.dart';
import 'package:innotes/constants/spaces.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelStyle: Theme.of(context)
      
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.w700),
      labelColor: Theme.of(context).scaffoldBackgroundColor,
      unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      dividerHeight: 0,
      splashBorderRadius: BorderRadius.circular(25),
      // indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
      tabs: const [
        Tab(
          height: 45,
          text: 'Log in',
        ),
        Tab(
          text: 'Sign up',
          height: 45,
        ),
      ],
    );
  }
}
