part of 'select_cards_to_send_bloc.dart';

@immutable
abstract class SelectCardsState {}

class SelectCardsInitialState extends SelectCardsState {}

class SelectCardsChangedState extends SelectCardsState {
  SelectCardsChangedState();
}
