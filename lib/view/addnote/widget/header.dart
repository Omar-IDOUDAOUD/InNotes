import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/model/flag.dart';
import 'package:innotes/view/addnote/addflag/bottomsheet.dart';
import 'package:innotes/view/addnote/assign_to_folder/bottomsheet.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SpacesConsts.screenPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              radius: 25,
              child: Icon(
                FluentIcons.chevron_left_24_regular,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          _AssignToFolder(),
          FlagButton(),
        ],
      ),
    );
  }
}

class _AssignToFolder extends StatefulWidget {
  const _AssignToFolder({
    super.key,
  });

  @override
  State<_AssignToFolder> createState() => _AssignToFolderState();
}

class _AssignToFolderState extends State<_AssignToFolder>
    with SingleTickerProviderStateMixin {
  AnimationController? __assignToFolderBsAnimation;
  AnimationController get _assignToFolderBsAnimation {
    __assignToFolderBsAnimation ??= BottomSheet.createAnimationController(this)
      ..duration = AnimationConsts.bottomSheetAnimationDuration
      ..drive(
        CurveTween(curve: AnimationConsts.curve),
      );
    return __assignToFolderBsAnimation!;
  }

  @override
  void dispose() {
    __assignToFolderBsAnimation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          showAssignToFolderBottomsheet(context, _assignToFolderBsAnimation),
      child: SizedBox(
        height: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Icon(
                //   FluentIcons.folder_add_24_regular,
                //   size: 15,
                //   color: Colors.blueGrey,
                // ),
                // SizedBox(width: 5),
                Text(
                  'Assigne To Folder',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                ),
                SizedBox(width: 5),
                Icon(
                  FluentIcons.chevron_down_24_regular,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FlagButton extends StatefulWidget {
  const FlagButton({
    super.key,
  });

  @override
  State<FlagButton> createState() => _FlagButtonState();
}

class _FlagButtonState extends State<FlagButton>
    with SingleTickerProviderStateMixin {
  AnimationController? __addFlagAnimation;
  AnimationController get _addFlagAnimation {
    __addFlagAnimation ??= BottomSheet.createAnimationController(this)
      ..duration = AnimationConsts.bottomSheetAnimationDuration
      ..drive(
        CurveTween(curve: AnimationConsts.curve),
      );
    return __addFlagAnimation!;
  }

  @override
  void dispose() {
    __addFlagAnimation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMenu,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).cardColor,
        radius: 25,
        child: Icon(
          FluentIcons.flag_24_regular,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  void _showMenu() {
    final size = MediaQuery.sizeOf(context);

    showMenu(
        context: context,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Theme.of(context).cardColor,
        position: RelativeRect.fromDirectional(
          textDirection: TextDirection.rtl,
          start: SpacesConsts.screenPadding,
          top: SpacesConsts.screenPadding + 50 + 10,
          end: SpacesConsts.screenPadding + 1,
          bottom: SpacesConsts.screenPadding,
        ),
        constraints: BoxConstraints(maxWidth: size.width * 0.40),
        items: [
          _PopupMenuItem(
            onTap: () {},
            flag: null,
          ),
          _PopupMenuItem(
            onTap: () {},
            flag: Flag(name: 'To Do', color: Colors.green),
          ),
          _PopupMenuItem(
            onTap: () {},
            flag: Flag(name: 'Blogs', color: Colors.blueAccent),
          ),
          _PopupMenuItem(
            onTap: () {},
            flag: Flag(name: 'Important', color: Colors.redAccent),
          ),
          _PopupMenuItem(
            onTap: () {
              showAddFlagBottomsheet(context, _addFlagAnimation);
            },
            isAddFlagButton: true,
          ),
        ]);
  }
}

class _PopupMenuItem<T> extends PopupMenuEntry<T> {
  _PopupMenuItem({
    required this.onTap,
    this.flag,
    this.isAddFlagButton = false,
  });

  final Flag? flag;
  final Function() onTap;
  final isAddFlagButton;

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(T? value) => false;

  @override
  State<StatefulWidget> createState() => __PopupMenuItemState();
}

class __PopupMenuItemState extends State<_PopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                if (widget.isAddFlagButton)
                  Icon(
                    FluentIcons.add_24_regular,
                    size: 17,
                  )
                else if (widget.flag == null)
                  Icon(
                    FluentIcons.flag_24_regular,
                    size: 17,
                  )
                else
                  Icon(
                    FluentIcons.flag_24_filled,
                    color: widget.flag!.color,
                    size: 17,
                  ),
                SizedBox(width: 12),
                Text(
                  widget.isAddFlagButton
                      ? 'New Flag'
                      : (widget.flag?.name) ?? 'No Flag',
                  style: Theme.of(context).textTheme.displayLarge,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
