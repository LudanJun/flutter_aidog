import 'dart:convert';
import 'dart:io';

import 'package:aidog/app/apis/my_api.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/global_style.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/string_extension.dart';
import 'package:aidog/app/http_tools/hoo_http.dart';
import 'package:aidog/app/pages/login/widget/picker.dart';
import 'package:aidog/app/pages/my/models/my_user_info_model.dart';
import 'package:aidog/app/pages/my/provider/my_provider.dart';
import 'package:aidog/app/pages/my/widget/base_app_bar.dart';
import 'package:aidog/app/pages/my/widget/tip_widget.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:aidog/app/widget/elevated_button.dart';
import 'package:aidog/app/widget/normal_text_field.dart';
import 'package:aidog/app/widget/outline_button.dart';
import 'package:aidog/app/widget/showBottomSheet/show_Bottom_sheet_tool.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

/// 我的 - 宠主 - 狗信息(帮养信息)
class MyPetOwnerProfilePage extends StatefulWidget {
  const MyPetOwnerProfilePage({super.key});

  @override
  State<MyPetOwnerProfilePage> createState() => _MyPetOwnerProfilePageState();
}

class _MyPetOwnerProfilePageState extends State<MyPetOwnerProfilePage> {
  MyUserInfoModel _myUserInfoModel = MyUserInfoModel();

  //狗狗名字文本框
  TextEditingController dognameController = TextEditingController();

  //更多描述
  TextEditingController desTextEditingController = TextEditingController();

  //已选中图片列表
  List<AssetEntity> _selectPhotoAssets = [];
  List<AssetEntity> _selectVideoAssets = [];

  // 身份选择  下个页面返回带来的数据
  String _getSelectIdentity = '';

  /// 存放 宠物日期
  String _petDate = '';
  // 存放 爱犬性别 下个页面返回带来的数据
  String _getSelectDogSex = '';
  // 狂犬疫苗 下个页面返回带来的数据
  String _getSelectKuangquanyimiao = '';
  // 照顾方式  下个页面返回带来的数据
  String _getSelectZhaogufangshi = '';

  /// 是否公开
  bool? _isSwitch;

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
            // desTextEditingController.text =
            //     _myUserInfoModel.data?.description ?? "";

            //宠主身份
            Provider.of<MyProvider>(context, listen: false)
                .selectPetIdentityValue = _myUserInfoModel.data?.identity ?? "";
            _getSelectIdentity = _myUserInfoModel.data?.identity ?? "";
            //狗狗生日
            // Provider.of<MyProvider>(context, listen: false)
            //                        .selectDogSexValue = _myUserInfoModel.data?.la
            // _petDate =

            //狗狗性别
            //  Provider.of<MyProvider>(context, listen: false)
            //                         .selectPetDogSexValue = _myUserInfoModel.data?.
            // _getSelectDogSex = 赋值狗狗性别

            //狗狗狂犬疫苗
            //  Provider.of<MyProvider>(context, listen: false)
            //                         .selectPetDogKuangquanyimiaoValue = _myUserInfoModel.data?.
            // _getSelectKuangquanyimiao=
            //狗狗照顾方式
            //  Provider.of<MyProvider>(context, listen: false)
            //                         .selectPetDogZhaogufangshiValue = _myUserInfoModel.data?.
            // _getSelectZhaogufangshi =

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

  //保存并更新
  void saveAndUpdate() async {
    EasyLoading.show(status: 'loading...');

    //上传图片返回的数组列表
    List imagArr = await uploadImages(_selectPhotoAssets);
    AALog("photosphotosimagArr--$imagArr");

    String imagArrJson = jsonEncode(imagArr);
    AALog("imagArrJson--$imagArrJson");

    Map<String, dynamic> dogDic = {
      "birthday": _petDate,
      "gender": _getSelectDogSex,
      "mode": "",
      "nickname": "",
      "photos": imagArrJson,
      "vaccine": "", //	疫苗
    };
    String dogJson = jsonEncode(dogDic);
    MyApi.masterUpdate(
      address: Provider.of<MyProvider>(context, listen: false).petAddressStr,
      dog: dogJson, //狗狗信息
      identity: _getSelectIdentity, //身份
      isOpen: _isSwitch ?? _myUserInfoModel.data?.isOpen, //是否公开
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _homePage(),
          const BaseAppBar(title: "宠主帮养信息"),
        ],
      ),
    );
  }

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

            Container(
              alignment: Alignment.centerLeft,
              width: ScreenAdapter.width(280),
              height: ScreenAdapter.height(90),
              // color: KTColor.amber,
              child: Image(
                image: AssetImage('assets/my_pet_title.png'),
              ),
            ),
            doginfoView(),

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
                  // saveAndUpdate();
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
      height: ScreenAdapter.width(670),
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
                width: padding_80,
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
                  // model?.isAuthenticated == true
                  //     ? AssetUtils.getAssetImagePNG('my_already_name')
                  //     :
                  AssetUtils.getAssetImagePNG('my_not_name'),
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
                  // (model?.age != "") ? (model?.age ?? "") : '未知',
                  "90后",
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
            child: InkWell(
              onTap: () {
                AALog('身份选择');

                NavigationUtil.getInstance()
                    .pushNamed(RoutersName.myPetChooseIdentityPage)
                    ?.then((value) {
                  setState(() {
                    AALog("返回来的值:$value");
                    if (value != null) {
                      _getSelectIdentity = value;
                    }
                  });
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '身份',
                    style: HooTextStyle.titleS32W6CBlackStyle,
                  ),
                  Row(
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
                ],
              ),
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
                  '常住位置',
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
                        // "点击获取位置提供精准服务",
                        addressModel?.description ?? "点击获取位置提供精准服务",
                        // // (tempModel!.address!.description!),
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

  /// 爱犬信息
  Widget doginfoView() {
    var tempModel = _myUserInfoModel.data;
    return Container(
      height: ScreenAdapter.width(610),
      color: KTColor.white,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            //爱犬名字
            Padding(
              padding: EdgeInsets.all(ScreenAdapter.width(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '爱犬名字',
                    style: HooTextStyle.titleS32W6CBlackStyle,
                  ),
                  Container(
                    width: ScreenAdapter.width(500),
                    height: ScreenAdapter.width(60),
                    // color: KTColor.amber,
                    child: NormalTextField(
                      textAlign: TextAlign.right,
                      controller: dognameController,
                      textColor: KTColor.color_60,
                      textFontSize: ScreenAdapter.fontSize(32),
                      textFontWeight: FontWeight.w300,
                      keyboardType: TextInputType.name,
                      hintText: "请输入",
                      hintColor: KTColor.color_164,
                    ),
                  ),
                ],
              ),
            ),

            Divider(
              height: 1.0,
              indent: padding_40,
              color: KTColor.color_243,
            ),

            //爱犬生日
            Padding(
              padding: EdgeInsets.all(ScreenAdapter.width(30)),
              child: InkWell(
                onTap: () {
                  AALog('爱犬生日');
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    // minTime: DateTime(, 3, 5),//设置最小时间
                    // maxTime: DateTime(2024, , 7),//设置最大时间
                    onChanged: (date) {
                      print('change $date');
                      // final now = DateTime.now();

                      // _petDate = DateFormat("yyyy-MM-dd").format(now);
                    },
                    onConfirm: (date) {
                      AALog('confirm $date');
                      setState(() {
                        // final now = DateTime.now();

                        _petDate = DateFormat("yyyy-MM-dd").format(date);

                        //获取宠物生日
                        // _petDate =
                        // "${date.year}-${date.month}-${date.day}";
                        AALog("获取宠物生日${_petDate}");
                      });
                    },
                    currentTime: DateTime.now(), //当前日期
                    locale: LocaleType.zh, //国际化配置
                    theme: const picker.DatePickerTheme(
                      // headerColor: KTColor.amber,
                      // backgroundColor: KTColor.orange,
                      // itemStyle: TextStyle(
                      //   color: KTColor.green,
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 18,
                      // ),
                      doneStyle: TextStyle(
                        color: KTColor.color_251_98_64,
                        // fontSize: 16,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '爱犬生日',
                      style: HooTextStyle.titleS32W6CBlackStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          _petDate, // "去选择",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            // color: KTColor.color_76_76_76, 生日颜色
                            color: KTColor.color_251_98_64,
                            fontSize: ScreenAdapter.fontSize(32),
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
                  ],
                ),
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

            //爱犬性别
            Padding(
              padding: EdgeInsets.all(ScreenAdapter.width(30)),
              child: InkWell(
                onTap: () {
                  AALog('去选择');
                  NavigationUtil.getInstance()
                      .pushNamed(RoutersName.myPetChooseDogSexPage)
                      ?.then(
                    (value) {
                      setState(
                        () {
                          AALog("返回来的值:$value");
                          if (value != null) {
                            _getSelectDogSex = value;
                          }
                        },
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '爱犬性别',
                      style: HooTextStyle.titleS32W6CBlackStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          _getSelectDogSex == ''
                              ? tempModel?.mode ?? "去选择"
                              : _getSelectDogSex,
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
                  ],
                ),
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
            Padding(
              padding: EdgeInsets.all(ScreenAdapter.width(30)),
              child: InkWell(
                onTap: () {
                  AALog('去选择');
                  NavigationUtil.getInstance()
                      .pushNamed(RoutersName.myPetChooseKuangyimiaoPage)
                      ?.then(
                    (value) {
                      setState(
                        () {
                          AALog("返回来的值:$value");
                          if (value != null) {
                            _getSelectKuangquanyimiao = value;
                          }
                        },
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '狂犬疫苗注射情况',
                      style: HooTextStyle.titleS32W6CBlackStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          // "去选择",
                          _getSelectKuangquanyimiao == ''
                              ? tempModel?.mode ?? "去选择"
                              : _getSelectKuangquanyimiao,
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
                  ],
                ),
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
            Padding(
              padding: EdgeInsets.all(ScreenAdapter.width(30)),
              child: InkWell(
                onTap: () {
                  AALog('去选择');
                  NavigationUtil.getInstance()
                      .pushNamed(RoutersName.myPetChooseZhaogustylePage)
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
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '您需要的照顾方式',
                      style: HooTextStyle.titleS32W6CBlackStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          // "去选择",
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
                  ],
                ),
              ),
            ),
          ],
        ),
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
