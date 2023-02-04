import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/blocs/internet_checker/internet_checker_bloc.dart';
import 'package:new_pay/utils/icons.dart';

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
          automaticallyImplyLeading: false,
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50.0.h,
                ),
                Image.asset(
                  NewPayIcons.noInternet,
                  height: 288.0.h,
                  width: 256.0.w,
                  fit: BoxFit.cover,
                ),
                Text(
                  'No connect Internet',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 24.0.sp),
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
