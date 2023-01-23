import 'package:flutter/material.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/styles.dart';

class AuthFields extends StatelessWidget {
  const AuthFields({
    super.key,
    required this.hintText,
    required this.isPassword,
    this.iconOnTap,
    required this.obscure,
    required this.controller,
  });
  final String hintText;
  final bool isPassword;
  final VoidCallback? iconOnTap;
  final bool obscure;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: NewPayColors.C_EEEEEE,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: NewPayStyles.w400
              .copyWith(color: NewPayColors.C_828282, fontSize: 16.0),
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
    );
    ;
  }
}
