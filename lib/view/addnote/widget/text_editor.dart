import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/providers/addnote/new_note.dart';
import 'package:provider/provider.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({super.key});

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  @override
  Widget build(BuildContext context) {
    final CreateNoteProvider createNoteController =
        context.read<CreateNoteProvider>();
    return QuillEditor(
      configurations: QuillEditorConfigurations(
        controller: createNoteController.quillController,
        padding: const EdgeInsets.fromLTRB(
          SpacesConsts.screenPadding,
          SpacesConsts.screenPadding,
          SpacesConsts.screenPadding,
          SpacesConsts.screenPadding + 50,
        ),
      ),
      focusNode: FocusNode(),
      scrollController: ScrollController(
          initialScrollOffset:
              createNoteController.noteDocument.lastScrollOffset),
    );
  }
}
