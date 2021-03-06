import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2021/04/02 10:53
/// email zdl328465042@163.com
/// description 页面基类
class ZBaseRoot extends StatefulWidget {
  /*整体配置*/
  final GestureTapCallback? clickBack;
  final Widget? body;
  final Color? bgColor;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final Function? onWillPop;
  final SystemUiOverlayStyle? statusBarStyle;
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool extendBody;
  final bool belowStatusBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;

  /*标题栏配置*/
  final dynamic title;
  final double? titleSpacing;
  final bool centerTitle;
  final Widget? leading;
  final double? leadingWidth;
  final bool canBack;
  final double? elevation;

  //常用的用IconButton来表示，不常用的用PopupMenuButton来显示三个点，点击展开
  final List<Widget>? actions;
  final Color? barBgColor;
  final bool isDarkTheme;

  const ZBaseRoot({
    this.clickBack,
    this.body,
    this.bgColor,
    this.resizeToAvoidBottomInset,
    this.floatingActionButton,
    this.onWillPop,
    this.statusBarStyle,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    this.extendBody = false,
    this.belowStatusBar = true,
    this.drawer,
    this.endDrawer,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.title,
    this.titleSpacing,
    this.centerTitle = true,
    this.leading,
    this.leadingWidth,
    this.canBack = true,
    this.elevation,
    this.actions,
    this.barBgColor,
    this.isDarkTheme = true,
  });

  @override
  _ZBaseRootState createState() => _ZBaseRootState();
}

class _ZBaseRootState extends State<ZBaseRoot> {
  @override
  Widget build(BuildContext context) {
    Widget? titleWidget;
    if (widget.title is String) {
      titleWidget = Text(
        widget.title,
        style: widget.isDarkTheme ? ZConfigBaseRoot.styleLight : ZConfigBaseRoot.styleDark,
      );
    } else if (widget.title is Widget) {
      titleWidget = widget.title;
    }
    Widget child;
    child = Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: titleWidget == null
          ? (widget.belowStatusBar
              ? PreferredSize(
                  preferredSize: Size.fromHeight(ZDeviceUtil.topBarHeight * 0.07),
                  child: SafeArea(
                    top: true,
                    child: Offstage(),
                  ),
                )
              : null)
          : AppBar(
              title: titleWidget,
              titleSpacing: widget.titleSpacing ?? NavigationToolbar.kMiddleSpacing,
              elevation: widget.elevation ?? ZConfigBaseRoot.elevation,
              centerTitle: widget.centerTitle,
              leading: (!widget.canBack)
                  ? null
                  : IconButton(
                      icon: widget.leading ?? ZConfigBaseRoot.leading,
                      onPressed: widget.clickBack ?? () => ZIntentUtil.finish(context),
                    ),
              leadingWidth: widget.leadingWidth,
              actions: widget.actions,
              backgroundColor: widget.barBgColor ?? (widget.isDarkTheme ? null : Colors.white),
              brightness: widget.isDarkTheme ? Brightness.dark : Brightness.light,
              iconTheme: IconThemeData(
                color: widget.isDarkTheme ? ZConfigBaseRoot.styleLight.color : ZConfigBaseRoot.styleDark.color,
              ),
            ),
      body: widget.body,
      drawer: widget.drawer,
      endDrawer: widget.endDrawer,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      backgroundColor: widget.bgColor ?? ZConfigColor.bgColor,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
      extendBody: widget.extendBody,
    );
    if (widget.statusBarStyle != null) {
      child = AnnotatedRegion<SystemUiOverlayStyle>(
        value: widget.statusBarStyle!,
        child: child,
      );
    }
    if (widget.onWillPop != null) {
      child = WillPopScope(
        onWillPop: widget.onWillPop as Future<bool> Function()?,
        child: child,
      );
    }
    return child;
  }
}
