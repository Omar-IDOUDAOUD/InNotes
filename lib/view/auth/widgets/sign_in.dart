import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:innotes/constants/spaces.dart';

class SignInTabView extends StatelessWidget {
  const SignInTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SpacesConsts.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Welcom back',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Center(
            child: Text(
              'By sign in, you can sync all your data online and access to them everywhere!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).hintColor, height: 1.3),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Email',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 8),
          TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(FluentIcons.mail_24_regular),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Password',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 8),
          TextField(
            style: Theme.of(context).textTheme.bodySmall,
            decoration: const InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(FluentIcons.lock_closed_24_regular),
              suffixIcon: Icon(FluentIcons.eye_24_regular),
            ),
          ),
          Spacer(),
          MaterialButton(
            color: Theme.of(context).primaryColor,
            height: 55,
            elevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  'Log-In',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                ),
                Icon(
                  FluentIcons.chevron_right_24_regular,
                  size: 25,
                  color: Theme.of(context).scaffoldBackgroundColor,
                )
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _smallLine(context),
              Text(
                'Or continue using',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              _smallLine(context),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _signInWithButton(context,
                    Icon(FluentIcons.fireplace_24_regular), 'Google', () {}),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _signInWithButton(
                    context, Icon(Icons.ten_k), 'Facebook', () {}),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _smallLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 1,
        width: 20,
        child: ColoredBox(color: Theme.of(context).dividerTheme.color!),
      ),
    );
  }

  Widget _signInWithButton(
      context, Widget icon, String label, VoidCallback ontap) {
    return TextButton.icon(
      style: ButtonStyle(
          minimumSize: MaterialStatePropertyAll(Size(0, 55)),
          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Theme.of(context).hintColor, width: 1),
            ),
          )),
      onPressed: ontap,
      icon: icon,
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
