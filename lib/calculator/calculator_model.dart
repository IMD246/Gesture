import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorModel extends ChangeNotifier {
  final List<NumPadChar> _listNumPadChars = [];
  ValueNotifier<String> displayNumber = ValueNotifier("");
  String _memory = "";

  _clear() {
    _listNumPadChars.clear();
    displayNumber.value = "";
  }

  _setDisplayNumber() {
    displayNumber.value = _toDisplayNumber();
  }

  _setNumber(String value) {
    // Clear the memory if user start to input a new number after calculated the result.
    if (_memory.isNotEmpty) {
      _memory = "";
    }
    NumPadChar? numPadChar = _getLastNumberItemFromList();
    if (numPadChar != null) {
      if (numPadChar.value.contains('.')) {
        // If already have (.) character, then return
        if (value == ".") {
          return;
        }
        // Only accept 3 character after (.)
        int decimalPlaces =
            numPadChar.value.length - (numPadChar.value.indexOf('.') + 1);
        if (decimalPlaces >= 3) {
          return;
        }
      } else {
        // If the total length is 15, then return
        if (numPadChar.value.length >= 15) {
          log("Đủ kí tự");
          return;
        }
      }
      // If numpad has 1 length and first char numpad is 0 and value not {.} then replace it by value
      if (numPadChar.value.length == 1 &&
          numPadChar.value[0] == "0" &&
          value != ".") {
        numPadChar.value = value;
      } else {
        numPadChar.value += value;
      }
    } else {
      // numpad is empty and value is {.} then return
      if (value == ".") return;
      numPadChar = NumPadChar(value == "000" ? "0" : value, KeyType.num);
      _listNumPadChars.add(numPadChar);
    }
    // Update the display number on the screen.
    _setDisplayNumber();
  }

  _setOperation(String value) {
    // If the last character is a operator then replace it with the new one.
    if (_listNumPadChars.isNotEmpty &&
        _listNumPadChars.last.status ==
            KeyType.operator /* && finalNumber.isEmpty*/) {
      _listNumPadChars.last.value = value;

      // Update the display number on the screen.
      _setDisplayNumber();

      return;
    }
    // If there is already have a calculated result, then continue to add operator
    if (_listNumPadChars.isEmpty && _memory.isNotEmpty) {
      _getResultFromMemory();
    }
    // If the first character is not a number and not +/- operator then return.
    if (_listNumPadChars.isEmpty && (value != "+" || value != "-")) {
      return;
    }
    // Else add the new operator into the list.
    _listNumPadChars.add(NumPadChar(value, KeyType.operator));

    // Update the display number on the screen.
    _setDisplayNumber();
  }

  void _delete() {
    // When user press delete on the calculated result.
    if (_listNumPadChars.isEmpty && _memory.isNotEmpty) {
      _getResultFromMemory();
    }
    // Delete item in the list if not empty
    if (_listNumPadChars.isNotEmpty) {
      NumPadChar numPadChar = _listNumPadChars.last;
      if (numPadChar.status == KeyType.operator) {
        // Remove operator from the list
        _listNumPadChars.removeLast();
      } else {
        // Remove the last character of the number
        String newValue =
            numPadChar.value.substring(0, numPadChar.value.length - 1);
        numPadChar.value = newValue.replaceAll(',', '');
        if (newValue.isEmpty) {
          // If already cleaned, then remove it from the list
          _listNumPadChars.removeLast();
          // If there is only 1 operator left, then cleanup the list
          if (_listNumPadChars.length == 1 &&
              _listNumPadChars.last.status == KeyType.operator) {
            _listNumPadChars.clear();
          }
        } else {
          // Or update the new value
          numPadChar.value = newValue.replaceAll(',', '');
        }
      }
      _setDisplayNumber();
    }
  }

  void _calculateResult() {
    // Do not calculate the result if displayNumber is empty
    if (displayNumber.value.isEmpty) return;

    // Start calculate the result
    Parser p = Parser();
    Expression exp = p.parse(displayNumber.value.replaceAll(',', ''));
    ContextModel cm = ContextModel();
    String eval = exp.evaluate(EvaluationType.REAL, cm).toString();
    // Show the result on the screen.
    displayNumber.value = _formatAmount(eval);
    // Add current result to memory
    _memory = displayNumber.value;
    // Clear the list.
    _listNumPadChars.clear();
  }

  String _toDisplayNumber() {
    String result = '';
    for (NumPadChar numPadChar in _listNumPadChars) {
      result += (numPadChar.status == KeyType.num)
          ? numPadChar.value.contains(".")
              ? numPadChar.toString()
              : _formatAmount(numPadChar.value)
          : numPadChar.toString();
      int decimalPlaces =
          numPadChar.value.length - (numPadChar.value.indexOf('.') + 1);
      if (decimalPlaces == numPadChar.value.length) {}
    }
    return result;
  }

  void _getResultFromMemory() {
    if (_memory.contains("-")) {
      _listNumPadChars.add(NumPadChar("-", KeyType.operator));
      _memory = _memory.replaceAll('-', '');
    }
    _listNumPadChars.add(NumPadChar(_memory, KeyType.num));
    _memory = "";
  }

  NumPadChar? _getLastNumberItemFromList() {
    if (_listNumPadChars.isNotEmpty &&
        _listNumPadChars.last.status == KeyType.num) {
      return _listNumPadChars.last;
    } else {
      return null;
    }
  }

  String _formatAmount(String value) {
    String trimmed = value.replaceAll(',', '');
    final nFormat = NumberFormat("#,##0.##", "en_US");
    return nFormat.format(double.parse(trimmed));
  }

  void onTapNumpad(int id, String idx) {
    switch (idx) {
      case 'id_btn_c':
        _clear();
        break;
      case 'id_btn_divide':
        _setOperation("/");
        break;
      case 'id_btn_multi':
        _setOperation("*");
        break;
      case 'id_btn_del':
        _delete();
        break;
      case 'id_btn_minus':
        _setOperation("-");
        break;
      case 'id_btn_plus':
        _setOperation("+");
        break;
      case 'id_btn_enter':
        _calculateResult();
        break;
      case 'id_btn_dot':
        _setNumber(".");
        break;
      case 'id_btn_7':
        _setNumber("7");
        break;
      case 'id_btn_8':
        _setNumber("8");
        break;
      case 'id_btn_9':
        _setNumber("9");
        break;
      case 'id_btn_4':
        _setNumber("4");
        break;
      case 'id_btn_5':
        _setNumber("5");
        break;
      case 'id_btn_6':
        _setNumber("6");
        break;
      case 'id_btn_1':
        _setNumber("1");
        break;
      case 'id_btn_2':
        _setNumber("2");
        break;
      case 'id_btn_3':
        _setNumber("3");
        break;
      case 'id_btn_0':
        _setNumber("0");
        break;
      case 'id_btn_000':
        _setNumber("000");
        break;
      default:
    }
  }

  @override
  void dispose() {
    displayNumber.dispose();
    super.dispose();
  }
}

enum KeyType { func, operator, num }

class NumPadChar {
  String value;
  KeyType status;

  NumPadChar(this.value, this.status);

  @override
  String toString() {
    return value;
  }
}
