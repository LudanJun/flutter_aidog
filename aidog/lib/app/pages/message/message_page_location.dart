import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/permission_utils.dart';
import 'package:aidog/app/widget/dialog/ios_dialog/dialog_manager.dart';
import 'package:aidog/app/widget/dialog/show_dialog_alert.dart';
import 'package:aidog/app/widget/dialog/ios_dialog/show_ios_dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  ///纬度
  String _latitude = "";

  ///经度
  String _longitude = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // GlobalLocationTool().startLocation((map) {
    //   AALog(map);
    //   setState(() {
    //     _latitude = map["latitude"].toString();
    //     _longitude = map["longitude"].toString();
    //   });
    // });

    // GlobalLocationTool().locationResultListen((map) {
    //   AALog("监听的定位信息:$map");
    //   setState(() {
    //     _latitude = map["latitude"].toString();
    //     _longitude = map["longitude"].toString();
    //   });
    // });
  }

  @override
  void dispose() {
    // GlobalLocationTool().destroyLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("消息导航"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text('纬度: $_latitude'),
            Text('经度: $_longitude'),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // PermissionUtils.checkSelfPermission(
                //   Permission.location,
                //   onSuccess: () {
                //     AALog("成功");
                //     // GlobalLocationTool().startLocation((map) {
                //     //   AALog("aaaa$map");
                //     // });
                //   },
                //   onFailed: () {
                //     AALog("失败");
                //   },
                //   onOpenSetting: () {
                //     AALog("去设置");
                //   },
                // );
                // GlobalLocationTool().startLocationInfo();
              },
              child: Text('开始定位'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("拍照选择"),
            ),
          ],
        ),
      ),
    );
  }
}
