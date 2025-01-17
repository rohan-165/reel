import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reel/core/constants/enum.dart';
import 'package:reel/core/utils/app_toast.dart';
import 'package:reel/feature/auth/domain/model/user_model.dart';

mixin AuthMixin {
  Future<void> emailAndPassword({
    required AuthMode mode,
    required String email,
    required String password,
    required Function({
      required AbsNormalStatus status,
      required String message,
    }) callBack,
  }) async {
    try {
      if (mode == AuthMode.LOGIN) {
        // Attempt to sign in
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        callBack(message: 'success', status: AbsNormalStatus.SUCCESS);
      } else if (mode == AuthMode.REGISTER) {
        // Attempt to register
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        callBack(message: 'success', status: AbsNormalStatus.SUCCESS);
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions
      switch (e.code) {
        case 'user-not-found':
          callBack(
            message: 'No user found for that email.',
            status: AbsNormalStatus.ERROR,
          );
          AppToasts().showToast(
            message: "No user found for that email.",
            isSuccess: false,
          );
          break;
        case 'wrong-password':
          callBack(
            message: 'Wrong password provided.',
            status: AbsNormalStatus.ERROR,
          );
          AppToasts().showToast(
            message: "Wrong password provided.",
            isSuccess: false,
          );
          break;
        case 'email-already-in-use':
          callBack(
            message: 'The email is already in use by another account.',
            status: AbsNormalStatus.ERROR,
          );
          AppToasts().showToast(
            message: "The email is already in use by another account.",
            isSuccess: false,
          );
          break;
        case 'invalid-email':
          callBack(
            message: 'The email address is not valid.',
            status: AbsNormalStatus.ERROR,
          );
          AppToasts().showToast(
            message: "The email address is not valid.",
            isSuccess: false,
          );
          break;
        case 'weak-password':
          callBack(
            message: 'The password is too weak.',
            status: AbsNormalStatus.ERROR,
          );
          AppToasts().showToast(
            message: "The password is too weak.",
            isSuccess: false,
          );
          break;
        default:
          callBack(
            message: 'An unexpected error occurred.',
            status: AbsNormalStatus.ERROR,
          );
          AppToasts().showToast(
            message: "An error occurred: ${e.message}",
            isSuccess: false,
          );
          break;
      }
    } catch (e) {
      // Handle other exceptions
      callBack(
        message: 'An unexpected error occurred',
        status: AbsNormalStatus.ERROR,
      );
      AppToasts().showToast(
        message: "An unexpected error occurred: $e",
        isSuccess: false,
      );
    }
  }
}

Future<void> signInWithGoogle({
  required Function({
    required UserModel userModel,
    required AbsNormalStatus status,
    required String message,
  }) callBack,
}) async {
  try {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // The user canceled the sign-in
      AppToasts().showToast(
        message: "Google sign-in was canceled.",
        isSuccess: false,
      );
      callBack(
        userModel: UserModel(
          id: googleUser?.id,
          email: googleUser?.email,
          displayName: googleUser?.displayName,
          photoUrl: googleUser?.photoUrl,
        ),
        status: AbsNormalStatus.ERROR,
        message: "Google sign-in was canceled.",
      );
      return;
    }

    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;
    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      debugPrint("Google authentication failed. Tokens are null.");
      callBack(
        userModel: UserModel(
          id: googleUser.id,
          email: googleUser.email,
          displayName: googleUser.displayName,
          photoUrl: googleUser.photoUrl,
        ),
        status: AbsNormalStatus.ERROR,
        message: "Google authentication failed. Tokens are null.",
      );
      return;
    }
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    callBack(
      userModel: UserModel(
        id: googleUser.id,
        email: googleUser.email,
        displayName: googleUser.displayName,
        photoUrl: googleUser.photoUrl,
      ),
      status: AbsNormalStatus.SUCCESS,
      message: "Google sign-in successful!",
    );
    AppToasts().showToast(
      message: "Google sign-in successful!",
      isSuccess: true,
    );
  } on FirebaseAuthException catch (e) {
    // Handle Firebase-specific exceptions
    switch (e.code) {
      case 'account-exists-with-different-credential':
        callBack(
          userModel: UserModel(),
          status: AbsNormalStatus.ERROR,
          message:
              "This email is already associated with another sign-in method.",
        );
        AppToasts().showToast(
          message:
              "This email is already associated with another sign-in method.",
          isSuccess: false,
        );
        break;
      case 'invalid-credential':
        callBack(
          userModel: UserModel(),
          status: AbsNormalStatus.ERROR,
          message: "Invalid Google credentials. Please try again.",
        );
        AppToasts().showToast(
          message: "Invalid Google credentials. Please try again.",
          isSuccess: false,
        );
        break;
      case 'user-disabled':
        callBack(
          userModel: UserModel(),
          status: AbsNormalStatus.ERROR,
          message: "This user account has been disabled.",
        );
        AppToasts().showToast(
          message: "This user account has been disabled.",
          isSuccess: false,
        );
        break;
      case 'operation-not-allowed':
        callBack(
          userModel: UserModel(),
          status: AbsNormalStatus.ERROR,
          message: "Google sign-in is not enabled in Firebase.",
        );
        AppToasts().showToast(
          message: "Google sign-in is not enabled in Firebase.",
          isSuccess: false,
        );
        break;
      default:
        callBack(
          userModel: UserModel(),
          status: AbsNormalStatus.ERROR,
          message: "An error occurred",
        );
        AppToasts().showToast(
          message: "An error occurred: ${e.message}",
          isSuccess: false,
        );
        break;
    }
  } catch (e) {
    callBack(
      userModel: UserModel(),
      status: AbsNormalStatus.ERROR,
      message: "An error occurred",
    );
    AppToasts().showToast(
      message: "An error occurred: $e",
      isSuccess: false,
    );
  }
}
