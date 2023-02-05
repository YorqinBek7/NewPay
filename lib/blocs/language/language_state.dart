part of 'language_bloc.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageChanged extends LanguageState {}
