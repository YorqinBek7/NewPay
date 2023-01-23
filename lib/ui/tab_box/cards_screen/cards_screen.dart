import 'dart:math';

import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_pay/ui/tab_box/cards_screen/widgets/charts.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/styles.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.0,
            ),
            SizedBox(
              height: 200.0,
              child: Row(
                children: [
                  Expanded(
                    child: LineChart(
                      mainData(),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: LineChart(
                      mainData(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'My Cards',
              style: NewPayStyles.w400.copyWith(
                fontSize: 14.0,
                color: NewPayColors.C_828282,
              ),
            ),
            Expanded(
              child: CardStackWidget.builder(
                  count: 3, builder: (index) => _plasticCards(context)),
            )
          ],
        ),
      ),
    );
  }

  CardModel _plasticCards(BuildContext context) {
    var color =
        Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
    return CardModel(
      radius: Radius.circular(10.0),
      backgroundColor: color,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: 200.0,
        width: MediaQuery.of(context).size.width - 80.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hamkor bank',
                  style: NewPayStyles.w700
                      .copyWith(fontSize: 12.0, color: NewPayColors.white),
                ),
                Icon(Icons.card_giftcard_outlined)
              ],
            ),
            Spacer(),
            Text(
              '93 254 000.25 uzs',
              style: NewPayStyles.w500
                  .copyWith(fontSize: 24.0, color: NewPayColors.white),
            ),
            Spacer(),
            Text(
              'Expires',
              style: NewPayStyles.w400
                  .copyWith(fontSize: 12.0, color: NewPayColors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hamkor bank',
                  style: NewPayStyles.w700
                      .copyWith(fontSize: 12.0, color: NewPayColors.white),
                ),
                Icon(Icons.card_giftcard_outlined)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
