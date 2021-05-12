import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2021/04/01 16:51
/// email zdl328465042@163.com
/// description widget相关属性全局配置
class ZConfigBaseRoot {
  const ZConfigBaseRoot._();

  //返回图标
  static Widget leading = Icon(Icons.arrow_back_ios);

  //标题字体样式
  static TextStyle styleLight = TextStyle(color: Colors.white, fontSize: 36.toFit, fontWeight: FontWeight.w600);
  static TextStyle styleDark = TextStyle(color: ZConfigColor.textDark, fontSize: 36.toFit, fontWeight: FontWeight.w600);

  //标题栏下方阴影，为0.5时等同于一条线
  static double elevation = 0.5;
}

class ZConfigExpandableText {
  const ZConfigExpandableText._();

  static int maxLines = 3;
  static String expandText = '全文';
  static String collapseText = '收起';
  static bool expanded = false;
}

class ZConfigImage {
  const ZConfigImage._();

  static bool useCached = true;
  static String imageFolder = 'assets';
}

class ZConfigInputInfoRow {
  const ZConfigInputInfoRow._();

  static TextStyle keyStyle = TextStyle(color: ZConfigColor.textDark, fontSize: 28.toFit, fontWeight: FontWeight.w600);
  static TextStyle valueStyle = TextStyle(color: ZConfigColor.textNormal, fontSize: 28.toFit);
  static TextStyle valueHintStyle = TextStyle(color: ZConfigColor.textLight, fontSize: 28.toFit);
  static int keyFlex = 1;
  static int valueFlex = 2;
  static double centerSpace = 20.toFit;
  static bool valueIsEnd = false;
}

class ZConfigShowInfoRow {
  const ZConfigShowInfoRow._();

  static TextStyle keyStyle = TextStyle(color: ZConfigColor.textDark, fontSize: 28.toFit, fontWeight: FontWeight.w600);
  static TextStyle valueStyle = TextStyle(color: ZConfigColor.textNormal, fontSize: 28.toFit);
  static TextStyle valueHintStyle = TextStyle(color: ZConfigColor.textLight, fontSize: 28.toFit);
  static Widget rightIcon = Icon(Icons.keyboard_arrow_right_outlined, color: ZConfigColor.textNormal);
  static int keyFlex = 1;
  static int valueFlex = 2;
  static double centerSpace = 20.toFit;
  static double rightIconSpace = 10.toFit;
  static bool valueIsEnd = false;
  static EdgeInsets padding = EdgeInsets.symmetric(vertical: 20.toFit);
}
