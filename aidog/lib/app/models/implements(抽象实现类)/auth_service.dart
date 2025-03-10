import 'package:aidog/app/apis/login_api.dart';
import 'package:aidog/app/common/global_shared_key.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/storage.dart';
import 'package:aidog/app/http_tools/hoo_http.dart';
import 'package:aidog/app/models/repository(%E6%8A%BD%E8%B1%A1%E4%BB%93%E5%BA%93%E7%B1%BB)/auth_repository.dart';
import 'package:aidog/app/models/request_model(%E8%AF%B7%E6%B1%82%E5%8F%82%E6%95%B0%E6%A8%A1%E5%9E%8B)/login_send_code.dart';
import 'package:aidog/app/models/success_message_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 认证服务 抽象类的实现类
/// 使用  bool isShowGuide = await AuthService().isShowGuide();
class AuthService implements AuthRepository {
  /// 是否显示引导页
  @override
  Future<bool> isShowGuide() async {
    String oldBuildNumber = await Storage.getString(kSharedPreferencesGuide);
    AALog(oldBuildNumber);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber;
    AALog(buildNumber);

    //如果存储的版本号 不是最新版本号,就重新设置并显示引导页
    if (oldBuildNumber != buildNumber) {
      Storage.setString(kSharedPreferencesGuide, buildNumber);
      return true;
    }
    return false;
  }

  /// 是否登录
  @override
  Future<bool> isLogin() async {
    String token = await Storage.getString(kSharedPreferencesUserToken);
    return token.isNotEmpty;
  }

  // /// 发送验证码 返回参数模型
  // @override
  // Future<SuccessMessageModel> sendeSmsCode(String phone) async {
  //   //请求参数模式
  //   final req = LoginSendCode(phone);
  //   return jsonMap = await HooHttpUtil().get(LoginApi.sendSms);
  // }
}
