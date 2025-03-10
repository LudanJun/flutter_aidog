import 'dart:convert';

import 'package:aidog/app/apis/login_api.dart';
import 'package:aidog/app/apis/my_api.dart';
import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/button_util.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/show_toast_utils.dart';
import 'package:aidog/app/pages/login/provider/login_provider.dart';
import 'package:aidog/app/pages/my/models/my_user_info_model.dart';
import 'package:aidog/app/pages/tabs/tabs_page.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:aidog/app/widget/outline_choese_button.dart';
import 'package:aidog/app/widget/pass_button.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

///我的 帮养人 信息完善
class MyChooseHelpOtherInfoPage extends StatefulWidget {
  const MyChooseHelpOtherInfoPage({super.key});

  @override
  State<MyChooseHelpOtherInfoPage> createState() =>
      _MyChooseHelpOtherInfoPageState();
}

class _MyChooseHelpOtherInfoPageState extends State<MyChooseHelpOtherInfoPage> {
  MyUserInfoModel _myUserInfoModel = MyUserInfoModel();

  ///养狗经验选项
  //记录你的养狗经验
  int _selectDogExp = 0;
  int _selectDogExpValue0 = 1;
  int _selectDogExpValue1 = 2;
  int _selectDogExpValue2 = 3;

  ///身份选项
  //记录你的身份选择
  int _selectShenfen = 0;
  int _selectShenfenValue0 = 1;
  int _selectShenfenValue1 = 2;
  int _selectShenfenValue2 = 3;

  ///照顾方式选项
  //记录你的照顾狗狗的方式
  int _selectZhaoguFangshi = 0;
  int _selectZhaoguValue0 = 1;
  int _selectZhaoguValue1 = 2;
  int _selectZhaoguValue2 = 3;

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
    GlobalLocationTool().locationResultListen((map) {
      AALog("监听的定位信息:$map");
      setState(() {
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
  }

  @override
  void dispose() {
    GlobalLocationTool().destroyLocation();
    super.dispose();
  }

  /// 完善信息请求
  void compeleteInfoData() {
    if (_selectDogExp == 0) {
      showToastCenter('请选择养狗经验');
      return;
    }

    if (_selectShenfen == 0) {
      showToastCenter('请选择身份');
      return;
    }

    if (_selectZhaoguFangshi == 0) {
      showToastCenter('请选择照顾狗狗方式');
      return;
    }
    if (Provider.of<LoginProvider>(context, listen: false).addressStr.isEmpty) {
      showToastCenter('请获取常住位置');
      return;
    }
    String _exp = '';
    if (_selectDogExp == 1) {
      _exp = "无经验";
    } else if (_selectDogExp == 2) {
      _exp = "新手";
    } else if (_selectDogExp == 3) {
      _exp = "老手";
    }

    String _shenfen = '';
    if (_selectShenfen == 1) {
      _shenfen = "学生党";
    } else if (_selectShenfen == 2) {
      _shenfen = "上班族";
    } else if (_selectShenfen == 3) {
      _shenfen = "自由职业";
    }

    String _zhaogu = '';
    if (_selectZhaoguFangshi == 1) {
      _zhaogu = "遛狗";
    } else if (_selectZhaoguFangshi == 2) {
      _zhaogu = "帮养";
    } else if (_selectZhaoguFangshi == 3) {
      _zhaogu = "两者均可";
    }
    //更新人物信息
    LoginApi.publickSettingInfo(
      //养狗经验
      experience: _exp,
      identity: _shenfen,
      mode: _zhaogu,
      address: Provider.of<LoginProvider>(context, listen: false).addressStr,
      onSuccess: (data) {
        AALog("onSuccess:$data");
        GlobalLocationTool().destroyLocation();

        if (data['code'] == "200") {
          //跳转
          ////登录跳转到tabbar首页
          NavigationUtil.getInstance().pushAndRemoveUtil(
            context,
            RoutersName.tabsPage,
            widget: const TabsPage(),
          );
        }
      },
      onFailure: (error) {
        AALog("onSuccess:$error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(context),
      builder: (context, child) {
        return Scaffold(
          body: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          AALog("返回");
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
                        "完善信息",
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
                              backgroundImage: AssetImage(
                                AssetUtils.getAssetImagePNG('default_head_img'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenAdapter.height(16),
                          ),
                          Text(
                            '纸飞机',
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

                //3.你的养狗经验
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(80),
                    top: ScreenAdapter.width(26),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '你的养狗经验',
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
                            title: "无经验",
                            index: _selectDogExpValue0,
                            onTap: (index) {
                              AALog("无经验 $index");
                              setState(() {
                                _selectDogExp = _selectDogExpValue0;
                              });
                            },
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth: (_selectDogExp == _selectDogExpValue0)
                                ? ScreenAdapter.width(2)
                                : 0,
                            borderColor: (_selectDogExp == _selectDogExpValue0)
                                ? KTColor.color_251_98_64
                                : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "新手",
                            index: _selectDogExpValue1,
                            onTap: (index) {
                              AALog("新手 $index");
                              setState(() {
                                _selectDogExp = _selectDogExpValue1;
                              });
                            },
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth: (_selectDogExp == _selectDogExpValue1)
                                ? ScreenAdapter.width(2)
                                : 0,
                            borderColor: (_selectDogExp == _selectDogExpValue1)
                                ? KTColor.color_251_98_64
                                : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "老手",
                            index: _selectDogExpValue2,
                            onTap: (index) {
                              AALog("老手 $index");
                              setState(() {
                                _selectDogExp = _selectDogExpValue2;
                              });
                            },
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth: (_selectDogExp == _selectDogExpValue2)
                                ? ScreenAdapter.width(2)
                                : 0,
                            borderColor: (_selectDogExp == _selectDogExpValue2)
                                ? KTColor.color_251_98_64
                                : Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                //4.你的身份
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(80),
                    top: ScreenAdapter.width(26),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '你的身份',
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
                            title: "学生党",
                            index: _selectShenfenValue0,
                            onTap: (index) {
                              AALog("学生党 $index");
                              setState(() {
                                _selectShenfen = _selectShenfenValue0;
                              });
                            },
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth: (_selectShenfen == _selectDogExpValue0)
                                ? ScreenAdapter.width(2)
                                : 0,
                            borderColor: (_selectShenfen == _selectDogExpValue0)
                                ? KTColor.color_251_98_64
                                : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "上班族",
                            index: _selectShenfenValue1,
                            onTap: (index) {
                              AALog("上班族 $index");
                              setState(() {
                                _selectShenfen = _selectShenfenValue1;
                              });
                            },
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth:
                                (_selectShenfen == _selectShenfenValue1)
                                    ? ScreenAdapter.width(2)
                                    : 0,
                            borderColor:
                                (_selectShenfen == _selectShenfenValue1)
                                    ? KTColor.color_251_98_64
                                    : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "自由职业",
                            index: _selectShenfenValue2,
                            onTap: (index) {
                              AALog("自由职业 $index");
                              setState(() {
                                _selectShenfen = _selectShenfenValue2;
                              });
                            },
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth:
                                (_selectShenfen == _selectShenfenValue2)
                                    ? ScreenAdapter.width(2)
                                    : 0,
                            borderColor:
                                (_selectShenfen == _selectShenfenValue2)
                                    ? KTColor.color_251_98_64
                                    : Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // 5.你的照顾狗狗的方式
                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(80),
                    top: ScreenAdapter.width(26),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '你的照顾狗狗的方式',
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
                            index: _selectZhaoguValue0,
                            onTap: (index) {
                              AALog("遛狗 $index");
                              setState(() {
                                _selectZhaoguFangshi = _selectZhaoguValue0;
                              });
                            },
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth:
                                (_selectZhaoguFangshi == _selectZhaoguValue0)
                                    ? ScreenAdapter.width(2)
                                    : 0,
                            borderColor:
                                (_selectZhaoguFangshi == _selectZhaoguValue0)
                                    ? KTColor.color_251_98_64
                                    : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "帮养",
                            index: _selectZhaoguValue1,
                            onTap: (index) {
                              AALog("帮养 $index");
                              setState(() {
                                _selectZhaoguFangshi = _selectZhaoguValue1;
                              });
                            },
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth:
                                (_selectZhaoguFangshi == _selectZhaoguValue1)
                                    ? ScreenAdapter.width(2)
                                    : 0,
                            borderColor:
                                (_selectZhaoguFangshi == _selectZhaoguValue1)
                                    ? KTColor.color_251_98_64
                                    : Colors.white,
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(12),
                          ),
                          OutlineChoeseButton(
                            title: "两者均可",
                            index: _selectZhaoguValue2,
                            onTap: (index) {
                              AALog("两者均可 $index");
                              setState(() {
                                _selectZhaoguFangshi = _selectZhaoguValue2;
                              });
                            },
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.width(66),
                            radius: 33,
                            borderWidth:
                                (_selectZhaoguFangshi == _selectZhaoguValue2)
                                    ? ScreenAdapter.width(2)
                                    : 0,
                            borderColor:
                                (_selectZhaoguFangshi == _selectZhaoguValue2)
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
                  builder: (_, LoginProvider provider, child) {
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
                          // PassButton(
                          //   text: "完成",
                          //   height: 90,
                          //   onPressed:
                          //       ButtonUtils.debounce(provider.registerAndLogin),
                          // ),
                        ],
                      ),
                    );
                  },
                ),

                Container(
                  margin: EdgeInsets.only(
                    left: ScreenAdapter.width(41),
                    top: ScreenAdapter.width(120),
                    right: ScreenAdapter.width(41),
                  ),
                  width: double.infinity,
                  child: PassButton(
                    text: "完成",
                    bgColor: KTColor.color_251_98_64,
                    height: ScreenAdapter.width(90),
                    // onPressed: ButtonUtils.debounce(provider.helpComplete),
                    onPressed: () {
                      compeleteInfoData();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
