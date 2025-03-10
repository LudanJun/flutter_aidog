import 'dart:convert';
import 'dart:io';

import 'package:aidog/app/common/global_shared_key.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/log_util.dart';
import 'package:aidog/app/common/show_toast_utils.dart';
import 'package:aidog/app/common/storage.dart';
import 'package:aidog/app/models/error_message_model.dart';
import 'package:aidog/app/models/implements(%E6%8A%BD%E8%B1%A1%E5%AE%9E%E7%8E%B0%E7%B1%BB)/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

typedef Success = Function(dynamic data);
typedef Failure = Function(dynamic error);

// const String CONTENT_TYPE = "content-type";
// const String ACCEPT = "accept";
// const String AUTHORIZATION = "authorization";
// const String DEFAULT_LANGUAGE = "en";
// const String TOKEN = "token";
// const String BASE_URL = "https://wpapi.ducafecat.tech"; //基地址

// const String BASE_URL = "https://puppyai.cn/api"; //基地址

const String BASE_URL = "http://106.54.22.55:8080"; //基地址
// const String BASE_URL = "http://192.168.79.100:8080"; //基地址

//仿 woo 猫哥
class HooHttpUtil {
  //_internal:内部的意思
  static final HooHttpUtil _instance = HooHttpUtil._internal();

  // 对象访问的也是自己本身
  factory HooHttpUtil() => _instance;

  late Dio _dio;

  HooHttpUtil._internal() {
    // header 头
    // Map<String, String> headers = {
    //   'content-type': 'application/json', //连接类型
    //   'accept': 'accept',
    // };

    // 初始选项
    var options = BaseOptions(
      baseUrl: BASE_URL, //基本URL
      // headers: headers, //header头
      connectTimeout: const Duration(seconds: 40), //5秒 连接超时
      receiveTimeout: const Duration(seconds: 40), //5秒 接收超时
      responseType: ResponseType.json, // 响应类型
      contentType: Headers.jsonContentType,
    );

    // 初始化dio
    _dio = Dio(options);

    // 拦截器 - 日志打印
    if (!kReleaseMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    // 拦截器 - 拦截请求头
    _dio.interceptors.add(RequestInterceptors());

    // _dio.interceptors.add(InterceptorsWrapper(
    //   onError: (DioException error, ErrorInterceptorHandler handler) async {
    //     if (error.response != null) {
    //       AALog("错误response ${error.response}");

    //       // 处理响应错误
    //     } else {
    //       // 处理请求设置或发送中触发的错误
    //       AALog("错误 $error");
    //     }
    //     return handler.next(error);
    //   },
    // ));
  }

  /// get 请求
  Future<dynamic> get(
    //相对于基地址 的请求路径
    String url, {
    //参数配置
    Map<String, dynamic>? params,
    //选项
    Options? options,
    //成功的返回
    Success? onSuccess,
    //失败的返回
    Failure? onFailure,
    //这个参数是可以取消请求操作
    CancelToken? cancelToken,
    //发送或接收数据时的进度监听回调类型。
    ProgressCallback? onReceiveProgress,
  }) async {
    EasyLoading.show(status: 'loading...');
    Options requestOptions = options ?? Options();
    Response? response = await _dio.get(
      url,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    var _data;
    if (response.data.runtimeType == String) {
      _data = jsonDecode(response.data);
    } else {
      _data = response.data;
    }
    EasyLoading.dismiss();

    if (_data != null) {
      onSuccess?.call(_data);
      EasyLoading.dismiss();

      return {'type': 'success', 'content': _data};
    } else {
      onFailure?.call(_data);
      EasyLoading.dismiss();

      return {'type': 'failure', 'content': _data};
    }
  }

  /// post 请求
  Future<dynamic> post(
    String url, {
    // required Map<String, String> params,
    dynamic params, //参数配置 //post传入的参数是data里面 相当于body
    Options? options, //选项
    //成功的返回
    Success? onSuccess,
    //失败的返回
    Failure? onFailure,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    //这个参数是可以取消请求操作
  }) async {
    // EasyLoading.show(status: 'loading...');

    var requestOptions = options ?? Options();
    Response response = await _dio.post(
      url,
      data: params,
      // queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    var _data;
    if (response.data.runtimeType == String) {
      _data = jsonDecode(response.data);
    } else {
      _data = response.data;
    }
    if (_data["code"] != "200") {
      showToastCenter(_data["message"]);
      return;
    }
    if (_data != null) {
      onSuccess?.call(_data);
      EasyLoading.dismiss();

      return {'type': 'success', 'content': _data};
    } else {
      onFailure?.call(_data);
      EasyLoading.dismiss();
      return {'type': 'failure', 'content': _data};
    }
  }

  /// put 请求
  Future<Response> put(
    String url, {
    dynamic data, //参数配置
    Options? options, //选项
    CancelToken? cancelToken, //这个参数是可以取消请求操作
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.put(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// delete 请求
  Future<Response> delete(
    String url, {
    dynamic data, //参数配置
    Options? options, //选项
    CancelToken? cancelToken, //这个参数是可以取消请求操作
  }) async {
    var requestOptions = options ?? Options();
    Response response = await _dio.delete(
      url,
      data: data ?? {},
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }
}

/// 拦截请求头
class RequestInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //加这个初始化报错 要去掉
    // 加入 token
    // http header 头加入 Authorization
    // if (UserService.to.hasToken) {
    // options.headers['token'] = '${UserService.to.token}';
    // options.headers['authorization'] = 'token';
    // }R
    // AALog("请求头拦截:${options.headers}");
    // options.headers['token'] = 'token';
    String token = await Storage.getString(kSharedPreferencesUserToken);
    AALog("请求头拦截:${options.headers}");
    if (token.isNotEmpty) {
      options.headers['token'] = token;
    }
    AALog("请求头拦截:${options.headers}");

    return super.onRequest(options, handler); //handler.next(options);
  }

  // 响应
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // AALog("responseresponse :$response");
    int? statusCode = response.statusCode;
    var requestData = response.data;

    // if (statusCode == 200) {
    //   try {
    //     if (response.headers[Headers.contentTypeHeader] !=
    //             Headers.jsonContentType &&
    //         response.data is String) {
    //       var json = const JsonCodec();
    //       requestData = json.decode(response.data);
    //       AALog("requestData $requestData");
    //     }
    //     // 接口成功
    //     handler.next(response);
    //     if ("401" == requestData['code']) {
    //       // sendStream(StreamType.logout);
    //     }
    //   } catch (e) {}
    // } else if (statusCode == 401) {
    //   // sendStream(StreamType.logout);
    // } else {
    //   handler.next(response);
    // }

    // 200 请求成功, 201 添加成功

    if (response.statusCode != 200 && response.statusCode != 201) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
        true,
      );
    } else {
      return handler.next(response);
    }
  }

  /// 错误
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final exception = HttpException(err.message ?? "error message");
    AALog("exception:$exception");
    switch (err.type) {
      case DioExceptionType.badResponse: // 服务端自定义错误体处理
        {
          final response = err.response;
          AALog("response $response");
          final errorMessage = ErrorMessageModel.fromJson(response?.data);
          switch (errorMessage.code) {
            // 401 未登录
            case 401:
              // 注销 并跳转到登录页面
              // _errorNoAuthLogout();
              break;
            case 404:
              break;
            case 500:
              break;
            case 502:
              break;
            default:
              break;
          }
          // 显示错误信息
          if (errorMessage.message != null) {
            showToastCenter(errorMessage.message!);
          }
        }
        break;
      case DioExceptionType.unknown:
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionTimeout:
        break;
      default:
        break;
    }
    DioException errNext = err.copyWith(
      error: exception,
    );
    return handler.next(errNext);
  }
}
