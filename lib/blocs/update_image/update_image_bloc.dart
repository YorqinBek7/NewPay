import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_pay/utils/helper.dart';

part 'update_image_event.dart';
part 'update_image_state.dart';

class UpdateImageBloc extends Bloc<UpdateImageEvent, UpdateImageState> {
  UpdateImageBloc() : super(UpdateImageInitialState()) {
    on<UpdateImageEvent>(tryToUpdateImage);
  }

  tryToUpdateImage(
      UpdateImageEvent event, Emitter<UpdateImageState> emit) async {
    if (event is UpdateImageManagerEvent) {
      emit(UpdateImageLoadingState());
      try {
        String imagePath =
            await Helper.instance.tryGetPickedImagePath(event.fromCamera);

        await Helper.instance.saveToServer(
            FirebaseAuth.instance.currentUser!.displayName!, imagePath);

        var imageUrl = await Helper.instance
            .getImageUrl(FirebaseAuth.instance.currentUser!.displayName!);

        await Helper.instance
            .updateProfileImage(FirebaseAuth.instance.currentUser!, imageUrl);

        emit(UpdateImageUpdatedState());
      } catch (e) {
        emit(UpdateImageErrorState());
        throw Exception(e);
      }
    }
  }
}
