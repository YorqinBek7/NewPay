import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pay/data/service.dart';
import 'package:new_pay/models/cards_model.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsService cardsService = CardsService();
  CardsBloc() : super(CardsInitialState()) {
    on<CardsEvent>(getCards);
  }

  void getCards(CardsEvent event, Emitter<CardsState> emit) async {
    if (event is CardsGetEvent) {
      double sum = 0.0;
      double incomes = 0.0;
      double expenses = 0.0;
      emit(CardsLoadingState());

      try {
        await for (var data in cardsService.getCards(event.userId)) {
          for (var element in data) {
            sum += double.parse(element.sum);
            incomes += double.parse(element.income);
            expenses += double.parse(element.expenses);
          }

          emit(
            CardsSuccessState(
              cards: data,
              sumAllCards: sum.toString(),
              expenses: expenses.toString(),
              incomes: incomes.toString(),
            ),
          );
        }
      } catch (e) {
        emit(CardsErrorState(error: e.toString()));
      }
    }
  }
}
