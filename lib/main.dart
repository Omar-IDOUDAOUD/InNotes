import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'constants/theme.dart';
import 'view/notes/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
