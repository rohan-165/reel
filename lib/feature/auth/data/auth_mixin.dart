import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reel/core/constants/enum.dart';
import 'package:reel/core/utils/app_toast.dart';

mixin AuthMixin {
  Future<void> emailAndPassword(
      {required AuthMode mode,
      required String email,
      required String password}) async {
    try {
      if (mode == AuthMode.LOGIN) {
        // Attempt to sign in
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        // Attempt to register
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions
      switch (e.code) {
        case 'user-not-found':
          AppToasts().showToast(
            message: "No user found for that email.",
          );
          break;
        case 'wrong-password':
          AppToasts().showToast(
            message: "Wrong password provided.",
          );
          break;
        case 'email-already-in-use':
          AppToasts().showToast(
            message: "The email is already in use by another account.",
          );
          break;
        case 'invalid-email':
          AppToasts().showToast(
            message: "The email address is not valid.",
          );
          break;
        case 'weak-password':
          AppToasts().showToast(
            message: "The password is too weak.",
          );
          break;
        default:
          AppToasts().showToast(
            message: "An error occurred: ${e.message}",
          );
          break;
      }
    } catch (e) {
      // Handle other exceptions
      AppToasts().showToast(
        message: "An unexpected error occurred: $e",
      );
    }
  }
}

Future<void> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // The user canceled the sign-in
      AppToasts().showToast(
        message: "Google sign-in was canceled.",
      );
      return;
    }

    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;
    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      debugPrint("Google authentication failed. Tokens are null.");
      return;
    }
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with Firebase using the credential
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Show success message
    AppToasts().showToast(
      message: "Google sign-in successful!",
    );
  } on FirebaseAuthException catch (e) {
    // Handle Firebase-specific exceptions
    switch (e.code) {
      case 'account-exists-with-different-credential':
        AppToasts().showToast(
          message:
              "This email is already associated with another sign-in method.",
        );
        break;
      case 'invalid-credential':
        AppToasts().showToast(
          message: "Invalid Google credentials. Please try again.",
        );
        break;
      case 'user-disabled':
        AppToasts().showToast(
          message: "This user account has been disabled.",
        );
        break;
      case 'operation-not-allowed':
        AppToasts().showToast(
          message: "Google sign-in is not enabled in Firebase.",
        );
        break;
      default:
        AppToasts().showToast(
          message: "An error occurred: ${e.message}",
        );
        break;
    }
  } catch (e) {
    // Handle other exceptions
    AppToasts().showToast(
      message: "$e",
    );
  }
}
