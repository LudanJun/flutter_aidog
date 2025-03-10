import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:aidog/app/pages/login/widget/picker.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

///宠主 - 爱犬档案资料填写
class LoginPetOwnerInfoPage extends StatefulWidget {
  const LoginPetOwnerInfoPage({super.key});

  @override
  State<LoginPetOwnerInfoPage> createState() => _LoginPetOwnerInfoPageState();
}

class _LoginPetOwnerInfoPageState extends State<LoginPetOwnerInfoPage> {
  //已选中图片列表
  List<AssetEntity> _selectAssets = [];
  //是否开始拖拽
  bool isDragNow = false;

  //是否将要删除
  bool isWillRemove = false;

  //是否将要排序
  bool isWillOrder = false;

  //被拖拽到的 target id
  String targetAssetId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加爱犬资料"),
        centerTitle: true,
        backgroundColor: KTColor.white,
      ),
      //如果屏幕上方显示一个屏幕键盘 脚手架，机身可以调整大小以避免与键盘重叠，这 防止键盘遮挡主体内部的小部件。
      resizeToAvoidBottomInset: true,
      backgroundColor: KTColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPhotoList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoList() {
    return Padding(
      padding: EdgeInsets.all(spacing),
      child: LayoutBuilder(
        builder: (context, constraints) {
          //设置每行显示3个
          final double width =
              (constraints.maxWidth - spacing * 2 - imagePadding * 2 * 3) / 3;
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              //图片
              //第一种循环写法
              for (final asset in _selectAssets)
                _buildPhotoItem(
                  asset,
                  width,
                ),

              //加入按钮
              if (_selectAssets.length < maxAssets)
                _buildAddBtn(context, width),
            ],
          );
        },
      ),
    );
  }

  //图片项
  Widget _buildPhotoItem(
    asset,
    double width,
    // int index,
  ) {
    //拖拽控件
    return Draggable<AssetEntity>(
      //此可拖动对象将删除的数据。
      data: asset,
      //当可拖动对象开始被拖动时调用。
      onDragStarted: () {
        setState(() {
          isDragNow = true;
        });
      },
      //当可拖动对象被放下时调用。
      onDragEnd: (details) {
        setState(() {
          isDragNow = false;
          isWillOrder = false;
        });
      },
      //当可拖动对象被放置并被 [DragTarget] 接受时调用。
      onDragCompleted: () {},
      //当可拖动对象未被 [DragTarget] 接受而被放置时调用。
      onDraggableCanceled: (velocity, offset) {
        setState(() {
          isDragNow = false;
          isWillOrder = false;
        });
      },
      //feedback:进行拖动时在指针下方显示的小部件。
      feedback: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        //显示跟手飘动的图片
        child: AssetEntityImage(
          asset,
          width: width,
          height: width,
          fit: BoxFit.cover,
          isOriginal: false,
        ),
      ),
      //当进行一次或多次拖动时要显示的小部件而不是 [child]。
      childWhenDragging: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenAdapter.width(3)),
        ),
        //默认的图片 为半透明
        child: AssetEntityImage(
          asset,
          width: width,
          height: width,
          fit: BoxFit.cover,
          isOriginal: false,
          //动画区间的一个透明度
          opacity: const AlwaysStoppedAnimation(0.3),
        ),
      ),

      child: DragTarget<AssetEntity>(
        builder: (context, candidateData, rejectedData) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   //直接调用控制器push
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return GalleryWidget(
              //         //indexOf:找到数组相应的值 返回对应的index
              //         initialIndex: _selectAssets.indexOf(asset),
              //         items: _selectAssets,
              //       );
              //     },
              //   ),
              // );
            },
            child: Container(
              //设置裁切属性
              clipBehavior: Clip.antiAlias,
              padding: (isWillOrder && targetAssetId == asset.id)
                  ? EdgeInsets.zero
                  : EdgeInsets.all(imagePadding),
              decoration: BoxDecoration(
                //设置完圆角度数后,需要设置裁切属性
                borderRadius: BorderRadius.circular(10),
                border: (isWillOrder && targetAssetId == asset.id)
                    ? Border.all(
                        color: Colors.amber,
                        width: imagePadding,
                      )
                    : null,
              ),
              child: Stack(
                children: [
                  
                  AssetEntityImage(
                    asset,
                    width: width,
                    height: width,
                    //设置了宽高显示还是不整齐 需要设置fit属性根据宽高裁切
                    fit: BoxFit.cover,
                    //是否显示原图
                    isOriginal: false,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey[200],
                        ),
                      ),
                      onPressed: () {
                        print("点击了");
                        setState(() {
                          //如果点击的在数组有就移除
                          _selectAssets.removeWhere((item) {
                            return item == asset;
                          });
                          print(_selectAssets.length);
                        });
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: ScreenAdapter.width(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        //将要拖拽到
        onWillAcceptWithDetails: (data) {
          setState(() {
            isWillOrder = true;
            targetAssetId = asset.id;
          });
          return true;
        },
        //接收
        onAcceptWithDetails: (details) {
          //从队列中删除拖拽对象
          final int index = _selectAssets.indexOf(details.data);
          _selectAssets.removeAt(index);
          //将拖拽对象插入到目标对象之前
          final int targetIndex = _selectAssets.indexOf(asset);
          _selectAssets.insert(targetIndex, details.data);
          setState(() {
            isWillOrder = false;
            targetAssetId = '';
          });
        },
        onLeave: (data) {
          setState(() {
            isWillOrder = false;
            targetAssetId = "";
          });
        },
      ),
    );
  }

  ///添加按钮
  Widget _buildAddBtn(BuildContext context, double width) {
    return InkWell(
      onTap: () async {
        AALog("+++");
        
        //  相册
        var result = await DuPicker.assets(context: context, maxAssets: 9);
        if (result == null) {
          return;
        }
        setState(() {
          // postType = PostType.image;
          //把拍摄图片加入到当前列表
          // _selectAssets = result;
          _selectAssets.addAll(result);
          AALog("选择的图片数量:${_selectAssets.length}");
          // 资产的相对路径抽象。
          // 安卓10及以上：MediaStore.MediaColumns.RELATIVE_PATH.
          // Android 9及以下： 的父路径MediaStore.MediaColumns.DATA.
          AALog(_selectAssets[0].file);

          // if (Platform.isIOS) {}
        });
        

        //视频
        // var result = await DuPicker.assetsVideo(context: context, maxAssets: 1);
        // if (result == null) {
        //   return;
        // }
        // setState(() {
        //   _selectAssets.addAll(result);
        //   AALog("选择的图片数量:${_selectAssets.length}");
        //   AALog(_selectAssets[0].file);
        // });

        ///拍摄
        // var result = await DuPicker.takePhoto(context);
        // if (result == null) {
        //   return;
        // }
        // setState(() {
        // // postType = PostType.image;
        //  _selectAssets = result as List<AssetEntity>;
        //   //把拍摄图片加入到当前列表
        //   _selectAssets.add(result);
        // });
      },
      child: Container(
        color: Colors.black12,
        width: width,
        height: width,
        child: Icon(
          Icons.add,
          size: ScreenAdapter.width(48),
          color: Colors.black38,
        ),
      ),
    );
  }
}
