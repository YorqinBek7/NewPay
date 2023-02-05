import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/input_formatters.dart';
import 'package:new_pay/widgets/global_button.dart';

class SendToPhoneScreen extends StatelessWidget {
  SendToPhoneScreen({super.key});
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('phone')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).cardColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('write_your_number'),
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 11.0.sp),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0.h),
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0.r),
                color: NewPayColors.white,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    NewPayIcons.uzFlag,
                    width: 28.0.w,
                    height: 20.0.h,
                  ),
                  SizedBox(
                    width: 5.0.w,
                  ),
                  Flexible(
                    child: TextField(
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 16.0.sp, color: NewPayColors.black),
                      inputFormatters: [EnterPhoneNumberFormatter()],
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '** *** ** **',
                        prefixIcon: Text(
                          '+998 ',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontSize: 16.0.sp, color: NewPayColors.black),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minHeight: 0.0,
                          maxHeight: 20.0,
                        ),
                        labelStyle:
                            Theme.of(context).textTheme.headline4!.copyWith(
                                  color: NewPayColors.C_C1C1C1,
                                  fontSize: 14.0.sp,
                                ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GlobalButton(
                buttonText: tr('next'),
                backgroundColor: NewPayColors.black,
                onTap: () {
                  if (phoneController.text.isEmpty ||
                      phoneController.text.length < 9) {
                    Helper.showCustomErrorSnackbar(
                        context, tr('pls_fill_phone_field'));
                    return;
                  }
                  Navigator.pushNamed(
                      context, NewPayConstants.selectCardToPhoneNumberScreen);
                }),
            SizedBox(
              height: 10.0.h,
            ),
          ],
        ),
      ),
    );
  }
}
