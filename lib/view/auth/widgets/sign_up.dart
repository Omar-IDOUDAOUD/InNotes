// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/services/auth.dart';
import 'package:innotes/view/notes/home.dart';
import 'package:innotes/view/shared/textfield_error_text.dart';
import 'package:provider/provider.dart';

class SignUpTabView extends StatefulWidget {
  const SignUpTabView({super.key, required this.onWaitRespons});

  final Function(bool) onWaitRespons;

  @override
  State<SignUpTabView> createState() => _SignUpTabViewState();
}

class _SignUpTabViewState extends State<SignUpTabView> {
  late final TextEditingController _emailController,
      _fullNameController,
      _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'pcomar.lenovo@gmail.com');
    _fullNameController = TextEditingController(text: 'Omar ID');
    _passwordController = TextEditingController(text: 'omaromaromar');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // final _formKey = GlobalKey<FormState>();

  bool _waitingRespons = false;
  AuthenticationRespons? _authResult;
  bool _obsecurePassword = false;

  // final
  void submit() async {
    _authResult = null;
    _waitingRespons = true;
    widget.onWaitRespons(true);
    final authService =
        Provider.of<AuthenticationService>(context, listen: false);
    _authResult = await authService.signUpEmailPassword(_emailController.text,
        _passwordController.text, _fullNameController.text);

    _waitingRespons = false;
    widget.onWaitRespons(false);

    if (_authResult!.success) {
      await Future.delayed(Durations.extralong4);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const NotesPage()),
        (route) => true,
      );
    }
  }

  Widget? buildErrorWidget(String? error) {
    return error != null ? TextFieldErrorText(message: error) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SpacesConsts.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Create Account',
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
            controller: _emailController,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              error: buildErrorWidget(_authResult?.emailError),
              hintText: 'Email',
              prefixIcon: Icon(FluentIcons.mail_24_regular),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Full name',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 8),
          TextField(
            controller: _fullNameController,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              error: buildErrorWidget(_authResult?.fullNameError),
              hintText: 'Email',
              prefixIcon: Icon(FluentIcons.person_24_regular),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Password',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            style: Theme.of(context).textTheme.bodySmall,
            obscureText: _obsecurePassword,
            decoration: InputDecoration(
              error: buildErrorWidget(_authResult?.passwordError),
              hintText: 'Password',
              prefixIcon: Icon(FluentIcons.lock_closed_24_regular),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obsecurePassword = !_obsecurePassword;
                  });
                },
                icon: Icon(
                  _obsecurePassword
                      ? FluentIcons.eye_24_regular
                      : FluentIcons.eye_off_24_regular,
                ),
                tooltip: 'obsecure password',
              ),
            ),
          ),
          Spacer(),
          AnimatedOpacity(
            duration: AnimationConsts.defaultDuration,
            curve: AnimationConsts.curve,
            opacity: _authResult?.error == null ? 0 : 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(.2),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFieldErrorText(message: _authResult?.error ?? ""),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          MaterialButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Color.lerp(
              Theme.of(context).primaryColor,
              Theme.of(context).scaffoldBackgroundColor,
              0.5,
            ),
            height: 55,
            elevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: _waitingRespons ? null : submit,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  'Sign-Up',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                ),
                _waitingRespons
                    ? SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(
                          strokeCap: StrokeCap.round,
                          strokeWidth: 2,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      )
                    : Icon(
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
