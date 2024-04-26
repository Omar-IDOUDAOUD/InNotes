import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/services/auth.dart';
import 'package:innotes/view/userdialog/dialog.dart';
import 'package:provider/provider.dart';

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
        preferredSize: Size(width, 70),
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
                        GestureDetector(
                          onTap: showUserDialog,
                          child: Hero(
                            tag: 'user-dialog-avatar-tag',
                            placeholderBuilder: (context, heroSize, child) =>
                                SizedBox.fromSize(
                              size: heroSize,
                              child: const Center(
                                child: Icon(
                                    FluentIcons.emoji_smile_slight_24_regular),
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Theme.of(context).cardColor,
                              radius: 25,
                              child: Icon(
                                FluentIcons.person_24_regular,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'Hi, ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _UserEditableName(),
                              ),
                            ],
                          ),
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

  void showUserDialog() {
    Navigator.push(context, UserDialogRoute());
  }
}

class _UserEditableName extends StatefulWidget {
  const _UserEditableName({super.key});

  @override
  State<_UserEditableName> createState() => __UserEditableNameState();
}

class __UserEditableNameState extends State<_UserEditableName> {
  late final TextEditingController _nameController;
  late final AuthenticationService _authenticationService;
  late final String _displayName;

  @override
  void initState() {
    super.initState();
    _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);

    _nameController = TextEditingController(
      text: _authenticationService.signedIn
          ? _authenticationService.user.displayName
          : _authenticationService.getDsiplayName(),
    );
    _displayName = _authenticationService.signedIn
        ? _authenticationService.user.displayName!
        : _authenticationService.getDsiplayName();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      onSubmitted: (name) {
        if (name.isEmpty) {
          _nameController.text = _displayName;
          return;
        }
        _authenticationService.updateDisplayName(name);
      },
      onTapOutside: (_) {
        _nameController.text = _displayName;
      },
      textInputAction: TextInputAction.done,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.1),
      decoration: InputDecoration(
        filled: false,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        isCollapsed: true,
        hintText: 'Provide a Name',
        contentPadding: EdgeInsets.zero,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              height: 1.1,
              color: Theme.of(context).hintColor,
            ),
      ),
    );
  }
}
