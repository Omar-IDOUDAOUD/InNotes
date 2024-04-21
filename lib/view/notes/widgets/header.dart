import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/constants/spaces.dart';

class Header extends StatefulWidget {
  const Header(
      {super.key,
      required this.onSearchStateChange,
      required this.searchState});
  final Function(bool) onSearchStateChange;
  final bool searchState;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SliverAppBar(
      toolbarHeight: 0,
      floating: true,
      elevation: 0,
      forceMaterialTransparency: true,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(SpacesConsts.screenPadding,
                  SpacesConsts.screenPadding, SpacesConsts.screenPadding, 0),
              child: Stack(
                children: [
                  AnimatedScale(
                    duration: AnimationConsts.defaultDuration,
                    curve: AnimationConsts.curve,
                    scale: widget.searchState ? 0.8 : 1,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).cardColor,
                          radius: 25,
                          child: Icon(
                            FluentIcons.person_24_regular,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          'Hi, Omar',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  AnimatedPositioned(
                    width: widget.searchState
                        ? width - SpacesConsts.screenPadding * 2
                        : 50,
                    height: 50,
                    right: 0,
                    duration: AnimationConsts.defaultDuration,
                    curve: AnimationConsts.curve,
                    onEnd: () {
                      if (widget.searchState) {
                        _searchFocusNode.requestFocus();
                        //switch to "all notes" tab
                      }
                    },
                    child: GestureDetector(
                      onTap: () {
                        widget.onSearchStateChange(!widget.searchState);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(width: 12.5),
                            const Icon(FluentIcons.search_24_regular),
                            const SizedBox(width: 13),
                            if (widget.searchState) ...[
                              Expanded(
                                child: TextField(
                                  focusNode: _searchFocusNode,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  decoration: const InputDecoration(
                                    hintText: 'My Note',
                                    contentPadding: EdgeInsets.only(right: 25),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    filled: false,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
