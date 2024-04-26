import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:innotes/view/auth/authentication.dart';
import 'package:innotes/view/userdialog/widget/button.dart';

class SignedOutWidget extends StatelessWidget {
  const SignedOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonTile(
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
