import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/styles.dart';

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
    radius: const Radius.circular(10.0),
    gradient: LinearGradient(
      colors: [
        Helper.hexToColor(cardsGradient['first_color']),
        Helper.hexToColor(cardsGradient['second_color'])
      ],
    ),
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 200.0,
      width: MediaQuery.of(context).size.width - 55.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardName,
                style: NewPayStyles.w700
                    .copyWith(fontSize: 12.0, color: NewPayColors.white),
              ),
              Text(
                cardType,
                style: NewPayStyles.w800
                    .copyWith(fontSize: 18.0, color: NewPayColors.white),
              )
            ],
          ),
          const Spacer(),
          Text(
            Helper.currenyFormat(sum),
            style: NewPayStyles.w500
                .copyWith(fontSize: 24.0, color: NewPayColors.white),
          ),
          const Spacer(),
          Text(
            cardStatus,
            style: NewPayStyles.w400
                .copyWith(fontSize: 12.0, color: NewPayColors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardPeriod,
                style: NewPayStyles.w700
                    .copyWith(fontSize: 12.0, color: NewPayColors.white),
              ),
              Text(
                "**** ${cardNumber.substring(14)}",
                style: NewPayStyles.w400.copyWith(
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
