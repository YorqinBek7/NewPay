import 'package:flutter/material.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/icons.dart';
import 'package:new_pay/utils/styles.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Monitoring',
              style: NewPayStyles.w600.copyWith(fontSize: 18.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: _monthlyStatsItem(
                      month: 'Spends on January',
                      sum: '-329 441,29',
                      sumColor: NewPayColors.C_F90000),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: _monthlyStatsItem(
                      month: 'Plus on January',
                      sum: '+329 441,29',
                      sumColor: NewPayColors.C_00F0FF),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: NewPayColors.white,
              ),
              margin: EdgeInsets.symmetric(vertical: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: NewPayStyles.w400
                        .copyWith(fontSize: 12.0, color: NewPayColors.C_828282),
                  ),
                  // All transactions
                  ...List.generate(
                    4,
                    (index) => Container(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Image.asset(NewPayIcons.paymentService),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Firdavs & Yorqin',
                                style: NewPayStyles.w500,
                              ),
                              Text(
                                'Передача друзьям',
                                style: NewPayStyles.w400,
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '- 15,000 UZS',
                                style: NewPayStyles.w500,
                              ),
                              Text(
                                '2:30 a.m',
                                style: NewPayStyles.w400,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//_monthlyStatsItem is simple container. About incomes and payments
  Container _monthlyStatsItem({
    required String month,
    required String sum,
    required Color sumColor,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: NewPayColors.white,
      ),
      child: Column(
        children: [
          Text(
            month,
            style: NewPayStyles.w400
                .copyWith(fontSize: 14.0, color: NewPayColors.C_828282),
          ),
          Text(
            '$sum uzs',
            style: NewPayStyles.w700.copyWith(color: sumColor),
          )
        ],
      ),
    );
  }
}
