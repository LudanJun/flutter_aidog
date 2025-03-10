import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  ///切换的角色
  int _selectRoleValue = 0;
  int get selectRoleValue => _selectRoleValue;
  set selectRoleValue(int value) {
    _selectRoleValue = value;
    notifyListeners();
  }

  ///切换的身份
  String _selectIdentityValue = "";
  String get selectIdentityValue => _selectIdentityValue;
  set selectIdentityValue(String value) {
    _selectIdentityValue = value;
    notifyListeners();
  }

  ///切换的养狗经验
  String _selectDogExpValue = '';
  String get selectDogExpValue => _selectDogExpValue;
  set selectDogExpValue(String value) {
    _selectDogExpValue = value;
    notifyListeners();
  }

  ///切换的照顾方式
  String _selectZhaogufangshiValue = '';
  String get selectZhaogufangshiValue => _selectZhaogufangshiValue;
  set selectZhaogufangshiValue(String value) {
    _selectZhaogufangshiValue = value;
    notifyListeners();
  }

  ///////---宠主帮养信息---////////
  //存放 位置
  String _petAddressStr = '';
  String get petAddressStr => _petAddressStr;
  set petAddressStr(String address) {
    _petAddressStr = address;
    notifyListeners();
  }

  ///切换宠主身份
  String _selectPetIdentityValue = "";
  String get selectPetIdentityValue => _selectPetIdentityValue;
  set selectPetIdentityValue(String value) {
    _selectPetIdentityValue = value;
    notifyListeners();
  }

  ///宠主爱犬生日
  String _selectPetDogBirthdayValue = "";
  String get selectPetDogBirthdayValue => _selectPetDogBirthdayValue;
  set selectPetDogBirthdayValue(String value) {
    _selectPetDogBirthdayValue = value;
    notifyListeners();
  }

  ///切换的狗狗性别
  String _selectPetDogSexValue = '';
  String get selectPetDogSexValue => _selectPetDogSexValue;
  set selectPetDogSexValue(String value) {
    _selectPetDogSexValue = value;
    notifyListeners();
  }

  ///切换的狗狗狂犬疫苗情况
  String _selectPetDogKuangquanyimiaoValue = '';
  String get selectPetDogKuangquanyimiaoValue =>
      _selectPetDogKuangquanyimiaoValue;
  set selectPetDogKuangquanyimiaoValue(String value) {
    _selectPetDogKuangquanyimiaoValue = value;
    notifyListeners();
  }

  ///切换的狗狗照顾方式
  String _selectPetDogZhaogufangshiValue = '';
  String get selectPetDogZhaogufangshiValue => _selectPetDogZhaogufangshiValue;
  set selectPetDogZhaogufangshiValue(String value) {
    _selectPetDogZhaogufangshiValue = value;
    notifyListeners();
  }
}
