import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parksmart/models/auth.dart';
import 'package:parksmart/models/auth_service.dart';

//import '../models/auth.dart';

class EmailVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please verify your email',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call the verification method
                _verifyEmail();
              },
              child: const Text('Verify Email'),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyEmail() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      AuthService.firebase().sendEmailVerification();
      // Check if the user .is null
      if (user == null) {
        Get.snackbar('Error', 'User not found');
        return;
      }

      // Call the email verification method
      await user.reload();

      // Check if the email is verified
      if (user.emailVerified) {
        Get.snackbar('Success', 'Email already verified');
      } else {
        Get.snackbar('Success',
            'Email verification link sent. Please check your email.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify email: $e');
    }
  }
}
