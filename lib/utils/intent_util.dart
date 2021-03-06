import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2020/7/15 15:21
/// email zdl328465042@163.com
/// description 路由跳转工具类
class ZIntentUtil {
  const ZIntentUtil._();

  static finish(BuildContext context, {Object? data}) {
    if (Navigator.canPop(context)) {
      return Navigator.of(context).pop(data);
    } else {
      return SystemNavigator.pop();
    }
  }

  static Future push(
    BuildContext ctx, {
    String? routeName,
    Widget? widget,
    dynamic data,
    bool finish = false,
    bool removeAll = false,
  }) {
    assert(!(routeName == null && widget == null), 'ZIntentUtil.push：routeName、widget不可同时为null');
    if (routeName != null) {
      return _pushByName(
        ctx,
        routeName,
        data: data,
        finish: finish,
        removeAll: removeAll,
      );
    } else {
      return _pushByWidget(
        ctx,
        widget,
        finish: finish,
        removeAll: removeAll,
      );
    }
  }

  static Future _pushByName(
    BuildContext ctx,
    String routeName, {
    dynamic data,
    bool? finish,
    required bool removeAll,
  }) {
    if (removeAll) {
      return Navigator.of(ctx).pushNamedAndRemoveUntil(
        routeName,
        (route) => route == null,
        arguments: data,
      );
    } else {
      if (finish!) {
        return Navigator.of(ctx).pushReplacementNamed(
          routeName,
          arguments: data,
        );
      } else {
        return Navigator.of(ctx).pushNamed(routeName, arguments: data);
      }
    }
  }

  static Future _pushByWidget(
    BuildContext ctx,
    Widget? widget, {
    bool? finish,
    required bool removeAll,
  }) {
    if (removeAll) {
      return Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget!), (route) => route == null);
    } else {
      if (finish!) {
        return Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context) => widget!));
      } else {
        if (Platform.isAndroid) {
          return Navigator.of(ctx, rootNavigator: true).push(ZPageRouteBuilder(widget));
        } else {
          return Navigator.of(ctx, rootNavigator: true).push(MaterialPageRoute(builder: (context) => widget!));
        }
      }
    }
  }
}
