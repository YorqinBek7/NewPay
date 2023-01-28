part of 'cards_bloc.dart';

@immutable
abstract class CardsEvent {}

class CardsGetEvent extends CardsEvent {
  CardsGetEvent({required this.userId});
  final String userId;
}
