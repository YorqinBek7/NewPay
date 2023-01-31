part of 'monitoring_bloc.dart';

@immutable
abstract class MonitoringEvent {}

class MonitoringManagerEvent extends MonitoringEvent {
  final String userId;
  MonitoringManagerEvent({required this.userId});
}
