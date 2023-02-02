import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/utils/colors.dart';

class CustomFields extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final ValueChanged onChanged;
  final TextInputFormatter formatter;
  final TextInputType inputType;
  final String? suffixIcon;
  final String? prefixIcon;
  const CustomFields({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.labelText,
    required this.inputType,
    required this.formatter,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.r),
        color: NewPayColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          prefixIcon != null
              ? Container(
                  decoration: BoxDecoration(
                      color: NewPayColors.C_828282,
                      borderRadius: BorderRadius.circular(10.0.r)),
                  child: Image.asset(
                    prefixIcon!,
                    height: 48.0.h,
                    width: 48.0.w,
                  ),
                )
              : const SizedBox(),
          SizedBox(
            width: 5.0.w,
          ),
          Flexible(
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
          ),
          suffixIcon != null
              ? SvgPicture.asset(
                  suffixIcon!,
                  width: 23.0.w,
                  height: 23.0.h,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
