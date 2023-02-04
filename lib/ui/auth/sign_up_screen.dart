import 'package:authentication/auth/sign_up/sign_up_bloc.dart';
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
import 'package:new_pay/widgets/global_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscure = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign up'),
        ),
        body: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoadingState) {
              Helper.showWaitDialog(context);
            } else if (state is SignUpSuccessState) {
              NewPayStorage.instance.setBool('isLogged', true);
              Navigator.pushNamedAndRemoveUntil(
                  context, NewPayConstants.verifiedScreen, (route) => false);
            } else if (state is SignUpErrorState) {
              Navigator.pop(context);
              Helper.showCustomErrorSnackbar(context, state.error);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: NewPayColors.C_C1C1C1),
                        ),
                        AuthFields(
                          hintText: 'Enter your name',
                          isPassword: false,
                          obscure: false,
                          controller: nameController,
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'Please enter your name';
                            }
                            if (v.length < 3) {
                              return 'Length of name must be at least 3 characters';
                            }
                            return '';
                          },
                        ),
                        Text(
                          'Email',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
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
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: NewPayColors.C_C1C1C1),
                        ),
                        AuthFields(
                          hintText: 'Enter your password',
                          isPassword: true,
                          obscure: obscure,
                          controller: passwordController,
                          iconOnTap: () => setState(() => obscure = !obscure),
                          validator: (String? v) {
                            if (v!.isEmpty) return 'Please enter your password';
                            if (v.length < 6) {
                              return 'Password should be at least 6 characters long';
                            }
                            return '';
                          },
                        ),
                        SizedBox(
                          height: 13.0.h,
                        ),
                        Text(
                          'At least 8 characters with uppercase letters and numbers',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 14.0.sp,
                                    color: NewPayColors.C_787A8D,
                                  ),
                        ),
                        SizedBox(
                          height: 16.0.h,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () =>
                                    setState(() => isChecked = !isChecked),
                                child: isChecked
                                    ? const Icon(Icons.check_box)
                                    : const Icon(
                                        Icons.check_box_outline_blank)),
                            Text(
                              'Accept Terms of Use & Privacy Policy',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontSize: 14.0.sp,
                                    color: NewPayColors.C_787A8D,
                                  ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GlobalButton(
                buttonText: 'Sign up',
                backgroundColor: NewPayColors.black,
                onTap: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      nameController.text.isEmpty) {
                    Helper.showCustomErrorSnackbar(
                        context, 'Please fill all fields.');
                    return;
                  }
                  if (!isChecked) {
                    Helper.showCustomErrorSnackbar(context,
                        'You did not accept the terms of use and privacy policy.');
                    return;
                  }
                  BlocProvider.of<SignUpBloc>(context).add(
                    SignUpManagerEvent(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      name: nameController.text.trim(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16.0.h,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account?',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 16.0.sp),
                    children: [
                      TextSpan(
                        text: ' Log in!',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushNamed(
                                context,
                                NewPayConstants.loginScreen,
                              ),
                        style: Theme.of(context).textTheme.headline4!.copyWith(
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
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
