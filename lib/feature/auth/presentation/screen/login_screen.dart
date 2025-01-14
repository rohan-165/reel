import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reel/core/constants/enum.dart';

/// Login screen implementation.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
}
