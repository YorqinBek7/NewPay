import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/styles.dart';

class AuthFields extends StatelessWidget {
  AuthFields({
    super.key,
    required this.hintText,
    required this.isPassword,
    this.iconOnTap,
    required this.obscure,
    required this.controller,
    required this.validator,
  });
  final String hintText;
  final bool isPassword;
  final VoidCallback? iconOnTap;
  final bool obscure;
  final TextEditingController controller;
  final String Function(String? v) validator;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0.h),
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      decoration: BoxDecoration(
        color: NewPayColors.C_EEEEEE,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Form(
        key: _key,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: NewPayStyles.w400
                .copyWith(color: NewPayColors.C_828282, fontSize: 16.0.sp),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: iconOnTap,
                    child: Icon(obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
