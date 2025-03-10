import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';

class CusCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const CusCheckBox({super.key, required this.value, required this.onChanged});

  @override
  State<CusCheckBox> createState() => _CusCheckBoxState();
}

class _CusCheckBoxState extends State<CusCheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: ScreenAdapter.width(padding_60),
        height: ScreenAdapter.width(padding_60),
        decoration: BoxDecoration(
          color: widget.value
              ? KTColor.color_251_98_64
              : Colors.transparent, // 设置选中时的填充颜色
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.value
                ? KTColor.color_251_98_64
                : KTColor.color_76_76_76, // 设置选中和未选中时的边框颜色
            width: ScreenAdapter.width(1), // 设置边框宽度，这里设置为2.0以使外框变细
          ),
        ),
        child: widget.value
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 14.0, // 设置图标大小
              )
            : null,
      ),
    );
  }
}
