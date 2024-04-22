import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/view/auth/authentication.dart';

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
                          _Button(
                            prefix: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                            ),
                            suffix:
                                const Icon(FluentIcons.checkmark_24_regular),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Omar Idoudaoud',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(height: 1.1)),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'pcomar.lenovo@gmail.com',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Text(
                                  'All your data are synced',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  FluentIcons.cloud_sync_16_regular,
                                  color: Theme.of(context).hintColor,
                                  size: 12,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          _Button(
                            prefix:
                                const Icon(FluentIcons.arrow_exit_20_regular),
                            onTap: () {},
                            child: const Text('Sign out'),
                          ),
                          _Button(
                            prefix: const Icon(FluentIcons.add_24_regular),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AuthenticationPage(),
                                  ));
                            },
                            child: const Text('Add account'),
                          ),
                          Divider(
                            indent: 40,
                            endIndent: 8,
                            height: 15,
                          ),
                          _Button(
                            onTap: () {},
                            prefix:
                                const Icon(FluentIcons.weather_moon_24_regular),
                            suffix:
                                const Icon(FluentIcons.chevron_down_24_regular),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('App Theme',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(height: 1.1)),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Dark',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
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

class _Button extends StatelessWidget {
  const _Button(
      {super.key,
      required this.prefix,
      required this.child,
      this.suffix,
      this.onTap});
  final Widget prefix;
  final Widget child;
  final Widget? suffix;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: prefix,
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          child,
          if (suffix != null) suffix!,
        ],
      ),
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        iconColor: MaterialStatePropertyAll(Theme.of(context).hintColor),
        // iconSize: MaterialStatePropertyAll(30),

        textStyle:
            MaterialStatePropertyAll(Theme.of(context).textTheme.bodyMedium),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 15,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
    // MaterialButton(
    //   onPressed: onTap,
    //   shape:,
    // );
  }
}
