
import 'package:parksmart/models/auth.dart';

import 'auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<void> sendEmailVerification();
}