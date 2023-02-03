import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Helper {
  static final Helper instance = Helper._();
  factory Helper() => instance;
  Helper._();
  ImagePicker imagePicker = ImagePicker();

  final _storage = FirebaseStorage.instance.ref('profile_storage/');
  static void showCustomErrorSnackbar(BuildContext context, String error) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error,
            style: NewPayStyles.w500.copyWith(color: NewPayColors.white),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: NewPayColors.C_ff3333,
        ),
      );

  static void showTopErrorSnackbar(
          {required BuildContext context, required String error}) =>
      showTopSnackBar(
        Overlay.of(context)!,
        CustomSnackBar.error(message: error),
      );

  static void showTopSuccessSnackbar(
          {required BuildContext context, required String success}) =>
      showTopSnackBar(
        Overlay.of(context)!,
        CustomSnackBar.success(message: success),
      );

  Future<String> tryGetPickedImagePath(bool fromCamera) async {
    XFile? file = await imagePicker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);
    return file!.path;
  }

  Future<void> updateProfileImage(User user, String imageUrl) async {
    await user.updatePhotoURL(imageUrl);
  }

  Future<void> saveToServer(String imageName, String imagePath) async {
    var fireStorage = _storage.child('$imageName.png');
    await fireStorage.putFile(File(imagePath));
  }

  Future<String> getImageUrl(String image) async {
    var imageUrl = await _storage.child('$image.png').getDownloadURL();
    return imageUrl;
  }

  static void showCustomSuccessSnackbar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: NewPayStyles.w500.copyWith(color: NewPayColors.white),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: NewPayColors.C_4BB543,
        ),
      );

  static Future<void> showWaitDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          content: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }

  static Future<bool> exitdialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0.r),
                border: Border.all(color: NewPayColors.black),
                color: NewPayColors.white,
              ),
              child: Text(
                'No',
                style: NewPayStyles.w500.copyWith(color: NewPayColors.black),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              exit(0);
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0.r),
                color: NewPayColors.black,
              ),
              child: Text(
                'Yes',
                style: NewPayStyles.w500.copyWith(color: NewPayColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String currenyFormat(String sum) =>
      NumberFormat.simpleCurrency(locale: 'uz').format(double.parse(sum));

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(4, 10), radix: 16) + 0xFF000000);
  }

  static bool emailChecker(String v) {
    return !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v);
  }

  static Future<bool> requestPermission({
    required Permission setting,
  }) async {
    final result = await setting.request();
    switch (result) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }
}
