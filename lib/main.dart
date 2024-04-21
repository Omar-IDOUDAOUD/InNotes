import 'package:flutter/material.dart';
import 'package:innotes/view/auth/authentication.dart';

import 'constants/theme.dart';
import 'view/notes/home.dart';

void main() {
  runApp(const InNotes());
}

class InNotes extends StatelessWidget {
  const InNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConsts.buildLightThemeData(),
      darkTheme: ThemeConsts.buildDarkThemeData(),
      themeMode: ThemeMode.system,
      home: const NotesPage(),
    );
  }
}
