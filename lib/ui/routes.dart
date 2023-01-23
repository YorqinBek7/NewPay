import 'package:flutter/cupertino.dart';
import 'package:new_pay/ui/auth/forgot_pass_screeen.dart';
import 'package:new_pay/ui/auth/login_screen.dart';
import 'package:new_pay/ui/auth/sign_up_screen.dart';
import 'package:new_pay/ui/auth/verified_screen.dart';
import 'package:new_pay/ui/no_route_screen.dart';
import 'package:new_pay/ui/onboarding/on_boarding_screen.dart';
import 'package:new_pay/ui/onboarding/splash_screen.dart';
import 'package:new_pay/ui/tab_box/home_tab.dart';
import 'package:new_pay/utils/constants.dart';

class NewPayRoutes {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case NewPayConstants.homeTab:
        return navigateToScreen(screen: const HomeTab());
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
      default:
        return navigateToScreen(screen: const NoRouteScreen());
    }
  }

  CupertinoPageRoute navigateToScreen({required Widget screen}) =>
      CupertinoPageRoute(
        builder: (context) => screen,
      );
}
