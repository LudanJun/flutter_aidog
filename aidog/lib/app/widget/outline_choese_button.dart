import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef CustomOutlineChoeseTapCallback = void Function(int index);

/// 外框是线 可以选择的按钮
class OutlineChoeseButton extends StatefulWidget {
  /// 按钮文字
  final String title;

  ///边框颜色
  Color? textColor = Colors.white;

  ///设置按钮数值
  final int index;

  /// 宽度
  final double width;

  /// 高度
  final double height;

  ///圆角半径
  final double radius;

  ///边框宽度
  double? borderWidth = 0.0;

  ///边框颜色
  Color? borderColor = Colors.white;

  ///右侧控件
  final Widget? rightWidget;

  /// 点击回调
  final CustomOutlineChoeseTapCallback onTap;

  OutlineChoeseButton({
    super.key,
    required this.title,
    this.textColor,
    required this.index,
    required this.onTap,
    required this.width,
    required this.height,
    required this.radius,
    this.borderWidth,
    this.borderColor,
    this.rightWidget,
  });

  @override
  State<OutlineChoeseButton> createState() => _OutlineChoeseButtonState();
}

class _OutlineChoeseButtonState extends State<OutlineChoeseButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(
          () {
            widget.onTap(widget.index);
          },
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: widget.width,
        height: widget.height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: KTColor.white,
          borderRadius: BorderRadius.circular(
            ScreenAdapter.height(widget.radius),
          ),
          border: Border.all(
            width: widget.borderWidth!,
            color: widget.borderColor!,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: ScreenAdapter.fontSize(26),
                fontWeight: FontWeight.w300,
                color: widget.textColor,
              ),
            ),
            if (widget.rightWidget != null) widget.rightWidget!
          ],
        ),
      ),
    );
  }
}
