import 'dart:convert';
import 'dart:io';

import 'package:aidog/app/apis/login_api.dart';
import 'package:aidog/app/apis/my_api.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/button_util.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/global_style.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/show_toast_utils.dart';
import 'package:aidog/app/common/string_extension.dart';
import 'package:aidog/app/http_tools/hoo_http.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:aidog/app/pages/login/widget/compress.dart';
import 'package:aidog/app/pages/login/widget/picker.dart';
import 'package:aidog/app/pages/my/models/my_user_info_model.dart';
import 'package:aidog/app/pages/tabs/tabs_page.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:aidog/app/widget/normal_text_field.dart';
import 'package:aidog/app/widget/outline_choese_button.dart';
import 'package:aidog/app/widget/pass_button.dart';
import 'package:aidog/app/widget/showBottomSheet/show_Bottom_sheet_tool.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

typedef PhotoArrUpdateCallback = void Function(List<dynamic> photoArr);

/// 我的 - 选择宠主完善爱犬档案
class MyChoosePetOwnerInfoPage extends StatefulWidget {
  const MyChoosePetOwnerInfoPage({super.key});

  @override
  State<MyChoosePetOwnerInfoPage> createState() =>
      _MyChoosePetOwnerInfoPageState();
}

class _MyChoosePetOwnerInfoPageState extends State<MyChoosePetOwnerInfoPage> {
  MyUserInfoModel _myUserInfoModel = MyUserInfoModel();

  ///纬度
  String _latitude = "";

  ///经度
  String _longitude = "";

  ///描述地址
  String _description = '';

  ///已选中图片列表
  List<AssetEntity> _selectPhotoAssets = [];

  // ///已选中的视频
  // List<AssetEntity> _selectVideoAssets = [];

  /// 宠主爱犬昵称
  TextEditingController petNameController = TextEditingController();

  /// 存放 宠物日期
  String _petDate = '';
  //记录选择的爱犬性别
  int _selectPetDogSex = 0;

  ///妹妹
  int _selectDogSexValue0 = 1;

  ///弟弟
  int _selectDogSexValue1 = 2;

  //狂犬疫苗注射情况
  //记录选择的狂犬疫苗情况
  int _selectPetKuangquanyimiaoState = 0;

  ///已注射
  int _selectKuangquanyimiaoValue0 = 1;

  ///暂未
  int _selectKuangquanyimiaoValue1 = 2;

  //照顾方式
  //记录选择的照顾方式
  int _selectPetZhaogufangshi = 0;

  ///遛狗
  int _selectZhaogufangshi0 = 1;

  ///帮养
  int _selectZhaogufangshi1 = 2;

  ///两者均可
  int _selectZhaogufangshi2 = 3;

  //存放 以map类型存放的图片数组用于发送给服务器
  List _photoArr = [];
  @override
  void initState() {
    super.initState();

    MyApi().userInfo(
      onSuccess: (data) {
        if (data['code'] == '200') {
          setState(() {
            _myUserInfoModel = MyUserInfoModel.fromJson(data);
            setState(() {
              Provider.of<LoginProvider>(context, listen: false).addressStr =
                  jsonEncode(_myUserInfoModel.data?.address);
            });
          });
        }
      },
      onFailure: (error) {},
    );
  }

  @override
  void dispose() {
    AALog("定位销毁了吗");
    GlobalLocationTool().destroyLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<LoginProvider>(
    //   create: (context) => LoginProvider(context),
    //   builder: (context, child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () {
            //收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: ScreenAdapter.getScreenHeight(),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                //渐变位置
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  KTColor.color_255_247_239,
                  KTColor.color_255_127_75,
                ],
              ),
            ),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1.返回箭头
                Container(
                  // color: Colors.red,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: ScreenAdapter.getStatusBarHeight() +
                            ScreenAdapter.height(66),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                    ],
                  ),
                ),
                //2.标题 头像
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: ScreenAdapter.width(80)),
                      // color: Colors.amber,
                      child: Text(
                        "完善爱犬档案",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenAdapter.fontSize(50),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: padding_80),
                      child: Column(
                        children: [
                          //头像
                          Container(
                            //设置裁切属性
                            width: ScreenAdapter.width(128),
                            height: ScreenAdapter.width(128),
                            child: CircleAvatar(
                              // radius: ScreenAdapter.width(40),
                              backgroundImage:
                                  _myUserInfoModel.data?.avatar != ""
                                      ? CachedNetworkImageProvider(
                                          _myUserInfoModel.data?.avatar ??
                                              defaultHeadImg,
                                        )
                                      : AssetImage(
                                          AssetUtils.getAssetImagePNG(
                                              'default_head_img'),
                                        ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenAdapter.height(16),
                          ),
                          Text(
                            _myUserInfoModel.data?.nickname ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: KTColor.color_60,
                              fontSize: ScreenAdapter.fontSize(32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //4.爱犬名称
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(80),
                    top: ScreenAdapter.width(26),
                    right: ScreenAdapter.width(80),
                  ),
                  // color: KTColor.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '爱犬名称',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_60,
                          fontSize: ScreenAdapter.fontSize(28),
                        ),
                      ),
                      SizedBox(
                        height: padding_20,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: ScreenAdapter.width(40),
                          bottom: ScreenAdapter.width(23),
                        ),
                        alignment: Alignment.center,
                        width: ScreenAdapter.width(295),
                        height: ScreenAdapter.height(
                            66), //texfield有一个固定的高度所以66高度不合适
                        decoration: BoxDecoration(
                          color: KTColor.white,
                          borderRadius: BorderRadius.circular(
                            ScreenAdapter.width(45),
                          ), //设置圆角
                        ),
                        child: NormalTextField(
                          controller: petNameController,
                          // height: ScreenAdapter.height(66),
                          bgColor: KTColor.white,
                          textAlign: TextAlign.left,
                          hintText: "请填写",
                          hintFontWeight: FontWeight.w300,
                          hintFontSize: ScreenAdapter.fontSize(26),
                          hintColor: KTColor.color_164,
                          keyboardType: TextInputType.name,
                          radius: 33,
                          inputFormatters: [
                            // FilteringTextInputFormatter.allow(
                            //     RegExp(r'[0-9]')), //设置只允许输入数字
                            LengthLimitingTextInputFormatter(8) //限制长度
                          ],
                          onChanged: (value) {
                            AALog(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                //5.爱犬生日
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(80),
                    top: ScreenAdapter.width(26),
                    right: ScreenAdapter.width(80),
                  ),
                  // color: KTColor.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '爱犬生日',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_60,
                          fontSize: ScreenAdapter.fontSize(28),
                        ),
                      ),
                      SizedBox(
                        height: padding_20,
                      ),
                      OutlineChoeseButton(
                        title: _petDate == "" ? "请选择" : _petDate,
                        textColor:
                            _petDate == "" ? KTColor.color_164 : KTColor.black,
                        index: 0,
                        onTap: (index) async {
                          AALog("日期 $index");
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

                                _petDate =
                                    DateFormat("yyyy-MM-dd").format(date);

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
                        rightWidget: Icon(
                          Icons.arrow_drop_down_sharp,
                          size: ScreenAdapter.height(32),
                        ),
                        width: ScreenAdapter.width(296),
                        height: ScreenAdapter.height(66),
                        radius: 33,
                        borderWidth: 0,
                        borderColor: Colors.white,
                      )
                    ],
                  ),
                ),

                //6.爱犬性别
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(80),
                    top: ScreenAdapter.width(26),
                    right: ScreenAdapter.width(80),
                  ),
                  // color: KTColor.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '爱犬性别',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_60,
                          fontSize: ScreenAdapter.fontSize(28),
                        ),
                      ),
                      SizedBox(
                        height: padding_20,
                      ),
                      Row(
                        children: [
                          OutlineChoeseButton(
                            title: "妹妹",
                            textColor: KTColor.color_60,
                            index: _selectDogSexValue0,
                            onTap: (index) {
                              AALog("妹妹 $index");
                              setState(() {
                                _selectPetDogSex = index;
                              });
                            },
                            width: ScreenAdapter.width(142),
                            height: ScreenAdapter.height(66),
                            radius: 33,
                            borderWidth:
                                (_selectPetDogSex == _selectDogSexValue0)
                                    ? ScreenAdapter.width(2)
                                    : 0,
                            borderColor:
                                (_selectPetDogSex == _selectDogSexValue0)
                                    ? KTColor.color_251_98_64
                                    : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "弟弟",
                            textColor: KTColor.color_60,
                            index: _selectDogSexValue1,
                            onTap: (index) {
                              AALog("弟弟 $index");
                              setState(() {
                                _selectPetDogSex = index;
                              });
                            },
                            width: ScreenAdapter.width(142),
                            height: ScreenAdapter.height(66),
                            radius: 33,
                            borderWidth:
                                (_selectPetDogSex == _selectDogSexValue1)
                                    ? ScreenAdapter.width(2)
                                    : 0,
                            borderColor:
                                (_selectPetDogSex == _selectDogSexValue1)
                                    ? KTColor.color_251_98_64
                                    : Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //7.狂犬疫苗注射情况
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(80),
                    top: ScreenAdapter.width(26),
                    right: ScreenAdapter.width(80),
                  ),
                  // color: KTColor.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '狂犬疫苗注射情况',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_60,
                          fontSize: ScreenAdapter.fontSize(28),
                        ),
                      ),
                      SizedBox(
                        height: padding_20,
                      ),
                      Row(
                        children: [
                          OutlineChoeseButton(
                            title: "已注射",
                            textColor: KTColor.color_60,
                            index: _selectKuangquanyimiaoValue0,
                            onTap: (index) {
                              AALog("已注射 $index");
                              setState(() {
                                _selectPetKuangquanyimiaoState = index;
                              });
                            },
                            width: ScreenAdapter.width(142),
                            height: ScreenAdapter.height(66),
                            radius: 33,
                            borderWidth: (_selectPetKuangquanyimiaoState ==
                                    _selectKuangquanyimiaoValue0)
                                ? ScreenAdapter.width(2)
                                : 0,
                            borderColor: (_selectPetKuangquanyimiaoState ==
                                    _selectKuangquanyimiaoValue0)
                                ? KTColor.color_251_98_64
                                : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "暂未",
                            textColor: KTColor.color_60,
                            index: _selectKuangquanyimiaoValue1,
                            onTap: (index) {
                              AALog("暂未 $index");
                              setState(() {
                                _selectPetKuangquanyimiaoState = index;
                              });
                            },
                            width: ScreenAdapter.width(142),
                            height: ScreenAdapter.height(66),
                            radius: 33,
                            borderWidth: (_selectPetKuangquanyimiaoState ==
                                    _selectKuangquanyimiaoValue1)
                                ? ScreenAdapter.width(2)
                                : 0,
                            borderColor: (_selectPetKuangquanyimiaoState ==
                                    _selectKuangquanyimiaoValue1)
                                ? KTColor.color_251_98_64
                                : Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //8.爱犬需要的照顾方式
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(80),
                    top: ScreenAdapter.width(26),
                    right: ScreenAdapter.width(80),
                  ),
                  // color: KTColor.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '爱犬需要的照顾方式',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_60,
                          fontSize: ScreenAdapter.fontSize(28),
                        ),
                      ),
                      SizedBox(
                        height: padding_20,
                      ),
                      Row(
                        children: [
                          OutlineChoeseButton(
                            title: "遛狗",
                            textColor: KTColor.color_60,
                            index: _selectZhaogufangshi0,
                            onTap: (index) {
                              AALog("遛狗 $index");
                              setState(() {
                                _selectPetZhaogufangshi = index;
                              });
                            },
                            width: ScreenAdapter.width(142),
                            height: ScreenAdapter.height(66),
                            radius: 33,
                            borderWidth: (_selectPetZhaogufangshi ==
                                    _selectZhaogufangshi0)
                                ? ScreenAdapter.width(2)
                                : 0,
                            borderColor: (_selectPetZhaogufangshi ==
                                    _selectZhaogufangshi0)
                                ? KTColor.color_251_98_64
                                : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "帮养",
                            textColor: KTColor.color_60,
                            index: _selectZhaogufangshi1,
                            onTap: (index) {
                              AALog("帮养 $index");
                              setState(() {
                                _selectPetZhaogufangshi = index;
                              });
                            },
                            width: ScreenAdapter.width(142),
                            height: ScreenAdapter.height(66),
                            radius: 33,
                            borderWidth: (_selectPetZhaogufangshi ==
                                    _selectZhaogufangshi1)
                                ? ScreenAdapter.width(2)
                                : 0,
                            borderColor: (_selectPetZhaogufangshi ==
                                    _selectZhaogufangshi1)
                                ? KTColor.color_251_98_64
                                : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "两者均可",
                            textColor: KTColor.color_60,
                            index: _selectZhaogufangshi2,
                            onTap: (index) {
                              AALog("两者均可 $index");
                              setState(() {
                                _selectPetZhaogufangshi = index;
                              });
                            },
                            width: ScreenAdapter.width(142),
                            height: ScreenAdapter.height(66),
                            radius: 33,
                            borderWidth: (_selectPetZhaogufangshi ==
                                    _selectZhaogufangshi2)
                                ? ScreenAdapter.width(2)
                                : 0,
                            borderColor: (_selectPetZhaogufangshi ==
                                    _selectZhaogufangshi2)
                                ? KTColor.color_251_98_64
                                : Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ///6. 你的常驻位置
                Consumer(
                  //使用它外面不能套ChangeNotifierProvider
                  builder: (context, LoginProvider provider, child) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: ScreenAdapter.width(80),
                        top: ScreenAdapter.width(26),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '你的常驻位置',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: KTColor.color_60,
                              fontSize: ScreenAdapter.fontSize(28),
                            ),
                          ),
                          SizedBox(
                            height: padding_20,
                          ),
                          OutlineChoeseButton(
                            title: provider.desAddressStr == ""
                                ? (_myUserInfoModel
                                                .data?.address?.description ??
                                            "") ==
                                        ""
                                    ? "点击获取常用地址"
                                    : (_myUserInfoModel
                                            .data?.address?.description ??
                                        "")
                                : provider.desAddressStr,
                            textColor: provider.desAddressStr == ""
                                ? (_myUserInfoModel
                                                .data?.address?.description ??
                                            "") ==
                                        ""
                                    ? KTColor.color_164
                                    : KTColor.black
                                : KTColor.black,
                            index: 0,
                            onTap: (index) {
                              AALog("点击获取常用地址 $index");
                              // GlobalLocationTool().startLocationInfo();
                              requestPermission();
                            },
                            width: ScreenAdapter.width(450),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth: 0,
                            borderColor: Colors.white,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                //3.爱犬照片
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(80),
                    top: ScreenAdapter.width(26),
                    right: ScreenAdapter.width(80),
                  ),
                  // color: KTColor.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '爱犬照片',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: KTColor.color_60,
                          fontSize: ScreenAdapter.fontSize(28),
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
                            // AALog(
                            // "constraints.maxWidth${constraints.maxWidth}");
                            //设置每行4个
                            final double width = (constraints.maxWidth * 2 -
                                    space * 2 -
                                    imagePadd * 5 -
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

                                    /*
                                    List<String> arr = [
                                      '照片',
                                      '视频',
                                    ];
                                    ShowBottomSheetTool.bottomSheet(
                                        context, arr, (value) {
                                      AALog("选择的值:$value");
                                      if (value == "照片") {
                                        openPhoto();
                                      } else {
                                        openVideo();
                                      }
                                    });
                                    */
                                    // //只上传图片
                                    openPhoto();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    // padding: EdgeInsets.all(padding_5),
                                    width: ScreenAdapter.width(width),
                                    height: ScreenAdapter.width(width),
                                    //设置裁切属性
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: KTColor.white,
                                      //设置完圆角度数后,需要设置裁切属性
                                      borderRadius: BorderRadius.circular(
                                          ScreenAdapter.width(10)),
                                    ),
                                    child: Image.asset(
                                      width: ScreenAdapter.width(52),
                                      height: ScreenAdapter.width(52),
                                      AssetUtils.getAssetImagePNG(
                                          'my_smail_camera'),
                                    ),
                                  ),
                                ),
                                for (final AssetEntity asset
                                    in _selectPhotoAssets)
                                  _buildPhotoItem(
                                      asset, ScreenAdapter.width(width)),
                                // for (final asset in _selectPhotoAssets)
                                //   _buildVideoItem(
                                //       asset, ScreenAdapter.width(width)),
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

                //7.完成
                Consumer(
                  builder: (context, LoginProvider provider, child) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: ScreenAdapter.width(41),
                        top: ScreenAdapter.width(30),
                        right: ScreenAdapter.width(41),
                        bottom: ScreenAdapter.width(60),
                      ),
                      width: double.infinity,
                      child: PassButton(
                        text: "完成",
                        bgColor: KTColor.color_251_98_64,
                        height: ScreenAdapter.width(90),
                        onPressed: petComplete,
                        // ButtonUtils.debounce(
                        //   provider.petComplete("ss "),
                        // ),
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: ScreenAdapter.height(100),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //   },
    // );
  }

  //显示图片item
  Widget _buildPhotoItem(AssetEntity asset, double width) {
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
          asset.type == AssetType.video
              ? Positioned(
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
                )
              : SizedBox.shrink(),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                // AALog('删除$asset');
                setState(() {
                  //如果点击的在数组有就移除
                  _selectPhotoAssets.removeWhere((item) {
                    return item == asset;
                  });

                  AALog("删除的图片:${_selectPhotoAssets.length}");
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
                  AALog("删除的视频:${_selectPhotoAssets.length}");
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
      _selectPhotoAssets.addAll(result);

      AALog("选择的图片结果:$_selectPhotoAssets");
    });
  }

  ///完善宠主狗狗信息 完成按钮
  void petComplete() async {
    if (petNameController.text.isEmpty) {
      showToastCenter('请输入爱犬名称');
      return;
    }

    if (_petDate.isEmpty) {
      showToastCenter('请选择日期');
      return;
    }

    if (_selectPetDogSex == 0) {
      showToastCenter('请选择爱犬性别');
      return;
    }
    if (_selectPetKuangquanyimiaoState == 0) {
      showToastCenter('请选择狂犬疫苗注射情况');
      return;
    }
    if (_selectPetZhaogufangshi == 0) {
      showToastCenter('请选择爱犬需要的照顾方式');
      return;
    }
    if (Provider.of<LoginProvider>(context, listen: false).addressStr.isEmpty) {
      showToastCenter('请获取常住位置');
      return;
    }
    //宠物性别
    String gender = '';
    if (_selectPetDogSex == 1) {
      gender = '妹妹';
    } else {
      gender = '哥哥';
    }
    String mode = '';
    if (_selectPetZhaogufangshi == 1) {
      mode = "遛狗";
    } else if (_selectPetZhaogufangshi == 2) {
      mode = "帮养";
    } else {
      mode = "两者均可";
    }
    //是否注射疫苗
    String vaccine = '';
    if (_selectPetKuangquanyimiaoState == 1) {
      vaccine = '已注射';
    } else {
      vaccine = '未注射';
    }
    if (_selectPhotoAssets.isEmpty) {
      showToastCenter('请选择照片');
      return;
    }

    EasyLoading.show(status: 'loading...');

    List imagArr = await uploadImages(_selectPhotoAssets);
    AALog("photosphotosimagArr--$imagArr");
    String imagArrJson = jsonEncode(imagArr);
    AALog("imagArrJson--$imagArrJson");
    AALog(
        "Provider.of<LoginProvider>(context, listen: false).addressStr--${Provider.of<LoginProvider>(context, listen: false).addressStr}");

    LoginApi.loginAddDog(
      Provider.of<LoginProvider>(context, listen: false).addressStr,
      _petDate,
      gender,
      mode,
      petNameController.text,
      imagArrJson,
      vaccine,
      onSuccess: (data) {
        AALog("data$data");
        EasyLoading.dismiss;
        //销毁定位
        GlobalLocationTool().destroyLocation();

        if (data['code'] == "200") {
          //登录跳转到tabbar首页
          NavigationUtil.getInstance().pushAndRemoveUtil(
            context,
            RoutersName.tabsPage,
            widget: const TabsPage(),
          );
        }
      },
      onFailure: (error) {
        AALog("error$error");
        EasyLoading.dismiss;
        showToastCenter("提交失败,请重试");
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
      // _selectVideoAssets.addAll(result);
      _selectPhotoAssets.addAll(result);
      // AALog(_selectVideoAssets[0].file);
    });
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      AALog("定位权限申请通过");

      GlobalLocationTool().locationResultListen((map) {
        AALog("监听的定位信息:$map");
        setState(() {
          _latitude = map["latitude"].toString();
          _longitude = map["longitude"].toString();
          Provider.of<LoginProvider>(context, listen: false).desAddressStr =
              map["description"].toString();
          //以map形式传地图数据
          Map<String, dynamic> tempMap = {
            "latitude": map["latitude"].toString(),
            "longitude": map["longitude"].toString(),
            "province": map["province"].toString(),
            "city": map["city"].toString(),
            "district": map["district"].toString(),
            "street": map["street"].toString(),
            "streetNumber": map["streetNumber"].toString(),
            "address": map["address"].toString(),
            "description": map["description"].toString(),
          };

          Provider.of<LoginProvider>(context, listen: false).addressStr =
              jsonEncode(tempMap);
        });
      });
      GlobalLocationTool().startLocationInfo();
    } else {
      AALog("定位权限申请不通过");
      showToastCenter("请在设置里授予定位权限");
    }
  }

  /// 申请定位权限 授予定位权限返回true,否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的定位权限 照相图片权限等
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        AALog("权限通过");
        return true;
      } else {
        AALog("权限不通过通过");
        return false;
      }
    }
  }
}
