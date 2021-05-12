import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2020/7/21 9:41
/// email zdl328465042@163.com
/// description 分割线
class ZLine extends StatelessWidget {
  final Color lineColor;
  final bool isHor;
  final double width;
  final double height;
  final EdgeInsets margin;

  const ZLine({
    this.lineColor,
    this.isHor = true,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: width ?? ((isHor ?? true) ? double.infinity : 1.toFit),
      height: height ?? ((isHor ?? true) ? 1.toFit : double.infinity),
      margin: margin,
      color: lineColor ?? ZConfigColor.lineColor,
    );
    return line;
  }
}
