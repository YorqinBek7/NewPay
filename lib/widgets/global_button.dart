import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/utils/colors.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    super.key,
    this.backgroundColor,
    required this.buttonText,
    this.onTap,
  });
  final String buttonText;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 13.0.h, horizontal: 43.0.w),
        margin: EdgeInsets.symmetric(horizontal: 10.0.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.r),
          color: backgroundColor,
          border: backgroundColor == null
              ? Border.all(color: NewPayColors.C_7000FF)
              : null,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 20.0.sp,
                  color: backgroundColor != null
                      ? NewPayColors.white
                      : NewPayColors.C_7000FF,
                ),
          ),
        ),
      ),
    );
  }
}
