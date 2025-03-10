import 'package:aidog/app/common/log_extern.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static VoidCallback defaultCall = () {};

  ///检查权限
  static void checkSelfPermission(Permission permission,
      {String? errMsg,
      Function? onSuccess,
      VoidCallback? onFailed,
      VoidCallback? onOpenSetting}) async {
    var status = await permission.status;
    if (status.isGranted) {
      if (onSuccess != null) {
        AALog('permission=======被允许');
        onSuccess.call();
      }
      // onSuccess != null ? onSuccess.call() : defaultCall();
    } else if (status.isDenied) {
      AALog('permission===isDenied===被拒绝');
      onFailed != null ? onFailed() : defaultCall();
    } else if (status.isPermanentlyDenied) {
      AALog('permission===isPermanentlyDenied===被永久拒绝');
      onOpenSetting != null ? onOpenSetting() : defaultCall();
    } else if (status.isRestricted || status.isLimited) {
      AALog('permission===isRestricted||isLimited===是受限的');
      onOpenSetting != null ? onOpenSetting() : defaultCall();
    }
  }

  /// 申请权限
  static void requestPermission(Permission permission,
      {String? errMsg,
      VoidCallback? onSuccess,
      VoidCallback? onFailed,
      VoidCallback? onOpenSetting}) async {
    final request = await permission.request();
    if (request.isGranted) {
      AALog('permission===isGranted===已授权');
      onSuccess != null ? onSuccess() : defaultCall();
    } else if (request.isDenied) {
      AALog('permission===isDenied===被拒绝');
      onFailed != null ? onFailed() : defaultCall();
    } else if (request.isPermanentlyDenied) {
      AALog('permission===isPermanentlyDenied===被永久拒绝');
      onOpenSetting != null ? onOpenSetting() : defaultCall();
    } else if (request.isRestricted || request.isLimited) {
      AALog('permission===isRestricted||isLimited===是受限的');
      onOpenSetting != null ? onOpenSetting() : defaultCall();
    }
  }
}
