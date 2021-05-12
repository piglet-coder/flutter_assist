import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2020/11/9 16:49
/// email zdl328465042@163.com
/// description 弹窗提示widget
class ZDialogHint extends StatelessWidget {
  final String msg;
  final ZDialogHintEnum enumType;
  final double width;
  final double height;
  final Color bgColor;
  final Color fontColor;
  final double fontSize;
  final Widget noDataIcon;
  final double drawablePadding;

  const ZDialogHint._(
    this.msg,
    this.enumType,
    this.width,
    this.height,
    this.bgColor,
    this.fontColor,
    this.fontSize,
    this.noDataIcon,
    this.drawablePadding,
  );

  //请使用此方法调用
  static void show(
    BuildContext context, {
    @required String msg,
    @required ZDialogHintEnum enumType,
    double width,
    double height,
    Color bgColor,
    Color fontColor = Colors.white,
    double fontSize,
    Widget noDataIcon,
    double drawablePadding,
  }) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => ZDialogHint._(msg, enumType, width, height, bgColor,
          fontColor, fontSize, noDataIcon, drawablePadding),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget icon;
    switch (enumType) {
      case ZDialogHintEnum.success:
        icon = Icon(Icons.check_circle_outline, color: Colors.white);
        break;
      case ZDialogHintEnum.fail:
      case ZDialogHintEnum.error:
        icon = Icon(Icons.cancel_outlined, color: Colors.white);
        break;
      case ZDialogHintEnum.warn:
        icon = Icon(Icons.error_outline, color: Colors.white);
        break;
    }
    Widget dialog = Center(
      child: ZText(
        msg,
        width: width ?? 240.toFit,
        height: height ?? 180.toFit,
        borderRadius: BorderRadius.circular(8.toFit),
        alignment: Alignment.center,
        bgColor: bgColor ?? ZColorUtil.color_3.withOpacity(0.9),
        style: TextStyle(
          color: fontColor,
          fontSize: fontSize ?? 24.toFit,
        ),
        drawableTop: noDataIcon ?? icon,
        drawableTopPadding: drawablePadding ?? 10.toFit,
      ),
    );
    return Material(
      type: MaterialType.transparency,
      child: dialog,
    );
  }
}

enum ZDialogHintEnum { success, fail, error, warn }
