/// 创建一个简单单例计数器的 Singleton 类。
class CounterSingleton {
  // 私有构造函数 (_后面都是自己命名的)
  CounterSingleton._privateConstructor();

  //实例化一个静态对象 _instance
  static final CounterSingleton _instance =
      CounterSingleton._privateConstructor();

  //公共 getter 方法读取类实例 _instance
  static CounterSingleton get instance => _instance;

  //类属性
  int counter = 0;

  //类方法
  void increment() {
    counter++;
  }
}

/*
  创建一个懒加载模式的单例

*/
class LazySingletion {
  // 私有构造函数 (_后面都是自己命名的)
  LazySingletion._privateConstructor();

  //实例化一个静态对象 _instance
  static LazySingletion? _instance;

  //公共 getter方法,访问时才去初始化实例
  static LazySingletion get instance {
    if (_instance == null) {
      _instance = LazySingletion._privateConstructor();
    }
    return _instance!;
  }

  //类属性
  int counter = 0;

  //类方法
  void increment() {
    counter++;
  }
}

//单例使用场景
//管理全局配置，如 api 配置、颜色、主题。
//全局配置单例类
class Config {
  //1.私有构造函数
  Config._privateConstructor();
  //实例化一个静态对象 _instance
  static final Config _instance = Config._privateConstructor();

  static Config get instance => _instance;

  String apiUrl = 'https://api.example.com';
  String appName = 'App Name';
}

//共享状态管理，如 购物车、用户状态、是否登录。
class UserSession {
  //1.私有构造函数
  UserSession._privateConstructor();
  //实例化一个静态对象 _instance
  static final UserSession _instance = UserSession._privateConstructor();

  //公共 getter 方法读取类实例 _instance
  static UserSession get instance => _instance;

  String? userId;
  bool get isLoggedIn => userId != null;
  
}
