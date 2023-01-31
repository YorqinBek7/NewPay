import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_pay/data/service.dart';
import 'package:new_pay/models/transfers.dart';

part 'monitoring_event.dart';
part 'monitoring_state.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  CardsService service = CardsService();
  MonitoringBloc() : super(MonitoringInitialState()) {
    on<MonitoringEvent>(tryToGetTransfers);
  }
  tryToGetTransfers(
      MonitoringEvent event, Emitter<MonitoringState> emit) async {
    if (event is MonitoringManagerEvent) {
      emit(MonitoringLoadingState());
      try {
        List<Transfers> transfers = [];
        var transfer = await service.getTransfers(event.userId);
        for (var element in transfer) {
          for (var element2 in element) {
            transfers.add(element2);
          }
        }
        emit(MonitoringSuccesState(transfers: transfers));
      } catch (e) {
        emit(MonitoringErrorState(error: e.toString()));
        throw Exception(e);
      }
    }
  }
}
