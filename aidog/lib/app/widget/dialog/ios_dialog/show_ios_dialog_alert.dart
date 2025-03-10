import 'package:aidog/app/common/global_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ShowIosDialogAlert extends StatelessWidget {
  final String title;
  final String content;
  final String content1;
  final String content2;
  final String license;
  final String policy;
  final String btnOK;
  final String btnCancel;
  final Function? onOKClick;
  final Function? onCancelClick;
  final Function? onLicenseClick;
  final Function? onPolicyClick;
  final bool showOnlyContent;

  const ShowIosDialogAlert({
    super.key,
    required this.title,
    required this.content,
    required this.content1,
    required this.content2,
    required this.license,
    required this.policy,
    required this.btnOK,
    required this.btnCancel,
    this.onOKClick,
    this.onCancelClick,
    this.onLicenseClick,
    this.onPolicyClick,
    this.showOnlyContent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.red,
      child: ConstrainedBox(
        //约束盒子
        constraints: const BoxConstraints(minWidth: 280),
        child: Container(
          decoration: BoxDecoration(
            color: KTColor.containerColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: KTColor.titleImp,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                //内容
                child: Container(
                  // color: Colors.blue,
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        !showOnlyContent
                            ? RichText(
                                text: TextSpan(
                                  text: content1,
                                  style: const TextStyle(
                                    height: 1.5,
                                    color: KTColor.titleImp,
                                    fontSize: 12,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: license,
                                        style: const TextStyle(
                                            color: KTColor.green,
                                            fontSize: 12),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            onLicenseClick?.call();
                                          }),
                                    const TextSpan(
                                      text: '与',
                                    ),
                                    TextSpan(
                                        text: policy,
                                        style: const TextStyle(
                                            color: KTColor.green,
                                            fontSize: 12),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            onPolicyClick?.call();
                                          }),
                                    TextSpan(
                                      text: content2,
                                    ),
                                  ],
                                ),
                              )
                            : Text(content,
                                style: const TextStyle(
                                    color: KTColor.titleImp, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
              //横线
              Divider(
                height: 2.0,
                color: KTColor.back2,
              ),
              SizedBox(
                height: 60.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CupertinoButton(
                        child: Text(
                          btnCancel,
                          style: const TextStyle(color: KTColor.darkGray),
                        ),
                        onPressed: () {
                          onCancelClick?.call();
                        },
                      ),
                    ),

                    /// 竖线
                    VerticalDivider(
                      width: 2.0,
                      color: KTColor.back2,
                    ),
                    Expanded(
                      flex: 1,
                      child: CupertinoButton(
                        child: Text(
                          btnOK,
                          style: const TextStyle(color: KTColor.green),
                        ),
                        onPressed: () {
                          onOKClick?.call();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
