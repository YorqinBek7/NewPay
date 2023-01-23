import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/styles.dart';

class Helper {
  static showCustomErrorSnackbar(BuildContext context, String error) =>
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
  static showCustomSuccessSnackbar(BuildContext context, String message) =>
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

  static showWaitDialog(BuildContext context) {
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
            child: Center(
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
        title: Text('Exit App'),
        content: Text('Are you sure?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
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
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
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
}
