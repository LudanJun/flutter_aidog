import 'package:aidog/app/common/button_util.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

typedef LoadingCallback = Future<bool> Function();

class GlobalLoadingElevatedButton extends StatefulWidget {
  ///
  final String title;

  ///
  final TextStyle? titleStyle;

  ///
  final ButtonStyle? style;

  ///
  final VoidCallback? onPressed;

  final LoadingCallback? onLoading;

  const GlobalLoadingElevatedButton({
    super.key,
    required this.title,
    this.titleStyle,
    this.style,
    this.onPressed,
    this.onLoading,
  });

  @override
  State<GlobalLoadingElevatedButton> createState() =>
      _GlobalLoadingElevatedButtonState();
}

class _GlobalLoadingElevatedButtonState
    extends State<GlobalLoadingElevatedButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, //设置按钮长度
      height: ScreenAdapter.height(80),
      padding: globalEdgeHorizontal8,
      // color: Colors.red,
      child: ElevatedButton(
        style: widget.style,
        onPressed: widget.onPressed != null || widget.onLoading != null
            ? ButtonUtils.debounce(onPressed)
            : null,
        child: isLoading
            ? const SizedBox(
                width: 60,
                height: 56,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballBeat,
                  colors: [Colors.white],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.black,
                ),
              )
            : Text(
                widget.title,
                style: widget.titleStyle,
              ),
      ),
    );
  }

  void onPressed() {
    if (widget.onPressed != null) {
      widget.onPressed?.call();
    }
    if (widget.onLoading != null) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        widget.onLoading?.call().then((value) {
          setState(() {
            isLoading = false;
          });
        });
      }
    }
  }
}
