class HomeHelpModel {
  String? code;
  String? message;
  Data? data;
  bool? success;

  HomeHelpModel({this.code, this.message, this.data, this.success});

  HomeHelpModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? count;
  int? pageSize;
  int? pageNum;
  int? totalPage;
  List<HelpListItemModel>? list;

  Data({this.count, this.pageSize, this.pageNum, this.totalPage, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pageSize = json['pageSize'];
    pageNum = json['pageNum'];
    totalPage = json['totalPage'];
    if (json['list'] != null) {
      list = <HelpListItemModel>[];
      json['list'].forEach((v) {
        list!.add(new HelpListItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['pageSize'] = this.pageSize;
    data['pageNum'] = this.pageNum;
    data['totalPage'] = this.totalPage;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HelpListItemModel {
  int? id;
  String? nickname;
  String? gender;
  String? mode;
  String? avatar;
  Address? address;
  double? distance;
  String? photo;
  String? description;
  String? lastTime;

  HelpListItemModel(
      {this.id,
      this.nickname,
      this.gender,
      this.mode,
      this.avatar,
      this.address,
      this.distance,
      this.photo,
      this.description,
      this.lastTime});

  HelpListItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    gender = json['gender'];
    mode = json['mode'];
    avatar = json['avatar'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    distance = json['distance'];
    photo = json['photo'];
    description = json['description'];
    lastTime = json['lastTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['gender'] = this.gender;
    data['mode'] = this.mode;
    data['avatar'] = this.avatar;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['distance'] = this.distance;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['lastTime'] = this.lastTime;
    return data;
  }
}

class Address {
  String? address;
  String? distance;
  String? city;
  String? level;
  String? district;
  String? latitude;
  String? description;
  String? longitude;

  Address(
      {this.address,
      this.distance,
      this.city,
      this.level,
      this.district,
      this.latitude,
      this.description,
      this.longitude});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    distance = json['distance'];
    city = json['city'];
    level = json['level'];
    district = json['district'];
    latitude = json['latitude'];
    description = json['description'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['distance'] = this.distance;
    data['city'] = this.city;
    data['level'] = this.level;
    data['district'] = this.district;
    data['latitude'] = this.latitude;
    data['description'] = this.description;
    data['longitude'] = this.longitude;
    return data;
  }
}
