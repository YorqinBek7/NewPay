import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pay/blocs/bloc_observer.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/blocs/login/login_bloc.dart';
import 'package:new_pay/blocs/sign_up/sign_up_bloc.dart';
import 'package:new_pay/blocs/theme/theme_bloc.dart';
import 'package:new_pay/data/storage.dart';
import 'package:new_pay/ui/routes.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NewPayStorage.instance.sharedPref = await SharedPreferences.getInstance();
  Bloc.observer = AuthBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SignUpBloc(),
      ),
      BlocProvider(
        create: (context) => LoginBloc(),
      ),
      BlocProvider(
        create: (context) => CardsBloc()
          ..add(CardsGetEvent(userId: FirebaseAuth.instance.currentUser!.uid)),
      ),
      BlocProvider(
        create: (context) => ThemeBloc(),
      ),
    ],
    child: const NewPay(),
  ));
}

class NewPay extends StatelessWidget {
  const NewPay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
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
        ),
        titleTextStyle: NewPayStyles.w600.copyWith(fontSize: 18.0),
        elevation: 0.0,
        toolbarHeight: 0.0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
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
        ),
        titleTextStyle: NewPayStyles.w600.copyWith(fontSize: 18.0),
        elevation: 0.0,
        toolbarHeight: 0.0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: NewPayColors.C_7000FF,
        unselectedItemColor: NewPayColors.C_828282,
      ),
    );
  }
}
