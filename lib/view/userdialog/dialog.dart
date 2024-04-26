import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/services/auth.dart';
import 'package:innotes/view/userdialog/widget/button.dart';
import 'package:innotes/view/userdialog/widget/signed_in_tiles.dart';
import 'package:innotes/view/userdialog/widget/signed_out_tile.dart';
import 'package:innotes/view/userdialog/widget/theme_select.dart';
import 'package:provider/provider.dart';

class UserDialogRoute<T> extends PageRoute<T> {
  UserDialogRoute() : super();

  // final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String? get barrierLabel => 'user-dialog-lebel';

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: animation.drive(CurveTween(curve: AnimationConsts.curve)).drive(
            Tween<Offset>(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ),
          ),
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return const UserDialog();
  }
}

class UserDialog extends StatelessWidget {
  const UserDialog({super.key});

  // double _dragDownOffset = 0;
  @override
  Widget build(BuildContext context) {
    final isUserSignedIn = context.read<AuthenticationService>().signedIn;
    final height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GestureDetector(
          onVerticalDragEnd: (d) {
            if (d.velocity.pixelsPerSecond.dy >= 600) Navigator.pop(context);
          },
          onTap: () {},
          child: SizedBox(
            height: height + 10,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Hero(
                    tag: 'user-dialog-avatar-tag',
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          isUserSignedIn ? SignedInWidget() : SignedOutWidget(),
                          Divider(
                            indent: 40,
                            endIndent: 8,
                            height: 15,
                          ),
                        
                          ThemeModeSelector(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // bool _showAppThemes = false;
}
