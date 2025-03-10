class HomeDetailModel {
  String? code;
  String? message;
  Data? data;
  bool? success;

  HomeDetailModel({this.code, this.message, this.data, this.success});

  HomeDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? avatar;
  String? masterNickname;
  String? nickname;
  String? age;
  String? birthday;
  String? gender;

  /// 宠主id
  int? masterUserId;

  /// 注射疫苗情况
  String? vaccine;
  String? mode;
  Address? address;
  List<Photos>? photos;
  double? distance;
  String? description;

  //获取图片数组
  List<String> get photosArr {
    List<String> imgArr = [];
    for (var img in photos ?? []) {
      imgArr.add(img.fileUrl);
    }
    return imgArr;
  }

  Data({
    this.id,
    this.avatar,
    this.masterNickname,
    this.nickname,
    this.age,
    this.birthday,
    this.gender,
    this.masterUserId,
    this.vaccine,
    this.mode,
    this.address,
    this.photos,
    this.distance,
    this.description,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    masterNickname = json['masterNickname'];
    nickname = json['nickname'];
    age = json['age'];
    birthday = json['birthday'];
    gender = json['gender'];
    masterUserId = json['masterUserId'];
    vaccine = json['vaccine'];
    mode = json['mode'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    distance = json['distance'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['masterNickname'] = this.masterNickname;
    data['nickname'] = this.nickname;
    data['age'] = this.age;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['masterUserId'] = this.masterUserId;
    data['vaccine'] = this.vaccine;
    data['mode'] = this.mode;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    data['description'] = this.description;

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

class Photos {
  String? fileUrl;
  int? sortOrder;

  Photos({this.fileUrl, this.sortOrder});

  Photos.fromJson(Map<String, dynamic> json) {
    fileUrl = json['fileUrl'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileUrl'] = this.fileUrl;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}
