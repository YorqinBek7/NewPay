import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewPayColors.white,
      appBar: AppBar(
        backgroundColor: NewPayColors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: NewPayColors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Place the QR code inside the area',
              style: NewPayStyles.w500.copyWith(fontSize: 17.0.sp),
            ),
            SizedBox(
              height: 20.0.h,
            ),
            Text(
              'Scanning will start automatically',
              style: NewPayStyles.w500.copyWith(fontSize: 17.0.sp),
            ),
            SizedBox(
              height: 20.0.h,
            ),
            Image.asset(
              NewPayIcons.scanner,
              width: 250.0.w,
              height: 250.0.h,
            )
          ],
        ),
      ),
    );
  }
}
