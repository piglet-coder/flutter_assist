import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2021/03/29 17:47
/// email zdl328465042@163.com
/// description num扩展类
extension ExtensionNum on num{

  ///适配不同分辨率的手机像素
  double get toFit => this * (ZDeviceUtil.screenWidth/ZConfigConstant.uiWidth);

  bool get isMonth => this is int && this >= 1 && this <= 12;
}