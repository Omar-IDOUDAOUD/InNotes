import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/services/auth.dart';
import 'package:innotes/view/auth/authentication.dart';
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
                          isUserSignedIn
                              ? _SignedInWidget()
                              : _SignedOutWidget(),
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

class _SignedInWidget extends StatefulWidget {
  _SignedInWidget({super.key});

  @override
  State<_SignedInWidget> createState() => _SignedInWidgetState();
}

class _SignedInWidgetState extends State<_SignedInWidget> {
  late final TextEditingController _nameController;
  late final AuthenticationService _authenticationService;
  late final User _user;

  @override
  void initState() {
    super.initState();
    _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    print(_authenticationService.signedIn);
    _user = _authenticationService.user;
    _nameController = TextEditingController(text: _user.displayName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Button(
          prefix: CircleAvatar(
            backgroundColor: Colors.white,
            // foregroundImage:
            //     _user.photoURL != null ? NetworkImage(_user.photoURL!) : null,
            radius: 12,
          ),
          suffix: const Icon(FluentIcons.checkmark_24_regular),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  onSubmitted: (name) {
                    if (name.isEmpty) {
                      _nameController.text = _user.displayName!;
                      return;
                    }
                    _authenticationService.updateDisplayName(name);
                  },
                  onTapOutside: (_) {
                    _nameController.text = _user.displayName!;
                  },
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(height: 1.1),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isCollapsed: true,
                    hintText: 'Provide a Name',
                    contentPadding: EdgeInsets.zero,
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          height: 1.1,
                          color: Theme.of(context).hintColor,
                        ),
                        filled: false, 
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  _user.email!,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Row(
            children: [
              Text(
                'All your data are synced',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
          prefix: const Icon(FluentIcons.arrow_exit_20_regular),
          onTap: () {
            Navigator.pop(context);
            _authenticationService.signOut(context);
          },
          child: const Text('Sign out'),
        ),
        _Button(
          prefix: const Icon(FluentIcons.add_24_regular),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthenticationPage(),
                ));
          },
          child: const Text('Add account'),
        ),
      ],
    );
  }
}

class _SignedOutWidget extends StatelessWidget {
  const _SignedOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Button(
          prefix: const Icon(FluentIcons.person_add_24_regular),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthenticationPage(),
                ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign In',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(height: 1.1)),
              const SizedBox(
                height: 4,
              ),
              Text(
                'To sync all your data on cloude',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
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
