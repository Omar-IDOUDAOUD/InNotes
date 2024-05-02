import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:innotes/services/auth.dart';
import 'package:innotes/view/auth/authentication.dart';
import 'package:innotes/view/splash/splash.dart';
import 'package:innotes/view/userdialog/widget/button.dart';
import 'package:provider/provider.dart';

class SignedInWidget extends StatefulWidget {
  SignedInWidget({super.key});

  @override
  State<SignedInWidget> createState() => _SignedInWidgetState();
}

class _SignedInWidgetState extends State<SignedInWidget> {
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
        ButtonTile(
          prefix: const CircleAvatar(
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
        ButtonTile(
          prefix: const Icon(FluentIcons.arrow_exit_20_regular),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SplashPage(doSignOut: true),
              ),
              (route) => false,
            );
          },
          child: const Text('Sign out'),
        ),
        ButtonTile(
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
