import 'package:aidog/app/apis/home_api.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/home/model/home_pet_owner_info_model.dart';
import 'package:aidog/app/pages/my/widget/base_app_bar.dart';
import 'package:aidog/app/widget/dialog/hoo_dialog.dart';
import 'package:aidog/app/widget/outline_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

///宠主看 帮养人详情 信息
class HomeHelpOtherInfoPage extends StatefulWidget {
  final int id;

  const HomeHelpOtherInfoPage({super.key, required this.id});

  @override
  State<HomeHelpOtherInfoPage> createState() => _HomeHelpOtherInfoPageState();
}

class _HomeHelpOtherInfoPageState extends State<HomeHelpOtherInfoPage> {
  HomePetOwnerInfoModel _homePetOwnerInfoModel = HomePetOwnerInfoModel();
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    GlobalLocationTool().destroyLocation();
    super.dispose();
  }

  void getData() {
    EasyLoading.show(status: 'loading...');

    HomeApi().getUserDetail(
      id: widget.id,
      onSuccess: (data) {
        setState(() {
          _homePetOwnerInfoModel = HomePetOwnerInfoModel.fromJson(data);
          AALog(_homePetOwnerInfoModel.data?.age ?? "");
          AALog(_homePetOwnerInfoModel.data?.identity ?? "");
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
          const BaseAppBar(title: "帮养人信息"),
        ],
      ),
    );
  }

  Widget _homePage() {
    return Positioned(
      top: ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(88),
      right: 0,
      bottom: 0,
      left: 0,
      child: Container(
        color: KTColor.color_247,
        // color: KTColor.amber,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: KTColor.color_247,
                  child: _infoView(),
                ),

                // _listWidget(10),
                _historyEvaluateView(),
                // _footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //详细信息
  Widget _infoView() {
    var model = _homePetOwnerInfoModel.data;

    return Container(
      // height: ScreenAdapter.height(1000), //
      color: KTColor.white,
      child: Column(
        children: [
          SizedBox(
            height: padding_30,
          ),
          //头像 名字
          Row(
            mainAxisAlignment: MainAxisAlignment.start, //左右
            crossAxisAlignment: CrossAxisAlignment.center, //上下
            children: [
              SizedBox(
                width: padding_30,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                width: ScreenAdapter.width(140),
                height: ScreenAdapter.width(140),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    ScreenAdapter.width(70),
                  ),
                ),
                child: (model?.avatar ?? "") != ""
                    ? Image.network(
                        model?.avatar ?? "",
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/default_head_img.png',
                        fit: BoxFit.cover,
                      ),
              ),
              /*
              Container(
                child: Container(
                  //设置裁切属性
                  width: ScreenAdapter.width(140),
                  height: ScreenAdapter.width(140),
                  child: CircleAvatar(
                    radius: ScreenAdapter.width(70),
                    backgroundImage: (model?.avatar ?? "") != ""
                        ? CachedNetworkImageProvider(model?.avatar ?? "")
                        : AssetImage(
                            AssetUtils.getAssetImagePNG('default_head_img'),
                          ),
                  ),
                ),
              ),
              */
              SizedBox(
                width: padding_25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start, //上下
                crossAxisAlignment: CrossAxisAlignment.start, //左右
                children: [
                  Row(
                    children: [
                      Text(
                        model?.nickname ?? "",
                        style: TextStyle(
                          color: KTColor.black,
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenAdapter.fontSize(32),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: padding_20,
                  ),
                  Row(
                    children: [
                      Text(
                        '用户ID：67875456765',
                        style: TextStyle(
                          color: KTColor.color_76_76_76,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenAdapter.fontSize(26),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              CusOutlineButton(
                title: "私信",
                onTap: () {
                  AALog("私信");
                  HooDialog.showCustomDialog(
                    context,
                    clickBgHidden: true,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          width: ScreenAdapter.getScreenWidth() -
                              ScreenAdapter.width(130) * 2,
                          height: ScreenAdapter.height(342),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: padding_20,
                              ),
                              Text(
                                '实名认证提示',
                                style: TextStyle(
                                  color: KTColor.color_76_76_76,
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenAdapter.fontSize(28),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  ScreenAdapter.width(35),
                                ),
                                child: Text(
                                  '为了您的安全，每一位和您聊天的用户都需要实名认证，请您同样进行实名认证。实名认证信息绝对保密与安全，不会用作平台以外用途。',
                                  style: TextStyle(
                                    color: KTColor.color_76_76_76,
                                    fontWeight: FontWeight.w300,
                                    fontSize: ScreenAdapter.fontSize(26),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      AALog('暂不');
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      '暂不',
                                      style: TextStyle(
                                        color: KTColor.color_164,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenAdapter.fontSize(28),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1, // 竖线的宽度
                                    height: ScreenAdapter.height(36), // 竖线的高度
                                    color: KTColor.color_151, // 竖线的颜色
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      AALog('认证');
                                    },
                                    child: Text(
                                      '认证',
                                      style: TextStyle(
                                        color: KTColor.color_251_98_64,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenAdapter.fontSize(28),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                width: ScreenAdapter.width(120),
                height: ScreenAdapter.width(60),
              ),
            ],
          ),
          SizedBox(
            height: ScreenAdapter.height(10),
          ),
          Divider(
            height: 1.0,
            indent: padding_40,
            color: KTColor.color_243,
          ),
          SizedBox(
            height: ScreenAdapter.height(10),
          ),

          //实名认证
          Padding(
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '实名认证',
                  style: TextStyle(
                    color: KTColor.black,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(32),
                  ),
                ),
                Image.asset(
                  width: ScreenAdapter.width(103),
                  height: ScreenAdapter.width(32),
                  model?.isAuthenticated == true
                      ? AssetUtils.getAssetImagePNG('my_already_name')
                      : AssetUtils.getAssetImagePNG('my_not_name'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenAdapter.width(8),
          ),
          Divider(
            height: 1.0,
            indent: padding_40,
            color: KTColor.color_243,
          ),
          SizedBox(
            height: ScreenAdapter.width(8),
          ),

          //年龄
          Padding(
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '年龄',
                  style: TextStyle(
                    color: KTColor.black,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(32),
                  ),
                ),
                Text(
                  (model?.age != "") ? (model?.age ?? "") : '未知',
                  style: TextStyle(
                    color: KTColor.color_76_76_76,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(32),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenAdapter.width(8),
          ),
          Divider(
            height: 1.0,
            indent: padding_40,
            color: KTColor.color_243,
          ),
          SizedBox(
            height: ScreenAdapter.width(8),
          ),

          //身份
          Padding(
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '身份',
                  style: TextStyle(
                    color: KTColor.black,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(32),
                  ),
                ),
                Text(
                  (model?.identity != "") ? (model?.identity ?? "") : '未知',
                  style: TextStyle(
                    color: KTColor.color_76_76_76,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(32),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenAdapter.width(8),
          ),
          Divider(
            height: 1.0,
            indent: padding_40,
            color: KTColor.color_243,
          ),
          SizedBox(
            height: ScreenAdapter.width(8),
          ),

          //常住位置
          Padding(
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '常住位置',
                  style: TextStyle(
                    color: KTColor.black,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(32),
                  ),
                ),
                Text(
                  " ${model?.address?.city}  ${model?.address?.district}", //'河南省 郑州市 中心花园小区',
                  style: TextStyle(
                    color: KTColor.color_76_76_76,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenAdapter.fontSize(32),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: ScreenAdapter.getScreenWidth(),
            height: padding_20,
            color: KTColor.color_247,
          ),
          //相关介绍
          Container(
            // height: ScreenAdapter.height(300),
            color: KTColor.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(30),
                ScreenAdapter.height(12),
                ScreenAdapter.width(30),
                ScreenAdapter.width(30),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右分开布局
                    crossAxisAlignment: CrossAxisAlignment.center, //行内元素上下居中
                    children: [
                      Text(
                        '相关介绍',
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(32),
                          fontWeight: FontWeight.w300,
                          color: KTColor.black,
                        ),
                      ),
                      Text(
                        (model?.description == "")
                            ? ''
                            : (model?.description ?? ""),
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(24),
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_164,
                        ),
                      ),
                    ],
                  ),
                  //相关介绍
                  Padding(
                    padding: EdgeInsets.only(top: padding_10),
                    child: Text(
                      //  (model?.identity != "") ? (model?.identity ?? "") : '未知',

                      (model?.description != "")
                          ? (model?.description ?? "")
                          : '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(32),
                        fontWeight: FontWeight.w300,
                        color: KTColor.color_76_76_76,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: ScreenAdapter.height(235 - 48),
                    padding: const EdgeInsets.all(5),
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(padding_10),
                          child: Image.network(imageUrl3),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: ScreenAdapter.getScreenWidth(),
            height: padding_20,
            color: KTColor.color_247,
          ),
          //历史评价
          Container(
            height: ScreenAdapter.height(80),
            color: KTColor.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(30),
                ScreenAdapter.height(12),
                ScreenAdapter.width(30),
                ScreenAdapter.width(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //左右分开布局
                crossAxisAlignment: CrossAxisAlignment.center, //行内元素上下居中
                children: [
                  Text(
                    '历史评价',
                    style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(32),
                      fontWeight: FontWeight.w300,
                      color: KTColor.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///历史评价
  Widget _historyEvaluateView() {
    return Container(
      color: KTColor.white,
      width: ScreenAdapter.getScreenWidth(),
      child: ListView.separated(
        // 加header要加上这两个属性
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // 加header要加上这两个属性
        // 取消footer和cell之间的空白
        padding: const EdgeInsets.all(0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(left: padding_30, right: padding_30),
            color: KTColor.white,
            width: ScreenAdapter.getScreenWidth(),
            // height: 100,
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Text(
                      '2024-09-28 09:26',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: KTColor.color_164,
                        fontSize: ScreenAdapter.fontSize(24),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: padding_20,
                    bottom: padding_40,
                  ),
                  padding: EdgeInsets.only(
                    left: padding_25,
                    right: padding_25,
                    top: padding_40,
                    bottom: padding_40,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: KTColor.color_243,
                    borderRadius: BorderRadius.circular(
                      ScreenAdapter.width(48),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image(
                                image:
                                    AssetImage('assets/default_head_img.png'),
                                width: padding_45,
                                height: padding_45,
                              ),
                              Text(
                                '西瓜太郎',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: KTColor.black,
                                  fontSize: ScreenAdapter.fontSize(26),
                                ),
                              ),
                            ],
                          ),
                          //数组里添加循环组件 后面想要继续添加控件 需要在前面添加...
                          // 使用for循环添加更多控件
                          Row(
                            children: [
                              for (int i = 0; i <= 5; i++)
                                Icon(
                                  Icons.star,
                                  size: ScreenAdapter.width(28), // 设置图标大小
                                  color: Colors.yellow[700], // 设置图标颜色
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: padding_10,
                      ),
                      Text(
                        '一次非常愉快的体验，总算是安心出差了一次。',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_76_76_76,
                          fontSize: ScreenAdapter.fontSize(32),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        //添加底部横线可以控制长短
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: .5,
            indent: 15,
            endIndent: 15,
            // color: Color(0xFFDDDDDD),
            color: Colors.transparent,
          );
        },
      ),
    );
  }
}
