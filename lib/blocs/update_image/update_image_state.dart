part of 'update_image_bloc.dart';

@immutable
abstract class UpdateImageState {}

class UpdateImageInitialState extends UpdateImageState {}

class UpdateImageLoadingState extends UpdateImageState {}

class UpdateImageUpdatedState extends UpdateImageState {
  UpdateImageUpdatedState();
}

class UpdateImageErrorState extends UpdateImageState {
  UpdateImageErrorState();
}
