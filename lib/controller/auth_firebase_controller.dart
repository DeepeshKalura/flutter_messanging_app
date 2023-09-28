import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';

import 'connectivity_controller.dart';
import 'random_avator_api_controller.dart';
import 'stroage_firebase_controller.dart';

class AuthFirebaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ConnectivityController _connectivityController;
  late StorageFirebaseController storageFirebaseController;

  AuthFirebaseController(this._connectivityController) {
    storageFirebaseController =
        StorageFirebaseController(_connectivityController);
  }

  // Register a user with email and password and send a verification email
  Future<String> registerWithEmailAndPassword(
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

      Uint8List file = await RandomImageAPIController.getRandomAvator();
      // Send a verification email to the user
      final String downloadUrl = await storageFirebaseController.uploadFile(
        "profile/${userCredential.user!.uid}",
        file,
        "SvgFile",
      );
      await userCredential.user!.updatePhotoURL(downloadUrl);
      await userCredential.user!.sendEmailVerification();

      return "sent verification email successfully";
    } on FirebaseAuthException catch (error) {
      developer.log("Error during registration: $error");
      return error.message!;
    } catch (error) {
      developer.log("Error during registration: $error");
      return error.toString();
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
      if (userCredential.user != null) {
        // Check if the user's email is verified
        if (userCredential.user!.emailVerified) {
          return userCredential.user;
        } else {
          developer.log("Email not verified");
          return null;
        }
      } else {
        developer.log("User is null");
        return null;
      }
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
