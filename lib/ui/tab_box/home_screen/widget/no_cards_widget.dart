import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';

GestureDetector noCardsView(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, NewPayConstants.addCardScreen),
    child: Container(
      height: 188.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
        color: NewPayColors.white,
        boxShadow: [
          BoxShadow(
              color: NewPayColors.C_828282.withOpacity(.15), blurRadius: 10.0.r)
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                NewPayColors.C_7000FF,
              )),
              onPressed: () =>
                  Navigator.pushNamed(context, NewPayConstants.addCardScreen),
              icon: const Icon(
                Icons.add,
                color: NewPayColors.white,
              ),
            ),
            Text(
              'Add bank card',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontSize: 12.0.sp, color: NewPayColors.black),
            )
          ],
        ),
      ),
    ),
  );
}
