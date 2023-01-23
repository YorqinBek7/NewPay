import 'package:flutter/material.dart';
import 'package:new_pay/utils/styles.dart';

Widget onBoardingScreen(String image, String text) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 300.0,
            height: 300.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            text,
            style: NewPayStyles.w400,
          ),
        ],
      ),
    );
