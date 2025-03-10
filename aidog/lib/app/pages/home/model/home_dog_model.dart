///帮养人看宠主的界面数据
class HomeDogModel {
  String? code;
  String? message;
  Data? data;
  bool? success;

  HomeDogModel({this.code, this.message, this.data, this.success});

  HomeDogModel.fromJson(Map<String, dynamic> json) {
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
  List<DogListItemModel>? list;

  Data({this.count, this.pageSize, this.pageNum, this.totalPage, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pageSize = json['pageSize'];
    pageNum = json['pageNum'];
    totalPage = json['totalPage'];
    if (json['list'] != null) {
      list = <DogListItemModel>[];
      json['list'].forEach((v) {
        list!.add(DogListItemModel.fromJson(v));
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

class DogListItemModel {
  int? id;
  int? appUserId;
  String? avatar;
  String? nickname;
  String? masterNickname;
  String? age;
  String? birthday;
  String? gender;
  String? vaccine;
  String? mode; //照顾方式
  Address? address;
  double? distance;
  String? photo;
  String? description;
  String? lastTime;

  // get modeTostring {
  //   if (mode == 1) {
  //     return '遛狗';
  //   } else if (mode == 2) {
  //     return '帮养';
  //   } else {
  //     return '两者均可';
  //   }
  // }

  DogListItemModel(
      {this.id,
      this.appUserId,
      this.avatar,
      this.nickname,
      this.masterNickname,
      this.age,
      this.birthday,
      this.gender,
      this.vaccine,
      this.mode,
      this.address,
      this.distance,
      this.photo,
      this.description,
      this.lastTime});

  DogListItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appUserId = json['appUserId'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    masterNickname = json['masterNickname'];
    age = json['age'];
    birthday = json['birthday'];
    gender = json['gender'];
    vaccine = json['vaccine'];
    mode = json['mode'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    distance = json['distance'];
    photo = json['photo'];
    description = json['description'];
    lastTime = json['lastTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appUserId'] = this.appUserId;
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['masterNickname'] = this.masterNickname;
    data['age'] = this.age;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['vaccine'] = this.vaccine;
    data['mode'] = this.mode;
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
  String? province;
  String? city;
  String? streetNumber;
  String? street;
  String? district;
  String? latitude;
  String? description;
  String? longitude;

  Address(
      {this.address,
      this.province,
      this.city,
      this.streetNumber,
      this.street,
      this.district,
      this.latitude,
      this.description,
      this.longitude});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    province = json['province'];
    city = json['city'];
    streetNumber = json['streetNumber'];
    street = json['street'];
    district = json['district'];
    latitude = json['latitude'];
    description = json['description'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['province'] = this.province;
    data['city'] = this.city;
    data['streetNumber'] = this.streetNumber;
    data['street'] = this.street;
    data['district'] = this.district;
    data['latitude'] = this.latitude;
    data['description'] = this.description;
    data['longitude'] = this.longitude;
    return data;
  }
}
