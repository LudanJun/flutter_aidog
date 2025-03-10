import 'package:flutter/material.dart';

///自定义弹框
class HooDialog {
  static bool _isShowDialog = false;

  /// 完全自定义弹框
  /// 更新弹窗内容使用StatefulBuilder
  static void showCustomDialog(
    BuildContext context, {
    Widget? child, //布局内容
    bool clickBgHidden = false, //点击背景是否隐藏
  }) {
    if (_isShowDialog) {
      return;
    }
    _isShowDialog = true;

    showDialog(
      context: context,
      barrierDismissible: false, //若设置为false用户不能点击空白部分来关闭对话框
      builder: (context) {
        return _CustomDialog(clickBgHidden: clickBgHidden, child: child);
      },
    ).then((value) => _isShowDialog = false);
  }
}

class _CustomDialog extends Dialog {
  const _CustomDialog({
    Key? key,
    super.child,
    this.clickBgHidden = false, // 点击背景隐藏，默认不隐藏
  }) : super(key: key);

  final bool clickBgHidden;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (clickBgHidden == true) {
                Navigator.pop(context);
              }
            },
          ),
          // 内容
          Container(child: child)
        ],
      ),
    );
  }
}
