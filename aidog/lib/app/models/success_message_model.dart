/**
 * 具体模型根据具体项目返回参数来确定
 */

/// 错误体信息
// class SuccessMessageModel {
//   String? code;
//   String? success;
//   String? message;
//   String? data;
//   SuccessMessageModel({this.code, this.success, this.message, this.data});

//   factory SuccessMessageModel.fromJson(Map<String, dynamic> json) {
//     return SuccessMessageModel(
//       code: json['code'] as String?,
//       success: json['success'] as String?,
//       message: json['message'] as String?,
//       data: json['data'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'code': code,
//         'success': success,
//         'message': message,
//         'data': data,
//       };
// }

class SuccessMessageModel {
  String? code;
  String? message;
  dynamic data;
  bool? success;

  SuccessMessageModel({this.code, this.message, this.data, this.success});

  SuccessMessageModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    data['data'] = data;
    data['success'] = success;
    return data;
  }
}
