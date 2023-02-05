import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/ui/onboarding/onboarding_screens.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/widgets/global_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Helper.exitdialog(context),
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Flexible(
              flex: 5,
              child: PageView.builder(
                itemCount: NewPayConstants.onBoardingModels.length,
                onPageChanged: (value) => setState(() => currentIndex = value),
                itemBuilder: (context, index) => onBoardingScreen(
                  NewPayConstants.onBoardingModels[index].image,
                  NewPayConstants.onBoardingModels[index].text,
                  context,
                ),
              ),
            ),
            currentIndex != 2
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      onboardingCircles(0, currentIndex),
                      onboardingCircles(1, currentIndex),
                      onboardingCircles(2, currentIndex),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GlobalButton(
                          buttonText: tr('sign_up'),
                          onTap: () => Navigator.pushReplacementNamed(
                              context, NewPayConstants.signUpScreen),
                        ),
                      ),
                      Expanded(
                        child: GlobalButton(
                          buttonText: tr('login'),
                          backgroundColor: NewPayColors.black,
                          onTap: () => Navigator.pushReplacementNamed(
                              context, NewPayConstants.loginScreen),
                        ),
                      ),
                    ],
                  ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Container onboardingCircles(int index, int currentIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0.w),
      width: 10.0.w,
      height: 10.0.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            index == currentIndex ? NewPayColors.black : NewPayColors.C_C1C1C1,
      ),
    );
  }
}
