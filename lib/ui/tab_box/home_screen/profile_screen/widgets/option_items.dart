import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/utils/colors.dart';

ListTile optionItems({
  required String icon,
  required String title,
  required VoidCallback onTap,
  required BuildContext context,
  Widget? trailingIcon,
}) {
  return ListTile(
    onTap: onTap,
    leading: Container(
        padding: EdgeInsets.all(10.0.r),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: NewPayColors.C_EEEEEE,
        ),
        child: SvgPicture.asset(icon)),
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 14.0.sp),
    ),
    trailing: GestureDetector(
      onTap: onTap,
      child: trailingIcon ??
          Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Theme.of(context).cardColor,
          ),
    ),
  );
}
