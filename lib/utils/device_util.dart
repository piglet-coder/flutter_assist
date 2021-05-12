import 'dart:ui';
import 'package:flutter/material.dart';

/// @author zdl
/// date 2021/03/30 16:50
/// email zdl328465042@163.com
/// description 设备相关工具类
class ZDeviceUtil{

  const ZDeviceUtil._();

  static MediaQueryData _mediaQueryData = MediaQueryData.fromWindow(window);

  /// padding
  static EdgeInsets get padding => _mediaQueryData.padding;

  ///屏幕宽
  static double get screenWidth => _mediaQueryData.size.width;

  ///屏幕高
  static double get screenHeight => _mediaQueryData.size.height;

  ///获取上方状态栏高度
  static double topBarHeight = padding.top;

  ///获取下方状态栏高度
  static double botBarHeight = padding.bottom;
}