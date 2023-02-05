import 'package:authentication/auth/sign_up/sign_up_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
      child: WillPopScope(
        onWillPop: () async => await Helper.exitdialog(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text(tr('sign_up')),
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
                            tr('name'),
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: NewPayColors.C_C1C1C1),
                          ),
                          AuthFields(
                            hintText: tr('enter_your_name'),
                            isPassword: false,
                            obscure: false,
                            controller: nameController,
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return tr('please_enter_your_name');
                              }
                              if (v.length < 3) {
                                return tr('least_3');
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
                            hintText: tr('enter_email'),
                            isPassword: false,
                            obscure: false,
                            controller: emailController,
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return tr('enter_your_email');
                              }
                              if (Helper.emailChecker(v)) {
                                return tr('please_enter_correct_email');
                              }
                              return '';
                            },
                          ),
                          Text(
                            tr('password'),
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: NewPayColors.C_C1C1C1),
                          ),
                          AuthFields(
                            hintText: tr('enter_your_password'),
                            isPassword: true,
                            obscure: obscure,
                            controller: passwordController,
                            iconOnTap: () => setState(() => obscure = !obscure),
                            validator: (String? v) {
                              if (v!.isEmpty)
                                return tr('please_enter_password');
                              if (v.length < 6) {
                                return tr('least_6');
                              }
                              return '';
                            },
                          ),
                          SizedBox(
                            height: 20.0.h,
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
                                tr('accept_terms'),
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
                  buttonText: tr('sign_up'),
                  backgroundColor: Theme.of(context).cardColor,
                  onTap: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        nameController.text.isEmpty) {
                      Helper.showCustomErrorSnackbar(
                          context, tr('please_fill_all_fields'));
                      return;
                    }
                    if (!isChecked) {
                      Helper.showCustomErrorSnackbar(
                          context, tr('didnt_accept_terms'));
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
                      text: tr('have_account'),
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 16.0.sp),
                      children: [
                        TextSpan(
                          text: ' ${tr('login')}!',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                  context,
                                  NewPayConstants.loginScreen,
                                ),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: NewPayColors.C_0057FF,
                                  fontSize: 16.0.sp),
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
