import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_pay/blocs/internet_checker/internet_checker_bloc.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCheckerBloc, InternetCheckerState>(
      listener: (context, state) {
        if (state is InternetCheckerHasInternet) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.0,
          automaticallyImplyLeading: false,
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Image.asset(
                  NewPayIcons.noInternet,
                  height: 288.0,
                  width: 256.0,
                  fit: BoxFit.cover,
                ),
                Text(
                  'No connect Internet',
                  style: NewPayStyles.w800.copyWith(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
