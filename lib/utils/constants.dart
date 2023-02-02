import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_pay/models/bottom_nav_models.dart';
import 'package:new_pay/models/cards_gradient.dart';
import 'package:new_pay/models/mini_card_with_pic.dart';
import 'package:new_pay/models/onboarding_model.dart';
import 'package:new_pay/utils/icons.dart';

class NewPayConstants {
  //CONSTANTS
  static User user = FirebaseAuth.instance.currentUser!;

  // SCREENS
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
  static const String addCardScreen = '/add_card_screen';
  static const String sendMoneyScreen = '/send_money_screen';
  static const String sendToCardScreen = '/send_to_card_screen';
  static const String sendToPhoneScreen = '/send_to_phone_screen';
  static const String noInternetScreen = '/no_internet_screen';
  static const String payScreen = '/pay_screen';
  static const String selectCardToPhoneNumberScreen =
      '/select_card_to_phone_number';
  static const String paymentScreen = '/payment_screen';

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
      icon: NewPayIcons.more,
      label: 'Payment',
    )
  ];
  static final List<CardsGradient> cardsGradient = [
    CardsGradient(
      firstColor: '0xff03CAFF',
      secondColor: '0xff5D00FF',
    ),
    CardsGradient(
      firstColor: '0xff000000',
      secondColor: '0xff5D00FF',
    ),
    CardsGradient(
      firstColor: '0xffFF9393',
      secondColor: '0xff7774FF',
    ),
    CardsGradient(
      firstColor: '0xffA4ECFF',
      secondColor: '0xffD2B8FF',
    ),
  ];

  static final List<String> selectedCardsGradient = [
    NewPayConstants.cardsGradient[0].firstColor,
    NewPayConstants.cardsGradient[1].secondColor,
  ];

  static MiniCard? miniCard;
}
