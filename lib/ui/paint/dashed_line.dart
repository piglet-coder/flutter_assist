import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2021/04/01 16:17
/// email zdl328465042@163.com
/// description 虚线
class ZDashedLine extends StatelessWidget {
  final Color? color;
  final double? dashedWidth;
  final double? dashedHeight;
  final double? dashedGap;
  final double? rootWidth;
  final EdgeInsets? margin;

  const ZDashedLine({
    this.color,
    this.dashedWidth,
    this.dashedHeight,
    this.dashedGap,
    this.rootWidth,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CustomPaint(
        size: Size(rootWidth ?? double.infinity, dashedHeight ?? 1.toFit),
        painter: _DashedPainter(color, dashedWidth, dashedHeight, dashedGap),
      ),
    );
  }
}

class _DashedPainter extends CustomPainter {
  final Color? color;
  final double? dashedWidth;
  final double? dashedHeight;
  final double? dashedGap;

  _DashedPainter(
    this.color,
    this.dashedWidth,
    this.dashedHeight,
    this.dashedGap,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color ?? ZConfigColor.lineColor
      ..isAntiAlias = true
      ..strokeWidth = dashedHeight ?? 1.toFit;
    double maxWidth = size.width;
    double startX = 0;
    final double space = (dashedWidth ?? 3.toFit) + (dashedGap ?? 3.toFit);
    while (startX < maxWidth) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashedWidth!, 0), paint);
      startX += space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
