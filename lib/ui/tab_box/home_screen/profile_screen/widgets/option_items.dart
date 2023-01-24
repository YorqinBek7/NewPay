import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/styles.dart';

ListTile optionItems({
  required String icon,
  required String title,
  required VoidCallback onTap,
  Widget? trailingIcon,
}) {
  return ListTile(
    onTap: onTap,
    leading: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: NewPayColors.C_EEEEEE,
        ),
        child: SvgPicture.asset(icon)),
    title: Text(
      title,
      style: NewPayStyles.w600.copyWith(fontSize: 14.0),
    ),
    trailing: GestureDetector(
      onTap: onTap,
      child: trailingIcon ??
          Icon(
            Icons.keyboard_arrow_right_outlined,
          ),
    ),
  );
}
