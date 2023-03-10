import 'package:flutter/cupertino.dart';
import 'package:new_pay/ui/auth/forgot_pass_screeen.dart';
import 'package:new_pay/ui/auth/login_screen.dart';
import 'package:new_pay/ui/auth/sign_up_screen.dart';
import 'package:new_pay/ui/auth/verified_screen.dart';
import 'package:new_pay/ui/no_internet_screen/no_internet_screen.dart';
import 'package:new_pay/ui/no_route_screen.dart';
import 'package:new_pay/ui/onboarding/on_boarding_screen.dart';
import 'package:new_pay/ui/onboarding/splash_screen.dart';
import 'package:new_pay/ui/tab_box/add_card_screen/add_card_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/notification_screen/notification_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/pay_screen/pay_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/app_settings/app_settings.dart';
import 'package:new_pay/ui/tab_box/home_screen/profile_screen/profile_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/qr_code_screen/qr_code_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/send_money_screen/send_money_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/send_money_screen/send_to_card_screen/send_to_card_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/send_money_screen/send_to_phone_screen/select_card_screen.dart';
import 'package:new_pay/ui/tab_box/home_screen/send_money_screen/send_to_phone_screen/send_to_phone_screen.dart';
import 'package:new_pay/ui/tab_box/home_tab.dart';
import 'package:new_pay/ui/tab_box/payment_screen/payment_screen.dart';
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
        return navigateToScreen(screen: const UpdateImage());
      case NewPayConstants.appSettings:
        return navigateToScreen(screen: const AppSettingsScreen());
      case NewPayConstants.scannerScreen:
        return navigateToScreen(screen: const QrCodeScreen());
      case NewPayConstants.addCardScreen:
        return navigateToScreen(screen: const AddCardScreen());
      case NewPayConstants.sendMoneyScreen:
        return navigateToScreen(screen: SendMoneyScreen());
      case NewPayConstants.noInternetScreen:
        return navigateToScreen(screen: const NoInternetScreen());
      case NewPayConstants.sendToCardScreen:
        return navigateToScreen(screen: const SendToCardScreen());
      case NewPayConstants.sendToPhoneScreen:
        return navigateToScreen(screen: SendToPhoneScreen());
      case NewPayConstants.payScreen:
        return navigateToScreen(screen: const PayScreen());
      case NewPayConstants.selectCardToPhoneNumberScreen:
        return navigateToScreen(screen: const SelectCardScreen());
      case NewPayConstants.paymentScreen:
        return navigateToScreen(screen: const PaymentScreen());
      case NewPayConstants.notifScreen:
        return navigateToScreen(screen: const NotificationScreen());
      default:
        return navigateToScreen(screen: const NoRouteScreen());
    }
  }

  CupertinoPageRoute navigateToScreen({required Widget screen}) =>
      CupertinoPageRoute(
        builder: (context) => screen,
      );
}
