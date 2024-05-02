// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:innotes/model/note_document.dart';

class NoteCard {
  final String title;
  final String saveDirectory;
  final DateTime createdIn;
  final String flag;
  NoteCard({
    required this.title,
    required this.saveDirectory,
    required this.createdIn,
    required this.flag,
  });

  factory NoteCard.fromNoteDoc(NoteDocument document) {
    return NoteCard(
      title: 'not implemented yet',
      saveDirectory: 'saveDirectory',
      createdIn: DateTime.now(),
      flag: document.flag,
    );
  }
}
