part of 'cards_bloc.dart';

@immutable
abstract class CardsState {}

class CardsInitialState extends CardsState {}

class CardsLoadingState extends CardsState {}

class CardsSuccessState extends CardsState {
  List<CardsModel> cards;
  String sumAllCards;
  String incomes;
  String expenses;
  CardsSuccessState({
    required this.cards,
    required this.sumAllCards,
    required this.incomes,
    required this.expenses,
  });
}

class CardsErrorState extends CardsState {
  final String error;
  CardsErrorState({required this.error});
}
