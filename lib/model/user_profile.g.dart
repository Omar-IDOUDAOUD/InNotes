// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 1;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      email: fields[0] as String,
      fullName: fields[1] as String,
      authCredentials: fields[3] as AuthCredentials2,
      lastSignIn: fields[4] as DateTime,
      photoUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.photoUrl)
      ..writeByte(3)
      ..write(obj.authCredentials)
      ..writeByte(4)
      ..write(obj.lastSignIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AuthCredentialsAdapter extends TypeAdapter<AuthCredentials2> {
  @override
  final int typeId = 2;

  @override
  AuthCredentials2 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthCredentials2(
      providerId: fields[0] as String,
      signInMethod: fields[1] as String,
      token: fields[2] as int?,
      accessToken: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthCredentials2 obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.providerId)
      ..writeByte(1)
      ..write(obj.signInMethod)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.accessToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCredentialsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
