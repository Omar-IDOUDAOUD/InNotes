import 'package:flutter/material.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/view/shared/appbar_under_scrollfade_box.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final unselectedLabelColor = Theme.of(context).primaryColor.withOpacity(.5);
    final selectedLabelColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      toolbarHeight: 0,
      pinned: true,
      elevation: 0,
      forceMaterialTransparency: true,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 72),
        child: Column(
          children: [
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                controller: controller,
                labelColor: selectedLabelColor,
                unselectedLabelColor: unselectedLabelColor,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w700),
                unselectedLabelStyle: Theme.of(context).textTheme.bodySmall!,
                isScrollable: true,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
                splashBorderRadius: BorderRadius.circular(0),
                overlayColor:
                    MaterialStatePropertyAll(Theme.of(context).splashColor),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 0,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.only(
                  top: 15,
                  right: SpacesConsts.screenPadding - 5,
                  left: SpacesConsts.screenPadding - 5,
                  bottom: 5,
                ),
                tabs: const [
                  _Tab(label: 'All (50)'),
                  _Tab(label: 'Folders & Flags'),
                  _Tab(label: 'To Do'),
                  _Tab(label: 'Notes'),
                  _Tab(label: 'Blogs'),
                ],
              ),
            ),
            AppBarUnderScrollFaceBox(),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 35,
      child: SizedBox(
        height: 35,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(.5),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}





/// flags (note, impor, to do, blog, urgent )
/// folders