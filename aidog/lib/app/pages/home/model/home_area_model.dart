class HomeAreaModel {
  String? code;
  String? message;
  List<String>? data;
  bool? success;

  HomeAreaModel({this.code, this.message, this.data, this.success});

  HomeAreaModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'].cast<String>();
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    data['success'] = this.success;
    return data;
  }
}
