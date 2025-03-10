import 'package:flutter/material.dart';

const double _cellHeight = 50.0;
const double _spaceHeight = 5.0;
const double _titleFontSize = 13.0;
const double _textFontSize = 18.0;

class JfBottomSheetView extends StatefulWidget {
  final String? title;
  final List<String>? dataArr;
  final String? redBtnTitle;
  final Function(int selectIndex, String selectText)? clickCallBack;

  const JfBottomSheetView(
      {super.key,
      this.title,
      this.dataArr,
      this.redBtnTitle,
      this.clickCallBack});

  @override
  State<JfBottomSheetView> createState() => _JfBottomSheetViewState();
}

class _JfBottomSheetViewState extends State<JfBottomSheetView> {
  List<String> _dataArr = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //如果数据源不为空
    if (widget.dataArr != null) {
      _dataArr = widget.dataArr!;
    }

    //如果红色按钮标题不为空
    if (widget.redBtnTitle != null) {
      _dataArr.insert(_dataArr.length, widget.redBtnTitle!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    var titleHeight = _cellHeight;
    //线高度
    var titleLineHeight = 0.6;
    if (widget.title == null) {
      titleHeight = 0.0;
      titleLineHeight = 0.0;
    }
    //背景高度
    var bgHeight = _cellHeight * (_dataArr.length + 1) +
        (_dataArr.length - 1) * 1 +
        _spaceHeight +
        titleHeight +
        titleLineHeight;
    //默认颜色
    // var redTextColor =
  }
}
