import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pay/blocs/bloc_observer.dart';
import 'package:new_pay/blocs/login/login_bloc.dart';
import 'package:new_pay/blocs/sign_up/sign_up_bloc.dart';
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
  runApp(const NewPay());
}

class NewPay extends StatelessWidget {
  const NewPay({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          useMaterial3: true,
          scaffoldBackgroundColor: NewPayColors.white,
          appBarTheme: AppBarTheme(
            scrolledUnderElevation: 0.0,
            backgroundColor: NewPayColors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: NewPayColors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            titleTextStyle: NewPayStyles.w600.copyWith(fontSize: 18.0),
            elevation: 0.0,
            toolbarHeight: 0.0,
            centerTitle: true,
          ),
        ),
        initialRoute: NewPayConstants.splashScreen,
        onGenerateRoute: NewPayRoutes().generateRoutes,
      ),
    );
  }
}
