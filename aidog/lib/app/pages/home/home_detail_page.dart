import 'package:aidog/app/apis/home_api.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/home/home_pet_owner_info_page.dart';
import 'package:aidog/app/pages/home/model/home_detail_model.dart';
import 'package:aidog/app/pages/home/widget/swiper_widget.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:aidog/app/widget/outline_button.dart';
import 'package:aidog/app/widget/pass_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// 首页 狗狗详情
class HomeDetailPage extends StatefulWidget {
  final int id;
  const HomeDetailPage({super.key, required this.id});

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  List<String> imagArr = [
    imageUrl1,
    imageUrl2,
    imageUrl3,
    imageUrl4,
  ];

  ///详情模型
  HomeDetailModel _homeDetailModel = HomeDetailModel();

  @override
  void initState() {
    super.initState();
    getDogDetailData();
  }

  void getDogDetailData() {
    EasyLoading.show(status: 'loading...');

    HomeApi().getDogDetail(
      id: widget.id,
      onSuccess: (data) {
        setState(() {
          _homeDetailModel = HomeDetailModel.fromJson(data);
          AALog("图片数组 ${_homeDetailModel.data?.photosArr}");
        });

        EasyLoading.dismiss();
      },
      onFailure: (error) {
        EasyLoading.dismiss();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _homePage(),
          _appaBar(),
          _floatButton(),
        ],
      ),
    );
  }

  /// 主内容
  Widget _homePage() {
    var model = _homeDetailModel.data;
    return Positioned(
      top: ScreenAdapter.height(88),
      right: 0,
      bottom: 0,
      left: 0,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            color: KTColor.white,
            width: ScreenAdapter.getScreenWidth(),
            height: ScreenAdapter.height(782),
            child: SwiperWidget(
              imagStrList: model?.photosArr ?? [],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenAdapter.width(padding_30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(model.nickname ?? ""),
                    // if ((model.modeTostring ?? "") != "")
                    //   Text(" | ${model.modeTostring ?? " "}"),
                    Text(
                      model?.nickname != ""
                          ? "${(model?.nickname ?? "")} | ${model?.mode ?? " "}"
                          : (model?.nickname ?? ""),
                      style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(48),
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    // if ((model?.modeTostring ?? "") != "")
                    //   Text(
                    //     " | ${model?.modeTostring ?? " "}",
                    //     style: TextStyle(
                    //       fontSize: ScreenAdapter.fontSize(48),
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.black,
                    //     ),
                    //   ),

                    //收藏目前不做
                    /*
                    IconButton(
                      onPressed: () {
                        AALog("点击了心");
                      },
                      icon: Image(
                        image: AssetImage(
                          AssetUtils.getAssetImagePNG('home_detail_heart'),
                        ),
                        width: ScreenAdapter.width(52),
                        height: ScreenAdapter.width(52),
                      ),
                    ),*/
                  ],
                ),
                SizedBox(
                  height: padding_5,
                ),
                Text(
                  '${model?.age ?? ""} |${model?.gender ?? ""}| ${model?.vaccine}',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(28),
                    color: KTColor.color_76_76_76,
                  ),
                ),
                SizedBox(
                  height: padding_10,
                ),
                Text(
                  model?.description ??
                      "", //'国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假， hahahahhahahahah',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(36),
                    color: KTColor.black,
                  ),
                ),
                SizedBox(
                  height: ScreenAdapter.height(37),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(
                            image: AssetImage(
                              AssetUtils.getAssetImagePNG(
                                  'home_detail_location_grey'),
                            ),
                            width: ScreenAdapter.width(17),
                            height: ScreenAdapter.height(21),
                          ),
                          SizedBox(
                            width: padding_10,
                          ),
                          Text(
                            '${model?.address?.city ?? ""}${model?.address?.district ?? ""}',
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(26),
                              fontWeight: FontWeight.w300,
                              color: KTColor.color_76_76_76,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '1.8Km',
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(26),
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_76_76_76,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenAdapter.bottomTabbarHeight() +
                      ScreenAdapter.bottomBarHeight(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 悬浮按钮
  Widget _floatButton() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.width(60) + ScreenAdapter.bottomBarHeight(),
        color: KTColor.color_252,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: padding_30),
              width: ScreenAdapter.width(200),
              child: PassButton(
                text: '私信',
                bgColor: KTColor.color_251_98_64,
                height: ScreenAdapter.width(60),
                onPressed: () {
                  AALog('私信');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 自定义导航
  Widget _appaBar() {
    var model = _homeDetailModel.data;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(
        leading: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.only(left: padding_30, right: padding_15),
                alignment: Alignment.center,
                // color: KTColor.red,
                child: Image.asset(
                  width: padding_45,
                  height: padding_45,
                  'assets/left_back.png',
                ),
                // const Icon(
                //   Icons.arrow_back_ios,
                // ),
              ),
            ),
            Container(
              // color: KTColor.red,
              // width: double.infinity,
              // height: padding_50,

              child: InkWell(
                onTap: () {
                  AALog('点击头像');
                  NavigationUtil.getInstance().pushPage(
                    context,
                    RoutersName.homeDetailPage,
                    widget: HomePetOwnerInfoPage(
                      masterUserId: model!.masterUserId!,
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //头像
                    Container(
                      //设置裁切属性
                      width: ScreenAdapter.width(80),
                      height: ScreenAdapter.width(80),
                      child: CircleAvatar(
                        radius: ScreenAdapter.width(40),
                        backgroundImage: //NetworkImage(model?.avatar ?? ""),

                            (model?.avatar ?? "") != ""
                                ? CachedNetworkImageProvider(
                                    model?.avatar ?? "")
                                : AssetImage(
                                    AssetUtils.getAssetImagePNG(
                                        'default_head_img'),
                                  ),
                      ),
                    ),
                    SizedBox(width: padding_20),
                    //名字
                    Container(
                      // color: Colors.orange,
                      child: Text(
                        model?.nickname ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenAdapter.fontSize(32),
                          color: KTColor.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        leadingWidth: ScreenAdapter.width(350),
        /*
        title: Container(
          color: KTColor.red,
          // width: double.infinity,
          // height: padding_50,

          child: InkWell(
            onTap: () {
              AALog('点击头像');
              NavigationUtil.getInstance().pushPage(
                context,
                RoutersName.homeDetailPage,
                widget: HomePetOwnerInfoPage(
                  masterUserId: model!.masterUserId!,
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //头像
                Container(
                  //设置裁切属性
                  width: ScreenAdapter.width(80),
                  height: ScreenAdapter.width(80),
                  child: CircleAvatar(
                    radius: ScreenAdapter.width(40),
                    backgroundImage: //NetworkImage(model?.avatar ?? ""),

                        (model?.avatar ?? "") != ""
                            ? CachedNetworkImageProvider(model?.avatar ?? "")
                            : AssetImage(
                                AssetUtils.getAssetImagePNG(
                                    'default_head_img'),
                              ),
                  ),
                ),
                SizedBox(width: padding_20),
                //名字
                Container(
                  // color: Colors.orange,
                  child: Text(
                    model?.nickname ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenAdapter.fontSize(32),
                      color: KTColor.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
*/
        centerTitle: true,
        backgroundColor: Colors.amber, //实现背景透明
        elevation: 0, //去掉阴影
        actions: [
          CusOutlineButton(
            title: '了解主人',
            onTap: () {
              AALog("了解主人");

              // NavigationUtil.getInstance()
              //     .pushNamed(RoutersName.homePetOwnerInfoPage);
              NavigationUtil.getInstance().pushPage(
                context,
                RoutersName.homeDetailPage,
                widget: HomePetOwnerInfoPage(
                  masterUserId: model!.masterUserId!,
                ),
              );

              // NavigationUtil.getInstance().pushPage(
              //   context,
              //   RoutersName.homeDetailPage,
              //   widget: HomeDetailPage(id: itemModel.id!),
              // );
            },
            width: ScreenAdapter.width(170),
            height: ScreenAdapter.width(60),
          ),
        ],
      ),
    );
  }
}
