import 'package:aidog/app/common/global_location_tool.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/permission_utils.dart';
import 'package:aidog/app/pages/home/widget/dropdown_menu_hou.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
          ],
        ),
      ),
    );
  }
}
