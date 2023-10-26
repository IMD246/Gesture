import 'package:flutter/material.dart';
import 'package:gesture_test/calculator/calculator_model.dart';
import 'package:gesture_test/calculator/components/numpad_list.dart';
import 'package:provider/provider.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key, this.onTap});
  final void Function(int, String)? onTap;

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorModel(),
      builder: (context, child) {
        return Consumer<CalculatorModel>(
          builder: (context, model, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 300,
                //   width: double.infinity,
                //   child: ListView.builder(
                //     itemCount: model.listNumPadChars.length,
                //     itemBuilder: (context, index) {
                //       return Text(model.listNumPadChars[index].value);
                //     },
                //   ),
                // ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ValueListenableBuilder(
                      valueListenable: model.displayNumber,
                      builder:
                          (BuildContext context, displayNumber, Widget? child) {
                        return Text(
                          displayNumber,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                NumpadList(
                  onTap: model.onTapNumpad,
                )
              ],
            );
          },
        );
      },
    );
  }
}
