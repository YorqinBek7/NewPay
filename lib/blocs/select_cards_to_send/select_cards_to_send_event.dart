part of 'select_cards_to_send_bloc.dart';

@immutable
abstract class SelectCardsEvent {}

class SelectCardsManagerEvent extends SelectCardsEvent {
  final int index;
  SelectCardsManagerEvent({required this.index});
}
