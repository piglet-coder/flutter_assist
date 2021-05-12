import 'package:flutter/services.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2021/03/30 17:07
/// email zdl328465042@163.com
/// description
class ZGlobalUtil {
  const ZGlobalUtil._();

  /// 处理服务端返回数据赋值
  static String dealNull(String str, [String def = '无']) => (str ?? '').isEmpty ? def : str;

  /// 复制内容
  static bool systemCopy(String value) {
    if ((value ?? '').isEmpty) return false;
    Clipboard.setData(ClipboardData(text: value));
    return true;
  }

  ///双击退出APP
  static int _last = 0;
  static Future<bool> doubleClickBack(Function onClickBack) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - _last > 1000) {
      _last = DateTime.now().millisecondsSinceEpoch;
      null != onClickBack ? onClickBack() : ZToastUtil.show('双击退出APP');
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}