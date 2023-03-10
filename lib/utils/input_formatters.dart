import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length > 19) return oldValue;
    if (RegExp(r'^[- ,.]').hasMatch(text)) return oldValue;
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
    if (RegExp(r'^[- ,.]').hasMatch(text)) return oldValue;
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
    if (text.length > 15) return oldValue;
    if (RegExp(r'^[- ,.]').hasMatch(text)) return oldValue;
    return newValue;
  }
}

class EnterPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newV = newValue.text;
    String oldV = oldValue.text;
    StringBuffer buffer = StringBuffer();
    if (newV.length > 12) return oldValue;
    if (oldV.length < newV.length) {
      if (newV.length == 2 || newV.length == 6 || newV.length == 9) {
        for (int i = 0; i < newV.length; i++) {
          buffer.write(newV[i]);
        }
        buffer.write(' ');
      } else {
        for (int i = 0; i < newV.length; i++) {
          buffer.write(newV[i]);
        }
      }
    } else {
      for (int i = 0; i < newV.length; i++) {
        buffer.write(newV[i]);
      }
    }
    return newValue.copyWith(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.toString().length));
  }
}
