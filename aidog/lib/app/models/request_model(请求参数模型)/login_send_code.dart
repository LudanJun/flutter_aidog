/// 发送验证码请求模型
class LoginSendCode {
  String phone;
  LoginSendCode(this.phone);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "phone": phone,
    };
    return map;
  }
}
