import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final String id;
  final bool isEmailVerified;
  final String email;

  const AuthUser({
    required this.id,
    required this.isEmailVerified,
    required this.email,
  });
factory AuthUser.fromFirebase(User user) =>
    AuthUser(id: user.uid, isEmailVerified: user.emailVerified, email: user.email!);
}