import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:innotes/model/user_profile.dart';
import 'package:innotes/services/app_settings.dart';
import 'package:innotes/services/auth.dart';
import 'package:innotes/view/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'constants/theme.dart';

late final SharedPreferences globaleSharedPreferencesInstance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  globaleSharedPreferencesInstance = await SharedPreferences.getInstance();

  await Hive.initFlutter();

  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(AuthCredentialsAdapter());

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            lazy: false,
            create: (BuildContext context) => AuthenticationService()),
        ListenableProvider<AppSettingsService>(
            create: (BuildContext context) => AppSettingsService()),
      ],
      child: const InNotes(),
    ),
  );
}

class InNotes extends StatelessWidget {
  const InNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AppSettingsService, ThemeMode>(
      selector: (_, service) => service.themeMode,
      builder: (context, themeMode, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeConsts.buildLightThemeData(),
        darkTheme: ThemeConsts.buildDarkThemeData(),
        themeMode: themeMode,
        home: const SplashPage(),
      ),
    );
  }
}
