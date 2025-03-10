import 'package:aidog/app/common/asset_utils.dart';
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
        onRefresh: () async {
          AALog('下拉刷新');
          //下拉刷新
          await Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              setState(() {});
            }
          });
        },
        onLoad: () async {
          AALog("上拉加载");
          await Future.delayed(
            const Duration(seconds: 1),
            () {
              if (mounted) {
                setState(() {});
              }
            },
          );
        },
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
                //上拉控件显示
                const HeaderLocator.sliver(clearExtent: false),
              ];
            },
            body: Stack(
              children: [
                Container(
                  width: ScreenAdapter.getScreenWidth(),
                  height: ScreenAdapter.width(289),
                  // color: Colors.red,
                  child: Image.asset(
                    AssetUtils.getAssetImagePNG('home_top_bg'),
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: ScreenAdapter.width(289) - ScreenAdapter.width(58),
                  left: 0,
                  right: 0,
                  child: Container(
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
                                child: Text(
                                  "获取定位${_latitude}>",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenAdapter.fontSize(26),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: padding_15,
                              ),
                              Text(
                                "为你找到36条相关推荐",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: ScreenAdapter.fontSize(24),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: ScreenAdapter.width(289) -
                      ScreenAdapter.width(58) +
                      ScreenAdapter.width(98),
                  left: 0,
                  right: 0,
                  child: Container(
                    color: KTColor.color_255_247_242,
                    child: TabBar(
                      dividerHeight: 0.0, //去掉tabbar底部线
                      controller: _tabController,
                      isScrollable: false, //是否可以滚动
                      labelColor: KTColor.black, //选中label后的文字颜色
                      labelStyle: TextStyle(
                        fontSize: ScreenAdapter.fontSize(34), //选中的文字大小
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: ScreenAdapter.fontSize(32), //未选中文字大小
                      ),
                      indicatorColor: themeData.colorScheme.primary, //指示器颜色
                      indicatorSize: TabBarIndicatorSize.label, //跟文字一样长
                      indicatorPadding: EdgeInsets.only(
                        top: ScreenAdapter.width(70),
                        bottom: ScreenAdapter.width(30),
                      ),

                      indicatorWeight: ScreenAdapter.height(18), //指示器高度
                      indicator: BoxDecoration(
                        shape: BoxShape.rectangle, //确保形状是矩形
                        image: DecorationImage(
                          image: AssetImage('assets/indicator.png'),
                          fit: BoxFit.cover, // 确保图片覆盖整个指示器区域
                        ),
                      ),
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
                  ),
                ),
                Positioned(
                  top: ScreenAdapter.width(289) -
                      ScreenAdapter.width(58) +
                      ScreenAdapter.width(98) +
                      ScreenAdapter.width(100),
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      //1.最新发布
                      ExtendedVisibilityDetector(
                        uniqueKey: const Key('Tab0'),
                        child: _AutomaticKeepAlive(
                          child: CustomScrollView(
                            physics: physics,
                            slivers: [
                              //warn SliverToBoxAdapter 需包裹MasonryGridView才能实现刷新
                              SliverToBoxAdapter(
                                child: masoryView(),
                              ),

                              const FooterLocator.sliver(), //上拉控件显示
                            ],
                          ),
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

                /*
                Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                
                      Container(
                        height: ScreenAdapter.height(80),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(padding_50),
                            topRight: Radius.circular(padding_50),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: ScreenAdapter.getScreenWidth() -
                                  padding_30 * 2,
                              height: ScreenAdapter.height(60),
                              decoration: BoxDecoration(
                                color: GlobalColor.color_243,
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
                                    color: GlobalColor.color_251_98_64,
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
                        dividerHeight: 0.0, //去掉tabbar底部线
                        controller: _tabController,
                        isScrollable: false, //是否可以滚动
                        labelColor: GlobalColor.black, //选中label后的文字颜色
                        labelStyle: TextStyle(
                          fontSize: ScreenAdapter.fontSize(34), //选中的文字大小
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: ScreenAdapter.fontSize(32), //未选中文字大小
                        ),
                        indicatorColor: themeData.colorScheme.primary, //指示器颜色
                        indicatorSize: TabBarIndicatorSize.label, //跟文字一样长
                        indicatorPadding: EdgeInsets.only(
                          top: ScreenAdapter.width(70),
                          bottom: ScreenAdapter.width(30),
                        ),

                        indicatorWeight: ScreenAdapter.height(18), //指示器高度
                        indicator: BoxDecoration(
                          shape: BoxShape.rectangle, //确保形状是矩形
                          image: DecorationImage(
                            image: AssetImage('assets/indicator.png'),
                            fit: BoxFit.cover, // 确保图片覆盖整个指示器区域
                          ),
                        ),
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
            
                    ],
                  ),
                ),

                */
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> shuaxin() async {
    AALog("刷新了");
  }

  Widget masoryView() {
    return MasonryGridView.count(
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
      physics: const NeverScrollableScrollPhysics(), //禁止滑动 不能少不然无法刷新

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
              borderRadius: BorderRadius.circular(10), //圆角
              // color: GlobalColor.getRandomColor(),
            ),
            child: Column(
              // mainAxisAlignment:
              //     MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1.图片
                Container(
                  //设置裁切属性
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    'http://gips3.baidu.com/it/u=100751361,1567855012&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280',
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                    //设置完圆角度数后,需要设置裁切属性
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(18)),
                  ),
                ),
                //2.标题
                Container(
                  // color: Colors.grey,
                  child: Stack(
                    children: [
                      // Positioned(child: child)
                      Image(
                        image: AssetImage(
                          AssetUtils.getAssetImagePNG('home_cell_title_bg'),
                        ),
                      ),
                      Positioned(
                        top: ScreenAdapter.width(20),
                        left: ScreenAdapter.width(25),
                        child: Row(
                          children: [
                            Text("哈尼"),
                            Text(" | "),
                            Text('求代遛'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //3.内容
                Text(
                  '国庆节放假,小狗求陪玩七天,性格温顺,希望小伙伴们积极',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenAdapter.fontSize(28),
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: padding_10,
                ),
                //4.作者信息
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //1.头像 名字
                    Row(
                      children: [
                        Container(
                          //设置裁切属性
                          width: ScreenAdapter.width(46),
                          height: ScreenAdapter.width(46),
                          child: CircleAvatar(
                            radius: ScreenAdapter.width(23),
                            backgroundImage: AssetImage(
                              AssetUtils.getAssetImagePNG('default_head_img'),
                            ),
                          ),
                        ),
                        SizedBox(width: padding_10),
                        Container(
                          // color: Colors.orange,
                          child: Text(
                            '纸飞机',
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(28),
                              color: KTColor.color_76_76_76,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //2.距离
                    Row(
                      children: [
                        Container(
                          width: ScreenAdapter.width(24),
                          height: ScreenAdapter.width(24),
                          // color: Colors.red,
                          child: Image.asset(
                            AssetUtils.getAssetImagePNG(
                                'home_cell_locaiton_white'),
                          ),
                        ),
                        SizedBox(
                          width: padding_5,
                        ),
                        Container(
                          child: Text(
                            '1.8km',
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /*
                //2.标签
                Row(
                  children: [
                    Container(
                      // color: Colors.red,
                      child: Wrap(
                        spacing: spacing,
                        // runSpacing: padding_5,
                        direction: Axis.horizontal, //在主轴显示,
                        alignment: WrapAlignment.start, //主轴对齐方式
                        children: [
                          Container(
                            child: Text(
                              ' ♀哈尼/8个月 ',
                              style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(
                                  18,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(padding_20),
                            ),
                          ),
                          Container(
                            child: Text(
                              ' 求代遛 ',
                              style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(
                                  18,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(padding_20),
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
                        fontSize: ScreenAdapter.fontSize(18),
                      ),
                    ),
                  ],
                ),
                */
              ],
            ),
          ),
        );
      },
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
