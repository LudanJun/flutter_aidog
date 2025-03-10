/// 宠主 - 用户信息
class HomePetOwnerInfoModel {
  String? code;
  String? message;
  Data? data;
  bool? success;

  HomePetOwnerInfoModel({this.code, this.message, this.data, this.success});

  HomePetOwnerInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? identity;
  String? experience;
  String? mode;
  Address? address;
  String? avatar;
  String? age;
  String? school;
  String? occupation;
  String? email;
  String? lastTime;
  String? description;
  bool? isOpen;
  bool? isAuthenticated;

  // //获取图片数组
  // List<String> get photosArr {
  //   List<String> imgArr = [];
  //   for (var img in photos ?? []) {
  //     imgArr.add(img.fileUrl);
  //   }
  //   return imgArr;
  // }

  Data(
      {this.phone,
      this.nickname,
      this.role,
      this.gender,
      this.identity,
      this.experience,
      this.mode,
      this.address,
      this.avatar,
      this.age,
      this.school,
      this.occupation,
      this.email,
      this.lastTime,
      this.description,
      this.isOpen,
      this.isAuthenticated});

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
    age = json['age'];
    school = json['school'];
    occupation = json['occupation'];
    email = json['email'];
    lastTime = json['lastTime'];
    description = json['description'];
    isOpen = json['isOpen'];
    isAuthenticated = json['isAuthenticated'];
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
    data['age'] = this.age;
    data['school'] = this.school;
    data['occupation'] = this.occupation;
    data['email'] = this.email;
    data['lastTime'] = this.lastTime;
    data['description'] = this.description;
    data['isOpen'] = this.isOpen;
    data['isAuthenticated'] = this.isAuthenticated;
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
