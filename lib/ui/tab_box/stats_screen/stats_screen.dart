import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/blocs/monitoring/monitoring_bloc.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/helper.dart';
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                child: BlocBuilder<CardsBloc, CardsState>(
                  builder: (context, state) {
                    if (state is CardsSuccessState) {
                      return _monthlyStatsItem(
                        month: 'Expenses',
                        sum: Helper.currenyFormat(state.expenses),
                        sumColor: NewPayColors.C_F90000,
                      );
                    } else if (state is CardsLoadingState) {
                      return CircularProgressIndicator();
                    } else if (state is CardsErrorState) {
                      return Text(state.error);
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: BlocBuilder<CardsBloc, CardsState>(
                  builder: (context, state) {
                    if (state is CardsSuccessState) {
                      return _monthlyStatsItem(
                        month: 'Incomes',
                        sum: Helper.currenyFormat(state.incomes),
                        sumColor: NewPayColors.C_00F0FF,
                      );
                    } else if (state is CardsLoadingState) {
                      return CircularProgressIndicator();
                    } else if (state is CardsErrorState) {
                      return Text(state.error);
                    } else {
                      return SizedBox();
                    }
                  },
                ),
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
            child: BlocBuilder<MonitoringBloc, MonitoringState>(
              builder: (context, state) {
                if (state is MonitoringErrorState) {
                  return SizedBox();
                } else if (state is MonitoringLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is MonitoringSuccesState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transfers',
                        style: NewPayStyles.w400.copyWith(
                            fontSize: 12.0, color: NewPayColors.C_828282),
                      ),
                      // All transactions
                      ...List.generate(
                        state.transfers.length,
                        (index) => Container(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Image.asset(NewPayIcons.paymentService),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.transfers[index].name,
                                    style: NewPayStyles.w500,
                                  ),
                                  Text(
                                    state.transfers[index].desc,
                                    style: NewPayStyles.w400,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    state.transfers[index].sum,
                                    style: NewPayStyles.w500,
                                  ),
                                  Text(
                                    state.transfers[index].time,
                                    style: NewPayStyles.w400,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          )
        ]),
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
            style: NewPayStyles.w700.copyWith(color: sumColor, fontSize: 15.0),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
