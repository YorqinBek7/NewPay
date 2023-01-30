part of 'cards_bloc.dart';

@immutable
abstract class CardsState {}

class CardsInitialState extends CardsState {}

class CardsLoadingState extends CardsState {}

class CardsSuccessState extends CardsState {
  final List<CardsModel> cards;
  final String allSum;
  final String incomes;
  final String expenses;
  CardsSuccessState({
    required this.cards,
    required this.allSum,
    required this.expenses,
    required this.incomes,
  });
}

class CardsErrorState extends CardsState {
  final String error;
  CardsErrorState({required this.error});
}
