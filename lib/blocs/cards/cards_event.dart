part of 'cards_bloc.dart';

@immutable
abstract class CardsEvent {}

class CardsGetEvent extends CardsEvent {
  CardsGetEvent();
}
