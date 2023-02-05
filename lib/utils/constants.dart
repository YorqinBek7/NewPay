import 'package:easy_localization/easy_localization.dart';
import 'package:new_pay/models/bottom_nav_models.dart';
import 'package:new_pay/models/cards_gradient.dart';
import 'package:new_pay/models/mini_card_with_pic.dart';
import 'package:new_pay/models/onboarding_model.dart';
import 'package:new_pay/models/payments.dart';
import 'package:new_pay/utils/icons.dart';

class NewPayConstants {
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
  static const String notifScreen = '/notif_screen';
  static const String selectCardToPhoneNumberScreen =
      '/select_card_to_phone_number';
  static const String paymentScreen = '/payment_screen';

  /// CUSTOM MODELS LIST
  static final List<OnBoardingModel> onBoardingModels = [
    OnBoardingModel(
        image: NewPayIcons.onBoardingScreen_1,
        text: tr('on_boarding_first_screen')),
    OnBoardingModel(
        image: NewPayIcons.onBoardingScreen_2,
        text: tr('on_boarding_second_screen')),
    OnBoardingModel(
        image: NewPayIcons.onBoardingScreen_3,
        text: tr('on_boarding_third_screen')),
  ];

  static final List<BottomNavModels> bottomNavModels = [
    BottomNavModels(
      icon: NewPayIcons.home,
      label: tr('home'),
    ),
    BottomNavModels(
      icon: NewPayIcons.card,
      label: tr('card'),
    ),
    BottomNavModels(
      icon: NewPayIcons.activity,
      label: tr('stats'),
    ),
    BottomNavModels(
      icon: NewPayIcons.more,
      label: tr('payments'),
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

  static final List<Payments> payments = [
    Payments(
      icon: NewPayIcons.phone,
      title: tr('phone'),
    ),
    Payments(
      icon: NewPayIcons.internet,
      title: tr('internet_provider'),
    ),
    Payments(
      icon: NewPayIcons.game,
      title: tr('game_service'),
    ),
    Payments(
      icon: NewPayIcons.shop,
      title: tr('shop_store'),
    ),
    Payments(
      icon: NewPayIcons.tv,
      title: tr('tv_service'),
    ),
    Payments(
      icon: NewPayIcons.restaurant,
      title: tr('restaurants'),
    ),
  ];

  static MiniCard? miniCard;
}
