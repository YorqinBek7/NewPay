import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/blocs/language/language_bloc.dart';
import 'package:new_pay/blocs/monitoring/monitoring_bloc.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/icons.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0.0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Text(
                      'Monitoring',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 18.0.sp),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<CardsBloc, CardsState>(
                            builder: (context, state) {
                              if (state is CardsSuccessState) {
                                return _monthlyStatsItem(
                                  month: tr('expenses'),
                                  sum: Helper.currenyFormat(state.expenses),
                                  sumColor: NewPayColors.C_F90000,
                                  context: context,
                                );
                              } else if (state is CardsLoadingState) {
                                return const CircularProgressIndicator();
                              } else if (state is CardsErrorState) {
                                return Text(state.error);
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.0.w,
                        ),
                        Expanded(
                          child: BlocBuilder<CardsBloc, CardsState>(
                            builder: (context, state) {
                              if (state is CardsSuccessState) {
                                return _monthlyStatsItem(
                                  month: tr('incomes'),
                                  sum: Helper.currenyFormat(state.incomes),
                                  sumColor: NewPayColors.C_00F0FF,
                                  context: context,
                                );
                              } else if (state is CardsLoadingState) {
                                return const CircularProgressIndicator();
                              } else if (state is CardsErrorState) {
                                return Text(state.error);
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0.r),
                        color: NewPayColors.white,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 28.0.h),
                      child: BlocBuilder<MonitoringBloc, MonitoringState>(
                        builder: (context, state) {
                          if (state is MonitoringErrorState) {
                            return const SizedBox();
                          } else if (state is MonitoringLoadingState) {
                            return const CircularProgressIndicator();
                          } else if (state is MonitoringSuccesState) {
                            return state.transfers.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tr('transfers'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                fontSize: 12.0.sp,
                                                color: NewPayColors.C_828282),
                                      ),
                                      // All transactions
                                      ...List.generate(
                                        state.transfers.length,
                                        (index) => Padding(
                                          padding: EdgeInsets.all(5.0.r),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                NewPayIcons.paymentService,
                                                width: 48.0.w,
                                                height: 48.h,
                                              ),
                                              SizedBox(
                                                width: 10.0.w,
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.transfers[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                              color:
                                                                  NewPayColors
                                                                      .black),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      state.transfers[index]
                                                          .desc,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              color:
                                                                  NewPayColors
                                                                      .black),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '-${state.transfers[index].sum}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                              color:
                                                                  NewPayColors
                                                                      .black),
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      state.transfers[index]
                                                          .time,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              color:
                                                                  NewPayColors
                                                                      .black),
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : LottieBuilder.asset(
                                    NewPayIcons.noTransaction,
                                    width: 250.0.w,
                                    height: 250.0.h,
                                  );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }

//_monthlyStatsItem is simple container. About incomes and payments

  Container _monthlyStatsItem({
    required String month,
    required String sum,
    required Color sumColor,
    required BuildContext context,
  }) {
    return Container(
      width: double.infinity,
      height: 58.0.h,
      padding: EdgeInsets.all(7.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.r),
        color: NewPayColors.white,
      ),
      child: Column(
        children: [
          Text(
            month,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontSize: 12.0.sp, color: NewPayColors.C_828282),
          ),
          Expanded(
            child: Text(
              '$sum uzs',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: sumColor, fontSize: 15.0.sp),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
