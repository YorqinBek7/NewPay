import 'package:flutter/services.dart';

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

class EnterAmountFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (RegExp(r'^[- ,.]').hasMatch(text)) return oldValue;

    return newValue;
  }
}
