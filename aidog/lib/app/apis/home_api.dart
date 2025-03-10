import 'package:aidog/app/http_tools/hoo_http.dart';

class HomeApi {
  /// 获取狗狗列表
  void getDogList({
    /// 城市
    String? city,

    /// 区县
    String? district,

    /// 排序字段:distance=按距离排序，time=按最新时间排序,示例值(distance)
    String? orderBy,

    /// 页码
    String? pageNum,

    /// 每页条数
    String? pageSize,
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().post(
      '/app/home/dogList',
      params: {
        "city": city,
        "district": district,
        "orderBy": orderBy,
        "pageNum": pageNum,
        "pageSize": pageSize,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (data) {
        onFailure!(data);
      },
    );
  }

  /// 帮养人列表
  void getHelpList({
    /// 城市
    String? city,

    /// 区县
    String? district,

    /// 排序字段:distance=按距离排序，time=按最新时间排序,示例值(distance)
    String? orderBy,

    /// 页码
    String? pageNum,

    /// 每页条数
    String? pageSize,
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().post(
      '/app/home/helperList',
      params: {
        "city": city,
        "district": district,
        "orderBy": orderBy,
        "pageNum": pageNum,
        "pageSize": pageSize,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (data) {
        onFailure!(data);
      },
    );
  }

  /// 宠主用户详情
  void getUserDetail({
    ///传用户id
    int? id,
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().get(
      '/app/user/detail',
      params: {
        "id": id,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (data) {
        onFailure!(data);
      },
    );
  }

  /// 宠主狗详情
  void getDogDetail({
    ///传用户id
    int? id,
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().get(
      '/app/dog/detail',
      params: {
        "id": id,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (data) {
        onFailure!(data);
      },
    );
  }

  /// 获取城市下所有区县
  void getDistrict({
    ///传用户id
    String? cityName,
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().get(
      '/common/district',
      params: {
        "cityName": cityName,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (data) {
        onFailure!(data);
      },
    );
  }
}
