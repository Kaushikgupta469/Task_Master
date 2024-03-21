import 'package:flutter/services.dart';

class NumberedBulletFormatter extends TextInputFormatter {
  int _initialNumericalValue = 1;
  String _initialSpace = "";

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if the change involves deletion
    if (oldValue.text.length > newValue.text.length) {
      // Perform default behavior (deletion)
      return newValue;
    }

    if (RegExp(r'(\n *)(\d+)\..+\n$').hasMatch(newValue.text)) {
      RegExpMatch? match =
          RegExp(r'(\n *)(\d+)\..*\n$').firstMatch(newValue.text);
      if (match != null) {
        _initialNumericalValue = int.parse(match.group(2)!);
      }
      if (match != null) {
        _initialSpace = match.group(1)!.substring(1);
      }
      return TextEditingValue(
        text: '${newValue.text}$_initialSpace${_initialNumericalValue + 1}. ',
      );
    }
    return newValue;
  }
}

class unNumberedBulletFormatter extends TextInputFormatter {
  String start = "";

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if the change involves deletion
    if (oldValue.text.length > newValue.text.length) {
      // Perform default behavior (deletion)
      return newValue;
    }

    if (RegExp(r'(\n\s*[*|+|-|>] +).*\n$').hasMatch(newValue.text)) {
      // print("match");
      RegExpMatch? match =
          RegExp(r'(\n\s*[*|+|-|>] +).*\n$').firstMatch(newValue.text);

      if (match != null) {
        start = match.group(1)!.substring(1);
      }
      // print(start.endsWith(" "));
      return TextEditingValue(
          text:
              // start.endsWith(" ")
              '${newValue.text}$start'
          // : '${newValue.text}$start ',
          );
    }
    return newValue;
  }
}
