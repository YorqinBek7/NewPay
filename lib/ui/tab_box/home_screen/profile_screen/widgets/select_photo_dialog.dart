import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_pay/blocs/update_image/update_image_bloc.dart';
import 'package:new_pay/utils/helper.dart';
import 'package:permission_handler/permission_handler.dart';

Future selectPhotoDialog(BuildContext _) async => showMaterialModalBottomSheet(
      context: _,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0.r),
          topRight: Radius.circular(10.0.r),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .2,
          child: Column(
            children: [
              SizedBox(
                height: 10.0.h,
              ),
              Text(
                tr('select_photo'),
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 17.0.sp),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              ListTile(
                onTap: () async {
                  if (await Helper.requestPermission(
                      setting: Permission.camera)) {
                    BlocProvider.of<UpdateImageBloc>(_)
                        .add(UpdateImageManagerEvent(true));
                    Helper.showCustomSuccessSnackbar(
                        context, tr('wait_updating_photo'));
                  } else {
                    Helper.showTopErrorSnackbar(
                        context: context,
                        error: tr('perm_denied_allow_setting'));
                    await Future.delayed(const Duration(milliseconds: 1500));
                    if (await Helper.requestPermission(
                        setting: Permission.location)) {
                      await openAppSettings();
                    }
                  }
                },
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(
                  tr('take_cam'),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              ListTile(
                onTap: () async {
                  if (await Helper.requestPermission(
                      setting: Permission.camera)) {
                    BlocProvider.of<UpdateImageBloc>(_)
                        .add(UpdateImageManagerEvent(false));
                    Helper.showCustomSuccessSnackbar(
                        context, tr('wait_updating_photo'));
                  } else {
                    Helper.showTopErrorSnackbar(
                        context: context,
                        error: tr('perm_denied_allow_setting'));
                    await Future.delayed(const Duration(seconds: 2));
                    if (await Helper.requestPermission(
                        setting: Permission.location)) {
                      await openAppSettings();
                    }
                  }
                },
                leading: const Icon(Icons.image_outlined),
                title: Text(
                  tr('choose_gallery'),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        );
      },
    );
