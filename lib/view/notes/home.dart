import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innotes/view/addnote/addnote.dart';
import 'package:innotes/view/notes/tabsviews/folders_and_flags.dart';
import 'package:innotes/view/notes/tabsviews/notes_gride.dart';
import 'package:innotes/view/notes/widgets/tabs.dart';
import 'package:innotes/view/notes/widgets/title.dart';
import 'package:innotes/view/notes/widgets/header.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) {
                return AddNotePage();
              },
            ),
          );
        },
        backgroundColor: Colors.blueGrey,
        heroTag: 'AddNoteButtonHero',
        elevation: 0,
        child: Icon(
          FluentIcons.add_24_regular,
          color: Colors.white,
        ),
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
            NotesGrideTabView(),
            FolderAndFlagsTabView(),
            ColoredBox(
              color: Colors.orange,
              child: Center(
                child: Text('2'),
              ),
            ),
            ColoredBox(
              color: Colors.orange,
              child: Center(
                child: Text('2'),
              ),
            ),
            ColoredBox(
              color: Colors.orange,
              child: Center(
                child: Text('2'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
