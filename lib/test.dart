import 'package:flutter/material.dart';
import 'package:innotes/services/auth.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthenticationService>();
    try {
      print(auth.user.toString());
      print(auth.signedInAnonymously);
    } catch (e) {
      print('error');
    }
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            child: Text('sign in anonym'),
            onTap: () {
              auth.signInAnonymously();
            },
          ),
          InkWell(
            child: Text('with creds'),
            onTap: () {
              auth.signInEmailPassword(
                  'omaromar@omar.omartest', '1234567985dssd');
            },
          )
        ],
      ),
    );
  }
}
