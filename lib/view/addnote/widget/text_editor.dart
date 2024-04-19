import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditor extends StatelessWidget {
  const TextEditor({super.key, required this.controller});
  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      configurations: QuillEditorConfigurations(controller: controller),
      focusNode: FocusNode(),
      scrollController: ScrollController(),
    );
  }
}
