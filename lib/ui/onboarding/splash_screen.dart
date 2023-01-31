import 'package:flutter/material.dart';
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
          if (NewPayStorage.instance.getBool('isLogged') == true) {
            Navigator.pushReplacementNamed(context, NewPayConstants.homeTab);
          } else {
            Navigator.pushReplacementNamed(
                context, NewPayConstants.onboardingScreen);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          NewPayIcons.logo,
          width: 150.0,
          height: 150.0,
        ),
      ),
    );
  }
}
