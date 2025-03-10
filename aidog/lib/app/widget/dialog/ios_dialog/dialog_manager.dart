import 'package:aidog/app/widget/dialog/ios_dialog/show_ios_dialog_alert.dart';
import 'package:flutter/material.dart';

/*
                DialogManager.instance.showPolicyDialog(
                  context,
                  title: '用户协议及隐私政策',
                  content: "sssssss",
                  content1:
                      '欢迎使用联大学堂APP,我们非常重视您的个人信息和隐私保护,在您使用”联大学堂”服务之前,请您务必审慎阅读',
                  content2: '并充分理解协议条款内容,我们将严格按照您同意的各项条款使用您的个人信息,以便为您提供更好的服务。',
                  license: '《用户协议》',
                  policy: '《隐私政策》',
                  onLicenseClick: () {
                    AALog("协议");
                  },
                  onPolicyClick: () {
                    AALog("隐私");
                  },
                  onOKClick: () {
                    AALog("确定");
                    Navigator.pop(context);
                  },
                  onCancelClick: () {
                    AALog("取消");
                    Navigator.pop(context);
                  },
                );
*/
class DialogManager {
  factory DialogManager() => _getInstance();
  static DialogManager get instance => _getInstance();
  static DialogManager? _instance;

  DialogManager._internal() {
    //初始化
  }

  static DialogManager _getInstance() {
    _instance ??= DialogManager._internal();
    return _instance!;
  }

  /// 展示协议弹框
  showPolicyDialog(BuildContext context,
      {required String title,
      required String content,
      required String content1, //内容1
      required String content2, //内容2
      required String license, //用户协议
      required String policy, //隐私政策

      Function? onOKClick,
      Function? onCancelClick,
      Function? onLicenseClick,
      Function? onPolicyClick}) {
    showDialog(
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: ShowIosDialogAlert(
            title: title,
            content: content,
            content1: content1,
            content2: content2,
            license: license,
            policy: policy,
            btnOK: "同意",
            btnCancel: "取消",
            onOKClick: () {
              if (onOKClick != null) {
                onOKClick();
              }
            },
            onCancelClick: () {
              if (onCancelClick != null) {
                onCancelClick();
              }
            },
            onLicenseClick: () {
              if (onLicenseClick != null) {
                onLicenseClick();
              }
            },
            onPolicyClick: () {
              if (onPolicyClick != null) {
                onPolicyClick();
              }
            },
          ),
        );
      },
    );
  }
}
