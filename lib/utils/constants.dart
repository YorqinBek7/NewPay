import 'package:flutter/material.dart';
import 'package:new_pay/models/onboarding_model.dart';
import 'package:new_pay/models/option_buttons_model.dart';
import 'package:new_pay/utils/icons.dart';

class NewPayConstants {
  static const String splashScreen = '/';
  static const String homeTab = '/home_tab';
  static const String onboardingScreen = '/on_boarding_screen';
  static const String loginScreen = '/login_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String verifiedScreen = '/verified_screen';
  static const String forgotPassScreen = '/forgot_pass_screen';
  static final List<OnBoardingModel> onBoardingModels = [
    OnBoardingModel(
        image: NewPayIcons.onBoardingScreen_1,
        text: 'Перемещайте свои деньги свободно и без границ'),
    OnBoardingModel(
        image: NewPayIcons.onBoardingScreen_2,
        text: 'Перемещайте свои деньги свободно и без границ'),
    OnBoardingModel(
        image: NewPayIcons.onBoardingScreen_3,
        text: 'Простой и безопасный способ управлять своими деньгами.'),
  ];

  static final List<OptionButtonsModel> optionsButtonsModels = [
    OptionButtonsModel(
      name: 'Send',
      icon: Icons.send,
    ),
    OptionButtonsModel(
      name: 'QR Code',
      icon: Icons.qr_code_outlined,
    ),
    OptionButtonsModel(
      name: 'Pay',
      icon: Icons.payment_outlined,
    ),
    OptionButtonsModel(
      name: 'More',
      icon: Icons.more_horiz_outlined,
    ),
  ];
}
