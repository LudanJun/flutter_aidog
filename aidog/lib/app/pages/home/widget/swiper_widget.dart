import 'package:aidog/app/common/defalut_image.dart';
import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class SwiperWidget extends StatefulWidget {
  /// 传入图片数组
  final List<String> imagStrList;
  const SwiperWidget({super.key, required this.imagStrList});

  @override
  State<SwiperWidget> createState() => _SwiperWidgetState();
}

class _SwiperWidgetState extends State<SwiperWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: KTColor.getRandomColor(),
      // width: ScreenAdapter.getScreenWidth(),
      // height: ScreenAdapter.height(782),
      child: Swiper(
        onTap: (index) {
          AALog("点击了第$index张图");
        },
        itemCount: widget.imagStrList.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: widget.imagStrList[index],
            fit: BoxFit.cover,
            placeholder: (context, url) => defaultBannerImage(),
            errorWidget: (context, url, error) => defaultBannerImage(),
          );
        },
        //自定义分页指示器
        pagination: SwiperPagination(
          margin: EdgeInsets.only(bottom: ScreenAdapter.width(30)),
          builder: SwiperCustomPagination(
            builder: (BuildContext context, SwiperPluginConfig config) {
              return ConstrainedBox(
                constraints: BoxConstraints.expand(
                  height: ScreenAdapter.height(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: const DotSwiperPaginationBuilder(
                          color: Colors.white,
                          activeColor: KTColor.color_251_98_64,
                        ).build(context, config),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
