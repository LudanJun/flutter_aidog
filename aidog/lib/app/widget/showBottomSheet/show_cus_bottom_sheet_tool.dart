import 'package:flutter/material.dart';

typedef ValueChanged<T> = void Function(T value);

class ShowCusBottomSheetTool {
  late Widget widget;
  // //点击回调
  // late final ValueChanged<String>? onChanged;

  cusBottomSheet(BuildContext context, Widget widget) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: widget,
        );
      },
    );
  }
}
