import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:new_pay/utils/icons.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Place the QR code inside the area',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 17.0.sp),
            ),
            SizedBox(
              height: 20.0.h,
            ),
            Text(
              'Scanning will start automatically',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 17.0.sp),
            ),
            SizedBox(
              height: 20.0.h,
            ),
            LottieBuilder.asset(
              NewPayIcons.qrCodeScanner,
              height: 316.0.h,
              width: 316.0.w,
            )
          ],
        ),
      ),
    );
  }
}
