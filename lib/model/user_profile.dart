import 'package:hive_flutter/adapters.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 1)
class UserProfile extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String? photoUrl;

  @HiveField(3)
  final AuthCredentials2 authCredentials;

  @HiveField(4)
  final DateTime lastSignIn;

  UserProfile({
    required this.email,
    required this.fullName,
    required this.authCredentials,
    required this.lastSignIn,
    this.photoUrl,
  });
}

@HiveType(typeId: 2)
class AuthCredentials2 extends HiveObject {
  @HiveField(0)
  final String providerId;

  @HiveField(1)
  final String signInMethod;

  @HiveField(2)
  final int? token;

  @HiveField(3)
  final String? accessToken;

  AuthCredentials2({
    required this.providerId,
    required this.signInMethod,
    required this.token,
    required this.accessToken,
  });
}
