import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:new_pay/data/storage.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async => await Future.delayed(
        const Duration(seconds: 2),
        () {
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.pushReplacementNamed(context, NewPayConstants.homeTab);
          } else if (FirebaseAuth.instance.currentUser == null) {
            Navigator.pushReplacementNamed(
                context, NewPayConstants.onboardingScreen);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: LottieBuilder.asset(
        NewPayIcons.splash,
        width: 150.0.w,
        height: 150.0.h,
      )),
    );
  }
}
