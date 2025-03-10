import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// 我的喜欢
class MyLikePage extends StatefulWidget {
  const MyLikePage({super.key});

  @override
  State<MyLikePage> createState() => _MyLikePageState();
}

class _MyLikePageState extends State<MyLikePage> {
  final EasyRefreshController _controller = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('我的喜欢'),
      //   // backgroundColor: LinearGradient(colors: [KTColor.amber, KTColor.back2]),
      // ),

      body: Stack(
        children: [
          _homePage(),
          _appBar(),
        ],
      ),
    );
  }

  ///主内容
  Widget _homePage() {
    return Positioned(
      top: ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(88),
      right: 0,
      bottom: 0,
      left: 0,
      child: EasyRefresh(
        controller: _controller,
        header: const ClassicHeader(
          dragText: '下拉刷新...',
          armedText: '释放立即刷新',
          readyText: '正在刷新...',
          // showMessage: false,
          processedText: '刷新完成',
          processingText: '正在刷新...',
          textStyle: TextStyle(
            color: KTColor.color9E9E9E,
          ),
        ),
        footer: const ClassicFooter(
          //这个属性意思是如果上拉加载完数据,就不显示加载控件
          // position: IndicatorPosition.locator,
          dragText: '正在刷新...',
          armedText: '释放立即刷新',
          readyText: '正在刷新...',
          // showMessage: false,
          processedText: '刷新完成',
          processingText: '正在刷新...',
          noMoreText: '没有更多内容',
          textStyle: TextStyle(
            color: KTColor.color9E9E9E,
          ),
        ),
        onRefresh: () async {
          AALog('下拉刷新');
          //下拉刷新
          await Future.delayed(
            const Duration(seconds: 1),
            () {
              if (mounted) {
                setState(() {});
              }
            },
          );
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              // color: KTColor.amber,
              child: masoryView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget masoryView() {
    return MasonryGridView.count(
      padding: EdgeInsets.only(
        left: padding_15,
        right: padding_15,
        top: padding_15,
      ), //取消头部间隙
      // padding: EdgeInsets.zero,
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
            NavigationUtil.getInstance().pushNamed(RoutersName.homeDetailPage);
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
              ],
            ),
          ),
        );
      },
    );
  }

  /// 自定义导航栏
  Widget _appBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            //渐变位置
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              KTColor.color_255_179_93,
              KTColor.color_255_154_92,
            ],
          ),
        ),
        child: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.only(left: padding_30),
              child: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
          leadingWidth: padding_50,
          title: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '我的喜欢',
                  style: TextStyle(
                    color: KTColor.color_60,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenAdapter.fontSize(36),
                  ),
                ),
                SizedBox(
                  width: padding_50,
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent, //实现背景透明
        ),
      ),
    );
  }
}
