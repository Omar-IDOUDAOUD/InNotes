// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/foundation.dart';
import 'package:innotes/model/note_document.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innotes/model/pagination.dart';

class NotesProvider extends ChangeNotifier {
  final String userId;
  NotesProvider({required this.userId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<NoteDocument> collectionRef = _firestore
      .collection('UsersNotes')
      .doc(userId)
      .collection('notes')
      .withConverter(
        fromFirestore: NoteDocument.fromFirestore,
        toFirestore: (value, options) => value.toFirestore(),
      );

  late final Pagination<NoteDocument> notesByFlagPagination =
      Pagination(listenersNotifier: notifyListeners);

  void loadNotesByFlag(String flag) async {
    if (!notesByFlagPagination.canLoadData || notesByFlagPagination.isLoading)
      return;
    print('LOADING DATA');
    notesByFlagPagination.loading(
        withNotifyListeners: !notesByFlagPagination.isFresh);
    Query<NoteDocument> query = collectionRef;
    query = notesByFlagPagination.addPaginationOffsetTo(query);
    notesByFlagPagination.performQuery(query);
  }

  void newDataAvailable() {
    notesByFlagPagination.reset();
  }

  void deleteAllNotes() {
    _firestore.collection('UsersNotes').doc(userId).delete();
  }
}
