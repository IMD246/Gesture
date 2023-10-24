import 'package:flutter/material.dart';
import 'package:gesture_test/staggered_reorderable_gridview/cutomer_multi_child_layout_view.dart';
import 'package:gesture_test/staggered_reorderable_gridview/item_model.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shorebird Code Push Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shorebird Code Push'),
    );
  }
}

Widget _buildNumpad(
    BuildContext context, dynamic Function(int, String)? onTap) {
  List<ReorderableItem> itemAll = [
    ReorderableItem(
        trackingNumber: 0,
        id: 'id_btn_c',
        child: const Text('C'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 1,
        id: 'id_btn_divide',
        child: const Text('÷'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 2,
        id: 'id_btn_multi',
        child: const Text('x'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 3,
        id: 'id_btn_del',
        child: const Text('<='),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 4,
        id: 'id_btn_7',
        child: const Text('7'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 5,
        id: 'id_btn_8',
        child: const Text('8'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 6,
        id: 'id_btn_9',
        child: const Text('9'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 7,
        id: 'id_btn_minus',
        child: const Text('-'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 8,
        id: 'id_btn_4',
        child: const Text('4'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 9,
        id: 'id_btn_5',
        child: const Text('5'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 10,
        id: 'id_btn_6',
        child: const Text('6'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 11,
        id: 'id_btn_plus',
        child: const Text('+'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 12,
        id: 'id_btn_1',
        child: const Text('1'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 13,
        id: 'id_btn_2',
        child: const Text('2'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 14,
        id: 'id_btn_3',
        child: const Text('3'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 15,
        id: 'id_btn_enter',
        child: const Text('>'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 2),
    ReorderableItem(
        trackingNumber: 16,
        id: 'id_btn_0',
        child: const Text('0'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 17,
        id: 'id_btn_000',
        child: const Text('000'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 18,
        id: 'id_btn_dot',
        child: const Text('.'),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
  ];
  return StaggeredReorderableGridView(
    columnNum: 4,
    rowNum: 5,
    containerWidth: MediaQuery.sizeOf(context).width - 50,
    containerHeight: MediaQuery.sizeOf(context).width - 50,
    children: itemAll,
    backgroundColor: Colors.white10,
    onDragBackgroundColor: Colors.white,
    gridBackgroundColor: Colors.indigo,
    onTap: onTap,
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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

class _MyHomePageState extends State<MyHomePage> {
  List<NumPadChar> listNumPadChars = [];
  String finalNumber = "";
  String displayNumber = "";
  String memory = "";

  _clear() {
    setState(() {
      listNumPadChars.clear();
      finalNumber = "";
      displayNumber = "";
    });
  }

  setNumber(String value) {
    if (finalNumber.contains('.')) {
      // If already have (.) character, then return
      if (value == ".") {
        return;
      }
      // Only accept 3 character after (.)
      int decimalPlaces = finalNumber.length - (finalNumber.indexOf('.') + 1);
      if (decimalPlaces >= 3) {
        return;
      }
    } else {
      // If the total length is 15, then return
      if (finalNumber.length >= 15) {
        print("Đủ kí tự");
        return;
      }
    }

    finalNumber += value;

    final nFormat = NumberFormat("#,##0.##", "en_US");
    // Update the display number on the screen.
    setState(() {
      displayNumber =
          _toDisplayNumber() + nFormat.format(double.parse(finalNumber));
    });
  }

  setOperation(String value) {
    // If the last character is a operator then replace it with the new one.
    if (listNumPadChars.isNotEmpty &&
        listNumPadChars.last.status == KeyType.operator) {
      listNumPadChars.last.value = value;

      // Update the display number on the screen.
      setState(() {
        displayNumber = _toDisplayNumber();
      });
      return;
    }
    // If the finalNumber is not empty then put it into the list.
    if (finalNumber.isNotEmpty) {
      listNumPadChars.add(NumPadChar(formatAmount(finalNumber), KeyType.num));
      // Clear finalNumber
      finalNumber = "";
    }
    // If
    if (listNumPadChars.isEmpty && memory.isNotEmpty) {
      listNumPadChars.add(NumPadChar(memory, KeyType.num));
    }
    // If the first character is not a number and not +/- operator then return.
    if (listNumPadChars.isEmpty && (value != "+" || value != "-")) {
      return;
    }
    // Else add the new operator into the list.
    listNumPadChars.add(NumPadChar(value, KeyType.operator));

    // Update the display number on the screen.
    setState(() {
      displayNumber = _toDisplayNumber();
    });
  }

  String _toDisplayNumber() {
    String result = '';
    for (NumPadChar numPadChar in listNumPadChars) {
      result += numPadChar.toString();
    }
    return result;
  }

  void _delete() {
    if (listNumPadChars.isNotEmpty) {
      NumPadChar numPadChar = listNumPadChars.last;
      if (numPadChar.status == KeyType.operator) {
        // Remove operator from the list
        listNumPadChars.removeLast();
      } else {
        // Remove the last character of the number
        numPadChar.value =
            numPadChar.value.substring(0, numPadChar.value.length - 1);
        setState(() {
          displayNumber = _toDisplayNumber();
        });
      }
    }
  }

  void _calculateResult() {
    Parser p = Parser();
    Expression exp = p.parse(displayNumber.replaceAll(',', ''));
    ContextModel cm = ContextModel();
    String eval = exp.evaluate(EvaluationType.REAL, cm).toString();
    setState(() {
      // Show the result on the screen.
      displayNumber = formatAmount(eval);
      // Add current result to memory
      memory = eval;
      // Clear the finalNumber.
      finalNumber = "";
      // Clear the list.
      listNumPadChars.clear();
    });
  }

  void onTap(int id, String idx) {
    switch (idx) {
      case 'id_btn_c':
        _clear();
        break;
      case 'id_btn_divide':
        setOperation("/");
        break;
      case 'id_btn_multi':
        setOperation("*");
        break;
      case 'id_btn_del':
        _delete();
        break;
      case 'id_btn_minus':
        setOperation("-");
        break;
      case 'id_btn_plus':
        setOperation("+");
        break;
      case 'id_btn_enter':
        _calculateResult();
        break;
      case 'id_btn_dot':
        setNumber(".");
        break;
      case 'id_btn_7':
        setNumber("7");
        break;
      case 'id_btn_8':
        setNumber("8");
        break;
      case 'id_btn_9':
        setNumber("9");
        break;
      case 'id_btn_4':
        setNumber("4");
        break;
      case 'id_btn_5':
        setNumber("5");
        break;
      case 'id_btn_6':
        setNumber("6");
        break;
      case 'id_btn_1':
        setNumber("1");
        break;
      case 'id_btn_2':
        setNumber("2");
        break;
      case 'id_btn_3':
        setNumber("3");
        break;
      case 'id_btn_0':
        setNumber("0");
        break;
      case 'id_btn_000':
        setNumber("000");
        break;
      default:
    }
  }

  String formatAmount(String value) {
    String trimmed = value.replaceAll(',', '');
    final nFormat = NumberFormat("#,##0.##", "en_US");
    return nFormat.format(double.parse(trimmed));
  }

  int getIndexOfString(String value, String keyword) {
    return value.characters.toList().indexOf(keyword);
  }

  String addCharToString(String value, position) {
    return "${value.substring(0, position - 1)}${value.substring(position, value.length)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    displayNumber,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              _buildNumpad(context, onTap),
            ],
          ),
        ),
      ),
    );
  }
}
