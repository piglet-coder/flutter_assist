import 'dart:ui';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

///  @author zdl
///  date 2020/3/31 18:19
///  email zdl328465042@163.com
///  description 扩展String

extension ExtensionString on String {
  /// 验证是否是数字
  bool get isNumber => null != this.toDouble;

  /// String转int
  int get toInt => int.tryParse(this);

  /// String转double
  double get toDouble => double.tryParse(this);

  /// 对字符串进行md5加密
  String get encodeMd5 => hex.encode((md5.convert(Utf8Encoder().convert(this))).bytes);

  /// 对字符串进行sha256加密
  String get encodeSha256 => hex.encode((sha256.convert(Utf8Encoder().convert(this))).bytes);

  /// 对字符串进行base64加密
  String get encodeBase64 => base64Encode(utf8.encode(this));

  /// 对base64解密
  String get decodeBase64 => String.fromCharCodes(base64Decode(this));

  /// 是否是图片
  bool get isImg => this.endsWith('.png') || this.endsWith('.jpg');

  bool _regExp(String source) => RegExp(source).hasMatch(this);

  /// 验证是否是电话号码
  bool get isPhoneNumber => _regExp(r'^1[3-9][0-9]\d{8}$');

  /// 验证是否是邮箱
  bool get isEmail => _regExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');

  /// 是否是url
  bool get isUrl => _regExp(r'^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+$');

  /// 是否是身份证
  bool get isIdCard => _regExp(r'^\d{17}[\d|x]|\d{15}$');

  /// 是否是中文
  bool get isChinese => _regExp(r'[\u4e00-\u9fa5]');

  /// 是否是车牌
  bool get isCarNumber => _regExp(
      r'(^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Za-z]{1}[A-Za-z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Za-z0-9]{4}[A-Za-z0-9挂学警港澳]{1}$)|(^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Za-z]{1}[A-Za-z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Za-z0-9]{4}[A-Za-z0-9挂学警港澳]{2}$)');

  /// 判断是否是日期字符串
  bool get isDateStr => _regExp(
      r'(^\d{4}$)|(^\d{4}[-.]\d{2}$)|(^\d{4}[-.]\d{2}[-.]\d{2}$)|(^\d{4}[-.]\d{2}[-.]\d{2} \d{2}$)|(^\d{4}[-.]\d{2}[-.]\d{2} \d{2}:\d{2}$)|(^\d{4}[-.]\d{2}[-.]\d{2} \d{2}:\d{2}:\d{2}$)');

  /// 获取字符串中第几个字符
  /// num 字符串中第几个字符，非下标
  String findChar(int num) => (num < 1 || num > this.length) ? '' : this.substring(num - 1, num);

  /// 字符串转颜色
  Color toColor({double alpha, Color defColor = Colors.red}) {
    try {
      String alphaRadix = 'ff';
      if (null != alpha && 0 <= alpha && 1 > alpha) {
        alphaRadix = (alpha * 256).toInt().toRadixString(16);
      }
      switch (this.length) {
        case 0:
          return defColor;
          break;
        case 3:
          return Color(int.tryParse('$alphaRadix${this.findChar(1) * 2}${this.findChar(2) * 2}${this.findChar(3) * 2}', radix: 16));
          break;
        case 4:
          return Color(int.tryParse('$alphaRadix${this.findChar(2) * 2}${this.findChar(3) * 2}${this.findChar(4) * 2}', radix: 16));
          break;
        case 6:
          return Color(int.tryParse('$alphaRadix$this', radix: 16));
          break;
        case 7:
          return Color(int.tryParse('$alphaRadix${this.substring(1, 7)}', radix: 16));
          break;
        case 8:
          return Color(int.tryParse(this.substring(0, 8), radix: 16));
          break;
        case 9:
          return Color(int.tryParse(this.substring(1, 9), radix: 16));
          break;
        default:
          return defColor;
          break;
      }
    } catch (e) {
      print(e);
      return defColor;
    }
  }

  /// 获取字符串中年
  String get getYear => this.length >= 4 ? this.substring(0, 4) : '';

  /// 获取字符串中月
  String get getMonth => this.length >= 7 ? this.substring(5, 7) : '';

  /// 获取字符串中日
  String get getDay => this.length >= 10 ? this.substring(8, 10) : '';

  /// 获取字符串中月日
  String get getMonthDay => this.length >= 10 ? this.substring(5, 10) : '';

  /// 获取图片地址
  String get toImgAsset => this.isImg ? 'assets/$this' : 'assets/$this.png';

  /// 替换除第一个的所有
  String replaceExceptFirst(Pattern from, String replace) {
    if (this.contains(from)) {
      int firstIndex = this.indexOf(from);
      return this.replaceAllMapped(from, (match) => match.start == firstIndex ? match.pattern : replace);
    } else {
      return this;
    }
  }
}
