import 'dart:math';

import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/constants.dart';
import 'package:new_pay/utils/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        leading: Icon(Icons.person),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi Man',
              style: NewPayStyles.w500.copyWith(fontSize: 14.0),
            ),
            Text(
              "Let's save your money",
              style: NewPayStyles.w700.copyWith(fontSize: 14.0),
            ),
          ],
        ),
        actions: [
          Icon(Icons.notifications_outlined),
          SizedBox(
            width: 10.0,
          )
        ],
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your balance',
              style: NewPayStyles.w500,
            ),
            Text(
              '\$926.21',
              style: NewPayStyles.w700.copyWith(
                fontSize: 32.0,
                color: NewPayColors.C_171D33,
              ),
            ),
            SizedBox(
              height: 26.0,
            ),
            SizedBox(
              height: 90.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: NewPayConstants.optionsButtonsModels.length,
                itemBuilder: (context, index) => _optionButtons(
                  icon: NewPayConstants.optionsButtonsModels[index].icon,
                  onTap: () {},
                  text: NewPayConstants.optionsButtonsModels[index].name,
                  index: index,
                ),
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

  GestureDetector _optionButtons({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
    required int index,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: index != 3 ? 45.0 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.0,
                    color: NewPayColors.C_828282.withOpacity(.4),
                  ),
                ],
                color: NewPayColors.white,
              ),
              child: Icon(
                icon,
                color: NewPayColors.C_7000FF,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              text,
              style: NewPayStyles.w700.copyWith(
                fontSize: 14.0,
                color: NewPayColors.C_7000FF,
              ),
            )
          ],
        ),
      ),
    );
  }
}
