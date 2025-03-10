class MyUserInfoModel {
  String? code;
  String? message;
  Data? data;
  bool? success;

  MyUserInfoModel({this.code, this.message, this.data, this.success});

  MyUserInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? phone;
  String? nickname;
  int? role;
  String? gender;

  /// 身份 1=学生党 2=上班族 3=自由职业
  String? identity;
  String? experience;
  String? mode;
  Address? address;
  String? avatar;
  List<Photos>? photos;
  String? age;
  String? school;
  String? occupation;
  String? email;
  String? lastTime;
  String? description;
  bool? isOpen;
  bool? isAuthenticated;
  ///根据dagid判断 是否有没有狗狗  0:代表没有
  int? dogId;

  ///身份
  // get identityTostring {
  //   if (identity == "1") {
  //     return "学生党";
  //   } else if (identity == "2") {
  //     return "上班族";
  //   } else if (identity == "3") {
  //     return "自由职业";
  //   }
  // }

  // ///养狗经验
  // get experienceToString {
  //   if (experience == "1") {
  //     return "无经验";
  //   } else if (experience == "2") {
  //     return "新手";
  //   } else if (experience == "3") {
  //     return "老手";
  //   }
  // }

  // get modeTostring {
  //   if (mode == "1") {
  //     return '遛狗';
  //   } else if (mode == "2") {
  //     return "帮养";
  //   } else if (mode == "3") {
  //     return "两者均可";
  //   }
  // }

  Data({
    this.phone,
    this.nickname,
    this.role,
    this.gender,
    this.identity,
    this.experience,
    this.mode,
    this.address,
    this.avatar,
    this.photos,
    this.age,
    this.school,
    this.occupation,
    this.email,
    this.lastTime,
    this.description,
    this.isOpen,
    this.isAuthenticated,
    this.dogId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    nickname = json['nickname'];
    role = json['role'];
    gender = json['gender'];
    identity = json['identity'];
    experience = json['experience'];
    mode = json['mode'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    avatar = json['avatar'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    age = json['age'];
    school = json['school'];
    occupation = json['occupation'];
    email = json['email'];
    lastTime = json['lastTime'];
    description = json['description'];
    isOpen = json['isOpen'];
    isAuthenticated = json['isAuthenticated'];
    dogId = json['dogId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['nickname'] = this.nickname;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['identity'] = this.identity;
    data['experience'] = this.experience;
    data['mode'] = this.mode;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['avatar'] = this.avatar;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['age'] = this.age;
    data['school'] = this.school;
    data['occupation'] = this.occupation;
    data['email'] = this.email;
    data['lastTime'] = this.lastTime;
    data['description'] = this.description;
    data['isOpen'] = this.isOpen;
    data['isAuthenticated'] = this.isAuthenticated;
    data['dogId'] = this.dogId;
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
