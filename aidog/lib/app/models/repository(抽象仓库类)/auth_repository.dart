import 'package:aidog/app/models/success_message_model.dart';

///抽象类 只负责定义
abstract class AuthRepository {
  /// 是否加载引导图
  Future<bool> isShowGuide();

  /// 是否登录
  Future<bool> isLogin();

  // /// 发送验证码
  // Future<SuccessMessageModel> sendeSmsCode(String phone);
}
