import 'dart:async';

import 'package:aidog/app/common/global_options.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/widget/dialog/show_dialog_alert.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class GlobalNetProvider extends ChangeNotifier {
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void dispose() {
    //取消订阅
    _subscription?.cancel();
    super.dispose();
  }

  void startNetEventStream() async {
    cancelNetEventStream();
    _subscription = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) async {
        if (result.contains(ConnectivityResult.none)) {
          AALog("开始检测网络");
          //重试
          _retry();
        }
      },
    );
  }

  Future _retry() async {
    final List<ConnectivityResult> result =
        await (Connectivity().checkConnectivity());
    print(result);
    if (result.contains(ConnectivityResult.none)) {
      //获取全局上下文
      BuildContext? context = navigatorKey.currentContext;
      if (context != null) {
        AALog("context不为空");
        final result = await showNotNetDialog(
          context: context,
          title: "网络错误!",
          message: "请检查网络状态，然后重试!",
        );
        if (result == ButtonActionType.action) {
          _retry();
        }
      }
    }
  }

  //取消订阅
  void cancelNetEventStream() async {
    _subscription?.cancel();
    _subscription = null;
  }
}
