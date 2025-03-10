import 'dart:io';

import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///带参数回调
typedef NormalParamCallback = Function(dynamic param);

//回调多个数据
typedef NormalListParamCallback = Function(List<XFile> param);

class ChoeseImageTool {
  //私有构造函数
  ChoeseImageTool._privateConstructor();

  //实例化一个静态对象
  static final ChoeseImageTool _instance =
      ChoeseImageTool._privateConstructor();
  //公共 getter 方法读取
  factory ChoeseImageTool() => _instance;

  ///实例化图片选择器
  final ImagePicker _picker = ImagePicker();
  // //定义全局获取的图片属性 来实现显示
  // XFile? _pickedFile;
  // String getHeadImgUrl = '';

  ///底部弹框
  void bottomSheet(BuildContext context, NormalParamCallback) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: ScreenAdapter.width(300),
          child: Center(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    "相册",
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    pickGallery(
                      (param) {
                        AALog("相册:$param ");
                        NormalParamCallback(param);
                      },
                    );

                    // mulpickGallery((list) {
                    //   AALog(list);
                    // });
                    // mulpickGalleryAndVideo((list) {
                    //   AALog(list);
                    // });
                    Navigator.of(context).pop("相册");
                  },
                ),
                ListTile(
                  title: const Text(
                    "拍照",
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    pickCamera((param) {
                      AALog("拍照:$param ");
                      NormalParamCallback(param);
                    });
                    Navigator.of(context).pop("拍照");
                  },
                ),
                // ListTile(
                //   title: const Text(
                //     "拍视频",
                //     textAlign: TextAlign.center,
                //   ),
                //   onTap: () {
                //     pickVideo((param) {
                //       AALog("视频:$param");
                //       NormalParamCallback(param);
                //     });
                //     Navigator.of(context).pop("视频");
                //   },
                // )
              ],
            ),
          ),
        );
      },
    );
  }

  //相册选择 只能选择一张图片
  void pickGallery(NormalParamCallback) async {
    //获取选择的照片
    XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        //默认选择的图片很大 需要指定下宽高
        maxWidth: 800,
        maxHeight: 800);
    print(image);
    if (image != null) {
      // AALog(image.path);
      NormalParamCallback(image.path);
      //选择完图片 开始上传

      // _uploadImageFile(image.path);
      // setState(() {
      //   // _pickedFile = image;
      // });
    }
  }

  //media 这个是视频和图片都可以选择 但是只能选择一张或一个视频
  void _pickMedia() async {
    //获取选择的照片
    XFile? image = await _picker.pickMedia(maxWidth: 800, maxHeight: 800);
    print(image);
    if (image != null) {
      print("_pickMedia${image.path}");
    }
  }

  //选择多个图像和视频
  void mulpickGalleryAndVideo(NormalListParamCallback) async {
    //获取多张图片
    List<XFile> medias = await _picker.pickMultipleMedia(
      limit: 2,
    );
    if (medias.length != 0) {
      print(medias);
      NormalListParamCallback(medias);
    }
  }

  //选择多个图片
  void mulpickGallery(NormalListParamCallback) async {
    //获取多张图片
    List<XFile> medias = await _picker.pickMultiImage(
      limit: 2, //最多选择2张
    );
    if (medias.length != 0) {
      print(medias.length);
      NormalListParamCallback(medias);
    }
  }

  //拍照 拍摄一张图片
  void pickCamera(NormalParamCallback) async {
    //获取拍的照片
    XFile? image = await _picker.pickImage(
        //指定选择图片的类型
        source: ImageSource.camera,
        //默认选择的图片很大 需要指定下宽高
        maxWidth: ScreenAdapter.width(200),
        maxHeight: ScreenAdapter.width(200));
    AALog(image as Object);
    if (image != null) {
      // print(image.path);
      NormalParamCallback(image.path);

      //选择完图片 开始上传
      // _uploadImageFile(image.path);
      // setState(() {
      //   // _pickedFile = image;
      // });
    }
  }

  void pickVideo(NormalParamCallback) async {
    //拍摄视频
    XFile? video = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(
        //拍摄30秒
        seconds: 30,
      ),
    );
    AALog(video as Object);
    if (video != null) {
      NormalParamCallback(video.path);
    }
  }
}
