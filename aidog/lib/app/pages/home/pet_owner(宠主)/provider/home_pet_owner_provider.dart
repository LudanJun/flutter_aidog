

import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  //ScrollController创建滚动控制器才能用来监听滚动视图滚动的状态
  final ScrollController scrollController = ScrollController();

  ///tab 标签数据
  final List<Map<String, dynamic>> subTabList = [
    {
      'id': 1,
      'name': '最新发布',
    },
    {
      'id': 2,
      'name': '离我最近',
    },
  ];
}
