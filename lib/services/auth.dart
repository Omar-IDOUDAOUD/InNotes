// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innotes/main.dart';
import 'package:innotes/view/splash/splash.dart';

class AuthenticationService {
  final _fbAuth = FirebaseAuth.instance;

  // void onCreate() {
  //   _fbAuth.authStateChanges().listen((event) {
  //     print('USER STATE EVENT: $event');
  //   });
  // }

  /// if anonumous, return false
  bool get signedIn => !(_fbAuth.currentUser?.isAnonymous ?? true);

  User get user => _fbAuth.currentUser!;

  String get userId => user.uid;

  AuthenticationRespons _validatFields(String email, String pass,
      [String? fullName]) {
    final emailV = email.isEmpty ? 'Missing email address' : null;
    final passV = pass.isEmpty ? 'Missing password' : null;
    final fullNameV = fullName?.isEmpty ?? false ? 'Missing full name' : null;
    return AuthenticationRespons(
      emailError: emailV,
      passwordError: passV,
      fullNameError: fullNameV,
    );
  }

  Future<AuthenticationRespons> signInEmailPassword(
      String email, String password) async {
    final validation = _validatFields(email, password);
    if (!validation.success) return validation;
    UserCredential? userCreds;
    final authResult = await _fbAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreds = value;

      print('SIGN IN Done');
      return AuthenticationRespons();
    }).catchError((ex) {
      print('SIGN IN Error, ${ex}');
      if (ex is FirebaseAuthException) {
        return AuthenticationRespons(
          errorCode: ex.code,
          emailError: AuthErrCode2ErrMsgConverters.invalideEmail(ex.code),
          passwordError: AuthErrCode2ErrMsgConverters.wrongPassword(ex.code),
          error: AuthErrCode2ErrMsgConverters.invalidCredentials(ex.code) ??
              AuthErrCode2ErrMsgConverters.userDisabled(ex.code) ??
              AuthErrCode2ErrMsgConverters.userNotFound(ex.code) ??
              AuthErrCode2ErrMsgConverters.unknownError(ex.code, ex.message),
        );
      } else
        return AuthenticationRespons(error: ex.toString());
    });

    /// will be used later
    // if (userCreds != null) _saveUserProfile(userCreds!);
    return authResult;
  }

  Future<AuthenticationRespons> signUpEmailPassword(
      String email, String password, String fullName) async {
    final validation = _validatFields(email, password, fullName);
    if (!validation.success) return validation;
    UserCredential? userCreds;
    final authResult = await _fbAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreds = value;
      print('SIGN UP Done');
      return AuthenticationRespons();
    }).catchError((ex) {
      print('SIGN UP Error, ${ex}');
      if (ex is FirebaseAuthException) {
        return AuthenticationRespons(
            errorCode: ex.code,
            emailError: AuthErrCode2ErrMsgConverters.invalideEmail(ex.code) ??
                AuthErrCode2ErrMsgConverters.emailAlreadyInUse(ex.code),
            passwordError: AuthErrCode2ErrMsgConverters.weakPassword(ex.code),
            error:
                AuthErrCode2ErrMsgConverters.unknownError(ex.code, ex.message));
      } else
        return AuthenticationRespons(error: ex.toString());
    });
    if (userCreds != null) {
      await user.updateDisplayName(fullName);

      /// will be used later
      // _saveUserProfile(userCreds!);
    }
    return authResult;
  }

  void updateDisplayName(String value) {
    if (signedIn)
      _fbAuth.currentUser?.updateDisplayName(value);
    else {
      globaleSharedPreferencesInstance.setString(
          'anonymous-displayname', value);
    }
  }

  ///it return displayname for anonymous user
  String getDsiplayName() {
    return globaleSharedPreferencesInstance
            .getString('anonymous-displayname') ??
        'Pretty';
  }

  void signOut(context) async {
    await _fbAuth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashPage(),
      ),
      (route) => true,
    );
  }

  ///TODO: look for an utilisation for those two functions:
  // void _saveUserProfile(UserCredential userCreds) async {
  //   print(userCreds.user.toString());
  //   final profile = userCreds.user!;
  //   final authCreds = userCreds.credential;
  //   final usersProfilsBox =
  //       await Hive.openLazyBox<UserProfile>('users-profiles-credentials');
  //   await usersProfilsBox.put(
  //     profile.uid,
  //     UserProfile(
  //       email: profile.email!,
  //       fullName: profile.displayName!,
  //       photoUrl: profile.photoURL,
  //       lastSignIn: DateTime.now(),
  //       authCredentials: AuthCredentials2(
  //         providerId: authCreds?.providerId ?? 'password',
  //         signInMethod: authCreds?.signInMethod ?? 'password',
  //         token: authCreds?.token,
  //         accessToken: authCreds?.accessToken,
  //       ),
  //     ),
  //   );
  //   usersProfilsBox.close();
  // }

  // List<UserProfile>? _usersProfils;
  // Future<List<UserProfile>> getUsersProfiles() async {
  //   if (_usersProfils != null) return _usersProfils!;
  //   final usersProfilsBox =
  //       await Hive.openBox<UserProfile>('users-profiles-credentials');
  //   final userList = usersProfilsBox.toMap().values.toList();
  //   userList.removeWhere(
  //       (element) => DateTime.now().difference(element.lastSignIn).inDays > 30);
  //   //TODO: remove the rest of users from hive storage;
  //   _usersProfils = userList;
  //   return userList;
  // }
}

class AuthenticationRespons {
  final String? emailError, fullNameError, passwordError;
  final String? error;
  final String? errorCode;

  bool get success =>
      errorCode == null &&
      error == null &&
      emailError == null &&
      fullNameError == null &&
      passwordError == null;

  AuthenticationRespons({
    this.emailError,
    this.fullNameError,
    this.passwordError,
    this.error,
    this.errorCode,
  });
}

abstract class AuthErrCode2ErrMsgConverters {
  static final knownErrors = [
    'invalid-email',
    'wrong-password',
    'user-disabled',
    'user-not-found',
    'email-already-in-use',
    'weak-password',
  ];

  static String? invalideEmail(e) =>
      e == 'invalid-email' ? 'Your email is invalid' : null;

  // static String? missingEmail(e) =>
  //     e == 'missing-email' ? 'You should provide email' : null;

  static String? wrongPassword(e) =>
      e == 'wrong-password' ? 'Password is not correct' : null;

  static String? userDisabled(e) =>
      e == 'user-disabled' ? 'This user is currently disabled' : null;

  static String? userNotFound(e) =>
      e == 'user-not-found' ? 'This user is not found' : null;

  static String? emailAlreadyInUse(e) =>
      e == 'email-already-in-use' ? 'This email is already used' : null;

  static String? weakPassword(e) =>
      e == 'weak-password' ? 'Try use a strong password' : null;

  static String? invalidCredentials(e) =>
      e == 'invalid-credential' ? 'Invalid email or password' : null;

  static String? unknownError(e, String? msg) =>
      knownErrors.contains(e) ? null : msg ?? 'Unkown error';
}
