import 'package:aidog/app/http_tools/hoo_http.dart';

class MyApi {
  /// 获取用户信息
  void userInfo({
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().get('/app/user/info', params: {}, onSuccess: (data) {
      onSuccess!(data);
    }, onFailure: (data) {
      onFailure!(data);
    });
  }

  //切换角色
  static Future<void> changeRole({
    /// 身份（1=宠物主，2=帮养人，3=兼有）
    String? role,
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().post(
      '/app/user/changeRole',
      params: {
        'role': role,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (error) {
        onFailure!(error);
      },
    );
  }

  //我的 宠主补充信息
  static Future<void> masterUpdate({
    /// 地址信息
    String? address,

    /// 狗狗信息
    /// birthday 爱犬生日
    /// gender 性别
    /// mode 照顾方式，1=遛狗，2=帮养，3两者均可
    /// nickname 爱犬名称
    /// photos 狗狗照片 json,示例值([ { "fileUrl": "http://xxx.jpg", "sortOrder": "1" } ])
    /// vaccine 疫苗
    String? dog, //map形式的json字符串
    /// 身份
    String? identity,

    /// 是否公开
    bool? isOpen,
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().post(
      '/app/user/changeRole',
      params: {
        'address': address,
        'dog': dog,
        'identity': identity,
        'isOpen': isOpen,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (error) {
        onFailure!(error);
      },
    );
  }
}
