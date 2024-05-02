import 'package:flutter/material.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/providers/addnote/toolbar.dart';
import 'package:innotes/providers/addnote/new_note.dart';
import 'package:innotes/providers/notes/notes.dart';
import 'package:innotes/model/note_document.dart';
import 'package:innotes/view/addnote/widget/floating_toolbar.dart';
import 'package:innotes/view/addnote/widget/header.dart';
import 'package:innotes/view/addnote/widget/text_editor.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key, this.note});
  final NoteDocument? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  /// As Json String:

  // final EditorState _editorState = EditorState.blank();
  late final QuillController _quillController;

  @override
  void initState() {
    super.initState();

    _quillController = widget.note == null
        ? QuillController.basic()
        : QuillController(
            document: Document.fromJson(widget.note!.contentJson!),
            selection: TextSelection.collapsed(
                offset: widget.note!.lastSelectionOffset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        bottom: const PreferredSize(
          preferredSize:
              Size(double.infinity, 50 + SpacesConsts.screenPadding * 2),
          child: Header(),
        ),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ToolbarProvider(
                quillController: _quillController, context: context),
          ),
          Provider(
            create: (context) => CreateNoteProvider(
              quillController: _quillController,
              notesProvider: context.read<NotesProvider>(),
              modifyDoc: widget.note,
            ),
          ),
        ],
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              TextEditor(),
              FloatingToolbar2(),
            ],
          );
        },
      ),
    );
  }
}
