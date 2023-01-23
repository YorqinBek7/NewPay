import 'package:flutter/material.dart';
import 'package:new_pay/ui/tab_box/home_screen/home_screen.dart';
import 'package:new_pay/utils/helper.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Helper.exitdialog(context),
      child: Scaffold(
        body: IndexedStack(
          children: [
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
