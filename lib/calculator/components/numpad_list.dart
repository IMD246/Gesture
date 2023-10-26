import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

import '../../staggered_reorderable_gridview/cutomer_multi_child_layout_view.dart';
import '../../staggered_reorderable_gridview/item_model.dart';

class NumpadList extends StatelessWidget {
  const NumpadList({super.key, this.onTap});
  final Function(int, String)? onTap;
  @override
  Widget build(BuildContext context) {
    return _buildNumpad(context, onTap);
  }
}

Widget _buildNumpad(
    BuildContext context, dynamic Function(int, String)? onTap) {
  List<ReorderableItem> itemAll = [
    ReorderableItem(
        trackingNumber: 0,
        id: 'id_btn_c',
        child: const _NumpadItem(
          content: "C",
          textColor: Color(
            0xffFF5555,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 1,
        id: 'id_btn_divide',
        child: const _NumpadItem(
          content: "÷",
          textColor: Color(
            0xff00cb76,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 2,
        id: 'id_btn_multi',
        child: const _NumpadItem(
          content: "x",
          textColor: Color(0xff00cb76),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 3,
        id: 'id_btn_del',
        child: const _NumpadItem(
          content: "assets/ic_delete.svg",
          isText: false,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
          ),
          width: 32,
          height: 32,
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
      trackingNumber: 4,
      id: 'id_btn_7',
      child: const _NumpadItem(
        content: "7",
        textColor: Color(0xff5297ff),
        bgColor: Color(
          0xff252632,
        ),
      ),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
    ),
    ReorderableItem(
        trackingNumber: 5,
        id: 'id_btn_8',
        child: const _NumpadItem(
          content: "8",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 6,
        id: 'id_btn_9',
        child: const _NumpadItem(
          content: "9",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 7,
        id: 'id_btn_minus',
        child: const _NumpadItem(
          content: "-",
          textColor: Color(
            0xff00cb76,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 8,
        id: 'id_btn_4',
        child: const _NumpadItem(
          content: "4",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 9,
        id: 'id_btn_5',
        child: const _NumpadItem(
          content: "5",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 10,
        id: 'id_btn_6',
        child: const _NumpadItem(
          content: "6",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 11,
        id: 'id_btn_plus',
        child: const _NumpadItem(
          content: "+",
          textColor: Color(
            0xff00cb76,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 12,
        id: 'id_btn_1',
        child: const _NumpadItem(
          content: "1",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 13,
        id: 'id_btn_2',
        child: const _NumpadItem(
          content: "2",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 14,
        id: 'id_btn_3',
        child: const _NumpadItem(
          content: "3",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 15,
        id: 'id_btn_enter',
        child: const _NumpadItem(
          content: "assets/ic_enter.svg",
          isText: false,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
          ),
          width: 36,
          height: 36,
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 2),
    ReorderableItem(
        trackingNumber: 16,
        id: 'id_btn_0',
        child: const _NumpadItem(
          content: "0",
          textColor: Color(0xff5297ff),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
          ),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 17,
        id: 'id_btn_000',
        child: const _NumpadItem(
          content: "000",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
    ReorderableItem(
        trackingNumber: 18,
        id: 'id_btn_dot',
        child: const _NumpadItem(
          content: ".",
          textColor: Color(0xff5297ff),
          bgColor: Color(
            0xff252632,
          ),
        ),
        crossAxisCellCount: 1,
        mainAxisCellCount: 1),
  ];
  return StaggeredReorderableGridView(
    columnNum: 4,
    rowNum: 5,
    containerWidth: MediaQuery.sizeOf(context).width - 50,
    containerHeight: MediaQuery.sizeOf(context).width - 50,
    spacing: 2,
    children: itemAll,
    onTap: onTap,
  );
}

class _NumpadItem extends StatelessWidget {
  const _NumpadItem({
    required this.content,
    this.isText = true,
    this.bgColor,
    this.borderRadius,
    this.textColor,
    this.width,
    this.height,
  });
  final Color? bgColor;
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;
  final String content;
  final bool isText;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor ?? const Color(0xff4e4f5b),
        borderRadius: borderRadius,
      ),
      child: isText
          ? Text(
              content,
              style: TextStyle(
                fontSize: 32,
                color: textColor ??
                    const Color(
                      0xffff5555,
                    ),
              ),
            )
          : SvgPicture.asset(
              content,
              width: width,
              height: height,
            ),
    );
  }
}
