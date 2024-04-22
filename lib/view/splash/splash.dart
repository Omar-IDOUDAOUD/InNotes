import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    //
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
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).hintColor),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
