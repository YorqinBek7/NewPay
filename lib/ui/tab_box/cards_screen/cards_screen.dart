import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pay/blocs/cards/cards_bloc.dart';
import 'package:new_pay/ui/tab_box/cards_screen/widgets/charts.dart';
import 'package:new_pay/ui/tab_box/cards_screen/widgets/plastic_cards.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/styles.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 200.0,
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      LineChart(
                        mainData(true),
                      ),
                      Positioned(
                        left: 5.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Income',
                                style: NewPayStyles.w500.copyWith(
                                    color:
                                        NewPayColors.C_367B72.withOpacity(.5))),
                            BlocBuilder<CardsBloc, CardsState>(
                              builder: (context, state) {
                                if (state is CardsSuccessState) {
                                  return Text(
                                    Helper.currenyFormat(state.incomes),
                                    style: NewPayStyles.w500.copyWith(
                                      fontSize: 16.0,
                                      color: NewPayColors.C_360C4A,
                                    ),
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
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: NewPayColors.C_4EFF8A,
                                  size: 15.0,
                                ),
                                Text("+1300 so'm",
                                    style: NewPayStyles.w400.copyWith(
                                        fontSize: 14.0,
                                        color: NewPayColors.C_367B72)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      LineChart(
                        mainData(false),
                      ),
                      Positioned(
                        left: 5.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Expenses',
                                style: NewPayStyles.w500.copyWith(
                                    color:
                                        NewPayColors.C_360C4A.withOpacity(.5))),
                            BlocBuilder<CardsBloc, CardsState>(
                              builder: (context, state) {
                                if (state is CardsSuccessState) {
                                  return Text(
                                      Helper.currenyFormat(state.expenses),
                                      style: NewPayStyles.w500.copyWith(
                                          fontSize: 16.0,
                                          color: NewPayColors.C_360C4A));
                                } else if (state is CardsLoadingState) {
                                  return CircularProgressIndicator();
                                } else if (state is CardsErrorState) {
                                  return Text(state.error);
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: NewPayColors.C_FF6770,
                                  size: 15.0,
                                ),
                                Text("-1300 so'm",
                                    style: NewPayStyles.w400.copyWith(
                                        fontSize: 14.0,
                                        color: NewPayColors.C_360C4A)),
                              ],
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
            height: 15.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Text(
              'My Cards',
              style: NewPayStyles.w400.copyWith(
                fontSize: 14.0,
                color: NewPayColors.C_828282,
              ),
            ),
          ),
          BlocBuilder<CardsBloc, CardsState>(builder: (context, state) {
            if (state is CardsSuccessState) {
              return Expanded(
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
                ),
              );
            } else if (state is CardsErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })
        ],
      ),
    );
  }
}
