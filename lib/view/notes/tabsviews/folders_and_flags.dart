import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/constants/spaces.dart';

class FolderAndFlagsTabView extends StatelessWidget {
  const FolderAndFlagsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SpacesConsts.screenPadding,
      ),
      child: CustomScrollView(
        slivers: [
          FolderDirectoryBarSliver(),
          FolderGride(),
          _Flags(),
        ],
      ),
    );
  }
}

class FolderDirectoryBarSliver extends StatelessWidget {
  const FolderDirectoryBarSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.only(bottom: 10),
        sliver: SliverToBoxAdapter(child: FolderDirectoryBar()));
  }
}

class FolderDirectoryBar extends StatelessWidget {
  const FolderDirectoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              FluentIcons.chevron_left_24_regular,
              color: Colors.blueGrey,
              size: 15,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'My Notes > Important > Work',
                maxLines: 1,
                // overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                // textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.blueGrey,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FolderGride extends StatelessWidget {
  const FolderGride({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 16,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 80,
      ),
      itemBuilder: (context, index) => _Folder(),
    );
  }
}

class _Folder extends StatefulWidget {
  const _Folder({super.key});

  @override
  State<_Folder> createState() => __FolderState();
}

class __FolderState extends State<_Folder> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _selected = true;
        });
      },
      onTap: () {
        if (_selected)
          setState(() {
            _selected = false;
          });
      },
      child: AnimatedContainer(
        duration: AnimationConsts.defaultDuration,
        curve: AnimationConsts.curve,
        transform: Matrix4.identity()..scale(_selected ? 0.9 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: _selected ? Colors.indigo : Colors.indigo.withOpacity(0),
              width: 2),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FluentIcons.folder_16_regular,
                  color: Colors.blueGrey,
                  size: 25,
                ),
                Text(
                  'All Notes',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: AnimatedOpacity(
                opacity: _selected ? 1 : 0,
                duration: AnimationConsts.defaultDuration,
                curve: AnimationConsts.curve,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.indigo.withOpacity(.3),
                  child: Icon(
                    FluentIcons.checkmark_12_filled,
                    color: Colors.indigo,
                    size: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Flags extends StatelessWidget {
  const _Flags({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 15),
      sliver: SliverToBoxAdapter(
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flags',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _getFlagTile('No Flag', 2),
                Divider(height: 0, thickness: 0),
                _getFlagTile('Important', 3),
                Divider(height: 0, thickness: 0),
                _getFlagTile('To Do', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getFlagTile(String title, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
