import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';

import 'connectivity_controller.dart';

class AuthFirebaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ConnectivityController _connectivityController;
  AuthFirebaseController(this._connectivityController);

  // Register a user with email and password and send a verification email
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      bool hasInternet =
          await _connectivityController.checkInternetConnectivity();
      if (!hasInternet) {
        developer.log("No internet connection");
        throw Exception("No internet connection");
      }
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send a verification email to the user
      await userCredential.user!.sendEmailVerification();

      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      developer.log("Error during registration: $error");
      return null;
    } catch (error) {
      developer.log("Error during registration: $error");
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      bool hasInternet =
          await _connectivityController.checkInternetConnectivity();
      if (!hasInternet) {
        developer.log("No internet connection");
        throw Exception("No internet connection");
      }
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (error) {
      developer.log("Error during sign-in: $error");
      return null;
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Reset user password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      developer.log("Error sending password reset email: $error");
    }
  }
}
