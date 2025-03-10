import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_options.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/global_style.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ValueChanged<T> = void Function(T value);

class ShowBottomSheetTool {
  late final ValueChanged<String>? onChanged;

  static bottomSheet(
      BuildContext context, List<String> contentList, onChanged) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: contentList.length.toDouble() * ScreenAdapter.height(50) +
              contentList.length.toDouble() * ScreenAdapter.height(38) +
              padding_20,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: contentList.map(
                (value) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop(value);
                      onChanged(value);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(padding_10),
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              value,
                              style: HooTextStyle.titleS32W6CBlackStyle,
                            ),
                            SizedBox(
                              height: padding_30,
                            ),
                            // Divider(
                            //   height: 1,
                            //   color: KTColor.color_164,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // ListTile(
                  //   title: Text(value),
                  //   titleAlignment: ListTileTitleAlignment.center,
                  //   onTap: () {
                  //     Navigator.of(context).pop(value);
                  //     onChanged(value);
                  //   },
                  // );
                },
              ).toList(),
            ),

            //  ListView(
            //   children: contentList.map(
            //     (value) {
            //       return ListTile(
            //         title: Text(value),
            //         onTap: () {
            //           Navigator.of(context).pop(value);
            //         },
            //       );
            //     },
            //   ).toList(),
            // ),
          ),
        );
      },
    );
  }
}
