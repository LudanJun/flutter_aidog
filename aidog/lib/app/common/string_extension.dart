/*  字符串扩展 */
class StringExtension {
  /// 传入11位手机号
  /// eg:String phone = StringExtension.maskPhoneNumber("13838487652");
  static String maskPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceRange(3, 7, '******');
  }

  /// 以时间戳创建图片名字
  static String generateImageNameByDate() {
    // 获取当前日期并格式化为字符串
    final now = DateTime.now();
    final formattedDate =
        now.toIso8601String().replaceAll(':', '-').replaceAll('.', '-');
    return 'aidog_image_$formattedDate.png';
  }
}
