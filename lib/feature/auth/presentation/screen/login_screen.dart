import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:reel/core/constants/app_colors.dart';
import 'package:reel/core/constants/enum.dart';
import 'package:reel/core/extension/widget_extension.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/core/utils/decore_utils.dart';
import 'package:reel/feature/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:reel/feature/widget/custom_button.dart';
import 'package:reel/feature/widget/text_field_widget.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<AuthMode> _authMode =
      ValueNotifier<AuthMode>(AuthMode.LOGIN);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: _formKey,
              child: ValueListenableBuilder(
                  valueListenable: _authMode,
                  builder: (_, mode, __) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'LogIn',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            20.verticalSpace,
                            TextFieldWidget(
                              controller: emailController,
                              labelText: 'Email',
                              hintText: 'email',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ).padBottom(bottom: 20.h),
                            TextFieldWidget(
                              controller: passwordController,
                              labelText: 'Password',
                              hintText: 'password',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 5) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                              isPassword: true,
                            ).padBottom(bottom: 20.h),
                            if (mode == AuthMode.REGISTER) ...{
                              TextFieldWidget(
                                controller: confirmPasswordController,
                                labelText: 'Confirm Password',
                                hintText: 'confirm password',
                                isPassword: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm Password is required';
                                  }
                                  if (value != passwordController.text.trim()) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ).padBottom(bottom: 20.h),
                            },
                            if (state.loginStatus == AbsNormalStatus.ERROR) ...{
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                width: double.maxFinite,
                                decoration: boxDecoration(
                                  color: Colors.red.shade100,
                                  borderColor: AppColors.absentColor,
                                ),
                                child: Text(
                                  state.message,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: AppColors.errorColor,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ).padBottom(bottom: 20.h),
                            },
                            CustomButton(
                              isLoading:
                                  state.loginStatus == AbsNormalStatus.LOADING,
                              lable: mode == AuthMode.LOGIN
                                  ? "Log In"
                                  : 'Register',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (mode == AuthMode.LOGIN) {
                                    getIt<AuthBloc>().add(AuthLogInEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ));
                                  } else {
                                    getIt<AuthBloc>().add(AuthRegisterEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ));
                                  }
                                }
                              },
                            ).padBottom(bottom: 20.h),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child:
                                    state.loginStatus == AbsNormalStatus.LOADING
                                        ? Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          )
                                        : SignInButton(
                                            Buttons.Google,
                                            onPressed: () => getIt<AuthBloc>()
                                                .add(AuthGoogleSignInEvent()),
                                          ),
                              ),
                            ).padBottom(bottom: 20.h),
                            RichText(
                              text: TextSpan(
                                text: mode == AuthMode.LOGIN
                                    ? 'Don\'t have an account? '
                                    : "Already have an account. ",
                                style: Theme.of(context).textTheme.bodyLarge,
                                children: [
                                  TextSpan(
                                    text: mode == AuthMode.REGISTER
                                        ? "Log In"
                                        : 'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (mode == AuthMode.LOGIN) {
                                          _authMode.value = AuthMode.REGISTER;
                                        } else {
                                          _authMode.value = AuthMode.LOGIN;
                                        }
                                      },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ).padHorizontal(horizontal: 20.w);
                  }),
            ),
          );
        },
      ),
    );
  }
}
