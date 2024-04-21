// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:innotes/constants/colors.dart';

// import 'package:innotes/utils/hexcolor.dart';
import 'package:innotes/view/addnote/widget/floating_toolbar.dart';

enum ToolbarButtons {
  todo,
  color, //
  backroundColor,
  fontSize, //
  fontFamily, //
  bold,
  italic,
  throughLine,
  underLine,
  list,
  dottedList,
  numberedList,
  textDirection,
  link,
}

class ToolbarButton {
  final ToolbarButtons name;
  final Widget icon;
  final double horizontalPadding;
  final Function action;
  final List<ToolbarButton>? children;
  final bool hasDividerToLeft;

  void onPressed() {
    if (children != null)
      action(children);
    else
      action();
  }

  ToolbarButton({
    required this.name,
    required this.icon,
    required this.action,
    this.horizontalPadding = 7,
    this.children,
    this.hasDividerToLeft = false,
  });
}

class ToolbarController extends ChangeNotifier {
  ToolbarController({required this.quillController, required this.context});

  final QuillController quillController;
  final BuildContext context;

  List<ToolbarButton>? extraToolbar;
  void _closeOrOpenExtraToolbar([children]) {
    if (children == null && extraToolbar != null) notifyListeners();
    if (extraToolbar == children)
      extraToolbar = null;
    else
      extraToolbar = children;
    notifyListeners();
  }

  bool _isToggled(Attribute attribute) {
    return quillController.getSelectionStyle().attributes[attribute.key] !=
        null;
  }

  late final List<ToolbarButton> toolbar = [
    ToolbarButton(
      name: ToolbarButtons.todo,
      icon: Icon(FluentIcons.checkbox_checked_24_regular),
      action: () {
        _closeOrOpenExtraToolbar();
        quillController.formatSelection(
            _isToggled(Attribute.list) ? Attribute.list : Attribute.unchecked);
      },
      hasDividerToLeft: true,
    ),
    ToolbarButton(
      name: ToolbarButtons.color,
      icon: const Icon(FluentIcons.text_color_24_regular),
      children: buildColorsToolbar(ColorsConsts.textColors),
      action: _closeOrOpenExtraToolbar,
    ),
    ToolbarButton(
      name: ToolbarButtons.backroundColor,
      icon: Icon(FluentIcons.highlight_24_regular),
      children: buildColorsToolbar(ColorsConsts.textBackroundColors),
      action: _closeOrOpenExtraToolbar,
      hasDividerToLeft: true,
    ),
    ToolbarButton(
      name: ToolbarButtons.fontSize,
      icon: Icon(
        FluentIcons.text_font_size_24_regular,
      ),
      children: buildFontSizeToolbar(),
      action: _closeOrOpenExtraToolbar,
    ),
    ToolbarButton(
      name: ToolbarButtons.fontFamily,
      icon: Icon(FluentIcons.text_t_24_regular),
      children: buildFontFamilyToolbar(),
      action: _closeOrOpenExtraToolbar,
      // action: () => _showExtraToolbar([]),
    ),
    ToolbarButton(
      name: ToolbarButtons.bold,
      icon: Icon(FluentIcons.text_bold_24_regular),
      action: () {
        _closeOrOpenExtraToolbar();
        quillController.formatSelection(_isToggled(Attribute.bold)
            ? Attribute.clone(Attribute.bold, null)
            : Attribute.bold);
      },
    ),
    ToolbarButton(
      name: ToolbarButtons.italic,
      icon: Icon(FluentIcons.text_italic_24_regular),
      action: () {
        _closeOrOpenExtraToolbar();

        quillController.formatSelection(_isToggled(Attribute.italic)
            ? Attribute.clone(Attribute.italic, null)
            : Attribute.italic);
      },
    ),
    ToolbarButton(
      name: ToolbarButtons.throughLine,
      icon: Icon(FluentIcons.text_strikethrough_24_regular),
      action: () {
        _closeOrOpenExtraToolbar();

        quillController.formatSelection(_isToggled(Attribute.strikeThrough)
            ? Attribute.clone(Attribute.strikeThrough, null)
            : Attribute.strikeThrough);
      },
    ),
    ToolbarButton(
      name: ToolbarButtons.underLine,
      icon: Icon(FluentIcons.text_underline_24_regular),
      action: () {
        _closeOrOpenExtraToolbar();

        quillController.formatSelection(_isToggled(Attribute.underline)
            ? Attribute.clone(Attribute.underline, null)
            : Attribute.underline);
      },
      hasDividerToLeft: true,
    ),
    ToolbarButton(
      name: ToolbarButtons.list,
      icon: Icon(FluentIcons.text_bullet_list_24_regular),
      action: () {
        _closeOrOpenExtraToolbar();

        quillController.formatSelection(_isToggled(Attribute.ul)
            ? Attribute.clone(Attribute.ul, null)
            : Attribute.ul);
      },
    ),
    ToolbarButton(
      name: ToolbarButtons.list,
      icon: Icon(FluentIcons.text_number_list_ltr_24_regular),
      action: () {
        _closeOrOpenExtraToolbar();

        quillController.formatSelection(_isToggled(Attribute.ol)
            ? Attribute.clone(Attribute.ol, null)
            : Attribute.ol);
      },
    ),
    ToolbarButton(
      name: ToolbarButtons.textDirection,
      icon: Icon(FluentIcons.text_align_left_24_regular),
      action: () {
        _closeOrOpenExtraToolbar();

        List<Attribute> alignAttrs = [
          Attribute.centerAlignment,
          Attribute.rightAlignment,
          Attribute.leftAlignment,
        ];

        final currentAttr =
            quillController.getSelectionStyle().attributes[Attribute.align.key];

        final applyAttrIndex =
            currentAttr != null ? alignAttrs.indexOf(currentAttr) + 1 : 0;

        final applyAttr =
            alignAttrs.elementAtOrNull(applyAttrIndex) ?? alignAttrs.first;

        quillController.formatSelection(
          Attribute.clone(Attribute.align, applyAttr.value),
        );
      },
      hasDividerToLeft: true,
    ),
    ToolbarButton(
      name: ToolbarButtons.link,
      icon: Icon(FluentIcons.link_24_regular),
      horizontalPadding: 3,
      action: () async {
        _closeOrOpenExtraToolbar();

        final selection = quillController.selection;
        final selectedText = quillController.getPlainText();
        print(selectedText);
        final result = await _openLinkDialog(selectedText);
        if (result == null) return;
        String name = result['name'];
        quillController
          ..replaceText(selection.start, selectedText.length, name, null)
          ..updateSelection(
              TextSelection(
                baseOffset: selection.baseOffset,
                extentOffset: selection.baseOffset + name.length,
              ),
              ChangeSource.remote)
          ..formatSelection(
            LinkAttribute(result['link']),
          )
          ..updateSelection(
            TextSelection.collapsed(offset: selection.baseOffset),
            ChangeSource.remote,
          );
      },
    ),
  ];

  List<ToolbarButton> buildColorsToolbar(List<Color> colorsList,
          {isbg = false}) =>
      List.generate(
        colorsList.length,
        (index) {
          final color = colorsList.elementAt(index);
          return ToolbarButton(
            name: ToolbarButtons.color,
            horizontalPadding: 3,
            icon: CircleAvatar(
              backgroundColor: color.withOpacity(.2),
              maxRadius: 15,
              child: CircleAvatar(
                maxRadius: 8,
                backgroundColor: color,
              ),
            ),
            action: () {
              quillController.formatSelection(isbg
                  ? BackgroundAttribute(colorToHex(color))
                  : ColorAttribute(colorToHex(color)));
              _closeOrOpenExtraToolbar();
            },
          );
        },
      );

  List<ToolbarButton> buildFontSizeToolbar() => List.generate(
        3,
        (index) {
          return ToolbarButton(
            name: ToolbarButtons.fontSize,
            icon: Text('${index + 1}'),
            action: () {
              quillController.formatSelection(
                HeaderAttribute(level: index + 1),
              );
              _closeOrOpenExtraToolbar();
            },
          );
        },
      );
  List<ToolbarButton> buildFontFamilyToolbar() {
    return List.generate(
      1,
      (index) {
        return ToolbarButton(
          name: ToolbarButtons.fontFamily,
          icon: const Text('Roboto'),
          action: () {
            quillController.formatSelection(FontAttribute('Roboto'));
            _closeOrOpenExtraToolbar();
          },
        );
      },
    );
  }

  Future<Map?> _openLinkDialog(String? selectedText) async {
    final Map? result = await showDialog<Map>(
      context: context,
      builder: (context) => LinkDialog(selectedText: selectedText),
    );
    return result;
  }
}
