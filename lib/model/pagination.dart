// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:innotes/model/note_document.dart';
import 'package:provider/provider.dart';

const defPaginationPayloadLimit = 12;

class Pagination<T> {
  final List<T> payload = List.empty(growable: true);
  bool isLoading = false;
  DocumentSnapshot<T>? lastDocument;
  bool _canLoadMoreData = true;
  final VoidCallback _listenersNotifier;

  PaginationErrorTypes? errorType;
  String? error;

  Pagination({required VoidCallback listenersNotifier})
      : _listenersNotifier = listenersNotifier;

  int get buildListviewItemCount {
    return payload.length + (isLoading ? 2 : 0) + (errorType != null ? 1 : 0);
  }

  static void checkSnapshotResponseHealthy(QuerySnapshot snapshot) {
    if (snapshot.metadata.isFromCache && snapshot.size == 0) {
      throw NeedConnectionInternetException();
    }
  }

  int changesIdentifier = 0;
  bool get isFresh => changesIdentifier == 0;

  void notifyListeners() {
    changesIdentifier++;
    _listenersNotifier();
  }

  void performQuery(Query<T> query) async {
    await query.get().then((snapshot) {
      checkSnapshotResponseHealthy(snapshot);
      lastDocument = snapshot.docs.last;
      if (snapshot.size < defPaginationPayloadLimit) _canLoadMoreData = false;
      payload.addAll(snapshot.docs.map((e) => e.data()));
      print('QUERY GOTTED, $snapshot');
    }).catchError(((e) {
      if (e is NeedConnectionInternetException) {
        errorType = PaginationErrorTypes.connectionError;
      } else {
        errorType = PaginationErrorTypes.unknownError;
        error = e.toString();
      }
      print('QUERY ERRORED, $e');
    }));
    isLoading = false;
    notifyListeners();
  }

  Query<NoteDocument> addPaginationOffsetTo(Query<NoteDocument> query) {
    if (lastDocument != null) query = query.startAfterDocument(lastDocument!);
    return query.limit(defPaginationPayloadLimit);
  }

  void loading({bool withNotifyListeners = true}) {
    error = errorType = null;
    isLoading = true;
    if (withNotifyListeners) notifyListeners();
  }

  bool get canLoadData {
    return !isLoading && _canLoadMoreData;
  }

  bool get hasError => errorType != null;

  void reset() {
    payload.clear();
    isLoading = false;
    error = errorType = null;
    _canLoadMoreData = true;
    lastDocument = null;
    changesIdentifier = 0;
  }

  @override
  bool operator ==(covariant Pagination<T> other) {
    return other.changesIdentifier == changesIdentifier;
  }

  @override
  int get hashCode => changesIdentifier.hashCode;
}

enum PaginationErrorTypes { connectionError, unknownError }

class NeedConnectionInternetException implements Exception {}
