import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_pay/blocs/update_image/update_image_bloc.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:new_pay/utils/styles.dart';
import 'package:permission_handler/permission_handler.dart';

selectPhotoDialog(BuildContext _) async => showMaterialModalBottomSheet(
      context: _,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .2,
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Select a photo to profile',
                style: NewPayStyles.w800.copyWith(fontSize: 17.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                onTap: () async {
                  if (await Helper.requestPermission(
                      setting: Permission.camera)) {
                    BlocProvider.of<UpdateImageBloc>(_)
                        .add(UpdateImageManagerEvent(true));
                  } else {
                    Helper.showTopErrorSnackbar(
                        context: context,
                        error: 'Permission is denied, allow from settings');
                    await Future.delayed(const Duration(milliseconds: 1500));
                    if (await Helper.requestPermission(
                        setting: Permission.location)) {
                      await openAppSettings();
                    }
                  }
                },
                leading: Icon(Icons.camera_alt_outlined),
                title: Text('Take from camera'),
              ),
              ListTile(
                onTap: () async {
                  if (await Helper.requestPermission(
                      setting: Permission.camera)) {
                    BlocProvider.of<UpdateImageBloc>(_)
                        .add(UpdateImageManagerEvent(false));
                  } else {
                    Helper.showTopErrorSnackbar(
                        context: context,
                        error: 'Permission is denied, allow from settings');
                    await Future.delayed(const Duration(seconds: 2));
                    if (await Helper.requestPermission(
                        setting: Permission.location)) {
                      await openAppSettings();
                    }
                  }
                },
                leading: Icon(Icons.image_outlined),
                title: Text('Choose from gallery'),
              ),
            ],
          ),
        );
      },
    );
