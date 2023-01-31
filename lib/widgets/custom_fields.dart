import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/utils/colors.dart';

class CustomFields extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final ValueChanged onChanged;
  final TextInputFormatter formatter;
  final TextInputType inputType;
  const CustomFields({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.labelText,
    required this.inputType,
    required this.formatter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      margin: EdgeInsets.symmetric(vertical: 10.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.r),
        color: NewPayColors.white,
      ),
      child: TextField(
        keyboardType: inputType,
        inputFormatters: [formatter],
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
