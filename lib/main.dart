import 'package:authentication/auth/login/login_bloc.dart';
import 'package:authentication/auth/sign_up/sign_up_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/blocs/internet_checker/internet_checker_bloc.dart';
import 'package:new_pay/blocs/monitoring/monitoring_bloc.dart';
import 'package:new_pay/blocs/update_image/update_image_bloc.dart';
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
  await Firebase.initializeApp();
  NewPayStorage.instance.sharedPref = await SharedPreferences.getInstance();
  Bloc.observer = GlobalBlocObserver();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => SignUpBloc(),
    ),
    BlocProvider(
      create: (context) => LoginBloc(),
    ),
    BlocProvider(
      create: (context) =>
          CardsBloc()..add(CardsGetEvent(userId: NewPayConstants.user.uid)),
    ),
    BlocProvider(
      create: (context) => ThemeBloc(),
    ),
    BlocProvider(
      create: (context) => MonitoringBloc()
        ..add(MonitoringManagerEvent(userId: NewPayConstants.user.uid)),
    ),
    BlocProvider<UpdateImageBloc>(
      create: (context) => UpdateImageBloc(),
    ),
    BlocProvider(
      create: (context) =>
          InternetCheckerBloc()..add(InternetCheckerManagerEvent()),
    )
  ], child: const NewPay()));
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
              title: 'Flutter Demo',
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
      scaffoldBackgroundColor: NewPayColors.C_203354,
      fontFamily: 'Manrope',
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0.0,
        backgroundColor: NewPayColors.C_203354,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: NewPayColors.C_203354,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: NewPayColors.C_203354,
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

  ThemeData _lightTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      useMaterial3: true,
      scaffoldBackgroundColor: NewPayColors.C_F1F2F6,
      fontFamily: 'Manrope',
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
