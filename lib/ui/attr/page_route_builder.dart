import 'package:flutter/material.dart';

/// @author zdl
/// date 2020/12/17 17:51
/// email zdl328465042@163.com
/// description Android页面转场动画
class ZPageRouteBuilder extends PageRouteBuilder{

  final Widget? widget;

  ZPageRouteBuilder(this.widget)
      :super(
    // 设置过度时间
      transitionDuration:Duration(milliseconds: 200),
      // 构造器
      pageBuilder:(
          // 上下文和动画
          BuildContext context,
          Animation<double> animation1,
          Animation<double> animation2,
          ){
        return widget!;
      },
      transitionsBuilder:(
          BuildContext context,
          Animation<double> animation1,
          Animation<double> animation2,
          Widget child,
          ){

        // 需要什么效果把注释打开就行了
        // 渐变效果
//        return FadeTransition(
//          // 从0开始到1
//          opacity: Tween(begin: 0.0,end: 1.0)
//              .animate(CurvedAnimation(
//            // 传入设置的动画
//            parent: animation1,
//            // 设置效果，快进漫出   这里有很多内置的效果
//            curve: Curves.fastOutSlowIn,
//          )),
//          child: child,
//        );

        // 缩放动画效果
        // return ScaleTransition(
        //   scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
        //     parent: animation1,
        //     curve: Curves.fastOutSlowIn
        //   )),
        //   child: child,
        // );

        // 旋转加缩放动画效果
        // return RotationTransition(
        //   turns: Tween(begin: 0.0,end: 1.0)
        //   .animate(CurvedAnimation(
        //     parent: animation1,
        //     curve: Curves.fastOutSlowIn,
        //   )),
        //   child: ScaleTransition(
        //     scale: Tween(begin: 0.0,end: 1.0)
        //     .animate(CurvedAnimation(
        //       parent: animation1,
        //       curve: Curves.fastOutSlowIn
        //     )),
        //     child: child,
        //   ),
        // );

//         左右滑动动画效果
        return SlideTransition(
          position: Tween<Offset>(
            // 设置滑动的 X , Y 轴
              begin: Offset(1.0, 0.0),
              end: Offset(0.0,0.0)
          ).animate(CurvedAnimation(
              parent: animation1,
              curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
      }
  );
}