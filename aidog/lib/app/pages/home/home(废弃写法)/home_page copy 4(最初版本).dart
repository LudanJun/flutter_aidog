import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/show_toast_utils.dart';
import 'package:aidog/app/pages/home/provider/home_provider.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:aidog/app/widget/dialog/hoo_dialog.dart';
import 'package:aidog/app/widget/dialog/net_dialog.dart';
import 'package:aidog/app/widget/dialog/show_dialog_alert.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  HomeProvider _homeProvider = HomeProvider();
  late TabController _tabController;

  ///纬度
  String _latitude = "";

  ///经度
  String _longitude = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        TabController(length: _homeProvider.subTabList.length, vsync: this);
    GlobalLocationTool().locationResultListen((map) {
      AALog("监听的定位信息:$map");
      setState(() {
        _latitude = map["latitude"].toString();
        _longitude = map["longitude"].toString();
      });
    });
  }

  @override
  void dispose() {
    GlobalLocationTool().destroyLocation();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: ElevatedButton(
    //     onPressed: () async {
    //       print("跳转");
    //       AALog("saga");
    //       // showToastCenter("显示中间");
    //       NavigationUtil.getInstance().pushNamed(RoutersName.homeDetailPage);

    //       // showNotNetDialog(context: context, title: "没有网络");
    //       // showNetErrorDialog(context: context, title: "网络错误");
    //       // showErrorDialog(
    //       //     context: context,
    //       //     title: "singasdadsad",
    //       //     message: 'Incorrect email address or password');
    //     },
    //     child: Text("点我跳转"),
    //   ),
    // );
    final themeData = Theme.of(context);

    return Scaffold(
      body: EasyRefresh.builder(
        header: const ClassicHeader(
          clamping: true,
          position: IndicatorPosition.locator,
          mainAxisAlignment: MainAxisAlignment.end,
          dragText: '下拉刷新...', //'Pull to refresh',
          armedText: '释放立即刷新', //'Release ready',
          readyText: '正在刷新...', //'Refreshing...',
          processingText: '正在刷新...', //'Refreshing...',
          processedText: '刷新完成', //'Succeeded',
          noMoreText: 'No more',
          failedText: 'Failed',
          messageText: 'Last updated at %T',
        ),
        footer: const ClassicFooter(
          position: IndicatorPosition.locator,
          dragText: '上拉加载', //'Pull to load',
          armedText: '释放立即刷新', //'Release ready',
          readyText: '正在加载...', //'Loading...',
          processingText: '正在加载...', //'Loading...',
          processedText: '加载完成', //'Succeeded',
          noMoreText: 'No more',
          failedText: 'Failed',
          messageText: 'Last updated at %T',
        ),
        onRefresh: () {},
        onLoad: () {},
        childBuilder: (context, physics) {
          return ExtendedNestedScrollView(
            controller: _homeProvider.scrollController,
            physics: const ClampingScrollPhysics(),
            onlyOneScrollInBody: true,
            //固定头部的高度
            pinnedHeaderSliverHeightBuilder: () {
              return MediaQuery.of(context).padding.top + kToolbarHeight;
            },

            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const HeaderLocator.sliver(clearExtent: false),
                // SliverAppBar(
                //   expandedHeight: ScreenAdapter.height(300),
                //   pinned: true,
                //   // title: Container(
                //   //   color: GlobalColor.amber,
                //   //   width: ScreenAdapter.getScreenWidth(),
                //   //   height: ScreenAdapter.height(100),
                //   // ),
                //   backgroundColor: Colors.white,
                //   elevation: 0, //去掉阴影
                //   flexibleSpace: FlexibleSpaceBar(
                //     //更改滚动视图往上推折叠方式引脚
                //     collapseMode: CollapseMode.pin,
                //     background: Container(
                //       color: Colors.red,
                //       child: Image.network(
                //         imageUrl1,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
              ];
            },
            body: Container(
              color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    width: ScreenAdapter.getScreenWidth(),
                    height: ScreenAdapter.height(240),
                    color: Colors.red,
                    child: Image.network(
                      imageUrl1,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: ScreenAdapter.height(80),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(padding_50),
                        topRight: Radius.circular(padding_50),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width:
                              ScreenAdapter.getScreenWidth() - padding_30 * 2,
                          height: ScreenAdapter.height(60),
                          decoration: BoxDecoration(
                            color: KTColor.color_243,
                            borderRadius: BorderRadius.circular(padding_20),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: padding_15,
                              ),
                              Icon(
                                Icons.location_on_rounded,
                                size: padding_35,
                                color: KTColor.color_251_98_64,
                              ),
                              SizedBox(
                                width: padding_10,
                              ),
                              InkWell(
                                onTap: () {
                                  AALog('获取定位');
                                  GlobalLocationTool().startLocationInfo();
                                },
                                child: Text("获取定位${_latitude}"),
                              ),
                              SizedBox(
                                width: padding_30,
                              ),
                              Text("为你找到36条相关推荐"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    labelColor: themeData.colorScheme.primary,
                    indicatorColor: themeData.colorScheme.primary,
                    onTap: (value) {
                      AALog(value);
                    },
                    tabs: _homeProvider.subTabList.map(
                      (value) {
                        return Tab(
                          child: Text(value['name']),
                        );
                      },
                    ).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        //1.最新发布
                        ExtendedVisibilityDetector(
                          uniqueKey: const Key('Tab0'),
                          child: _AutomaticKeepAlive(
                            child: MasonryGridView.count(
                              padding: EdgeInsets.only(
                                left: padding_15,
                                right: padding_15,
                                top: padding_15,
                              ), //取消头部间隙
                              crossAxisCount: 2,
                              mainAxisSpacing: ScreenAdapter.width(26),
                              crossAxisSpacing: ScreenAdapter.width(26),
                              itemCount: 15, //元素总个数
                              shrinkWrap: true, //收缩,让元素宽度自适应
                              // physics:
                              //     const NeverScrollableScrollPhysics(), //禁止滑动

                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    AALog(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(
                                      ScreenAdapter.width(20),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10), //圆角
                                      color: KTColor.getRandomColor(),
                                    ),
                                    child: Column(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //1.图片
                                        Container(
                                          padding: EdgeInsets.all(padding_5),
                                          child: Image.network(
                                            'http://gips3.baidu.com/it/u=100751361,1567855012&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        //2.文本
                                        Text(
                                          '国庆节放假,小狗求陪玩七天,性格温顺,希望小伙伴们积极',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        //3.标签
                                        Row(
                                          children: [
                                            Container(
                                              // color: Colors.red,
                                              child: Wrap(
                                                spacing: spacing,
                                                // runSpacing: padding_5,
                                                direction:
                                                    Axis.horizontal, //在主轴显示,
                                                alignment: WrapAlignment
                                                    .start, //主轴对齐方式
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      ' ♀哈尼/8个月 ',
                                                      style: TextStyle(
                                                        fontSize: ScreenAdapter
                                                            .fontSize(
                                                          18,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              padding_20),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      ' 求代遛 ',
                                                      style: TextStyle(
                                                        fontSize: ScreenAdapter
                                                            .fontSize(
                                                          18,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              padding_20),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: padding_20,
                                            ),
                                            //4.日期
                                            Text(
                                              '09-15',
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenAdapter.fontSize(18),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            /*
                            child: CustomScrollView(
                              physics: physics,
                              slivers: [
                                SliverPadding(
                                  padding: EdgeInsets.all(
                                    ScreenAdapter.height(10),
                                  ),
                                  sliver: SliverGrid(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        return Container(
                                          height: ScreenAdapter.height(
                                              100 + 10 * index),
                                          alignment: Alignment.center,
                                          // color: Colors
                                          //     .blueGrey[100 * (index % 9)],
                                          color: GlobalColor.getRandomColor(),
                                          child: Text("Grid ite $index"),
                                        );
                                      },
                                      childCount: 10,
                                    ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 每行的子组件数量
                                      crossAxisSpacing: 10, // 子组件之间的间距
                                      mainAxisSpacing: 10, //行间距
                                      // childAspectRatio: 1.0, //子组件宽高比
                                    ),
                                  ),
                                ),
                                const FooterLocator.sliver(),
                              ],
                            ),
                            */
                          ),
                        ),
                        //2.离我最近
                        ExtendedVisibilityDetector(
                          uniqueKey: const Key('Tab1'),
                          child: _AutomaticKeepAlive(
                            child: CustomScrollView(
                              physics: physics,
                              slivers: [
                                SliverPadding(
                                  padding: EdgeInsets.all(
                                    ScreenAdapter.height(10),
                                  ),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        return Container(
                                          color: KTColor.getRandomColor(),
                                          height: 200,
                                          width: ScreenAdapter.getScreenWidth(),
                                        );
                                      },
                                      childCount: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AutomaticKeepAlive extends StatefulWidget {
  final Widget child;

  const _AutomaticKeepAlive({
    required this.child,
  });

  @override
  State<_AutomaticKeepAlive> createState() => _AutomaticKeepAliveState();
}

class _AutomaticKeepAliveState extends State<_AutomaticKeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
