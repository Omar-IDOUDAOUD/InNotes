// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/model/note_document.dart';
import 'package:innotes/model/pagination.dart';
import 'package:innotes/providers/notes/notes.dart';
import 'package:innotes/utils/pagination_list_builder.dart';
import 'package:innotes/view/notes/tabsviews/notes_gridview/widgets/error_card.dart';
import 'package:innotes/view/notes/tabsviews/notes_gridview/widgets/loading_card.dart';
import 'package:innotes/view/notes/tabsviews/notes_gridview/widgets/note_card.dart';
import 'package:provider/provider.dart';

class NotesGrideTabView extends StatefulWidget {
  const NotesGrideTabView(
      {super.key,
      required this.paginationSelector,
      required this.dataRequester});
  // final NotesProvider _notesProvider ;
  final Pagination<NoteDocument> Function(NotesProvider provider)
      paginationSelector;
  final Function(NotesProvider provider) dataRequester;

  @override
  State<NotesGrideTabView> createState() => _NotesGrideTabViewState();
}

class _NotesGrideTabViewState extends State<NotesGrideTabView> {
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void didUpdateWidget(covariant NotesGrideTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadInitialData();
  }

  void _loadInitialData() {
    final provider = context.read<NotesProvider>();
    if (widget.paginationSelector(provider).isFresh)
      widget.dataRequester(provider);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<NotesProvider, int>(
      selector: (_, provider) =>
          widget.paginationSelector(provider).changesIdentifier,
      builder: (_, __, ___) {
        final pagination = widget.paginationSelector(context.read());
        print('SELECTOR UPDATED');
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent)
              widget.dataRequester(context.read());
            return !(pagination.canLoadData && !pagination.hasError);
          },
          // child: Text(pagination),
          child: MasonryGridView.builder(
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return paginationListItemBuilder(
                index,
                pagination,
                itemBuilder: (index) => const NoteCard(),
                loadingBuilder: (index) => LoadingCard(index: index),
                errorBuilder: (_) => ErrorCard(
                  type: pagination.errorType!,
                  error: pagination.error,
                  onRety: () => widget.dataRequester(context.read()),
                ),
              );
            },
            padding: const EdgeInsets.symmetric(
                horizontal: SpacesConsts.screenPadding),
            itemCount: pagination.buildListviewItemCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
        );
      },
    );
  }
}
