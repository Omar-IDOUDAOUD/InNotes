// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/providers/addnote/new_note.dart';
import 'package:innotes/view/notes/home.dart';
import 'package:provider/provider.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:innotes/constants/spaces.dart';
import 'package:innotes/providers/addnote/toolbar.dart';

class FloatingToolbar2 extends StatefulWidget {
  const FloatingToolbar2({super.key});

  @override
  State<FloatingToolbar2> createState() => _FloatingToolbarState();
}

class _FloatingToolbarState extends State<FloatingToolbar2> {
  @override
  Widget build(BuildContext context) {
    final toolbarController =
        Provider.of<ToolbarProvider>(context, listen: true);
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
                      Tween<Offset>(
                          begin: const Offset(0, 0.2), end: Offset.zero),
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
                    : const Padding(
                        padding:
                            EdgeInsets.only(right: SpacesConsts.screenPadding),
                        child: _AddButton(),
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

class _AddButton extends StatefulWidget {
  const _AddButton({super.key});

  @override
  State<_AddButton> createState() => __AddButtonState();
}

class __AddButtonState extends State<_AddButton> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _loading
          ? null
          : () async {
              final provider = context.read<CreateNoteProvider>();
              setState(() {
                _loading = true;
              });
              await provider.submitNote().then((value) {
                setState(() {
                  _loading = false;
                });
                Navigator.pop(context, true);
              });
            },
      heroTag: addNoteButtonHeroTag,
      elevation: 0,
      child: _loading
          ? SizedBox.square(
              dimension: 25,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                strokeCap: StrokeCap.round,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            )
          : Icon(
              FluentIcons.add_24_regular,
              color: Theme.of(context).colorScheme.background,
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
    return SingleChildScrollView(
      reverse: true,
      padding:
          const EdgeInsets.symmetric(horizontal: SpacesConsts.screenPadding),
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Theme.of(context).cardColor,
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
                    _divider(context),
                  ],
                );
              return _Button(button: btnCell);
            },
          ),
        ),
      ),
    );
  }

  _divider(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: 1,
        height: 15,
        child: ColoredBox(color: Theme.of(context).hintColor),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Link name',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _controller1,
              style: Theme.of(context).textTheme.bodySmall,
              keyboardType: TextInputType.text,
              validator: (str) => str!.isEmpty ? 'No name found!' : null,
              decoration: const InputDecoration(
                hintText: 'Please enter a text for your link',
              ),
              autofocus: true,
              textInputAction: TextInputAction.next,
              autofillHints: const [
                AutofillHints.name,
                AutofillHints.url,
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Link Url',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (str) =>
                  GetUtils.isURL(str ?? '') ? null : 'No link found!',
              style: Theme.of(context).textTheme.bodySmall,
              controller: _controller2,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                hintText: 'Please enter the link url',
              ),
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.url],
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
