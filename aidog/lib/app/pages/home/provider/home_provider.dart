import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  // final BuildContext context;

  // HomeProvider(this.context);

  //ScrollController创建滚动控制器才能用来监听滚动视图滚动的状态
  final ScrollController scrollController = ScrollController();
  // TabController? _tabController;

  ///tab 标签数据
  final List<Map<String, dynamic>> subTabList = [
    {
      'id': 1,
      'name': '离我最近',
    },
    {
      'id': 2,
      'name': '最新发布',
    },
  ];

  final List<String> leftList = [
    '全郑州',
  ];
  // final List<String> rightList = [
  //   '全郑州',
  //   '金水区',
  //   '中原区',
  //   '管城回族区',
  //   '二七区',
  //   '惠济区',
  //   '郑东新区',
  //   '高新区',
  // ];

  /// 左侧选择的
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  set selectIndex(int value) {
    _selectIndex = value;
    notifyListeners();
  }

  /// 右侧选择的
  int _selectRightIndex = 0;
  int get selectRightIndex => _selectRightIndex;
  set selectRightIndex(int value) {
    _selectRightIndex = value;
    notifyListeners();
  }
}
