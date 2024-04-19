import 'package:flutter/material.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/view/shared/appbar_under_scrollfade_box.dart';

final _unselectedLabelColor = Colors.blueGrey.withOpacity(.5);
const _selectedLabelColor = Colors.blueGrey;

class Tabs extends StatelessWidget {
  const Tabs({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                controller: controller,
                labelColor: Colors.white,
                unselectedLabelColor: _unselectedLabelColor,
                labelStyle: const TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                isScrollable: true,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _selectedLabelColor,
                ),
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
            border: Border.all(color: _unselectedLabelColor, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}





/// flags (note, impor, to do, blog, urgent )
/// folders