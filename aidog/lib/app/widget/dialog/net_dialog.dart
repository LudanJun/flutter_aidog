import 'package:aidog/app/common/global_color.dart';
import 'package:flutter/material.dart';
/* 1.显示加载控件
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) {
    return NetLoadingDialog();
  },
);
await Future.delayed(Duration(seconds: 1));

// 2.隐藏加载控件
Navigator.of(context).pop();
*/
// ignore: must_be_immutable
class NetLoadingDialog extends StatefulWidget {
  String loadingText; //加载的文字
  bool outsideDismiss = false; //点击加载控件是否关闭显示 一般默认false
  Function? dismissDialog;

  NetLoadingDialog(
      {super.key,
      this.loadingText = "加载中...",
      this.outsideDismiss = true,
      this.dismissDialog});

  @override
  State<NetLoadingDialog> createState() => _LoadingDialog();
}

class _LoadingDialog extends State<NetLoadingDialog> {
  _dismissDialog() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    widget.dismissDialog?.call(() {
      //将关闭 dialog的方法传递到调用的页面
      // Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.outsideDismiss ? _dismissDialog : null,
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: SizedBox(
            width: 120.0,
            height: 120.0,
            child: Container(
              decoration: const ShapeDecoration(
                color: KTColor.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const CircularProgressIndicator(
                    color: KTColor.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Text(
                      widget.loadingText,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
