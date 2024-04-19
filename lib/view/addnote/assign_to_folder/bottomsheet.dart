import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/view/notes/addfolder/botomsheet.dart';
import 'package:innotes/view/notes/tabsviews/folders_and_flags.dart'
    as homePageFoldersTab;
import 'package:innotes/view/shared/appbar_under_scrollfade_box.dart';
import 'package:innotes/view/shared/bottomsheet_bar_handler.dart';

Future showAssignToFolderBottomsheet(
    BuildContext context, AnimationController animation) async {
  final result = await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    transitionAnimationController: animation,
    builder: (_) {
      return DraggableScrollableSheet(
        minChildSize: .5,
        maxChildSize: .8,
        expand: false,
        builder: (context, scrollController) =>
            _Content(controller: scrollController),
      );
    },
  );
  return result;
}

class _Content extends StatefulWidget {
  const _Content({super.key, required this.controller});
  final ScrollController controller;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content>
    with SingleTickerProviderStateMixin {
  AnimationController? __addFolderBsAnimation;
  AnimationController get _addFolderBsAnimation {
    __addFolderBsAnimation ??= BottomSheet.createAnimationController(this)
      ..duration = AnimationConsts.bottomSheetAnimationDuration
      ..drive(
        CurveTween(curve: AnimationConsts.curve),
      );
    return __addFolderBsAnimation!;
  }

  @override
  void dispose() {
    __addFolderBsAnimation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SpacesConsts.screenPadding, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetDragHandlerBar(),
              Expanded(
                child: CustomScrollView(
                  controller: widget.controller,
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      titleSpacing: 0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      title: Text(
                        'Select folder',
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                      toolbarHeight: 50,
                      floating: true,
                      actions: [
                        GestureDetector(
                            onTap: () {
                              showAddFolderBottomsheet(
                                  context, _addFolderBsAnimation);
                            },
                            child: Icon(FluentIcons.folder_add_24_regular)),
                      ],
                    ),
                    SliverAppBar(
                      toolbarHeight: 0,
                      pinned: true,
                      elevation: 0,
                      forceMaterialTransparency: true,
                      bottom: PreferredSize(
                        preferredSize: const Size(double.infinity, 56),
                        child: Column(
                          children: [
                            ColoredBox(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: homePageFoldersTab.FolderDirectoryBar(),
                            ),
                            AppBarUnderScrollFaceBox(),
                          ],
                        ),
                      ),
                    ),
                    homePageFoldersTab.FolderGride()
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(SpacesConsts.screenPadding),
            child: FloatingActionButton(
              tooltip: 'put on this destination',
              onPressed: () {},
              child: Icon(
                FluentIcons.checkmark_24_regular,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
