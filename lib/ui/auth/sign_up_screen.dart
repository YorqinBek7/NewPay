import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pay/blocs/sign_up/sign_up_bloc.dart';
import 'package:new_pay/data/storage.dart';
import 'package:new_pay/ui/auth/widgets/auth_fields.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/styles.dart';
import 'package:new_pay/widgets/global_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscure = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        title: const Text('Sign up'),
      ),
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoadingState) {
            Helper.showWaitDialog(context);
          } else if (state is SignUpSuccessState) {
            NewPayStorage.instance.setBool('isLogged', true);
            Navigator.pushReplacementNamed(
                context, NewPayConstants.verifiedScreen);
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Text(
                        'At least 8 characters with uppercase letters and numbers',
                        style: NewPayStyles.w400.copyWith(
                          fontSize: 14.0,
                          color: NewPayColors.C_787A8D,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () =>
                                  setState(() => isChecked = !isChecked),
                              child: isChecked
                                  ? Icon(Icons.check_box)
                                  : Icon(Icons.check_box_outline_blank)),
                          Text(
                            'Accept Terms of Use & Privacy Policy',
                            style: NewPayStyles.w400.copyWith(
                              fontSize: 14.0,
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
                    passwordController.text.isEmpty) {
                  Helper.showCustomErrorSnackbar(
                      context, 'Please fill all fields.');
                  return;
                } else if (!isChecked) {
                  Helper.showCustomErrorSnackbar(context,
                      'You did not accept the terms of use and privacy policy.');
                  return;
                }
                BlocProvider.of<SignUpBloc>(context).add(
                  SignUpManagerEvent(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account?',
                  style: NewPayStyles.w400.copyWith(fontSize: 16.0),
                  children: [
                    TextSpan(
                      text: ' Log in!',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(
                              context,
                              NewPayConstants.loginScreen,
                            ),
                      style: NewPayStyles.w500.copyWith(
                          color: NewPayColors.C_0057FF, fontSize: 16.0),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }
}
