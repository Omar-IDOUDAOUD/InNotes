import 'package:flutter/material.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/controller/addnote/toolbar.dart';
import 'package:innotes/view/addnote/widget/floating_toolbar.dart';
import 'package:innotes/view/addnote/widget/header.dart';
import 'package:innotes/view/addnote/widget/text_editor.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({super.key});
  // final EditorState _editorState = EditorState.blank();
  final QuillController _quillController = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          TextEditor(controller: _quillController),
          ChangeNotifierProvider<ToolbarController>(
            create: (context) => ToolbarController(
                quillController: _quillController, context: context),
            child: FloatingToolbar_(
              controller: _quillController,
              test: () {},
            ),
          ),
        ],
      ),
    );
  }
}
