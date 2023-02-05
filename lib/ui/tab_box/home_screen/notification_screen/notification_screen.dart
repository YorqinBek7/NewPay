import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SingleChildScrollView(
          child: Column(
              children: List.generate(
            4,
            (index) => _notificationItem(),
          )),
        ),
      ),
    );
  }

  Container _notificationItem() {
    return Container(
      padding: EdgeInsets.all(10.0.w),
      margin: EdgeInsets.symmetric(vertical: 5.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
        color: NewPayColors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Pay', style: NewPayStyles.w600),
              Text(DateFormat.yMMMd().format(DateTime.now())),
            ],
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Image.asset(
            NewPayIcons.notif,
            width: 333.0.w,
            height: 181.0.h,
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Text(
            """
A simple and secure way to manage your money.A simple and secure way to manage your money.
A simple and secure way to manage your money.A simple and secure way to manage your money.A simple and secure way to manage your money.
A simple and secure way to manage your money.A simple and secure way to manage your money.A simple and secure way to manage your money.
A simple and secure way to manage your money.A simple and secure way to manage your money.A simple and secure way to manage your money.
""",
            style: NewPayStyles.w500,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
