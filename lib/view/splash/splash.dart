// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:innotes/services/auth.dart';
import 'package:innotes/view/notes/home.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _initialize().then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NotesPage()),
        ));
  }

  Future _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
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
