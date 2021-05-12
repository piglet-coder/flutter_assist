import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

/// @author zdl
/// date 2020/11/6 16:36
/// email zdl328465042@163.com
/// description BaseViewModel
enum ViewState {
  idle, //空闲
  busy, //加载中
  empty, //无数据
  error, //加载error
}

class ZBaseViewModel with ChangeNotifier {
  bool _disposed = false;
  ViewState _viewState;
  BuildContext context;
  bool autoLoadData;

  ZBaseViewModel({ViewState viewState, BuildContext context}) {
    _viewState = (viewState ?? ViewState.idle);
    context = context;
    // if(ZConfigUtil.pageStart != null) ZConfigUtil.pageStart('${runtimeType.toString().replaceAll('ViewModel', 'Page')}');
    debugPrint('ZBaseViewModel---constructor--->$runtimeType');
  }

  ViewState get viewState => _viewState;

  bool get isBusy => _viewState == ViewState.busy;

  bool get isIdle => _viewState == ViewState.idle;

  bool get isEmpty => _viewState == ViewState.empty;

  bool get isError => _viewState == ViewState.error;

  setBuildContext(BuildContext context) {
    this.context = context;
  }

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  void setIdle() {
    _viewState = ViewState.idle;
  }

  void setBusy() {
    _viewState = ViewState.busy;
  }

  void setEmpty() {
    _viewState = ViewState.empty;
  }

  void setError() {
    _viewState = ViewState.error;
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    // if(ZConfigUtil.pageEnd != null) ZConfigUtil.pageEnd('${runtimeType.toString().replaceAll('ViewModel', 'Page')}');
    debugPrint('ZBaseViewModel dispose -->$runtimeType');
    super.dispose();
  }

  void initState() {}
}
