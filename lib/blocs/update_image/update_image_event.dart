part of 'update_image_bloc.dart';

@immutable
abstract class UpdateImageEvent {}

class UpdateImageManagerEvent extends UpdateImageEvent {
  final bool fromCamera;
  UpdateImageManagerEvent(this.fromCamera);
}
