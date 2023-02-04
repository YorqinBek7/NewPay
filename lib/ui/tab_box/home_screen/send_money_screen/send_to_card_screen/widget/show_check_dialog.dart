import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/icons.dart';

Future<dynamic> showCheckDialog(
  BuildContext context,
  String cardNumber,
  String amount,
) {
  return showBarModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0.r),
        topRight: Radius.circular(30.0.r),
      ),
    ),
    builder: (context) => Container(
      color: NewPayColors.C_F1F2F6,
      height: 512.0.h,
      child: Column(
        children: [
          Container(
            height: 228.0.h,
            margin: EdgeInsets.only(bottom: 4.0.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0.r),
              color: NewPayColors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  NewPayIcons.humo,
                  width: 48.9.w,
                  height: 48.0.h,
                ),
                Text(
                  "- $amount so'm",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 24.0.sp, color: NewPayColors.black),
                ),
                Text(
                  DateFormat.yMMMEd().format(DateTime.now()),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: 14.0.sp,
                        color: NewPayColors.C_828282,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: NewPayColors.C_4EFF8A,
                    ),
                    SizedBox(
                      width: 4.0.w,
                    ),
                    Text(
                      'Completed successfully',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 14.0.sp, color: NewPayColors.C_4EFF8A),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 276.0.h,
            margin: EdgeInsets.only(top: 4.0.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0.r),
              color: NewPayColors.white,
            ),
            padding: EdgeInsets.all(10.0.w),
            child: Column(
              children: [
                Text(
                  'Payment details',
                  style: Theme.of(context).textTheme.headline3!,
                ),
                _checkInfo(
                  desc: 'New Pay',
                  name: 'Service',
                  context: context,
                ),
                _checkInfo(
                  desc: 'Reciver name',
                  name: 'Yorqin',
                  context: context,
                ),
                _checkInfo(
                  desc: cardNumber,
                  name: 'Card',
                  context: context,
                ),
                _checkInfo(
                  desc: "- $amount so'm",
                  name: 'Sum',
                  context: context,
                ),
                _checkInfo(
                  desc: '0',
                  name: 'Comission',
                  context: context,
                ),
                _checkInfo(
                  desc: DateFormat.yMMMEd().format(DateTime.now()),
                  name: 'Date and Time',
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Container _checkInfo({
  required String name,
  required String desc,
  required BuildContext context,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontSize: 14.0.sp, color: NewPayColors.C_828282),
        ),
        Text(
          desc,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontSize: 14.0.sp, color: NewPayColors.black),
        ),
      ],
    ),
  );
}
