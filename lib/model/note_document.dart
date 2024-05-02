// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class NoteDocument {
  final String? id;
  List<dynamic>? contentJson;
  int lastSelectionOffset;
  double lastScrollOffset;
  String saveDirectory;
  DateTime createdIn;
  String flag;

  NoteDocument({
    required this.id,
    this.contentJson,
    required this.lastSelectionOffset,
    required this.lastScrollOffset,
    required this.saveDirectory,
    required this.createdIn,
    required this.flag,
  });

  NoteDocument copyWith({
    List<dynamic>? contentJson,
    int? lastSelectionOffset,
    double? lastScrollOffset,
    String? saveDirectory,
    DateTime? createdIn,
    String? flag,
  }) {
    return NoteDocument(
      id: id,
      contentJson: contentJson ?? this.contentJson,
      lastSelectionOffset: lastSelectionOffset ?? this.lastSelectionOffset,
      lastScrollOffset: lastScrollOffset ?? this.lastScrollOffset,
      saveDirectory: saveDirectory ?? this.saveDirectory,
      createdIn: createdIn ?? this.createdIn,
      flag: flag ?? this.flag,
    );
  }

  factory NoteDocument.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    final map = doc.data()!;
    return NoteDocument(
      id: doc.id,
      contentJson: map['content_json'] as List,
      lastSelectionOffset: map['last_selection_offset'] as int,
      lastScrollOffset: map['last_scroll_offset'] as double,
      saveDirectory: map['save_directory'] as String,
      createdIn: (map['created_in'] as Timestamp).toDate(),
      flag: map['flag'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'content_json': contentJson,
      'last_selection_offset': lastSelectionOffset,
      'last_scroll_offset': lastScrollOffset,
      'save_directory': saveDirectory,
      'created_in': Timestamp.fromDate(createdIn),
      'flag': flag,
    };
  }
}
