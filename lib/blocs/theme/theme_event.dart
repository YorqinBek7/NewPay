part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeManagerEvent extends ThemeEvent {
  final int themeState;
  ThemeManagerEvent({
    required this.themeState,
  });
}
