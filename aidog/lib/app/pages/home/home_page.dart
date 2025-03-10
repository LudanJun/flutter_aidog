import 'package:aidog/app/apis/home_api.dart';
import 'package:aidog/app/apis/my_api.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/defalut_image.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/show_toast_utils.dart';
import 'package:aidog/app/pages/home/home_detail_page.dart';
import 'package:aidog/app/pages/home/home_help_other_info_page.dart';
import 'package:aidog/app/pages/home/model/home_area_model.dart';
import 'package:aidog/app/pages/home/model/home_dog_model.dart';
import 'package:aidog/app/pages/home/model/home_help_model.dart';
import 'package:aidog/app/pages/home/provider/home_provider.dart';
import 'package:aidog/app/pages/home/widget/dropdown_menu_hou.dart';
import 'package:aidog/app/pages/my/models/my_user_info_model.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeProvider _homeProvider = HomeProvider();
  late TabController _tabController;
  final EasyRefreshController _easycontroller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  MyUserInfoModel _myUserInfoModel = MyUserInfoModel();

  /// 首页帮养人列表
  HomeHelpModel _homeHelpModel = HomeHelpModel();

  /// 城市区域
  HomeAreaModel _homeAreaModel = HomeAreaModel();
  List<HelpListItemModel> _helpListModel = [];
  int _helpPage = 1;
  bool _helpflag = true; //解决重复请求的问题
  bool _helpHasData = true; //是否有数据

  /// 首页狗狗列表
  HomeDogModel _homeDogModel = HomeDogModel();
  List<DogListItemModel> _dogListModel = [];
  int _dogPage = 1;
  bool _dogflag = true;
  bool _dogHasData = true;

  // final List<CustomDropdownMenuItem> _items = [
  //   CustomDropdownMenuItem(
  //     header: "管城回族自治区",
  //     body: Container(
  //       width: ScreenAdapter.getScreenWidth(),
  //       height: ScreenAdapter.height(300),
  //       color: KTColor.red,
  //     ),
  //   ),
  // ];
  List<CustomDropdownMenuItem> _items = [];

  // 记录是离我最近还是最新发布
  String _orderBy = 'distance';
  // 记录选择的县
  String _district = "全郑州";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController =
        TabController(length: _homeProvider.subTabList.length, vsync: this);

    ///获取用户数据和首页列表
    getUseInfoData(1);
    // _items = [
    //   CustomDropdownMenuItem(
    //     header: "金水区",
    //     body: Container(
    //       width: ScreenAdapter.getScreenWidth(),
    //       height: ScreenAdapter.height(524),
    //       color: KTColor.white,
    //       child: Row(
    //         children: [
    //           //左侧
    //           _leftCate(),
    //           //右侧
    //           _rightCate(),
    //         ],
    //       ),
    //     ),
    //   ),
    // ];
  }

  /// 获取完用户信息同时获取首页数据
  void getUseInfoData(int page) {
    /// 获取用户信息
    MyApi().userInfo(
      onSuccess: (data) {
        // AALog("data $data");
        if (data['code'] == "200") {
          // setState(() {
          _myUserInfoModel = MyUserInfoModel.fromJson(data);
          // _district = _myUserInfoModel.data?.address?.district ?? "";

          getArea();

          AALog("模型address:${_myUserInfoModel.data?.role}");

          //1=宠物主，2=帮养人
          if (_myUserInfoModel.data?.role == 1) {
            AALog("宠物主获取帮养人列表");
            if (_helpflag && _helpHasData) {
              _helpflag == false;
              HomeApi().getHelpList(
                city: _myUserInfoModel.data?.address?.city ?? "郑州市", //城市
                district: _district, //区县
                orderBy:
                    _orderBy, //排序方式排序字段:distance=按距离排序，time=按最新时间排序,示例值(distance)
                pageNum: page.toString(),
                pageSize: "10",
                onSuccess: (data) {
                  _homeHelpModel = HomeHelpModel.fromJson(data);
                  setState(() {
                    _helpListModel.addAll(_homeHelpModel.data?.list ?? []);
                    _helpPage++;
                    _helpflag = true;
                    //判断有没有数据
                    if (_homeHelpModel.data!.list!.length < 10) {
                      _helpHasData = false;
                    }
                  });
                },
                onFailure: (error) {
                  AALog("error-$error");
                },
              );
            }
          } else if (_myUserInfoModel.data?.role == 2) {
            if (_dogflag && _dogHasData) {
              _dogflag == false;
              AALog("帮养人获取宠主狗狗列表");
              HomeApi().getDogList(
                city: _myUserInfoModel.data?.address?.city ?? "郑州市", //城市
                district: _district, //区县
                orderBy:
                    _orderBy, //排序方式排序字段:distance=按距离排序，time=按最新时间排序,示例值(distance)
                pageNum: page.toString(),
                pageSize: "10",
                onSuccess: (data) {
                  AALog("帮养人列表数据$data");
                  _homeDogModel = HomeDogModel.fromJson(data);
                  setState(() {
                    _dogListModel.addAll(_homeDogModel.data?.list ?? []);
                    _dogPage++;
                    _dogflag = true;
                    //判断有没有数据
                    if (_homeDogModel.data!.list!.length < 10) {
                      _dogHasData = false;
                    }
                  });
                },
                onFailure: (error) {
                  AALog("error-$error");
                },
              );
            }
          }
          // });
        }
        EasyLoading.dismiss();
      },
      onFailure: (error) {
        EasyLoading.dismiss();

        AALog("error-$error");
      },
    );
  }

  /// 获取城市下的区县
  void getArea() {
    HomeApi().getDistrict(
      cityName: _myUserInfoModel.data?.address?.city ?? "郑州市",
      onSuccess: (data) {
        _homeAreaModel = HomeAreaModel.fromJson(data);
        setState(
          () {
            _items = [
              CustomDropdownMenuItem(
                header: _district,
                body: Container(
                  width: ScreenAdapter.getScreenWidth(),
                  height: ScreenAdapter.height(524),
                  color: KTColor.white,
                  child: Row(
                    children: [
                      //左侧
                      _leftCate(),
                      //右侧
                      _rightCate(),
                    ],
                  ),
                ),
              ),
            ];
          },
        );
      },
      onFailure: (error) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    // final themeData = Theme.of(context);
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        return Scaffold(
          body: EasyRefresh.builder(
            controller: _easycontroller,
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
              messageText: '最后更新时间 %T',
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
              messageText: '最后更新时间 %T',
            ),
            onRefresh: () async {
              AALog('下拉刷新');
              //下拉刷新
              await Future.delayed(const Duration(seconds: 1), () {
                if (mounted) {
                  setState(() {
                    if (_myUserInfoModel.data?.role == 1) {
                      _helpListModel = [];
                      _helpPage = 1;
                      _helpHasData = true;

                      ///获取离我最近宠主看帮养人的数据
                      getUseInfoData(1);
                    } else if (_myUserInfoModel.data?.role == 2) {
                      _dogListModel = [];
                      _dogPage = 1;
                      _dogHasData = true;

                      ///获取离我最近宠主看帮养人的数据
                      getUseInfoData(1);
                    }
                  });

                  _easycontroller.finishRefresh();
                  _easycontroller.resetHeader();
                }
              });
            },
            onLoad: () async {
              AALog("上拉加载");
              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  if (mounted) {
                    setState(() {
                      if (_myUserInfoModel.data?.role == 1) {
                        ///获取离我最近宠主看帮养人的数据
                        getUseInfoData(_helpPage);
                      } else {
                        ///获取离我最近宠主看帮养人的数据
                        getUseInfoData(_dogPage);
                      }
                    });

                    _easycontroller.finishLoad();
                    _easycontroller.resetFooter();
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
                    //1.顶部背景区域
                    topBgView(),

                    //2.地址显示区域
                    addressVeiw(),

                    //4.标签地区选择
                    areaButtonView(),

                    //3.tabbar
                    tabBar(),

                    //4.tabbarView内容
                    tabBarView(physics),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  //1.顶部背景
  Widget topBgView() {
    return SizedBox(
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(289),
      // color: Colors.red,
      child: Image.asset(
        'assets/home_top_bg.png',
        fit: BoxFit.fill,
      ),
    );
  }

  ///2.地址显示区域
  Widget addressVeiw() {
    return Positioned(
      top: ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(29),
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(left: padding_30),
        child: Row(
          children: [
            Image.asset(
              width: ScreenAdapter.height(31),
              height: ScreenAdapter.height(34),
              'assets/home_top_house.png',
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: ScreenAdapter.width(8),
            ),
            Text(
              "${_myUserInfoModel.data?.address?.city ?? ""} ${_myUserInfoModel.data?.address?.description ?? ""}", //'金水区 东方国际小区',
              style: TextStyle(
                fontSize: ScreenAdapter.fontSize(26),
                fontWeight: FontWeight.w600,
                color: KTColor.color_76_76_76,
              ),
            ),
            SizedBox(
              width: ScreenAdapter.width(4),
            ),
            Image.asset(
              width: ScreenAdapter.height(16),
              height: ScreenAdapter.height(18),
              'assets/common_right_arrow.png',
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

  // 左侧分类控件
  Widget _leftCate() {
    return Container(
      color: KTColor.color_243,
      width: ScreenAdapter.width(200),
      height: ScreenAdapter.height(525),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount:
            Provider.of<HomeProvider>(context, listen: false).leftList.length,
        itemBuilder: (context, index) {
          return Container(
            color: KTColor.white,
            width: double.infinity,
            height: ScreenAdapter.height(85),
            child: InkWell(
              onTap: () {
                setState(
                  () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .selectIndex = index;
                    AALog(
                        "点击了第${Provider.of<HomeProvider>(context, listen: false).selectIndex}个");
                  },
                );
              },
              child: Stack(
                children: [
                  Container(
                    color: KTColor.white,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Consumer(
                          builder: (context, HomeProvider provider, child) {
                            return Container(
                              width: ScreenAdapter.width(10),
                              height: ScreenAdapter.height(46),
                              color: provider.selectIndex == index
                                  ? Colors.red
                                  : Colors.white,
                            );
                          },
                        )),
                  ),
                  Center(
                    child: Consumer(
                      builder: (context, HomeProvider provider, child) {
                        return Text(
                          provider.leftList[index],
                          style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(26),
                              //选中的时候加粗 其他默认
                              fontWeight: Provider.of<HomeProvider>(context,
                                              listen: true)
                                          .selectIndex ==
                                      index
                                  ? FontWeight.w300
                                  : FontWeight.normal),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //右侧市区分类控件
  Widget _rightCate() {
    return Expanded(
      child: Container(
        height: double.infinity,
        color: Colors.white,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: _homeAreaModel.data?.length,

          // Provider.of<HomeProvider>(context, listen: false)
          //     .rightList
          //     .length,
          itemBuilder: (context, index) {
            return Container(
              color: KTColor.white,
              width: double.infinity,
              height: ScreenAdapter.height(90),
              child: InkWell(
                onTap: () {
                  setState(
                    () {
                      Provider.of<HomeProvider>(context, listen: false)
                          .selectRightIndex = index;

                      AALog(
                          "点击了第${Provider.of<HomeProvider>(context, listen: false).selectRightIndex}个");

                      Navigator.of(context).pop();
                      _district = _homeAreaModel.data?[index] ?? "";

                      // _district =
                      //     Provider.of<HomeProvider>(context, listen: false)
                      //         .rightList[index];
                      _items = [
                        CustomDropdownMenuItem(
                          header: _district,
                          body: Container(
                            width: ScreenAdapter.getScreenWidth(),
                            height: ScreenAdapter.height(524),
                            color: KTColor.white,
                            child: Row(
                              children: [
                                //左侧
                                _leftCate(),
                                //右侧
                                _rightCate(),
                              ],
                            ),
                          ),
                        ),
                      ];

                      if (_myUserInfoModel.data?.role == 1) {
                        _helpListModel = [];
                        _helpPage = 1;
                        _helpHasData = true;

                        ///获取离我最近宠主看帮养人的数据
                        getUseInfoData(1);
                      } else {
                        _dogListModel = [];
                        _dogPage = 1;
                        _dogHasData = true;

                        ///获取离我最近宠主看帮养人的数据
                        getUseInfoData(1);
                      }
                    },
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: padding_30),
                      child: Consumer(
                          builder: (context, HomeProvider provider, child) {
                        return Text(
                          // provider.rightList[index],
                          _homeAreaModel.data?[index] ?? "",
                          style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(26),
                              //选中的时候加粗 其他默认
                              fontWeight: Provider.of<HomeProvider>(context,
                                              listen: true)
                                          .selectRightIndex ==
                                      index
                                  ? FontWeight.bold
                                  : FontWeight.w300),
                        );
                      }),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //3.tabbar
  Widget tabBar() {
    return Positioned(
      // 状态栏高度+ 29 + 18 =等于左上角位置控件的最底部 +38间距
      top: ScreenAdapter.getStatusBarHeight() +
          ScreenAdapter.height(29) +
          ScreenAdapter.height(18) +
          ScreenAdapter.height(38), //间距
      left: padding_100,
      // right: ScreenAdapter.width(220),
      child: Container(
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // color: Colors.amber,
              width: ScreenAdapter.width(400),
              child: TabBar(
                dividerHeight: 0.0, //去掉tabbar底部线
                controller: _tabController,
                isScrollable: false, //是否可以滚动
                labelColor: KTColor.black, //选中label后的文字颜色
                labelStyle: TextStyle(
                  fontSize: ScreenAdapter.fontSize(32), //选中的文字大小
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: ScreenAdapter.fontSize(32), //未选中文字大小
                ),
                // indicatorColor: themeData.colorScheme.primary, //指示器颜色
                indicatorSize: TabBarIndicatorSize.tab, //跟文字一样长

                indicatorPadding: EdgeInsets.only(
                  top: ScreenAdapter.width(75),
                  left: ScreenAdapter.width(35),
                  right: ScreenAdapter.width(35),
                  bottom: ScreenAdapter.width(25),
                ),

                indicatorWeight: ScreenAdapter.width(24), //指示器高度
                indicator: const BoxDecoration(
                  shape: BoxShape.rectangle, //确保形状是矩形
                  image: DecorationImage(
                    image: AssetImage('assets/indicator.png'),
                    fit: BoxFit.fill, // 确保图片覆盖整个指示器区域
                  ),
                ),
                onTap: (value) {
                  if (value == 0) {
                    _orderBy = 'distance';
                  } else if (value == 1) {
                    _orderBy = 'time';
                  }
                  AALog(value);
                  // setState(() {
                  ///获取宠主看帮养人的数据
                  if (_myUserInfoModel.data?.role == 1) {
                    _helpListModel = [];
                    _helpPage = 1;
                    _helpHasData = true;
                    getUseInfoData(1);
                  }

                  ///获取离我最近宠主看帮养人的数据
                  else if (_myUserInfoModel.data?.role == 2) {
                    AALog("_dogListModel");
                    _dogListModel = [];
                    _dogPage = 1;
                    _dogHasData = true;
                    getUseInfoData(1);
                  }
                  // });
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
          ],
        ),
      ),
    );
  }

  /// 右边地区选择
  Widget areaButtonView() {
    return Positioned(
      // 状态栏高度+ 29 + 18 =等于左上角位置控件的最底部 +38间距
      top: ScreenAdapter.getStatusBarHeight() +
          ScreenAdapter.height(29) +
          ScreenAdapter.height(18) +
          ScreenAdapter.height(38), //间距
      left: ScreenAdapter.width(500),
      right: 0,
      child: Container(
        height: ScreenAdapter.width(90),
        child: CustomDropdownMenu(
          items: _items,
          // headerSuffix: Image.asset(//最右面控件
          //   width: ScreenAdapter.height(16),
          //   height: ScreenAdapter.height(8),
          //   'assets/common_right_arrow.png',
          //   fit: BoxFit.fill,
          // ),
          onTap: (index) {
            AALog("回调传值$index");
          },
        ),
      ),
    );
  }

  void _show() async {
    SmartDialog.show(builder: (_) {
      return Container(
        height: 80,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: const Text(
          'easy custom dialog',
          style: TextStyle(color: Colors.white),
        ),
      );
    });
  }

  //4.tabbarView
  Widget tabBarView(ScrollPhysics? physics) {
    return Positioned(
      top: ScreenAdapter.getStatusBarHeight() +
          ScreenAdapter.height(29) +
          ScreenAdapter.height(18) +
          ScreenAdapter.height(38) +
          ScreenAdapter.height(80),
      // +
      // ScreenAdapter.height(16), //间距

      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        // padding: EdgeInsets.only(top: padding_20),
        decoration: BoxDecoration(
          color: KTColor.color_243,
          // color: KTColor.amber,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(padding_50),
          //   topRight: Radius.circular(padding_50),
          // ),
        ),
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
                      child: _myUserInfoModel.data?.role == 1
                          ? masoryPetLookHelpView()
                          : masoryHelpLookPetView(),
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
                    //warn SliverToBoxAdapter 需包裹MasonryGridView才能实现刷新
                    SliverToBoxAdapter(
                      child: _myUserInfoModel.data?.role == 1
                          ? masoryPetLookHelpView()
                          : masoryHelpLookPetView(),
                    ),

                    const FooterLocator.sliver(), //上拉控件显示
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //帮养人看宠主 进入狗狗详情 主内容滚动图
  Widget masoryHelpLookPetView() {
    return MasonryGridView.count(
      padding: EdgeInsets.only(
        left: padding_15,
        right: padding_15,
        top: padding_15,
      ), //取消头部间隙
      crossAxisCount: 2,
      mainAxisSpacing: ScreenAdapter.width(26),
      crossAxisSpacing: ScreenAdapter.width(13),
      itemCount: _dogListModel.length, //元素总个数
      shrinkWrap: true, //收缩,让元素宽度自适应
      physics: const NeverScrollableScrollPhysics(), //禁止滑动 不能少不然无法刷新

      itemBuilder: (context, index) {
        AALog("_dogListModel---$_dogListModel");

        if (_dogListModel.isEmpty) {
          return Container();
        } else {
          var itemModel = _dogListModel[index];

          return InkWell(
            onTap: () {
              AALog(index);
              // NavigationUtil.getInstance().pushNamed(RoutersName.homeDetailPage);
              NavigationUtil.getInstance().pushPage(
                context,
                RoutersName.homeDetailPage,
                widget: HomeDetailPage(id: itemModel.id!),
              );

              // NavigationUtil.getInstance()
              //     .pushNamed(RoutersName.homeHelpOtherInfoPage);

              // NavigationUtil.getInstance()
              //     .pushNamed(RoutersName.homePetOwnerInfoPage);
            },
            child: Container(
              // padding: EdgeInsets.all(
              //   ScreenAdapter.width(20),
              // ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), //圆角
                color: KTColor.white,
                // color: KTColor.red,
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

                    // Image.network(
                    //   'http://gips3.baidu.com/it/u=100751361,1567855012&fm=3028&app=3028&f=JPEG&fmt=auto?w=960&h=1280',
                    //   fit: BoxFit.cover,
                    // ),
                    decoration: BoxDecoration(
                      //设置完圆角度数后,需要设置裁切属性
                      borderRadius:
                          BorderRadius.circular(ScreenAdapter.width(18)),
                    ),
                    child:
                        //     // Image.network(itemModel.photo ?? ""),
                        //     // child: Image.network(imageUrl1),

                        CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: itemModel.photo ?? "",
                      placeholder: (context, url) => defaultBannerImage(),
                      errorWidget: (context, url, error) =>
                          defaultBannerImage(),
                    ),
                  ),
                  //2.标题
                  Container(
                    // color: Colors.grey,
                    child: Stack(
                      children: [
                        //标题背景
                        Image(
                          // height: ScreenAdapter.height(84),
                          image: AssetImage(
                            AssetUtils.getAssetImagePNG('home_cell_title_bg'),
                          ),
                        ),
                        Positioned(
                          top: ScreenAdapter.width(20),
                          left: ScreenAdapter.width(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(itemModel.nickname ?? ""),
                              if ((itemModel.mode ?? "") != "")
                                Text(" | ${itemModel.mode ?? " "}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //3.内容
                  // Text(
                  //   itemModel.description ?? "",
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: TextStyle(
                  //     fontSize: ScreenAdapter.fontSize(28),
                  //     color: Colors.black,
                  //   ),
                  // ),
                  SizedBox(
                    height: padding_10,
                  ),
                  //4.作者信息
                  Container(
                    padding: EdgeInsets.only(
                        left: padding_15,
                        right: padding_15,
                        bottom: padding_15),
                    child: Row(
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
                                backgroundImage: itemModel.avatar != ""
                                    ? CachedNetworkImageProvider(
                                        itemModel.avatar ?? "")
                                    : AssetImage(
                                        AssetUtils.getAssetImagePNG(
                                            'default_head_img'),
                                      ),
                              ),
                            ),
                            SizedBox(width: padding_10),
                            Container(
                              // color: Colors.orange,
                              child: Text(
                                itemModel.masterNickname ?? "",
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
                                "${itemModel.distance.toString()}km",
                                style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(22),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  //宠主看帮养人 主内容滚动图
  Widget masoryPetLookHelpView() {
    return MasonryGridView.count(
      padding: EdgeInsets.only(
        left: padding_15,
        right: padding_15,
        top: padding_15,
        // top: 0.0,
      ), //取消头部间隙
      crossAxisCount: 2,
      mainAxisSpacing: ScreenAdapter.width(26),
      crossAxisSpacing: ScreenAdapter.width(26),
      itemCount: _helpListModel.length, //元素总个数
      shrinkWrap: true, //收缩,让元素宽度自适应
      physics: const NeverScrollableScrollPhysics(), //禁止滑动 不能少不然无法刷新

      itemBuilder: (context, index) {
        if (_helpListModel.isEmpty) {
          return Container();
        } else {
          var itemModel = _helpListModel[index];
          //狗照片为空
          if (itemModel.photo == "") {
            //没图片显示
            return petNotPicCell(index, itemModel);
          } else {
            //有图片显示
            return petHasPicCell(index, itemModel);
          }
        }
      },
    );
  }

  //宠主 cell 有标题或者有图片 或者两者都有
  Widget petHasPicCell(int index, HelpListItemModel model) {
    return InkWell(
      onTap: () {
        AALog('宠主 cell 有标题或者有图片 或者两者都有');

        NavigationUtil.getInstance().pushPage(
          context,
          RoutersName.homeDetailPage,
          widget: HomeHelpOtherInfoPage(id: model.id!),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: KTColor.white,
          borderRadius: BorderRadius.circular(
            ScreenAdapter.width(18),
          ),
        ),
        child: Stack(
          children: [
            //1.头像信息
            Column(
              children: [
                Row(
                  children: [
                    //头像
                    Container(
                      //设置裁切属性
                      width: ScreenAdapter.width(80),
                      height: ScreenAdapter.width(80),
                      child: CircleAvatar(
                        radius: ScreenAdapter.width(23),
                        backgroundImage: model.avatar != ""
                            ? CachedNetworkImageProvider(model.avatar ?? "")
                            : AssetImage(
                                AssetUtils.getAssetImagePNG('default_head_img'),
                              ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //名字
                            Container(
                              // color: Colors.orange,
                              child: Text(
                                model.nickname ?? '纸飞机',
                                style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(28),
                                  fontWeight: FontWeight.w300,
                                  color: KTColor.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: padding_30,
                            ),
                            //标签
                            if (model.mode != "")
                              Container(
                                padding: EdgeInsets.only(
                                  left: padding_5,
                                  right: padding_5,
                                ),
                                // color: Colors.orange,
                                decoration: BoxDecoration(
                                  color: KTColor.color_255_220_200,
                                  borderRadius:
                                      BorderRadius.circular(padding_25),
                                ),
                                child: Text(
                                  model.mode ?? "",
                                  style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(24),
                                    fontWeight: FontWeight.w300,
                                    color: KTColor.color_60,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        //时间
                        Container(
                          // color: Colors.orange,
                          child: Text(
                            model.lastTime ?? "",
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(24),
                              color: KTColor.color_76_76_76,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: padding_10,
                ),
                //标题 根据数据判断
                Container(
                  child: Text(
                    model.description ?? "",
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenAdapter.fontSize(28),
                      color: KTColor.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: padding_10,
                ),
                //图片
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      ScreenAdapter.width(18),
                    ),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: model.photo ?? "",
                    placeholder: (context, url) => defaultBannerImage(),
                    errorWidget: (context, url, error) => defaultBannerImage(),
                  ),
                ),
              ],
            ),
            //距离
            Positioned(
              left: padding_20,
              bottom: ScreenAdapter.width(16),
              child: Container(
                decoration: BoxDecoration(
                  color: KTColor.color_0,
                  borderRadius: BorderRadius.circular(
                    ScreenAdapter.width(17),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: padding_10,
                    ),
                    Container(
                      width: ScreenAdapter.width(17),
                      height: ScreenAdapter.width(21),
                      // color: Colors.transparent,
                      child: Image.asset(
                        AssetUtils.getAssetImagePNG('home_cell_white_fill'),
                      ),
                    ),
                    SizedBox(
                      width: padding_5,
                    ),
                    Text(
                      "${(model.distance).toString()}km",
                      style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(24),
                        color: KTColor.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 宠主 cell  没有图片
  Widget petNotPicCell(int index, HelpListItemModel model) {
    return InkWell(
      onTap: () {
        AALog('宠主-cell-没有图片');
        NavigationUtil.getInstance().pushPage(
          context,
          RoutersName.homeDetailPage,
          widget: HomeHelpOtherInfoPage(id: model.id!),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: KTColor.white,
          borderRadius: BorderRadius.circular(
            ScreenAdapter.width(18),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: padding_15,
                ),
                //头像
                Container(
                  //设置裁切属性
                  width: ScreenAdapter.width(80),
                  height: ScreenAdapter.width(80),
                  child: CircleAvatar(
                    radius: ScreenAdapter.width(23),
                    backgroundImage: model.avatar != ""
                        ? CachedNetworkImageProvider(model.avatar ?? "")
                        : AssetImage(
                            AssetUtils.getAssetImagePNG('default_head_img'),
                          ),
                  ),
                ),
                SizedBox(
                  width: padding_10,
                ),
                //名字
                Container(
                  child: Text(
                    model.nickname ?? "",
                    style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(28),
                      fontWeight: FontWeight.w300,
                      color: KTColor.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: padding_10,
                ),
                //时间
                Container(
                  // color: Colors.orange,
                  child: Text(
                    model.lastTime ?? "",
                    style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(24),
                      color: KTColor.color_76_76_76,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),

                //标题 根据数据 判断是否显示
                if (model.description != "")
                  Container(
                    padding:
                        EdgeInsets.only(left: padding_10, right: padding_10),
                    child: Text(
                      model.description ?? "", //'国庆节放假，不准备出远门，想找一只狗狗来照顾啊啊啊',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(28),
                        color: KTColor.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                SizedBox(
                  height: padding_10,
                ),
                //地址  距离
                Container(
                  margin: EdgeInsets.only(
                      left: padding_10,
                      top: padding_10,
                      right: padding_10,
                      bottom: padding_20),
                  // padding: EdgeInsets.only(
                  //   left: padding_10,
                  //   right: padding_10,
                  //   bottom: padding_10,
                  // ),
                  decoration: BoxDecoration(
                    color: KTColor.white,
                    borderRadius: BorderRadius.circular(
                      ScreenAdapter.width(14),
                    ),
                  ),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: ScreenAdapter.width(17),
                          height: ScreenAdapter.width(21),
                          // color: Colors.transparent,
                          child: Image.asset(
                            AssetUtils.getAssetImagePNG(
                                'home_detail_location_grey'),
                          ),
                        ),
                      ),
                      if ((model.address?.description ?? "") != "")
                        Expanded(
                          flex: 4,
                          child: Container(
                            // width: ScreenAdapter.width(17),
                            // height: ScreenAdapter.width(40),
                            child: Text(
                              (model.address?.description ?? ""),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(24),
                                color: KTColor.color_76_76_76,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text(
                            "${(model.distance ?? "")}km",
                            maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(24),
                              color: KTColor.color_76_76_76,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*
                   Row(
                    children: [
                      SizedBox(
                        width: padding_10,
                      ),
                      Container(
                        width: ScreenAdapter.width(17),
                        height: ScreenAdapter.width(21),
                        // color: Colors.transparent,
                        child: Image.asset(
                          AssetUtils.getAssetImagePNG(
                              'home_detail_location_grey'),
                        ),
                      ),
                      SizedBox(
                        width: padding_5,
                      ),
                      Text(
                        "${(model.address?.description ?? "")}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(24),
                          color: KTColor.color_76_76_76,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "${(model.distance ?? "")}km",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(24),
                          color: KTColor.color_76_76_76,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  */
                ),
              ],
            ),
            Positioned(
              top: ScreenAdapter.width(16),
              right: ScreenAdapter.width(12),
              child: Container(
                padding: EdgeInsets.only(left: padding_5, right: padding_5),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: KTColor.color_255_220_200,
                  borderRadius: BorderRadius.circular(padding_25),
                ),
                child: model.mode != ""
                    ? Text(model.mode ?? "")
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
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
