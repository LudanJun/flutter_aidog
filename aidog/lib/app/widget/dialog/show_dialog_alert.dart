import 'dart:io';

import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/widget/global_loading_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
                showNotNetDialog(context: context, title: "没有网络");
                showNetErrorDialog(context: context, title: "网络错误");
                showErrorDialog(
                    context: context,
                    title: "singasdadsad",
                    message: 'Incorrect email address or password');
                showNormalDialog(context, '', '是否打开设置', "通过设置来打开定位",
                    onDialogCallback: (type) {

                    });

                showNormalDialog(
                  context: context,
                  title: 'title',
                  actionButtonTitle: '哈哈',
                  cancelButtonTitle: '呵呵',
                  message: "没有东西",
                  onDialogCallback: (type) {
                    if (type == ButtonActionType.action) {
                      AALog("确认");
                    } else {
                      AALog("取消");
                    }
                  },
                );

*/
enum ButtonActionType { action, cancel }

typedef DialogCallback = void Function(ButtonActionType);

/// 通过ButtonActionType 来区分 确认和取消
Future<ButtonActionType?> showNormalDialog({
  required BuildContext context,
  required String title,
  required message,
  required String actionButtonTitle,
  required String cancelButtonTitle,
  required DialogCallback onDialogCallback,
}) {
  return showDialogAlert(
    context: context,
    image: AssetUtils.getAssetImagePNG('dialog_fail'),
    title: title,
    message: message,
    actionButtonTitle: actionButtonTitle,
    cancelButtonTitle: cancelButtonTitle,
    onDialogCallback: onDialogCallback,
  );
}

Future<ButtonActionType?> showErrorDialog(
    {required BuildContext context, required String title, String? message}) {
  return showDialogAlert(
    context: context,
    image: AssetUtils.getAssetImagePNG('dialog_fail'),
    title: title,
    message: message,
    actionButtonTitle: "OK",
    cancelButtonTitle: "Cancel",
  );
}

/// 确认 和 取消按钮 没有点击事件
Future<ButtonActionType?> showNetErrorDialog(
    {required BuildContext context, required String title, String? message}) {
  return showDialogAlert(
    context: context,
    image: AssetUtils.getAssetImagePNG('dialog_fail'),
    title: title,
    message: message,
    actionButtonTitle: "再试一次",
    cancelButtonTitle: "取消",
  );
}

/// 只有确认按钮 没有点击实现
Future<ButtonActionType?> showNotNetDialog(
    {required BuildContext context, required String title, String? message}) {
  return showDialogAlert(
    context: context,
    image: AssetUtils.getAssetImagePNG('dialog_fail'),
    title: title,
    message: message,
    actionButtonTitle: "再试一次",
  );
}

Future<ButtonActionType?> showDialogAlert({
  required BuildContext context,

  /// 图标显示
  required String image,

  /// 标题显示
  required String title,

  /// 内容显示
  String? message,

  /// 确认按钮的文字
  required String actionButtonTitle,

  /// 取消按钮的文字
  String? cancelButtonTitle,

  /// 确认按钮的颜色
  Color? actionButtonColor,

  /// 取消按钮的颜色
  Color? cancelButtonColor,

  /// 按钮样式
  TextStyle? buttonStyle,

  /// 标题样式
  TextStyle? titleStyle,

  /// 内容样式
  TextStyle? contentStyle,

  /// 点击回调
  DialogCallback? onDialogCallback,
}) {
  return _showDialogAlert(
    context: context,
    image: image,
    title: title,
    message: message,
    actionButtonTitle: actionButtonTitle,
    cancelButtonTitle: cancelButtonTitle,
    actionButtonColor: actionButtonColor,
    cancelButtonColor: cancelButtonColor,
    buttonStyle: buttonStyle,
    titleStyle: titleStyle,
    contentStyle: contentStyle,
    onDialogCallback: onDialogCallback,
  );
}

Future<ButtonActionType?> _showDialogAlert({
  required BuildContext context,

  /// 图标显示
  required String image,

  /// 标题显示
  required String title,

  /// 内容显示
  String? message,

  /// 确认按钮的文字
  required String actionButtonTitle,

  /// 取消按钮的文字
  String? cancelButtonTitle,

  /// 确认按钮的颜色
  Color? actionButtonColor,

  /// 取消按钮的颜色
  Color? cancelButtonColor,

  /// 按钮样式
  TextStyle? buttonStyle,

  /// 标题样式
  TextStyle? titleStyle,

  /// 内容样式
  TextStyle? contentStyle,

  /// 点击回调
  DialogCallback? onDialogCallback,
}) {
  TextStyle defultButtonStyle = const TextStyle(
    fontSize: 12,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w900,
  );

  //确认按钮创建
  Widget actionWidget = GlobalLoadingElevatedButton(
    title: actionButtonTitle,
    style: ElevatedButton.styleFrom(
      backgroundColor: KTColor.tabbar_select, // const Color(0xFFFFCD1B),
      foregroundColor: actionButtonColor ?? const Color(0xFF33363F),
      //elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    // style: ButtonStyle(
    //   backgroundColor: WidgetStateProperty.all(Colors.blue),
    //   foregroundColor: WidgetStateProperty.all(Colors.white),
    //   shape: WidgetStateProperty.all(
    //     //圆角配置
    //     RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //   ),
    // ),
    titleStyle: buttonStyle ?? defultButtonStyle,
    onPressed: () {
      if (onDialogCallback != null) {
        onDialogCallback.call(ButtonActionType.action);
      } else {
        Navigator.of(context).pop(ButtonActionType.action);
      }
    },
  );
  //取消按钮创建
  Widget? cancelWidget;
  if (cancelButtonTitle != null) {
    cancelWidget = GlobalLoadingElevatedButton(
      title: cancelButtonTitle,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF5EFE9), //GlobalColor.dialogActionCancel,
        foregroundColor: cancelButtonColor ?? const Color(0xFF746352),
        //elevation: 0, //取消按钮点击显示的阴影
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      // style: ButtonStyle(
      //   backgroundColor: WidgetStateProperty.all(Color(0xFFF5EFE9)),
      //   foregroundColor: WidgetStateProperty.all(
      //       cancelButtonColor ?? const Color(0xFF746352)),
      //   shape: WidgetStateProperty.all(
      //     //圆角配置
      //     RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //   ),
      // ),
      titleStyle: buttonStyle ?? defultButtonStyle,
      onPressed: () {
        if (onDialogCallback != null) {
          onDialogCallback.call(ButtonActionType.cancel);
        } else {
          Navigator.of(context).pop(ButtonActionType.cancel);
        }
      },
    );
  }

  return _showDialogAlertWidget(
      context, image, title, message, actionWidget, cancelWidget,
      titleStyle: titleStyle, contentStyle: contentStyle);
}

/* 构建 基本弹框 */
Future<ButtonActionType?> _showDialogAlertWidget(
  BuildContext context,

  /// 图片
  String image,

  /// 标题
  String title,

  /// 内容
  String? message,

  /// 确认按钮控件
  Widget actionWidget,

  /// 取消按钮控件
  Widget? cancelWidget, {
  /// 标题样式
  TextStyle? titleStyle,

  /// 内容样式
  TextStyle? contentStyle,
}) {
  //安卓弹框
  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Colors.white,
          content: _buildDialogAlertContent(
            context,
            image,
            title,
            message,
            actionWidget,
            cancelWidget,
            titleStyle: titleStyle,
            contentStyle: contentStyle,
          ),
        ),
      ),
    );
  }
  //iOS弹框
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: _buildDialogAlertContent(
        context,
        image,
        title,
        message,
        actionWidget,
        cancelWidget,
        titleStyle: titleStyle,
        contentStyle: contentStyle,
      ),
    ),
  );
}

Widget _buildDialogAlertContent(
  BuildContext context,

  /// 图片
  String image,

  /// 标题
  String title,

  /// 内容
  String? message,

  /// 确认按钮控件
  Widget actionWidget,

  /// 取消按钮控件
  Widget? cancelWidget, {
  /// 标题样式
  TextStyle? titleStyle,

  /// 内容样式
  TextStyle? contentStyle,
}) {
  TextTheme textTheme = Theme.of(context).textTheme;

  return Container(
    constraints: const BoxConstraints(minWidth: 500),
    // 设置对话框的最大宽度
    child: Column(
      mainAxisSize: MainAxisSize.min, //垂直方向根据控件多少,显示最小高度
      children: [
        //1.弹框图标
        SizedBox(
          width: 76,
          height: 76,
          child: Image.asset(
            image,
          ),
        ),
        globalSpaceH15,
        //2.标题
        Text(
          title,
          textAlign: TextAlign.center,
          // style: textTheme.bodyLarge,
          style: titleStyle ?? textTheme.titleMedium,
        ),
        Visibility(visible: message != null, child: globalSpaceH8),
        //3.内如
        Visibility(
            visible: message != null,
            child: Text(
              message ?? "",
              textAlign: TextAlign.center,
              // style: textTheme.titleSmall,
              style: contentStyle ?? textTheme.titleSmall,
            )),
        globalSpaceH30,
        //确认按钮
        actionWidget,
        globalSpaceH10,
        //取消按钮
        cancelWidget ?? const SizedBox.shrink()
      ],
    ),
  );
}
