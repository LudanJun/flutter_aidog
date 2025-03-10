import 'dart:convert';
import 'dart:io';

import 'package:aidog/app/apis/login_api.dart';
import 'package:aidog/app/apis/my_api.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/global_style.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/show_toast_utils.dart';
import 'package:aidog/app/common/string_extension.dart';
import 'package:aidog/app/global_provider/global_provider.dart';
import 'package:aidog/app/http_tools/hoo_http.dart';
import 'package:aidog/app/pages/login/widget/picker.dart';
import 'package:aidog/app/pages/my/models/my_user_info_model.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/my/widget/base_app_bar.dart';
import 'package:aidog/app/pages/my/widget/tip_widget.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:aidog/app/widget/elevated_button.dart';
import 'package:aidog/app/widget/outline_button.dart';
import 'package:aidog/app/widget/showBottomSheet/show_Bottom_sheet_tool.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 我的-帮养人-帮养信息
class MyHelpOtherProfilePage extends StatefulWidget {
  const MyHelpOtherProfilePage({super.key});

  @override
  State<MyHelpOtherProfilePage> createState() => _MyHelpOtherProfilePageState();
}

class _MyHelpOtherProfilePageState extends State<MyHelpOtherProfilePage> {
  MyUserInfoModel _myUserInfoModel = MyUserInfoModel();
  //更多描述
  TextEditingController desTextEditingController = TextEditingController();

  /// 是否公开
  bool? _isSwitch;
  //已选中图片列表
  List<AssetEntity> _selectPhotoAssets = [];
  List<AssetEntity> _selectVideoAssets = [];

  // 身份选择  下个页面返回带来的数据
  String _getSelectIdentity = '';
  // 养狗经验  下个页面返回带来的数据
  String _getSelectDogExp = '';
  // 照顾方式  下个页面返回带来的数据
  String _getSelectZhaogufangshi = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MyApi().userInfo(
      onSuccess: (data) {
        // AALog("data $data");
        if (data['code'] == "200") {
          setState(() {
            _myUserInfoModel = MyUserInfoModel.fromJson(data);
            desTextEditingController.text =
                _myUserInfoModel.data?.description ?? "";

            Provider.of<MyProvider>(context, listen: false)
                .selectIdentityValue = _myUserInfoModel.data?.identity ?? "";

            Provider.of<MyProvider>(context, listen: false).selectDogExpValue =
                _myUserInfoModel.data?.experience ?? "";

            Provider.of<MyProvider>(context, listen: false)
                .selectZhaogufangshiValue = _myUserInfoModel.data?.mode ?? "";

            AALog("模型address:${_myUserInfoModel.data?.phone}");
          });
        }
      },
      onFailure: (error) {
        AALog("error $error");
      },
    );
  }

  @override
  void dispose() {
    GlobalLocationTool().destroyLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _homePage(),
          const BaseAppBar(title: "帮养人帮养信息"),
        ],
      ),
    );
  }

  ///主内容
  Widget _homePage() {
    return Positioned(
      top: ScreenAdapter.height(88),
      right: 0,
      bottom: 0,
      left: 0,
      child: Container(
        color: KTColor.color_247,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            ///提示语
            const TipWidget(),

            /// 个人信息
            infoView(),

            SizedBox(
              height: padding_20,
            ),

            ///更多描述
            moreWidget(),

            ///是否公开
            SizedBox(
              height: padding_20,
            ),
            switchWidget(),

            /// 保存并更新
            SizedBox(
              height: padding_60 * 2,
            ),

            Padding(
              padding: EdgeInsets.only(left: padding_40, right: padding_40),
              child: CusElevatedButton(
                title: '保存并更新',
                width: ScreenAdapter.getScreenWidth(),
                height: padding_90 * 2,
                onPressed: () {
                  AALog("保存");
                  saveAndUpdate();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 个人信息
  Widget infoView() {
    var tempModel = _myUserInfoModel.data;
    var addressModel = tempModel?.address;
    return Container(
      height: ScreenAdapter.width(666),
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
                child: Container(
                  //设置裁切属性
                  width: ScreenAdapter.width(140),
                  height: ScreenAdapter.width(140),
                  child: CircleAvatar(
                      radius: ScreenAdapter.width(70),
                      backgroundImage:
                          CachedNetworkImageProvider(tempModel?.avatar ?? "")
                      //  AssetImage(
                      //   AssetUtils.getAssetImagePNG('default_head_img'),
                      // ),
                      ),
                ),
              ),
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
                        tempModel?.nickname ?? "",
                        style: TextStyle(
                          color: KTColor.black,
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenAdapter.fontSize(32),
                        ),
                      ),
                      SizedBox(
                        width: padding_10,
                      ),
                      Image(
                        width: ScreenAdapter.width(104),
                        height: ScreenAdapter.width(32),
                        image: AssetImage(
                          AssetUtils.getAssetImagePNG('my_already_name'),
                        ),
                      ),
                      SizedBox(
                        width: padding_10,
                      ),
                      Image(
                        width: ScreenAdapter.width(67),
                        height: ScreenAdapter.width(32),
                        image: AssetImage(
                          AssetUtils.getAssetImagePNG('my_90_year'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: padding_20,
                  ),
                  Row(
                    children: [
                      Text('用户ID：67875456765'),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: padding_60,
              ),
              CusOutlineButton(
                title: "去认证",
                onTap: () {
                  AALog("去认证");
                },
                width: ScreenAdapter.width(120),
                height: ScreenAdapter.width(60),
              ),
            ],
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
                  style: HooTextStyle.titleS32W6CBlackStyle,
                ),
                InkWell(
                  onTap: () {
                    AALog('身份选择');

                    NavigationUtil.getInstance()
                        .pushNamed(RoutersName.myChooseIdentityPage)
                        ?.then((value) {
                      setState(() {
                        AALog("返回来的值:$value");
                        if (value != null) {
                          _getSelectIdentity = value;
                        }
                      });
                    });

                    // List<String> arr = [
                    //   '在校学生',
                    //   '社会人',
                    //   '社会人',
                    //   '社会人',
                    //   '社会人',
                    //   '在校学生',
                    //   '在校学生',
                    // ];
                    // ShowBottomSheetTool.bottomSheet(context, arr, (value) {
                    //   AALog("选择的值:$value");
                    // });
                  },
                  child: Row(
                    children: [
                      Text(
                        _getSelectIdentity == ""
                            ? tempModel?.identity ?? "请选择身份"
                            : _getSelectIdentity,
                        style: HooTextStyle.titleS32W6CBlackStyle,
                      ),
                      SizedBox(
                        width: ScreenAdapter.width(14),
                      ),
                      Image.asset(
                        width: ScreenAdapter.width(14),
                        height: ScreenAdapter.width(24),
                        AssetUtils.getAssetImagePNG('right_jiantou'),
                      ),
                    ],
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
          //养狗经验
          Padding(
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '养狗经验',
                  style: HooTextStyle.titleS32W6CBlackStyle,
                ),
                InkWell(
                  onTap: () {
                    AALog('新手');
                    NavigationUtil.getInstance()
                        .pushNamed(RoutersName.myChooseDogExpPage)
                        ?.then((value) {
                      setState(() {
                        AALog("返回来的值:$value");
                        if (value != null) {
                          _getSelectDogExp = value;
                        }
                      });
                    });
                    // List<String> arr = [
                    //   '新手',
                    //   '老手',
                    //   '中级',
                    //   '高级',
                    // ];
                    // ShowBottomSheetTool.bottomSheet(context, arr, (value) {
                    //   AALog("选择的值:$value");
                    // });
                  },
                  child: Row(
                    children: [
                      Text(
                        _getSelectDogExp == ""
                            ? tempModel?.experience ?? "请选择养狗经验"
                            : _getSelectDogExp,
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(32),
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_76_76_76,
                        ),
                      ),
                      SizedBox(
                        width: ScreenAdapter.width(14),
                      ),
                      Image.asset(
                        width: ScreenAdapter.width(14),
                        height: ScreenAdapter.width(24),
                        AssetUtils.getAssetImagePNG('right_jiantou'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //您能提供的照顾方式
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
          Padding(
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '您能提供的照顾方式',
                  style: HooTextStyle.titleS32W6CBlackStyle,
                ),
                InkWell(
                  onTap: () {
                    AALog('去选择');
                    NavigationUtil.getInstance()
                        .pushNamed(RoutersName.myChooseZhaogustylePage)
                        ?.then(
                      (value) {
                        setState(
                          () {
                            AALog("返回来的值:$value");
                            if (value != null) {
                              _getSelectZhaogufangshi = value;
                            }
                          },
                        );
                      },
                    );
                    // List<String> arr = [
                    //   '早上遛',
                    //   '全天候',
                    //   '偶尔',
                    //   '频繁',
                    // ];
                    // ShowBottomSheetTool.bottomSheet(context, arr, (value) {
                    //   AALog("选择的值:$value");
                    // });
                  },
                  child: Row(
                    children: [
                      Text(
                        _getSelectZhaogufangshi == ''
                            ? tempModel?.mode ?? "去选择"
                            : _getSelectZhaogufangshi,
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(32),
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_251_98_64,
                        ),
                      ),
                      SizedBox(
                        width: ScreenAdapter.width(14),
                      ),
                      Image.asset(
                        width: ScreenAdapter.width(14),
                        height: ScreenAdapter.width(24),
                        AssetUtils.getAssetImagePNG('right_jiantou'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //位置
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
          Padding(
            padding: EdgeInsets.all(ScreenAdapter.width(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '位置',
                  style: HooTextStyle.titleS32W6CBlackStyle,
                ),
                InkWell(
                  onTap: () {
                    AALog('点击获取位置提供精准服务');
                    GlobalLocationTool().startLocationInfo();
                  },
                  child: Row(
                    children: [
                      Text(
                        addressModel?.description ?? "点击获取位置提供精准服务",
                        // (tempModel!.address!.description!),
                        // (tempModel?.address?.description != null)
                        //     ? _myUserInfoModel.data!.address!
                        //     : '点击获取位置提供精准服务',
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(24),
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_164,
                        ),
                      ),
                      SizedBox(
                        width: ScreenAdapter.width(14),
                      ),
                      Image.asset(
                        width: ScreenAdapter.width(14),
                        height: ScreenAdapter.width(24),
                        AssetUtils.getAssetImagePNG('right_jiantou'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///更多描述
  Widget moreWidget() {
    return Container(
      width: ScreenAdapter.getScreenWidth(),
      color: KTColor.white,
      child: Padding(
        padding: EdgeInsets.only(left: padding_30, right: padding_30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: padding_20,
            ),
            Text(
              '更多描述',
              style: HooTextStyle.titleS32W6CBlackStyle,
            ),
            SizedBox(
              height: padding_20,
            ),
            Container(
              height: ScreenAdapter.height(400),
              //设置裁切属性
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: KTColor.color_243,
                borderRadius: BorderRadius.circular(ScreenAdapter.width(48)),
              ),
              child: TextField(
                style: TextStyle(color: KTColor.black), //文字颜色
                controller: desTextEditingController,
                // minLines: 3,
                maxLines: 10,
                cursorColor: Colors.red,
                cursorRadius: Radius.circular(5),
                cursorWidth: 0,
                showCursor: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "清晰的描述有利于宠主更快捷地了解您，比如您可以描述历史帮养的情况等",
                  border: InputBorder.none,
                  // fillColor: KTColor.color_243, // 设置输入框背景色为灰色
                  // filled: true,
                ),
                onChanged: (value) {
                  AALog('输入的内容');
                },
              ),
            ),
            SizedBox(
              height: padding_20,
            ),
            Padding(
              padding: EdgeInsets.all(spacing),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double space = ScreenAdapter.width(3);
                  double imagePadd = ScreenAdapter.width(2);
                  AALog("constraints.maxWidth${constraints.maxWidth}");
                  //设置每行4个
                  final double width = (constraints.maxWidth * 2 -
                          space * 2 -
                          imagePadd * 2 * 4 -
                          padding_75) /
                      4;

                  return Wrap(
                    spacing: space,
                    runSpacing: space,
                    children: [
                      /// 添加狗狗照片视频按钮
                      InkWell(
                        onTap: () {
                          AALog('添加照片/视频');
                          List<String> arr = [
                            '照片',
                            '视频',
                          ];
                          ShowBottomSheetTool.bottomSheet(context, arr,
                              (value) {
                            AALog("选择的值:$value");
                            if (value == "照片") {
                              openPhoto();
                            } else {
                              openVideo();
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(padding_5),
                          width: ScreenAdapter.width(width),
                          height: ScreenAdapter.width(width),
                          //设置裁切属性
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: KTColor.color_243,
                            //设置完圆角度数后,需要设置裁切属性
                            borderRadius:
                                BorderRadius.circular(ScreenAdapter.width(10)),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: padding_20,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Text(
                                  '可添加居家环境或帮养狗狗照片',
                                  style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(28),
                                    fontWeight: FontWeight.w300,
                                    color: KTColor.color_164,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: ScreenAdapter.width(10),
                                bottom: ScreenAdapter.width(20),
                                child: Image.asset(
                                  width: ScreenAdapter.width(32),
                                  height: ScreenAdapter.width(32),
                                  AssetUtils.getAssetImagePNG(
                                      'my_smail_camera'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      for (final asset in _selectPhotoAssets)
                        _buildPhotoItem(asset, ScreenAdapter.width(width)),
                      for (final asset in _selectVideoAssets)
                        _buildVideoItem(asset, ScreenAdapter.width(width)),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: padding_20,
            ),
          ],
        ),
      ),
    );
  }

  ///是否公开
  Widget switchWidget() {
    return Container(
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(120),
      color: KTColor.white,
      child: Padding(
        padding: EdgeInsets.only(left: padding_30, right: padding_30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '是否公开',
              style: HooTextStyle.titleS32W6CBlackStyle,
            ),
            CupertinoSwitch(
              value: _isSwitch ?? (_myUserInfoModel.data?.isOpen ?? false),
              // onChanged: context
              //     .watch<SettingProvider>()
              //     .onChangeRobotInterrupt,
              onChanged: (value) {
                AALog("开关:$value");
                setState(() {
                  _isSwitch = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  ///完善宠主狗狗信息 完成按钮
  void saveAndUpdate() async {
    EasyLoading.show(status: 'loading...');

    List imagArr = await uploadImages(_selectPhotoAssets);
    AALog("photosphotosimagArr--$imagArr");

    String imagArrJson = jsonEncode(imagArr);
    AALog("imagArrJson--$imagArrJson");

    //更新人物信息
    LoginApi.publickSettingInfo(
      //身份
      identity: _myUserInfoModel.data?.identity,
      //养狗经验
      experience: _myUserInfoModel.data?.experience,

      mode: _myUserInfoModel.data?.mode,
      description: desTextEditingController.text,

      address:
          Provider.of<GlobalProvider>(context, listen: false).globalDesressStr,
      photos: imagArrJson,
      isOpen: _isSwitch ?? _myUserInfoModel.data?.isOpen,

      onSuccess: (data) {
        AALog("onSuccess:$data");
        if (data['code'] == "200") {
          setState(() {
            EasyLoading.dismiss();
            showToastCenter('保存成功');
          });
        }
      },
      onFailure: (error) {
        AALog("onSuccess:$error");
      },
    );
  }

  ///上传多张图片
  Future<List> uploadImages(
    List<AssetEntity> entitys,
  ) async {
    List photos = [];
    List<Future> futures = [];

    // for (AssetEntity entity in entitys) {
    for (int i = 0; i < entitys.length; i++) {
      //originFile:原图巨大
      //file:压缩图
      // String? imagePath = await getImagePath(entity.originFile);
      String? imagePath = await getImagePath(entitys[i].originFile);
      AALog('图片路径是: $imagePath');

      var formData = FormData.fromMap(
        {
          'multipartFile': await MultipartFile.fromFile(imagePath!,
              filename: '${StringExtension.generateImageNameByDate()}.jpg'),
        },
      );
      futures.add(
        HooHttpUtil().post(
          '/common/uploadFile',
          params: formData,
          onSuccess: (data) {
            // onSuccess!(data);
            AALog('上传成功');
            var pictureUrl = data['data']['fileUrl'];
            AALog('上传成功 pictureUrl$pictureUrl');

            Map<String, dynamic> map = {
              "fileUrl": pictureUrl,
              "sortOrder": i + 1,
            };
            AALog('上传成功 map$map');
            // onsuccess!(map);
            photos.add(map); //yo
            // AALog('上传成功 imageIds$photos');
          },
        ),
      );
      // AALog('上传成功 imageIds$photos');
    }
    await Future.wait(futures);
    AALog("photosphotos:$photos");

    return photos;
  }

  // 使用 originFile 方法获取 File 对象，并获取它的路径
  Future<String?> getImagePath(originFile) async {
    File? file = await originFile; // 等待异步操作完成
    if (file != null) {
      return file.path; // 返回文件路径
    } else {
      return null; // 如果 File 对象为 null，则返回 null
    }
  }

  //显示图片item
  Widget _buildPhotoItem(asset, double width) {
    return Container(
      //设置裁切属性
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(imagePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding_10),
      ),
      child: Stack(
        children: [
          //根据获取的用户信息的照片数组情况判断显示
          AssetEntityImage(
            asset,
            width: width,
            height: width,
            fit: BoxFit.cover,
            isOriginal: false, //是否显示原图
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                AALog('删除');
                setState(() {
                  _selectPhotoAssets.removeWhere((item) {
                    return item == asset;
                  });
                });
              },
              child: Image.asset(
                width: ScreenAdapter.width(32),
                height: ScreenAdapter.width(32),
                AssetUtils.getAssetImagePNG('my_close'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //显示视频item
  Widget _buildVideoItem(asset, double width) {
    return Container(
      //设置裁切属性
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(imagePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding_10),
      ),
      child: Stack(
        children: [
          AssetEntityImage(
            asset,
            width: width,
            height: width,
            fit: BoxFit.cover,
            isOriginal: false, //是否显示原图
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                AALog('删除');
              },
              child: Image.asset(
                width: ScreenAdapter.width(32),
                height: ScreenAdapter.width(32),
                AssetUtils.getAssetImagePNG('my_close'),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                AALog('播放');
              },
              child: Image.asset(
                width: ScreenAdapter.width(32),
                height: ScreenAdapter.width(32),
                AssetUtils.getAssetImagePNG('my_play'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //打开图片库
  void openPhoto() async {
    var result = await DuPicker.assets(
      context: context,
      maxAssets: 9,
    );
    if (result == null) {
      return;
    }
    setState(() {
      AALog("选择的图片结果:$result");
      _selectPhotoAssets.addAll(result);
      // AALog(_selectPhotoAssets[0].file);
    });
  }

  //打开视频库
  void openVideo() async {
    var result = await DuPicker.assetsVideo(
      context: context,
      maxAssets: 1,
    );
    if (result == null) {
      return;
    }
    setState(() {
      AALog("选择的视频结果:$result");
      _selectVideoAssets.addAll(result);
      AALog(_selectVideoAssets[0].file);
    });
  }
}
