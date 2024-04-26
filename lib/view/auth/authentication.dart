// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/view/auth/widgets/sign_in.dart';
import 'package:innotes/view/auth/widgets/sign_up.dart';
import 'package:innotes/view/auth/widgets/tabs.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AthenticationStatePage();
}

class _AthenticationStatePage extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  // bool _isRegistering = true;
  bool _waitingRespons = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: SpacesConsts.screenPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: SpacesConsts.screenPadding),
            child: Tabs(tabController: _tabController),
          ),
          // SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics:
                  _waitingRespons ? const NeverScrollableScrollPhysics() : null,
              children: [
                SignInTabView(
                  onWaitRespons: (b) {
                    setState(() {
                      _waitingRespons = b;
                    });
                  },
                ),
                SignUpTabView(
                  onWaitRespons: (b) {
                    setState(() {
                      _waitingRespons = b;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
