import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_pay/utils/constants.dart';
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

        await helper.saveToServer(NewPayConstants.user.displayName!, imagePath);
        var imageUrl =
            await helper.getImageUrl(NewPayConstants.user.displayName!);

        await helper.updateProfileImage(NewPayConstants.user, imageUrl);

        emit(UpdateImageUpdatedState());
      } catch (e) {
        emit(UpdateImageErrorState());
        throw Exception(e);
      }
    }
  }
}
