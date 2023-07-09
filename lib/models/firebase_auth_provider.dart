import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parksmart/firebase_options.dart';
import 'package:parksmart/models/auth.dart';
import 'package:parksmart/models/auth_provider.dart';
import 'package:parksmart/models/auth_user.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null) {
      return AuthUser.fromFirebase(user);
    }
  }

  @override
  Future<void> initialize() async{
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
   );
  }

  @override
  Future<void> sendEmailVerification() async{
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null) {
      await user.sendEmailVerification();
    }
    
  }



}