import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/data/service.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class SendMoneyScreen extends StatelessWidget {
  SendMoneyScreen({super.key});
  final CardsService service = CardsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfers'),
        backgroundColor: NewPayColors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: NewPayColors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: NewPayColors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.0.h,
          ),
          _optionTransfer(
              name: 'Send to Card',
              icon: NewPayIcons.cards,
              onTap: () => Navigator.pushNamed(
                  context, NewPayConstants.sendToCardScreen)),
          _optionTransfer(
              name: 'Send to phone number',
              icon: NewPayIcons.personalCard,
              onTap: () => Navigator.pushNamed(
                  context, NewPayConstants.sendToPhoneScreen)),
        ],
      ),
    );
  }

  GestureDetector _optionTransfer({
    required String name,
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 20.0.h),
        margin: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 10.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.r),
          color: NewPayColors.white,
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(
              width: 25.0.w,
            ),
            Text(
              name,
              style: NewPayStyles.w600,
            ),
          ],
        ),
      ),
    );
  }
}
