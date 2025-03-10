import 'dart:async';

import 'package:aidog/app/apis/login_api.dart';
import 'package:aidog/app/common/button_util.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_shared_key.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/input_formatters.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/common/show_toast_utils.dart';
import 'package:aidog/app/common/storage.dart';
import 'package:aidog/app/http_tools/hoo_http.dart';
import 'package:aidog/app/models/success_message_model.dart';
import 'package:aidog/app/pages/login/widget/user_agreement.dart';
import 'package:aidog/app/pages/tabs/tabs_page.dart';
import 'package:aidog/app/routers/navigation_util.dart';
import 'package:aidog/app/routers/routers_name.dart';
import 'package:aidog/app/widget/pass_button.dart';
import 'package:aidog/app/widget/showBottomSheet/show_cus_bottom_sheet_tool.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/*
通过Provider调用add方法
调用方法的时候listen设置为false
Provider.of<LoginProvider>(context, listen: false).isAgree = ;,

调用属性的时候listen设置true 默认为true
Provider.of<LoginProvider>(context, listen: true)
 */
class LoginProvider extends ChangeNotifier {
  final BuildContext context;

  LoginProvider(this.context);
  //手机号文本框
  TextEditingController telController = TextEditingController();

  //用户昵称文本框
  TextEditingController usernameController = TextEditingController();
  //验证码文本框
  TextEditingController codeController = TextEditingController();
  //验证码倒计时
  int _seconds = 0;
  int get seconds => _seconds;
  bool _isFirstTime = false;
  bool get isFirstTime => _isFirstTime;
  // set seconds(int value) {
  //   _seconds = value;
  //   notifyListeners();
  // }

  Timer? t;
  //验证码
  String codeStr = '';

  /// 记录手机号
  String _recordPhoneStr = '';
  String get recordPhoneStr => _recordPhoneStr;
  set recordPhoneStr(String str) {
    _recordPhoneStr = str;
    notifyListeners();
  }

  /// 记录验证码
  String _recordCodeStr = '';
  String get recordCodeStr => _recordCodeStr;
  set recordCodeStr(String str) {
    _recordCodeStr = str;
    notifyListeners();
  }

  bool _isAgree = false; //是否同意属性
  bool get isAgree => _isAgree;

  bool isPhone = false; //判断手机号是否输入正确

  //需要设置属性set方法 并通知数据改变
  set isAgree(bool isagree) {
    _isAgree = isagree;
    notifyListeners();
  }

  //选择男女值
  int _selectGenderValue = 1;
  int get selectGenderValue => _selectGenderValue;
  set selectGenderValue(int value) {
    _selectGenderValue = value;
    notifyListeners();
  }

  ///---登录->第一个页面的头像男女性别信息属性
  //获取上传头像返回的地址
  String _getHeadImgUrl = '';
  String get getHeadImgUrl => _getHeadImgUrl;
  set getHeadImgUrl(String value) {
    _getHeadImgUrl = value;
    notifyListeners();
  }

  int _selectSex = 2;
  int get selectSex => _selectSex;
  set selectSex(int value) {
    _selectSex = value;
    notifyListeners();
  }

  ///---登录->第二个页面的角色选择信息属性
  //监听记录选择的角色状态
  int _selectRole = 0;
  int get selectRole => _selectRole;
  set selectRole(int value) {
    _selectRole = value;
    notifyListeners();
  }

  ///---登录->第三个页面的帮养人信息属性

  // int get selectZhaoguFangshi => _selectZhaoguFangshi;
  // set selectZhaoguFangshi(int value) {
  //   _selectZhaoguFangshi = value;
  //   notifyListeners();
  // }

  /// 注册登录
  void registerAndLogin() {
    AALog("注册登录");
    // NavigationUtil.getInstance().pushAndRemoveUtil(
    //   context,
    //   RoutersName.tabsPage,
    //   widget: const TabsPage(),
    // );

    if (telController.text.isEmpty) {
      showToastCenter("请输入手机号");
      return;
    }
    isPhone = rExpCNPhone.hasMatch(telController.text);
    if (!isPhone) {
      showToastCenter("请输入正确的手机号");
      return;
    }

    if (isAgree == false) {
      // showToastCenter("请勾选协议");
      bottomShetView();

      return;
    }
    // LoginApi.login(telController.text, codeController.text, );
    AALog(telController.text);
    AALog(codeController.text);
    LoginApi.login(
      telController.text,
      codeController.text,
      onSuccess: (data) {
        AALog("data:${data['data']}");
        if (data['code'] == "200") {
          Storage.setString(kSharedPreferencesUserToken, data['data']);

          showToastCenter('登录成功');

          Future.delayed(const Duration(seconds: 1), () {
            NavigationUtil.getInstance()
                .pushNamed(RoutersName.loginSetHeadPage);
          });
        } else {
          showToastCenter(data['message']);
        }
      },
      onFailure: (error) {
        AALog("error$error");
      },
    );

    // NavigationUtil.getInstance().pushAndRemoveUtil(
    //   context,
    //   RoutersName.tabsPage,
    //   widget: const TabsPage(),
    // );

    // NavigationUtil.getInstance().pushReplacementNamed(RoutersName.tabsPage);

    //push可以返回上级页面
    // NavigationUtil.getInstance().pushNamed(RoutersName.loginCodePage);
  }

  /// 同意并继续
  void agreeAndGoon() {
    AALog('同意并继续');
    //开始倒计时023358
    // if (isAgree == false) {
    // } else {

    //   isAgree = false;
    // }
    if (recordPhoneStr.length == 11 && recordCodeStr.length == 6) {
      if (isAgree == false) {
        AALog("isAgree$isAgree");
        isAgree = true;
        AALog("isAgree$isAgree");
        registerAndLogin();
      }

      AALog("isAgree$isAgree");
    } else {
      AALog("isAgree$isAgree");

      isAgree = true;
      startCountdown();

      LoginApi.sendSmsCode(
        telController.text,
        onSuccess: (data) {
          AALog(data);
          var phoneStr = SuccessMessageModel.fromJson(data).data;
        },
        onFailure: (error) {
          AALog(error);
        },
      );
    }

    Navigator.pop(context);
  }

  /// 发送验证码
  void sendCodeData() async {
    if (telController.text.isEmpty) {
      showToastCenter("请输入手机号");
      return;
    }
    isPhone = rExpCNPhone.hasMatch(telController.text);
    if (!isPhone) {
      showToastCenter("请输入正确的手机号");
      return;
    }

    if (isAgree == false) {
      // showToastCenter("请勾选协议");
      bottomShetView();
      return;
    }
    //开始倒计时
    startCountdown();

    LoginApi.sendSmsCode(
      telController.text,
      onSuccess: (data) {
        AALog(data);
        var phoneStr = SuccessMessageModel.fromJson(data).data;
      },
      onFailure: (error) {
        AALog(error);
      },
    );

    notifyListeners();
  }

  //倒计时的方法
  void startCountdown() {
    _isFirstTime = true;
    _seconds = 10;
    t = Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        _seconds--;
        // AALog(_seconds);
        if (_seconds <= 0) {
          timer.cancel();
        }
        notifyListeners();
      },
    );
  }

  /// 上传头像
  void uploadHeadImage(String imgPath) {
    LoginApi.uploadImageFile(
      imgPath,
      onSuccess: (data) {
        if (data["code"] == "200") {
          getHeadImgUrl = data['data']['fileUrl'];
          AALog("上传头像返回的数据:$getHeadImgUrl");
          showToastCenter("上传头像成功");
        } else {
          showToastCenter("上传失败,请重新上传");
        }
      },
      onFailure: (error) {},
      onSendProgress: (count, total) {
        AALog("onSendProgress--count:$count---total:$total");
      },
      onReceiveProgress: (count, total) {
        AALog("onReceiveProgress--count:$count---total:$total");
      },
    );
    notifyListeners();
  }

  // ///上传宠主 宠物多张图片
  // uploadMutableImage(List<AssetEntity> selectPhotos) async {
  //   await LoginApi.uploadImages(
  //     selectPhotos,
  //     onsuccess: (data) {
  //       AALog(
  //           "返回的map:$data"); //{fileUrl: http://puppy-1301258381.cos.ap-shanghai.myqcloud.com/puppy/dog/17be10a711d34247841e5cf80ea7b230.jpg, sortOrder: 2}
  //       photoArr.add(data);
  //       AALog("最终图片数组:$photoArr");
  //     },
  //   );
  //   AALog("photoArrphotoArrphotoArr$photoArr");
  //   notifyListeners();
  // }
  // Future<void> uploadMutableImage(List<AssetEntity> selectPhotos) async {
  //   await LoginApi.uploadImages(
  //     selectPhotos,
  //     onsuccess: (data) {
  //       AALog(
  //           "返回的map:$data"); //{fileUrl: http://puppy-1301258381.cos.ap-shanghai.myqcloud.com/puppy/dog/17be10a711d34247841e5cf80ea7b230.jpg, sortOrder: 2}
  //       photoArr.add(data);
  //       AALog("最终图片数组:$photoArr  ${photoArr.length}");
  //     },
  //   );
  //   notifyListeners();
  // }

  /// 设置完头像下一步
  void headNext() {
    AALog("头像设置完下一步");
    /*头像选填
    if (getHeadImgUrl.isEmpty) {
      showToastCenter('请上传头像');
      return;
    }
    */
    if (selectSex == 2) {
      showToastCenter('请选择性别');
      return;
    }
    String? sexStr;
    if (selectSex == 0) {
      sexStr = 'female'; //女
    } else if (selectSex == 1) {
      sexStr = 'male'; //男
    } else {
      sexStr = '未知';
    }

    if (usernameController.text.isEmpty) {
      showToastCenter('请输入昵称');
      return;
    }

    LoginApi.publickSettingInfo(
      avatar: getHeadImgUrl,
      gender: sexStr,
      nickname: usernameController.text,
      onSuccess: (data) {
        AALog("headNext-onSuccess:$data");
        NavigationUtil.getInstance().pushNamed(RoutersName.loginSetRolePage);
      },
      onFailure: (error) {
        AALog("headNext-onSuccess:$error");
      },
    );
  }

  /// 选完角色下一步
  void selectRoleNext() {
    AALog("选完角色下一步");
    String? role;
    if (selectRole == 1) {
      role = '1'; //宠主
    } else if (selectRole == 2) {
      role = '2'; //帮养人
    } else {
      return showToastCenter("请选择您的角色");
    }
    LoginApi.publickSettingInfo(
      role: role,
      onSuccess: (data) {
        AALog("onSuccess:$data");
        if (selectRole == 1) {
          NavigationUtil.getInstance()
              .pushNamed(RoutersName.loginPetOwnerInfoPage);
        } else {
          NavigationUtil.getInstance().pushNamed(
            RoutersName.loginHelpOtherInfoPage,
          );
        }
      },
      onFailure: (error) {
        AALog("onSuccess:$error");
      },
    );
  }

  /// 完善帮养人信息 完成按钮
  void helpComplete() {
    AALog("完成");
    NavigationUtil.getInstance().pushNamed(RoutersName.loginPetOwnerInfoPage);
    //登录跳转到tabbar首页
    // NavigationUtil.getInstance().pushAndRemoveUtil(
    //   context,
    //   RoutersName.tabsPage,
    //   widget: const TabsPage(),
    // );
  }

  // //存放 选择的图片
  // List _photoArr = [];
  // List get photoArr => _photoArr;
  // set photoArr(dynamic data) {
  //   _photoArr = data;
  //   notifyListeners();
  // }

  //存放 描述位置
  String _desAddressStr = '';
  String get desAddressStr => _desAddressStr;
  set desAddressStr(String address) {
    _desAddressStr = address;
    notifyListeners();
  }

  //存放 常驻位置
  String _addressStr = '';
  String get addressStr => _addressStr;
  set addressStr(String address) {
    _addressStr = address;
    notifyListeners();
  }

  ///底部协议弹框
  void bottomShetView() {
    ShowCusBottomSheetTool().cusBottomSheet(
      context,
      Container(
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.height(460),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: KTColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(padding_30),
            topRight: Radius.circular(padding_30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: padding_60,
            ),
            Text(
              '请阅读并同意以下条款',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: KTColor.black,
                fontSize: ScreenAdapter.fontSize(28),
              ),
            ),
            SizedBox(
              height: padding_60,
            ),
            Wrap(
              //协议比较多可能会换号所以用wrap组件
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                InkWell(
                  child: Text(
                    "《用户协议》",
                    style: TextStyle(
                      color: KTColor.color_251_98_64,
                      fontSize: ScreenAdapter.fontSize(24),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                InkWell(
                  child: Text(
                    "《隐私协议》",
                    style: TextStyle(
                      color: KTColor.color_251_98_64,
                      fontSize: ScreenAdapter.fontSize(24),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                InkWell(
                  child: Text(
                    "《儿童/青少年个人信息保护规则》",
                    style: TextStyle(
                      color: KTColor.color_251_98_64,
                      fontSize: ScreenAdapter.fontSize(24),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenAdapter.height(182),
            ),
            PassButton(
              text: "同意并继续",
              bgColor: KTColor.color_251_98_64,
              width: ScreenAdapter.width(300),
              height: ScreenAdapter.width(80),
              onPressed: ButtonUtils.debounce(agreeAndGoon),
            ),
          ],
        ),
      ),
    );
  }
}
