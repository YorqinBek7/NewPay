import 'package:authentication/auth/login/login_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:new_pay/data/storage.dart';
import 'package:new_pay/ui/auth/widgets/auth_fields.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';
import 'package:new_pay/widgets/global_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Log in'),
        ),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              Helper.showWaitDialog(context);
            } else if (state is LoginErrorState) {
              Navigator.pop(context);
              Helper.showCustomErrorSnackbar(context, state.error);
            } else if (state is LoginSuccessState) {
              NewPayStorage.instance.setBool('isLogged', true);
              Navigator.pushReplacementNamed(context, NewPayConstants.homeTab);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            NewPayIcons.onBoardingScreen_3,
                            width: 200.0.w,
                            height: 200.0.h,
                          ),
                        ),
                        Text(
                          'Email',
                          style: NewPayStyles.w500
                              .copyWith(color: NewPayColors.C_C1C1C1),
                        ),
                        AuthFields(
                          hintText: 'Enter your email',
                          isPassword: false,
                          obscure: false,
                          controller: emailController,
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (Helper.emailChecker(v)) {
                              return 'Please enter correct email address';
                            }
                            return '';
                          },
                        ),
                        Text(
                          'Password',
                          style: NewPayStyles.w500
                              .copyWith(color: NewPayColors.C_C1C1C1),
                        ),
                        AuthFields(
                          hintText: 'Enter your password',
                          isPassword: true,
                          obscure: obscure,
                          controller: passwordController,
                          iconOnTap: () => setState(() => obscure = !obscure),
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (v.length < 6) {
                              return 'Password should be at least 6 characters long';
                            }
                            return '';
                          },
                        ),
                        TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, NewPayConstants.forgotPassScreen),
                            child: const Text('Forgot password?')),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GlobalButton(
                  buttonText: 'Log in',
                  backgroundColor: NewPayColors.black,
                  onTap: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      Helper.showCustomErrorSnackbar(
                          context, 'Please fill all fields.');
                      return;
                    }
                    BlocProvider.of<LoginBloc>(context).add(LoginManagerEvent(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()));
                  },
                ),
                SizedBox(
                  height: 16.0.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'New to Newpay?',
                      style: NewPayStyles.w400.copyWith(fontSize: 16.0.sp),
                      children: [
                        TextSpan(
                          text: ' Create an account',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                  context,
                                  NewPayConstants.signUpScreen,
                                ),
                          style: NewPayStyles.w500.copyWith(
                              color: NewPayColors.C_0057FF, fontSize: 16.0.sp),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
