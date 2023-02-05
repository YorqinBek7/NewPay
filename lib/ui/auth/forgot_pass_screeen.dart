import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:new_pay/ui/auth/widgets/auth_fields.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/widgets/global_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('reset_password'),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 20.0.sp),
                  textAlign: TextAlign.center,
                ),
                Text(
                  tr('enter_email_to_reset'),
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: NewPayColors.C_828282),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 35.0.h,
                ),
                AuthFields(
                  hintText: tr('enter_your_email'),
                  isPassword: false,
                  obscure: false,
                  controller: emailController,
                  validator: (String? v) {
                    return '';
                  },
                ),
                SizedBox(
                  height: 42.0.h,
                ),
                GlobalButton(
                  buttonText: tr('next'),
                  backgroundColor: NewPayColors.black,
                  onTap: () => Navigator.pushReplacementNamed(
                      context, NewPayConstants.loginScreen),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
