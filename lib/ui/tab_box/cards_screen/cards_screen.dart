import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/ui/tab_box/cards_screen/widgets/charts.dart';
import 'package:new_pay/ui/tab_box/cards_screen/widgets/plastic_cards.dart';
import 'package:new_pay/ui/tab_box/home_screen/widget/no_cards_widget.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/helper.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.0.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0.w),
            height: 200.0.h,
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      LineChart(
                        mainData(true),
                      ),
                      Positioned(
                        left: 5.0.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Income',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: NewPayColors.C_367B72
                                            .withOpacity(.5))),
                            BlocBuilder<CardsBloc, CardsState>(
                              builder: (context, state) {
                                if (state is CardsSuccessState) {
                                  return Text(
                                    Helper.currenyFormat(state.incomes),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 16.0.sp,
                                          color: NewPayColors.C_00F0FF,
                                        ),
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.0.w,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      LineChart(
                        mainData(false),
                      ),
                      Positioned(
                        left: 5.0.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Expenses',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: NewPayColors.C_360C4A
                                            .withOpacity(.5))),
                            BlocBuilder<CardsBloc, CardsState>(
                              builder: (context, state) {
                                if (state is CardsSuccessState) {
                                  return Text(
                                      Helper.currenyFormat(state.expenses),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                              fontSize: 16.0.sp,
                                              color: NewPayColors.C_FF6770));
                                } else if (state is CardsLoadingState) {
                                  return const CircularProgressIndicator();
                                } else if (state is CardsErrorState) {
                                  return Text(state.error);
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0.w),
            child: Text(
              'My Cards',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 14.0.sp,
                    color: NewPayColors.C_828282,
                  ),
            ),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          BlocBuilder<CardsBloc, CardsState>(builder: (context, state) {
            if (state is CardsSuccessState) {
              return state.cards.isNotEmpty
                  ? Expanded(
                      child: CardStackWidget.builder(
                      swipeOrientation: CardOrientation.down,
                      count: state.cards.length,
                      builder: (index) => plasticCards(
                        context,
                        cardName: state.cards[index].cardName,
                        cardNumber: state.cards[index].cardNumber,
                        cardPeriod: state.cards[index].cardPeriod,
                        cardStatus: state.cards[index].cardStatus,
                        cardType: state.cards[index].typeCard,
                        cardsGradient: state.cards[index].gradientColor,
                        sum: state.cards[index].sum,
                      ),
                    ))
                  : noCardsView(context);
            } else if (state is CardsErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })
        ],
      ),
    );
  }
}
