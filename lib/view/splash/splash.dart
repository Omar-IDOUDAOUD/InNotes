// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:innotes/providers/notes/notes.dart';
import 'package:innotes/services/auth.dart';
import 'package:innotes/view/notes/home.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.doSignOut = false});

  final bool doSignOut;
  // final NotesProvider notesProvider;
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
// print(context.read<AuthenticationService>().)
    Future.wait([
      _initialize(),
      1.seconds.delay(),
    ]).then((value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NotesPage()),
          (route) => false,
        ));
  }

  Future _initialize() async {
    final authService = context.read<AuthenticationService>();

    if (widget.doSignOut) await authService.signOut(context);

    if (!authService.signedIn && !authService.signedInAnonymously)
      await authService.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text(
              'IN NOTES',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    height: 1,
                  ),
            ),
            Text(
              'Note everything',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).hintColor,
                    letterSpacing: 1.9,
                  ),
            ),
            Spacer(),
            SizedBox.square(
              dimension: 40,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                strokeCap: StrokeCap.round,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'By Omar ID.DAOUD',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
