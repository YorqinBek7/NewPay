part of 'bottom_nav_bloc.dart';

@immutable
abstract class BottomNavEvent {}

class BottomNavManagerEvent extends BottomNavEvent {
  int index;
  BottomNavManagerEvent({
    required this.index,
  });
}
