import 'dart:math';
import 'package:flutter/material.dart';

/// @author zdl
/// date 2021/03/30 16:26
/// email zdl328465042@163.com
/// description color工具类
class ZColorUtil{

  const ZColorUtil._();

  static const Color color_3 = Color(0xff333333);
  static const Color color_6 = Color(0xff666666);
  static const Color color_9 = Color(0xff999999);

  ///获取随机颜色
  static Color randomColor({double alpha = 1.0}) {
    assert(alpha >= 0.0 && alpha <= 1.0, '透明度不正确，当前透明度为($alpha)');
    Random random = Random.secure();
    return Color.fromARGB((255*alpha).round(), random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}