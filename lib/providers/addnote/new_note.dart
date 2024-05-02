import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:innotes/providers/notes/notes.dart';
import 'package:innotes/model/note_document.dart';

class CreateNoteProvider {
  CreateNoteProvider({
    required this.quillController,
    required NotesProvider notesProvider,
    NoteDocument? modifyDoc,
  })  : _notesProvider = notesProvider,
        noteDocument = modifyDoc ??
            NoteDocument(
              id: null,
              contentJson: quillController.document.toDelta().toJson(),
              lastSelectionOffset: 0,
              lastScrollOffset: 0,
              saveDirectory: '/All Notes',
              createdIn: DateTime.now(),
              flag: 'notes',
            );

  final NotesProvider _notesProvider;
  final QuillController quillController;
  final NoteDocument noteDocument;

  Future<void> submitNote() async {
    print('submit note');
    await _notesProvider.collectionRef.doc(noteDocument.id).set(noteDocument);
    _notesProvider.newDataAvailable();
  }
}
