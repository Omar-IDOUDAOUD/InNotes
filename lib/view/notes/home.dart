import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innotes/providers/notes/notes.dart';
import 'package:innotes/services/auth.dart';
import 'package:innotes/view/addnote/addnote.dart';
import 'package:innotes/view/notes/tabsviews/folders_and_flags.dart';
import 'package:innotes/view/notes/tabsviews/notes_gridview/notes_gridview.dart';
import 'package:innotes/view/notes/widgets/tabs.dart';
import 'package:innotes/view/notes/widgets/title.dart';
import 'package:innotes/view/notes/widgets/header.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 5, vsync: this);
  late final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _searchState = false;

  @override
  Widget build(BuildContext context) {
    // print('----------');
    // print(FirebaseAuth.instance.currentUser);
    // print('----------');

    return ChangeNotifierProvider<NotesProvider>(
        create: (context) =>
            NotesProvider(userId: context.read<AuthenticationService>().userId),
        builder: (_, __) {
          return Scaffold(
            floatingActionButton: AddNoteButton(
              onDataNeedRefesh: () => setState(() {}),
            ),
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                Header(
                  searchState: _searchState,
                  onSearchStateChange: (b) {
                    setState(() {
                      _searchState = b;
                    });
                  },
                ),
                Title_(searchState: _searchState),
                Tabs(controller: _tabController),
              ],
              body: TabBarView(
                controller: _tabController,
                children: [
                  NotesGrideTabView(
                    paginationSelector: (provider) =>
                        provider.notesByFlagPagination,
                    dataRequester: (provider) =>
                        provider.loadNotesByFlag('notes'),
                  ),
                  const FolderAndFlagsTabView(),
                  const ColoredBox(
                    color: Colors.orange,
                    child: Center(
                      child: Text('2'),
                    ),
                  ),
                  const ColoredBox(
                    color: Colors.orange,
                    child: Center(
                      child: Text('2'),
                    ),
                  ),
                  const ColoredBox(
                    color: Colors.orange,
                    child: Center(
                      child: Text('2'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({
    super.key,
    required this.onDataNeedRefesh,
  });
  final VoidCallback onDataNeedRefesh;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final needReloadData = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (_) {
              return ChangeNotifierProvider<NotesProvider>.value(
                value: context.read<NotesProvider>(),
                builder: (_, __) => const AddNotePage(),
              );
            },
          ),
        );
        if (needReloadData == true) onDataNeedRefesh();
      },
      heroTag: addNoteButtonHeroTag,
      elevation: 0,
      child: Icon(
        FluentIcons.add_24_regular,
        color: Theme.of(context).colorScheme.background,
      ),
    );
  }
}

const String addNoteButtonHeroTag = 'AddNoteButtonHeroTag';
