import 'package:logger/logger.dart';

const String _tag = "aidog";

var _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
  ),
);

/// 跟踪日志
logT(dynamic msg) {
  _logger.t("$_tag : $msg");
}

/// 调试日志
logD(dynamic msg) {
  _logger.d("$_tag : $msg");
}

/// 信息日志
logI(dynamic msg) {
  _logger.i("$_tag : $msg");
}

/// 警告日志
logW(dynamic msg) {
  _logger.w("$_tag : $msg");
}

/// 错误日志
logE(dynamic msg) {
  _logger.e("$_tag : $msg");
}

/// 多么致命的日志
logF(dynamic msg) {
  _logger.f("$_tag : $msg");
}
