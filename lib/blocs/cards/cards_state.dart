part of 'cards_bloc.dart';

@immutable
abstract class CardsState {}

class CardsInitialState extends CardsState {}

class CardsLoadingState extends CardsState {}

class CardsSuccessState extends CardsState {
  List<CardsModel> cards;
  String sumAllCards;
  CardsSuccessState({
    required this.cards,
    required this.sumAllCards,
  });
}

class CardsErrorState extends CardsState {
  final String error;
  CardsErrorState({required this.error});
}
