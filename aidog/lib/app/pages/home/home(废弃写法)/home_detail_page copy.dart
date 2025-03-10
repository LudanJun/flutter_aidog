import 'package:aidog/app/common/asset_utils.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/home/widget/swiper_widget.dart';
import 'package:aidog/app/widget/pass_button.dart';
import 'package:flutter/material.dart';

class HomeDetailPage extends StatefulWidget {
  const HomeDetailPage({super.key});

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  List<String> imagArr = [
    imageUrl1,
    imageUrl2,
    imageUrl3,
    imageUrl4,
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //导航以下显示内容高度
    double contextHeight = ScreenAdapter.getScreenHeight() -
        ScreenAdapter.getStatusBarHeight() -
        49;
    return Scaffold(
      /*
      appBar: AppBar(
        leading: Container(
          color: Colors.amber,
        ),
        title: InkWell(
          onTap: () {
            AALog("点击了头像和名字");
          },
          child: Container(
            color: Colors.red,
            width: ScreenAdapter.width(650),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Spacer(),
                Container(
                  //设置裁切属性
                  width: ScreenAdapter.width(80),
                  height: ScreenAdapter.width(80),
                  child: CircleAvatar(
                    radius: ScreenAdapter.width(40),
                    backgroundImage: AssetImage(
                      AssetUtils.getAssetImagePNG('default_head_img'),
                    ),
                  ),
                ),
                SizedBox(width: padding_20),
                Container(
                  // color: Colors.orange,
                  child: Text(
                    '纸飞机',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenAdapter.fontSize(32),
                      color: KTColor.black,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: margin_10),
            width: ScreenAdapter.width(170),
            height: ScreenAdapter.width(60),
            child: OutlinedButton(
              onPressed: () {
                AALog("了解主人");
              },
              style: OutlinedButton.styleFrom(
                // 设置内边距为较小的值，例如上下0像素，左右4像素
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 0,
                ),

                side: const BorderSide(
                  width: 1,
                  color: KTColor.color_251_98_64,
                ),
              ),
              child: Text(
                '了解主人',
                style: TextStyle(
                    fontSize: ScreenAdapter.fontSize(24),
                    fontWeight: FontWeight.w600,
                    color: KTColor.color_251_98_64),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: ScreenAdapter.width(280),
        child: PassButton(
          text: '私信',
          onPressed: () {
            AALog('私信');
          },
        ),
      ),
      */
      body: Stack(
        children: [
          
        ],
      )
      
      /*
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              height: ScreenAdapter.height(782),
              child: SwiperWidget(imagStrList: imagArr),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenAdapter.width(68)),
                  topRight: Radius.circular(ScreenAdapter.width(68)),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  ScreenAdapter.width(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "哈尼丨寻找代遛",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(48),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            AALog("点击了心");
                          },
                          icon: Image(
                            image: AssetImage(
                              AssetUtils.getAssetImagePNG('home_detail_heart'),
                            ),
                            width: ScreenAdapter.width(52),
                            height: ScreenAdapter.width(52),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: padding_5,
                    ),
                    Text(
                      '8个月|母|已注射疫苗',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenAdapter.fontSize(28),
                        color: KTColor.color_76_76_76,
                      ),
                    ),
                    SizedBox(
                      height: padding_10,
                    ),
                    Text(
                      '国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺温顺国庆节放假，小狗求陪玩七天，性格非常温顺温顺国庆节放假，小狗求陪玩七天，性格非常温顺hahahahhahahahah',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenAdapter.fontSize(36),
                        color: KTColor.black,
                      ),
                    ),
                    SizedBox(
                      height: ScreenAdapter.height(37),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image(
                                image: AssetImage(
                                  AssetUtils.getAssetImagePNG(
                                      'home_detail_location_grey'),
                                ),
                                width: ScreenAdapter.width(17),
                                height: ScreenAdapter.height(21),
                              ),
                              Text('郑州市 金水区 东方国际花园小区'),
                            ],
                          ),
                          Text('1.8Km'),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Container(
                    //       width: ScreenAdapter.width(280),
                    //       child: PassButton(
                    //         text: '私信',
                    //         onPressed: () {
                    //           AALog('私信');
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),*/
      /*
      body: SingleChildScrollView(
        child: Container(
          color: KTColor.color_252,
          // height: contextHeight + 500,
          height: ScreenAdapter.getScreenHeight(),
          child: Stack(
            children: [
              //1.轮播图
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.amber,
                  height: ScreenAdapter.height(782),
                  child: SwiperWidget(imagStrList: imagArr),
                ),
              ),
              //2.内容
              Positioned(
                left: 0,
                right: 0,
                top: ScreenAdapter.height(782 - 98),
                child: 
                Container(
                  // height: ScreenAdapter.height(600),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenAdapter.width(68)),
                      topRight: Radius.circular(ScreenAdapter.width(68)),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      ScreenAdapter.width(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "哈尼丨寻找代遛",
                              style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(48),
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                AALog("点击了心");
                              },
                              icon: Image(
                                image: AssetImage(
                                  AssetUtils.getAssetImagePNG(
                                      'home_detail_heart'),
                                ),
                                width: ScreenAdapter.width(52),
                                height: ScreenAdapter.width(52),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: padding_5,
                        ),
                        Text(
                          '8个月|母|已注射疫苗',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenAdapter.fontSize(28),
                            color: KTColor.color_76_76_76,
                          ),
                        ),
                        SizedBox(
                          height: padding_10,
                        ),
                        Text(
                          '国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺国庆节放假，小狗求陪玩七天，性格非常温顺温顺国庆节放假，小狗求陪玩七天，性格非常温顺温顺国庆节放假，小狗求陪玩七天，性格非常温顺hahahahhahahahah',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenAdapter.fontSize(36),
                            color: KTColor.black,
                          ),
                        ),
                        SizedBox(
                          height: ScreenAdapter.height(37),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      AssetUtils.getAssetImagePNG(
                                          'home_detail_location_grey'),
                                    ),
                                    width: ScreenAdapter.width(17),
                                    height: ScreenAdapter.height(21),
                                  ),
                                  Text('郑州市 金水区 东方国际花园小区'),
                                ],
                              ),
                              Text('1.8Km'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                right: ScreenAdapter.width(padding_30),
                bottom: ScreenAdapter.width(padding_20),
                child:
                 Container(
                  width: ScreenAdapter.width(280),
                  child: PassButton(
                    text: '私信',
                    onPressed: () {
                      AALog('私信');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      */
    );
  }
}
