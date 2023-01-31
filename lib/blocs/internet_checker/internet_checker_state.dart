part of 'internet_checker_bloc.dart';

@immutable
abstract class InternetCheckerState {}

class InternetCheckerHasInternet extends InternetCheckerState {}

class InternetCheckerHasNoInternet extends InternetCheckerState {}
