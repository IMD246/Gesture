import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:gesture_test/staggered_reorderable_gridview/cutomer_multi_child_layout_view.dart';
import 'package:gesture_test/staggered_reorderable_gridview/item_model.dart';
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

enum StatusKeyboard { enter, operation, num }

class _MyHomePageState extends State<MyHomePage> {
  String finalNumber = "";
  String displayNumber = "";
  String operation = "";
  String dot = "";
  StatusKeyboard statusKeyboard = StatusKeyboard.num;
  _clear() {
    setState(() {
      finalNumber = "";
      dot = "";
      displayNumber = "";
    });
  }

  setDot(String value) {
    if (dot.isNotEmpty) return;
    setState(() {
      dot = value;
    });
  }

  setStatusKeyBoard(StatusKeyboard status) {
    if (statusKeyboard == status) return;
    setState(() {
      statusKeyboard = status;
    });
  }

  setNumber(String value) {
    if (statusKeyboard == StatusKeyboard.enter) {
      setState(() {
        dot = "";
      });
    }
    setState(() {
      operation = "";
    });
    setStatusKeyBoard(StatusKeyboard.num);
    if (operation.isEmpty && displayNumber.length == 15) {
      print("Đủ kí tự");
      return;
    }
    if (operation.isNotEmpty) {
      final splitDisplayNumber = displayNumber.split(operation);
      if (splitDisplayNumber.last.length == 15) {
        print("Đủ kí tự");
        return;
      }
    }
    if (value[0] == "0") {
      if (displayNumber.length == 1 && displayNumber[0] == "0") {
        return;
      }
      setState(() {
        displayNumber += value;
      });
    } else {
      if ((dot.isNotEmpty && value == "." && operation.isEmpty) ||
          (displayNumber.isEmpty && value == ".")) {
        return;
      }
      setState(() {
        displayNumber += value;
      });
    }
  }

  setOperation(String value) {
    if (statusKeyboard == StatusKeyboard.operation) return;
    if (displayNumber.isEmpty) return;
    if (operation.isNotEmpty) return;
    setState(() {
      operation = value;
      dot = "";
      displayNumber += value;
    });
  }

  calculateResult() {
    // Multiplication, division first
    if (operation.isNotEmpty) {
      print("wrong format");
      return;
    }
    Parser p = Parser();
    Expression exp = p.parse(displayNumber);
    ContextModel cm = ContextModel();
    Decimal eval =
        Decimal.parse(exp.evaluate(EvaluationType.REAL, cm).toString());
    setState(() {
      displayNumber = eval.toString();
      operation = "";
      dot = "";
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
        if (statusKeyboard == StatusKeyboard.enter) {
          _clear();
        } else {
          if (displayNumber.isNotEmpty) {
            setState(() {
              statusKeyboard = StatusKeyboard.num;
              displayNumber =
                  displayNumber.substring(0, displayNumber.length - 1);
            });
          }
        }
        break;
      case 'id_btn_minus':
        setOperation("-");
        break;
      case 'id_btn_plus':
        setOperation("+");
        break;
      case 'id_btn_enter':
        calculateResult();
        break;
      case 'id_btn_dot':
        setDot(".");
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

  String formatAmount(String price) {
    if (price.isNotEmpty) {
      final convertToNumPrice = num.parse(price);
      if (convertToNumPrice < 000000009) {
        setState(() {
          displayNumber = "0";
        });
        return "0";
      }
    }
    final splitPrice = price.split(".");
    String numberString = splitPrice.first;
    if (splitPrice.length >= 2) {
      numberString = splitPrice.first;
      String decimal = handleDecimal(price);
      numberString = Decimal.parse(
              (num.parse(splitPrice.first) + num.parse(decimal)).toString())
          .toString();
    }
    final numberDigits = List.from(numberString.split(''));
    int index = numberDigits.length - 3;
    while (index > 0) {
      numberDigits.insert(index, ',');
      index -= 3;
    }
    return numberDigits.join().replaceAll(".", "");
  }

  String handleDecimal(String value) {
    final numValue = num.parse(value);
    double fraction = 0;
    if (numValue < 0) {
      fraction = double.parse(value) + double.parse(value).truncate();
    } else {
      fraction = double.parse(value) - double.parse(value).truncate();
    }
    if (fraction <= 0.0009) {
      return "0";
    }
    if (fraction.toString().length > 4) {
      final splitFraction = fraction.toString().split(".");
      String stringFraction = splitFraction.first + splitFraction.last;
      int thirdCharacter = int.parse(stringFraction[2]);
      if (thirdCharacter >= 5) {
        final getIndexDot = getIndexOfString(fraction.toString(), ".");
        thirdCharacter++;
        stringFraction = stringFraction.replaceFirst(
            stringFraction[2], thirdCharacter.toString(), 2);
        stringFraction = addCharToString(value, getIndexDot);
        return num.parse(stringFraction).toStringAsFixed(3);
      }
      return fraction.toStringAsFixed(3);
    }
    return fraction.toString();
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
                    operation.isEmpty && statusKeyboard == StatusKeyboard.enter
                        ? formatAmount(displayNumber)
                        : displayNumber,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.yellow,
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
