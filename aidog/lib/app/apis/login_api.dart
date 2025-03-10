import 'dart:io';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/log_util.dart';
import 'package:aidog/app/common/string_extension.dart';
import 'package:aidog/app/http_tools/hoo_http.dart';
import 'package:aidog/app/models/success_message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// mark -  Response 里面还有个data记得取出来
class LoginApi {
  /// 发送验证码
  static sendSmsCode(
    String phone, {
    Success? onSuccess,
    Failure? onFailure,
    ProgressCallback? onReceiveProgress,
  } //接受数据进度
      ) async {
    HooHttpUtil().get('/sendSms', params: {
      'phone': phone,
    }, onSuccess: (data) {
      onSuccess!(data);
    }, onFailure: (data) {
      onFailure!(data);
    });
  }

  /*
  // 发送验证码
  static Future<String> sendSmsCode(
    String phone,
    Success? onSuccess,
    Failure? onFailure,
    ProgressCallback? onSendProgress, //上传数据进度
    ProgressCallback? onReceiveProgress, //接受数据进度
  ) async {
    Response res = await HooHttpUtil().get('/sendSms', params: {
      'phone': phone,
    });

    if (res != null) {
      var _data;
      
    }

    //这个res.data 取出来的SuccessMessageModel的默认模型
    //以后模型转换是res.data['data']
    var phoneStr = SuccessMessageModel.fromJson(res.data).data;
    AALog(phoneStr!); //259292

    return phoneStr;
  }
  */
  //登录接口
  static Future<void> login(
    String phone,
    String code, {
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().post(
      '/app/login',
      params: {
        'phone': phone,
        'code': code,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (error) {
        onFailure!(error);
      },
    );
    // var temp = SuccessMessageModel.fromJson(res);
    // AALog("res ${res['message']}");
  }

  // 新增狗狗数据
  static Future<void> loginAddDog(
    //常住位置
    String address,
    //爱犬生日
    String birthday,
    //性别
    String gender,
    //照顾方式，1=遛狗，2=帮养，3两者均可
    String mode,
    //爱犬名称
    String nickName,
    //狗狗照片 数组json
    String photos,
    //疫苗
    String vaccine, {
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().post(
      '/app/dog/add',
      params: {
        'address': address,
        'birthday': birthday,
        'gender': gender,
        'mode': mode,
        'nickName': nickName,
        'photos': photos,
        'vaccine': vaccine,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (error) {
        onFailure!(error);
      },
    );
  }

  //公共用户信息设置更新接口
  static Future<void> publickSettingInfo({
    /// 地址信息
    String? address,

    /// 年龄
    String? age,

    /// 头像
    String? avatar,

    /// 描述
    String? description,

    /// 距离
    String? distance,

    /// 邮箱
    String? email,

    /// 养狗经验
    String? experience,

    /// 性别 male=男，female=女）
    String? gender,

    /// 身份
    String? identity,

    /// 是否公开
    bool? isOpen,

    /// 养狗方式
    String? mode,

    /// 昵称
    String? nickname,

    /// 职业
    String? occupation,

    /// 身份（1=宠物主，2=帮养人，3=兼有）
    String? role,

    /// 狗狗照片 数组json
    String? photos,

    /// 学校
    String? school,
    Success? onSuccess,
    Failure? onFailure,
  }) async {
    HooHttpUtil().post(
      '/app/user/update',
      params: {
        'address': address,
        'avatar': avatar,
        'description': description,
        'distance': distance,
        'email': email,
        'experience': experience,
        'gender': gender,
        'identity': identity,
        'isOpen': isOpen,
        'mode': mode,
        'nickname': nickname,
        'occupation': occupation,
        'role': role,
        'photos': photos,
        'school': school,
      },
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (error) {
        onFailure!(error);
      },
    );
  }

  /// 公共上传单张图片接口
  static Future<void> uploadImageFile(
    String imageDir, {
    Success? onSuccess,
    Failure? onFailure,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var formData = FormData.fromMap(
      {
        'multipartFile': await MultipartFile.fromFile(
          imageDir,
          filename: StringExtension.generateImageNameByDate(),
        ),
      },
    );
    await HooHttpUtil().post(
      '/common/uploadFile',
      params: formData,
      onSuccess: (data) {
        onSuccess!(data);
      },
      onFailure: (error) {
        onFailure!(error);
      },
      onSendProgress: (count, total) {
        onSendProgress!(count, total);
      },
      onReceiveProgress: (count, total) {
        onReceiveProgress!(count, total);
      },
    );
  }

/*
  ///上传多张图片
  static Future<void> uploadImages(
    // Future<List> uploadImages(
    List<AssetEntity> entitys, {
    Success? onsuccess,
    Failure? onfailure,
  }) async {
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
            onsuccess!(map);
            // photos.add(map); //yo
            // AALog('上传成功 imageIds$photos');
          },
          onFailure: (error) {
            onfailure!(error);
          },
        ),
      );
      // AALog('上传成功 imageIds$photos');
    }
    AALog("photos:$photos");
    await Future.wait(futures);

    // return photos;
  }
*/
  // 使用 originFile 方法获取 File 对象，并获取它的路径
  static Future<String?> getImagePath(originFile) async {
    File? file = await originFile; // 等待异步操作完成
    if (file != null) {
      return file.path; // 返回文件路径
    } else {
      return null; // 如果 File 对象为 null，则返回 null
    }
  }

  /// 商品列表
  // static Future<List<ProductModel>> list({int? page, int? prePage}) async {
  //   var res = await WooHttpUtil().get('/products', params: {
  //     'page': page ?? 1,
  //     'per_page': prePage ?? 20,
  //   });

  //   List<ProductModel> items = [];
  //   for (var item in res.data) {
  //     items.add(ProductModel.fromJson(item));
  //   }

  //   return items;
  // }

  /// 退出登录
  static loginOut({
    Success? onSuccess,
    Failure? onFailure,
  } //接受数据进度
      ) async {
    HooHttpUtil().get('/app/logout', params: {}, onSuccess: (data) {
      onSuccess!(data);
    }, onFailure: (data) {
      onFailure!(data);
    });
  }
}
