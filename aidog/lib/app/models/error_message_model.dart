/**
 * 具体模型根据具体项目返回参数来确定
 */

/// 错误体信息
class ErrorMessageModel {
  String? code;
  String? success;
  String? message;
  dynamic data;
  ErrorMessageModel({this.code, this.success, this.message, this.data});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      code: json['code'],
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': data,
      };
}
