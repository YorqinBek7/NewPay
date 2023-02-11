import 'package:authentication/auth/login/login_bloc.dart';
import 'package:authentication/auth/sign_up/sign_up_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/blocs/internet_checker/internet_checker_bloc.dart';
import 'package:new_pay/blocs/language/language_bloc.dart';
import 'package:new_pay/blocs/monitoring/monitoring_bloc.dart';
import 'package:new_pay/blocs/update_image/update_image_bloc.dart';
import 'package:new_pay/data/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_pay/blocs/bloc_observer.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/blocs/theme/theme_bloc.dart';
import 'package:new_pay/data/storage.dart';
import 'package:new_pay/ui/routes.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onBackgroundMessage(
  //     NotificationService.instance.backGroundhandler);
  NotificationService.instance.permissoinNotif();
  NotificationService.instance.getToken();
  NotificationService.instance.init();
  NewPayStorage.instance.sharedPref = await SharedPreferences.getInstance();
  Bloc.observer = GlobalBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SignUpBloc(),
      ),
      BlocProvider(
        create: (context) => LoginBloc(),
      ),
      BlocProvider(
        create: (context) => LanguageBloc(),
      ),
      BlocProvider(
        create: (context) => CardsBloc()
          ..add(CardsGetEvent(userId: FirebaseAuth.instance.currentUser!.uid)),
      ),
      BlocProvider(
        create: (context) => ThemeBloc()
          ..add(ThemeManagerEvent(
              themeState: NewPayStorage.instance.getInt('themeState'))),
      ),
      BlocProvider(
        create: (context) => MonitoringBloc()
          ..add(MonitoringManagerEvent(
              userId: FirebaseAuth.instance.currentUser!.uid)),
      ),
      BlocProvider<UpdateImageBloc>(
        create: (context) => UpdateImageBloc(),
      ),
      BlocProvider(
        create: (context) =>
            InternetCheckerBloc()..add(InternetCheckerManagerEvent()),
      )
    ],
    child: EasyLocalization(
      supportedLocales: const [
        Locale('en', 'EN'),
        Locale('uz', 'UZ'),
      ],
      fallbackLocale: const Locale('en', 'EN'),
      path: 'assets/translations',
      child: const NewPay(),
    ),
  ));
}

class NewPay extends StatelessWidget {
  const NewPay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(375.0, 812.0),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'New Pay',
              themeMode: BlocProvider.of<ThemeBloc>(context).theme == 0
                  ? ThemeMode.system
                  : BlocProvider.of<ThemeBloc>(context).theme == 1
                      ? ThemeMode.dark
                      : ThemeMode.light,
              theme: _lightTheme(),
              darkTheme: _darkTheme(),
              initialRoute: NewPayConstants.splashScreen,
              onGenerateRoute: NewPayRoutes().generateRoutes,
            );
          },
        );
      },
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      useMaterial3: true,
      scaffoldBackgroundColor: NewPayColors.darkScaffoldColor,
      fontFamily: 'Manrope',
      iconTheme: const IconThemeData(color: NewPayColors.white),
      cardColor: NewPayColors.white,
      backgroundColor: NewPayColors.white,
      textTheme: TextTheme(
        headline1: NewPayStyles.w800.copyWith(color: NewPayColors.white),
        headline2: NewPayStyles.w700.copyWith(color: NewPayColors.white),
        headline3: NewPayStyles.w600.copyWith(color: NewPayColors.white),
        headline4: NewPayStyles.w500.copyWith(color: NewPayColors.white),
        headline5: NewPayStyles.w400.copyWith(color: NewPayColors.white),
        headline6: NewPayStyles.w600.copyWith(color: NewPayColors.black),
      ),
      appBarTheme: AppBarTheme(
        color: NewPayColors.darkScaffoldColor,
        scrolledUnderElevation: 0.0,
        iconTheme: const IconThemeData(color: NewPayColors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: NewPayColors.darkScaffoldColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: NewPayColors.darkScaffoldColor,
        ),
        titleTextStyle: NewPayStyles.w600
            .copyWith(fontSize: 18.0.sp, color: NewPayColors.white),
        elevation: 0.0,
        toolbarHeight: 60.0.h,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: NewPayColors.C_7000FF,
        unselectedItemColor: NewPayColors.C_828282,
        backgroundColor: NewPayColors.darkScaffoldColor,
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      useMaterial3: true,
      scaffoldBackgroundColor: NewPayColors.C_F1F2F6,
      fontFamily: 'Manrope',
      cardColor: NewPayColors.black,
      iconTheme: const IconThemeData(color: NewPayColors.C_C1C1C1),
      backgroundColor: NewPayColors.black,
      textTheme: TextTheme(
        headline1: NewPayStyles.w800,
        headline2: NewPayStyles.w700,
        headline3: NewPayStyles.w600,
        headline4: NewPayStyles.w500,
        headline5: NewPayStyles.w400,
        headline6: NewPayStyles.w600.copyWith(color: NewPayColors.white),
      ),
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0.0,
        backgroundColor: NewPayColors.C_F1F2F6,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: NewPayColors.C_F1F2F6,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: NewPayColors.white,
        ),
        titleTextStyle: NewPayStyles.w600.copyWith(fontSize: 18.0.sp),
        elevation: 0.0,
        toolbarHeight: 60.0.h,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: NewPayColors.C_7000FF,
        unselectedItemColor: NewPayColors.C_828282,
      ),
    );
  }
}
