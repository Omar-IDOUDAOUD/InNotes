// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:innotes/constants/animation.dart';
import 'package:provider/provider.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:innotes/constants/spaces.dart';
import 'package:innotes/controller/addnote/toolbar.dart';

class FloatingToolbar_ extends StatefulWidget {
  const FloatingToolbar_(
      {super.key, required this.controller, required this.test});
  final Function() test;

  final QuillController controller;

  @override
  State<FloatingToolbar_> createState() => _FloatingToolbar_State();
}

class _FloatingToolbar_State extends State<FloatingToolbar_> {
  // QuillController get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    final toolbarController =
        Provider.of<ToolbarController>(context, listen: true);
    final showExtraToolbar = toolbarController.extraToolbar != null;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: KeyboardVisibilityBuilder(
        builder: (_, isKeyboardVisible) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedSwitcher(
                layoutBuilder: (currentChild, previousChildren) => Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                ),
                switchInCurve: AnimationConsts.curve,
                switchOutCurve: AnimationConsts.curve.flipped,
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => DualTransitionBuilder(
                  animation: animation,
                  forwardBuilder: (context, animation, child) =>
                      SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero),
                    ),
                    child: child,
                  ),
                  reverseBuilder: (context, animation, child) =>
                      SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(begin: Offset.zero, end: Offset(0, -0.2)),
                    ),
                    child: child,
                  ),
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: showExtraToolbar
                    ? _ButtonList(
                        buttons: toolbarController.extraToolbar!,
                        key: ValueKey(toolbarController.extraToolbar),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.only(right: SpacesConsts.screenPadding),
                        child: FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.blueGrey,
                          heroTag: 'AddNoteButtonHero',
                          elevation: 0,
                          child: Icon(
                            FluentIcons.add_24_regular,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              _ButtonList(buttons: toolbarController.toolbar),
              const SizedBox(height: SpacesConsts.screenPadding),
            ],
          );
        },
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({super.key, required this.button});
  final ToolbarButton button;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: button.onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: button.horizontalPadding),
        child: button.icon,
      ),
    );
  }
}

class _ButtonList extends StatelessWidget {
  const _ButtonList({super.key, required this.buttons});
  final List<ToolbarButton> buttons;

  @override
  Widget build(BuildContext context) {
    // return _Button(icon: Icons.abc);

    return SingleChildScrollView(
      reverse: true,
      padding:
          const EdgeInsets.symmetric(horizontal: SpacesConsts.screenPadding),
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.grey.shade200,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: List.generate(
            buttons.length,
            (index) {
              final btnCell = buttons.elementAt(index);
              if (btnCell.hasDividerToLeft)
                return Row(
                  children: [
                    _Button(button: btnCell),
                    _divider(),
                  ],
                );
              return _Button(button: btnCell);
            },
          ),
        ),
      ),
    );
  }

  _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: 1,
        height: 15,
        child: ColoredBox(color: Colors.blueGrey.withOpacity(.5)),
      ),
    );
  }
}

class LinkDialog extends StatefulWidget {
  const LinkDialog({super.key, this.selectedText});
  final String? selectedText;

  @override
  State<LinkDialog> createState() => _LinkDialogState();
}

class _LinkDialogState extends State<LinkDialog> {
  late final TextEditingController _controller1;
  late final TextEditingController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController(text: widget.selectedText);
    _controller2 = TextEditingController();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Link'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller1,
              style: Theme.of(context).textTheme.bodySmall,
              keyboardType: TextInputType.text,
              validator: (str) => str!.isEmpty ? 'No name found!' : null,
              decoration: InputDecoration(
                hintText: 'Please enter a text for your link',
              ),
              autofocus: true,
              textInputAction: TextInputAction.next,
              autofillHints: [
                AutofillHints.name,
                AutofillHints.url,
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              validator: (str) =>
                  GetUtils.isURL(str ?? '') ? null : 'No link found!',
              style: Theme.of(context).textTheme.bodySmall,
              controller: _controller2,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                hintText: 'Please enter the link url',
              ),
              textInputAction: TextInputAction.done,
              autofillHints: [AutofillHints.url],
              autocorrect: false,
              onEditingComplete: submit,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('back'),
        ),
        TextButton(
          onPressed: submit,
          child: Text("Apply"),
        ),
      ],
    );
  }

  void submit() {
    final valid = _formKey.currentState!.validate();
    if (valid)
      Navigator.pop(
          context, {'name': _controller1.text, 'link': _controller2.text});
  }
}
