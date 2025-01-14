import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef OAuthSignIn = void Function();

/// Helper class to show a snackbar using the passed context.
class ScaffoldSnackbar {
  ScaffoldSnackbar(this._context);

  factory ScaffoldSnackbar.of(BuildContext context) {
    return ScaffoldSnackbar(context);
  }

  final BuildContext _context;

  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

/// The mode of the current auth session.
enum AuthMode { login, register, phone }

extension on AuthMode {
  String get label => this == AuthMode.login
      ? 'Sign in'
      : this == AuthMode.phone
          ? 'Sign in'
          : 'Register';
}

/// Login screen implementation.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String error = '';
  AuthMode mode = AuthMode.login;
  bool isLoading = false;

  late Map<Buttons, OAuthSignIn> authButtons;

  @override
  void initState() {
    super.initState();
    authButtons = {
      Buttons.Google: () => _signInWithGoogle(),
    };
  }

  void setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SafeArea(
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (error.isNotEmpty)
                            MaterialBanner(
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              content: SelectableText(error),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      error = '';
                                    });
                                  },
                                  child: const Text(
                                    'Dismiss',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                              contentTextStyle:
                                  const TextStyle(color: Colors.white),
                              padding: const EdgeInsets.all(10),
                            ),
                          const SizedBox(height: 20),
                          _buildEmailPasswordFields(),
                          const SizedBox(height: 20),
                          _buildSignInButton(),
                          TextButton(
                            onPressed: _resetPassword,
                            child: const Text('Forgot password?'),
                          ),
                          ...authButtons.keys.map(
                            (button) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      )
                                    : SignInButton(
                                        button,
                                        onPressed: authButtons[button]!,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildToggleAuthMode(),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailPasswordFields() {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          validator: (value) =>
              value != null && value.isNotEmpty ? null : 'Required',
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              value != null && value.isNotEmpty ? null : 'Required',
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : _emailAndPassword,
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : Text(mode.label),
      ),
    );
  }

  Widget _buildToggleAuthMode() {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: mode == AuthMode.login
                ? "Don't have an account? "
                : 'Already have an account? ',
          ),
          TextSpan(
            text: mode == AuthMode.login ? 'Register now' : 'Login',
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  mode = mode == AuthMode.login
                      ? AuthMode.register
                      : AuthMode.login;
                });
              },
          ),
        ],
      ),
    );
  }

  Future<void> _resetPassword() async {
    String? email;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Send'),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your email'),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) => email = value,
              ),
            ],
          ),
        );
      },
    );

    if (email != null) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
        Fluttertoast.showToast(
          msg: "Password reset email sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error: ${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  Future<void> _emailAndPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      setIsLoading(true);
      try {
        if (mode == AuthMode.login) {
          // Attempt to sign in
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          Fluttertoast.showToast(msg: "Login successful!");
        } else {
          // Attempt to register
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          Fluttertoast.showToast(msg: "Registration successful!");
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase-specific exceptions
        switch (e.code) {
          case 'user-not-found':
            Fluttertoast.showToast(
              msg: "No user found for that email.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            break;
          case 'wrong-password':
            Fluttertoast.showToast(
              msg: "Wrong password provided.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            break;
          case 'email-already-in-use':
            Fluttertoast.showToast(
              msg: "The email is already in use by another account.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            break;
          case 'invalid-email':
            Fluttertoast.showToast(
              msg: "The email address is not valid.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            break;
          case 'weak-password':
            Fluttertoast.showToast(
              msg: "The password is too weak.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            break;
          default:
            Fluttertoast.showToast(
              msg: "An error occurred: ${e.message}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
            );
            break;
        }
      } catch (e) {
        // Handle other exceptions
        Fluttertoast.showToast(
          msg: "An unexpected error occurred: $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } finally {
        setIsLoading(false);
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setIsLoading(true);
    try {
      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        Fluttertoast.showToast(
          msg: "Google sign-in was canceled.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        setIsLoading(false);
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

      log(credential.toString());
      // Sign in with Firebase using the credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Show success message
      Fluttertoast.showToast(
        msg: "Google sign-in successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions
      switch (e.code) {
        case 'account-exists-with-different-credential':
          Fluttertoast.showToast(
            msg:
                "This email is already associated with another sign-in method.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
          break;
        case 'invalid-credential':
          Fluttertoast.showToast(
            msg: "Invalid Google credentials. Please try again.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          break;
        case 'user-disabled':
          Fluttertoast.showToast(
            msg: "This user account has been disabled.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          break;
        case 'operation-not-allowed':
          Fluttertoast.showToast(
            msg: "Google sign-in is not enabled in Firebase.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
          break;
        default:
          Fluttertoast.showToast(
            msg: "An error occurred: ${e.message}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
          );
          break;
      }
    } catch (e) {
      // Handle other exceptions
      log("$e");
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      setIsLoading(false);
    }
  }
}
