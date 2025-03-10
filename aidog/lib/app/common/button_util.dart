/*
  里面传入的是方法
  使用:onPressed:ButtonUtils.debounce(provider.onObscureText),
*/
class ButtonUtils {
  /*防止重复点击方法*/
  static debounce(Function fn, {int t = 1000}) {
    int timeOld = 0;
    return () {
      int timeNew = DateTime.timestamp().millisecondsSinceEpoch;
      if (timeNew - timeOld < t) {
        return;
      }
      fn();
      timeOld = timeNew;
    };
  }
}
