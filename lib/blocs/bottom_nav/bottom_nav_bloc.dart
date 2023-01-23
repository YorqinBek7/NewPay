import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'bottom_nav_event.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, int> {
  BottomNavBloc() : super(0) {
    on<BottomNavEvent>((event, emit) {
      if (event is BottomNavManagerEvent) {
        emit(event.index);
      }
    });
  }
}
