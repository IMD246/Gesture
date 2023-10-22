import 'package:flutter/material.dart';
import 'package:gesture_test/staggered_reorderable_gridview/cutomer_multi_child_layout_view.dart';
import 'package:gesture_test/staggered_reorderable_gridview/item_model.dart';

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
  StatusKeyboard statusKeyboard = StatusKeyboard.num;
  _clear() {
    setState(() {
      finalNumber = "";
      displayNumber = "";
    });
  }

  setNumber(String value) {
    // List<String> getLastString = displayNumber.split(operation);
    // if (getLastString.isNotEmpty && getLastString.last.length == 15) {
    //   print(getLastString.last);
    //   print("đủ kí tự");
    //   return;
    // }
    if (statusKeyboard == StatusKeyboard.enter) {
      setState(() {
        finalNumber = "";
      });
    }
    setState(() {
      statusKeyboard = StatusKeyboard.num;
    });
    if (value[0] == "0") {
      if (displayNumber.length == 1 && displayNumber[0] == "0") {
        return;
      }
      setState(() {
        displayNumber += value;
      });
    } else {
      if ((displayNumber.contains(".") == true && value == ".") ||
          (displayNumber.isEmpty && value == ".")) {
        return;
      }
      setState(() {
        displayNumber += value;
      });
    }
  }

  setOperation(String value) {
    if (statusKeyboard == StatusKeyboard.operation) {
      return;
    }
    setState(() {
      operation += value;
      statusKeyboard = StatusKeyboard.operation;
      displayNumber += value;
    });
  }

  calculateResult() {
    var matchMulDiv = RegExp(r'([0-9]*\.?[0-9]*)([\*/])([0-9]*\.?[0-9]*)');
    var matchPlusMinus = RegExp(r'([0-9]*\.?[0-9]*)([\+\-])([0-9]*\.?[0-9]*)');
    String data = displayNumber;
    double result = 0;
    // Multiplication, division first
    while (matchMulDiv.firstMatch(data) != null) {
      var m = matchMulDiv.firstMatch(data);
      if (m!.group(2) == "*") {
        result = double.parse(m.group(1)!) * double.parse(m.group(3)!);
      } else {
        result = double.parse(m.group(1)!) / double.parse(m.group(3)!);
      }
      data = data.replaceAll(m.group(0)!, result.toString());
    }
    // Addition, subtraction second
    while (matchPlusMinus.firstMatch(data) != null) {
      var m = matchPlusMinus.firstMatch(data);
      final m1 = m!.group(1);
      final m3 = m.group(3);
      if (m.group(2) == "+") {
        result = (double.tryParse(m1!) ?? 0) + (double.tryParse(m3!) ?? 0);
      } else {
        result = (double.tryParse(m1!) ?? 0) - (double.tryParse(m3!) ?? 0);
      }
      data = data.replaceAll(m.group(0)!, result.toString());
    }
    setState(() {
      displayNumber = data;
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
    return price;
    // final splitPrice = price.split(".");
    // String numberString = price;
    // String? decimalPrice;
    // if (splitPrice.isNotEmpty && splitPrice.length >= 2) {
    //   numberString = splitPrice.first;
    //   decimalPrice = ".${splitPrice.last}";
    // }
    // final numberDigits = List.from(numberString.split(''));
    // int index = numberDigits.length - 3;
    // while (index > 0) {
    //   numberDigits.insert(index, ',');
    //   index -= 3;
    // }
    // if (numberDigits.isNotEmpty && numberDigits.length >= 2) {
    //   if (numberDigits[1] == ",") {
    //     numberDigits.removeAt(1);
    //   }
    // }
    // return "${numberDigits.join()}${decimalPrice ?? ""}";
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
              if (statusKeyboard == StatusKeyboard.num ||
                  statusKeyboard == StatusKeyboard.operation)
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      formatAmount(displayNumber),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
              if (statusKeyboard == StatusKeyboard.enter)
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      textAlign: TextAlign.start,
                      formatAmount(finalNumber),
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
