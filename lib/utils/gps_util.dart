import 'dart:math';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2021/03/30 17:50
/// email zdl328465042@163.com
/// description GPS相关工具类
class ZGPSUtil {
  const ZGPSUtil._();

  //地球半径，单位米
  static final double _earthRadius = 6371393;

  static double _rad(double d) {
    return d * pi / 180.0;
  }

  /// 计算两点间距离，保留三位小数
  /// return double(unit:km)
  static double distance(double lat1, double lng1, double lat2, double lng2) {
    double radLat1 = _rad(lat1);
    double radLat2 = _rad(lat2);
    double a = radLat1 - radLat2;
    double b = _rad(lng1) - _rad(lng2);
    double s = 2 * asin(sqrt(pow(sin(a / 2), 2) + cos(radLat1) * cos(radLat2) * pow(sin(b / 2), 2)));
    return (s * _earthRadius).toStringAsFixed(3).toDouble;
  }
}
