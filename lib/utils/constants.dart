import 'package:flutter/material.dart';
import 'package:new_pay/models/bottom_nav_models.dart';
import 'package:new_pay/models/cards_gradient.dart';
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
  static const String home = '/home_tab';
  static const String profileScreen = '/profile_screen';
  static const String appSettings = '/app_settings';
  static const String scannerScreen = '/scanner_screen';

  /// CUSTOM MODELS LIST
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

  static final List<BottomNavModels> bottomNavModels = [
    BottomNavModels(
      icon: NewPayIcons.home,
      label: 'Home',
    ),
    BottomNavModels(
      icon: NewPayIcons.card,
      label: 'Card',
    ),
    BottomNavModels(
      icon: NewPayIcons.activity,
      label: 'Stats',
    ),
    BottomNavModels(
      icon: NewPayIcons.cashback,
      label: 'Cash Back',
    )
  ];
  static final List<CardsGradient> cardsGradient = [
    CardsGradient(
      firstColor: Color(0xff8676FB),
      secondColor: Color(0xffAB7BFF),
    ),
    CardsGradient(
      firstColor: Color(0xffF673FF),
      secondColor: Color(0xffd91e63),
    ),
    CardsGradient(
      firstColor: Color(0xff00F0F0),
      secondColor: Color(0xff5895e0),
    ),
  ];
}
