import 'package:flutter/cupertino.dart';
import 'package:new_pay/ui/auth/forgot_pass_screeen.dart';
import 'package:new_pay/ui/auth/login_screen.dart';
import 'package:new_pay/ui/auth/sign_up_screen.dart';
import 'package:new_pay/ui/auth/verified_screen.dart';
import 'package:new_pay/ui/no_route_screen.dart';
import 'package:new_pay/ui/onboarding/on_boarding_screen.dart';
import 'package:new_pay/ui/onboarding/splash_screen.dart';
import 'package:new_pay/ui/tab_box/add_card_screen/add_card_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/app_settings/app_settings.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/profile_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/qr_code_screen/qr_code_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/send_money_screen/send_money_screen.dart';
import 'package:new_pay/ui/tab_box/home_tab.dart';
import 'package:new_pay/utils/constants.dart';

class NewPayRoutes {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case NewPayConstants.homeTab:
        return navigateToScreen(screen: const BottomNavBlocProvider());
      case NewPayConstants.splashScreen:
        return navigateToScreen(screen: const SplashScreen());
      case NewPayConstants.onboardingScreen:
        return navigateToScreen(screen: const OnBoardingScreen());
      case NewPayConstants.loginScreen:
        return navigateToScreen(screen: const LoginScreen());
      case NewPayConstants.signUpScreen:
        return navigateToScreen(screen: const SignUpScreen());
      case NewPayConstants.verifiedScreen:
        return navigateToScreen(screen: const VerifiedScreen());
      case NewPayConstants.forgotPassScreen:
        return navigateToScreen(screen: ForgotPasswordScreen());
      case NewPayConstants.profileScreen:
        return navigateToScreen(screen: const ProfileScreen());
      case NewPayConstants.appSettings:
        return navigateToScreen(screen: const AppSettings());
      case NewPayConstants.scannerScreen:
        return navigateToScreen(screen: const QrCodeScreen());
      case NewPayConstants.addCardScreen:
        return navigateToScreen(screen: const AddCardScreen());
      case NewPayConstants.sendMoneyScreen:
        return navigateToScreen(screen: SendMoneyScreen());
      default:
        return navigateToScreen(screen: const NoRouteScreen());
    }
  }

  CupertinoPageRoute navigateToScreen({required Widget screen}) =>
      CupertinoPageRoute(
        builder: (context) => screen,
      );
}
