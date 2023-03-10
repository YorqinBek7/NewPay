import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget onBoardingScreen(String image, String text, BuildContext context) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 300.0.w,
            height: 300.0.h,
          ),
          SizedBox(
            height: 10.0.h,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline5!,
          ),
        ],
      ),
    );
