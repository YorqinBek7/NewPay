import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/helper.dart';

CardModel plasticCards(
  BuildContext context, {
  required Map<String, dynamic> cardsGradient,
  required String cardName,
  required String cardNumber,
  required String sum,
  required String cardPeriod,
  required String cardStatus,
  required String cardType,
}) {
  return CardModel(
    radius: Radius.circular(10.0.r),
    gradient: LinearGradient(
      colors: [
        Helper.hexToColor(cardsGradient['first_color']),
        Helper.hexToColor(cardsGradient['second_color'])
      ],
    ),
    padding: EdgeInsets.all(10.0.r),
    child: SizedBox(
      height: 200.0.h,
      width: MediaQuery.of(context).size.width - 55.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardName,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 12.0.sp, color: NewPayColors.white),
              ),
              Text(
                cardType,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 18.0.sp, color: NewPayColors.white),
              )
            ],
          ),
          const Spacer(),
          Text(
            Helper.currenyFormat(sum),
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontSize: 24.0.sp, color: NewPayColors.white),
          ),
          const Spacer(),
          Text(
            cardStatus,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontSize: 12.0.sp, color: NewPayColors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardPeriod,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 12.0.sp, color: NewPayColors.white),
              ),
              Text(
                "**** ${cardNumber.substring(14)}",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: NewPayColors.white,
                    ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
