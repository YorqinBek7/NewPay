import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_pay/utils/helper.dart';

part 'update_image_event.dart';
part 'update_image_state.dart';

class UpdateImageBloc extends Bloc<UpdateImageEvent, UpdateImageState> {
  Helper helper = Helper();
  UpdateImageBloc() : super(UpdateImageInitialState()) {
    on<UpdateImageEvent>(tryToUpdateImage);
  }

  tryToUpdateImage(
      UpdateImageEvent event, Emitter<UpdateImageState> emit) async {
    if (event is UpdateImageManagerEvent) {
      emit(UpdateImageLoadingState());
      try {
        String imagePath = await helper.tryGetPickedImagePath(event.fromCamera);

        await helper.saveToServer(
            FirebaseAuth.instance.currentUser!.displayName!, imagePath);
        var imageUrl = await helper
            .getImageUrl(FirebaseAuth.instance.currentUser!.displayName!);

        await helper.updateProfileImage(
            FirebaseAuth.instance.currentUser!, imageUrl);

        emit(UpdateImageUpdatedState());
      } catch (e) {
        emit(UpdateImageErrorState());
        throw Exception(e);
      }
    }
  }
}
