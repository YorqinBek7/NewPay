import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

  static String currenyFormat(String sum) =>
      NumberFormat.simpleCurrency(locale: 'uz').format(double.parse(sum));

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(4, 10), radix: 16) + 0xFF000000);
  }

  static bool emailChecker(String v) {
    return !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v);
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length > 19) return oldValue;
    var buffer = StringBuffer();
    if (oldValue.text.length < newValue.text.length) {
      if ((text.length + 1) % 5 == 0 && text.length + 1 < 19) {
        for (var i = 0; i < text.length; i++) {
          buffer.write(text[i]);
        }
        buffer.write(' ');
      } else if (text.length % 5 != 0) {
        for (var i = 0; i < text.length; i++) {
          buffer.write(text[i]);
        }
      }
    } else {
      for (var i = 0; i < text.length; i++) {
        buffer.write(text[i]);
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class PeriodCardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length > 5) return oldValue;
    var buffer = StringBuffer();
    if (oldValue.text.length < newValue.text.length) {
      if (text.length == 2) {
        for (var i = 0; i < text.length; i++) {
          buffer.write(text[i]);
        }
        buffer.write('/');
      } else {
        for (var i = 0; i < text.length; i++) {
          buffer.write(text[i]);
        }
      }
    } else {
      for (var i = 0; i < text.length; i++) {
        buffer.write(text[i]);
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class NameCardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length > 20) return oldValue;
    var buffer = StringBuffer();

    for (var i = 0; i < text.length; i++) {
      buffer.write(text[i]);
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
