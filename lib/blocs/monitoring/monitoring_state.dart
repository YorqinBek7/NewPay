part of 'monitoring_bloc.dart';

@immutable
abstract class MonitoringState {}

class MonitoringInitialState extends MonitoringState {}

class MonitoringLoadingState extends MonitoringState {}

class MonitoringSuccesState extends MonitoringState {
  final List<Transfers> transfers;
  MonitoringSuccesState({required this.transfers});
}

class MonitoringErrorState extends MonitoringState {
  final String error;
  MonitoringErrorState({required this.error});
}
