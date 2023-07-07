import 'package:parksmart/models/auth.dart';
import 'package:parksmart/models/auth_provider.dart';
import 'package:parksmart/models/auth_user.dart';

import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(
    FirebaseAuthProvider(),
  );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();
  

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}