import 'package:aidog/app/common/global_color.dart';
import 'package:aidog/app/common/global_size.dart';
import 'package:aidog/app/common/log_extern.dart';
import 'package:aidog/app/common/screenAdapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<CustomDropdownMenuItem> items;
  final Widget? headerSuffix;
  final void Function(int index) onTap;

  const CustomDropdownMenu({
    super.key,

    /// 多个标签
    required this.items,

    ///按钮右面控件
    this.headerSuffix,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _DropdownMenuHeader(
      onTap: (index) {
        //计算从什么地方弹出
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox == null) return;
        final offset = renderBox.localToGlobal(renderBox.paintBounds.topLeft);
        final rect = offset & renderBox.paintBounds.size;
        //点击弹出界面
        Navigator.of(context).push(_DropdownMenuRoute(
          targetRect: rect,
          builder: (context, animation) => _DropdownMenuBody(
            animation: animation,
            headerRect: rect,
            items: items,
            currentIndex: index,
            headerSuffix: headerSuffix,
          ),
        ));
        onTap(index);
      },
      items: items,
      suffix: headerSuffix,
    );
  }
}

//单个标签创建
class CustomDropdownMenuItem {
  final String header;
  final bool isActive;
  final Widget? body;
  final void Function()? onTap;

  const CustomDropdownMenuItem({
    required this.header,
    this.isActive = false,
    this.body,
    this.onTap,
  });
}

///下拉菜单标题
class _DropdownMenuHeader extends StatelessWidget {
  final List<CustomDropdownMenuItem> items;
  final Widget? suffix;
  final int? currentIndex;
  final void Function(int index)? onTap;

  ///
  const _DropdownMenuHeader({
    required this.items,
    this.currentIndex,
    this.onTap,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final ws = <Widget>[];
    for (var index = 0; index < items.length; index++) {
      final item = items[index];
      final isActive = currentIndex == index || item.isActive;
      if (index != 0) ws.add(const SizedBox(width: 5));
      ws.add(Expanded(
        child: GestureDetector(
          onTap: item.onTap ?? () => onTap?.call(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: const ShapeDecoration(
              shape: StadiumBorder(),
              color: Colors.transparent,
              // color: Color(0xFFF5F6F7), //标签文字背景色
              // color: KTColor.amber, //标签文字背景色
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    item.header,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(32),
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? const Color(0xFF333333) //const Color(0xFFFF0000)
                          : const Color(0xFF333333),
                    ),
                  ),
                ),
                // if (item.onTap == null) const SizedBox(width: 3),
                // if (item.onTap == null)
                // Icon(
                //   CupertinoIcons.chevron_down,
                //   // Icons.chevron_down,
                //   color: isActive
                //       ? KTColor.green // const Color(0xFFFF0000)
                //       : const Color(0xFF979797),
                //   size: 12,
                // ),
                Transform.rotate(
                  angle: 3.14 / 2,
                  child: Image(
                    width: ScreenAdapter.width(30),
                    height: ScreenAdapter.width(20),
                    image: const AssetImage('assets/common_right_arrow.png'),
                  ),
                ),
                // Transform(
                //   transform: Matrix4.rotationY(3.14 * 2),
                //   alignment: Alignment.center,
                //   child: Image(
                //     width: ScreenAdapter.width(30),
                //     height: ScreenAdapter.width(20),
                //     image: const AssetImage('assets/common_right_arrow.png'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ));
    }
    if (suffix != null) {
      ws.add(const SizedBox(width: 5));
      ws.add(suffix!);
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      // decoration: const BoxDecoration(color: Colors.white),
      // decoration: const BoxDecoration(color: Colors.black),
      decoration: const BoxDecoration(color: Colors.transparent), //标签背景色

      child: Row(children: ws),
    );
  }
}

class _DropdownMenuBody extends StatefulWidget {
  final int currentIndex;
  final List<CustomDropdownMenuItem> items;
  final Rect headerRect;
  final Animation<double> animation;
  final Widget? headerSuffix;

  const _DropdownMenuBody({
    required this.currentIndex,
    required this.items,
    required this.animation,
    required this.headerRect,
    this.headerSuffix,
  });

  @override
  State<_DropdownMenuBody> createState() => _DropdownMenuBodyState();
}

class _DropdownMenuBodyState extends State<_DropdownMenuBody> {
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: SlideTransition(
              position: widget.animation.drive(Tween(
                begin: const Offset(0, -1),
                end: const Offset(0, 0),
              )),
              child: Container(
                clipBehavior: Clip.hardEdge,
                // margin: EdgeInsets.only(top: widget.headerRect.height),
                //展开页面 标题高度屏蔽
                // padding: EdgeInsets.only(top: widget.headerRect.height),

                decoration: const BoxDecoration(
                  color: Colors.white, //点开标签 又显示一次标签的背景
                  // color: Colors.brown,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                child: widget.items[_currentIndex].body,
              ),
            ),
          ),
          // _DropdownMenuHeader(
          //   currentIndex: _currentIndex,
          //   items: widget.items,
          //   suffix: widget.headerSuffix,
          //   onTap: (index) {
          //     if (_currentIndex == index) {
          //       Navigator.of(context).pop();
          //       return;
          //     }
          //     setState(() {
          //       _currentIndex = index;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}

//底部遮罩部分弹出的内容
class _DropdownMenuRoute extends PopupRoute<void> {
  final Rect targetRect;
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
  ) builder;

  _DropdownMenuRoute({
    required this.targetRect,
    required this.builder,
  });

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Dropdown menu';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context, animation);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    //AbsorbPointer:吸收点击
    return AbsorbPointer(
      absorbing: !animation.isCompleted, //是否吸收事件 按键被吸收无法点击
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            top: targetRect.bottom,
            child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: FadeTransition(
                opacity: animation,
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.5),
                  // color: Colors.red.withOpacity(0.5),
                ),
              ),
            ),
          ),
          //弹出的body内容
          Positioned(
            //这俩是根据item数量来显示宽度
            // left: targetRect.left,
            // width: targetRect.right - targetRect.left,
            left: 0,
            right: 0,

            top: targetRect.top + ScreenAdapter.width(70), //控制底部显示body的坐标
            bottom: 0,
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}




// class City {
//   String? name;
// }

// class CustomDropdownMenuRegion extends StatefulWidget {
//   final int? regionIndex;
//   final int? villageIndex;
//   final List<City> regionItems;
//   final Future<List<City>> Function(int regionIndex)? fetchVillageItems;
//   final void Function(int? regionIndex, int? villageIndex)? onChanged;

//   const CustomDropdownMenuRegion({
//     super.key,
//     required this.regionItems,
//     this.regionIndex,
//     this.villageIndex,
//     this.fetchVillageItems,
//     this.onChanged,
//   });

//   @override
//   State<CustomDropdownMenuRegion> createState() =>
//       _CustomDropdownMenuRegionState();
// }

// class _CustomDropdownMenuRegionState extends State<CustomDropdownMenuRegion> {
//   List<City> _villageList = [];
//   int? _regionIndex;
//   int? _villageIndex;

//   @override
//   void initState() {
//     _regionIndex = widget.regionIndex;
//     _villageIndex = widget.villageIndex;
//     _getVillageList();
//     super.initState();
//   }

//   Future<void> _getVillageList() async {
//     if (_regionIndex == null) return;
//     final result = await widget.fetchVillageItems?.call(_regionIndex!);
//     setState(() {
//       _villageList = result ?? [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 400,
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               itemBuilder: (BuildContext context, int index) {
//                 final item = widget.regionItems[index];
//                 final isActive = _regionIndex == index;
//                 return GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     setState(() {
//                       _regionIndex = index;
//                       _villageIndex = null;
//                     });
//                     _getVillageList();
//                     widget.onChanged?.call(_regionIndex, _villageIndex);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 16,
//                     ),
//                     child: Text(
//                       item.name ?? '',
//                       style: TextStyle(
//                         color: isActive ? const Color(0xFFFF0000) : null,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               itemCount: widget.regionItems.length,
//             ),
//           ),
//           const VerticalDivider(
//             width: 1,
//             color: Color(0xFFEEEEEE),
//           ),
//           Expanded(
//             flex: 3,
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               itemBuilder: (BuildContext context, int index) {
//                 final item = _villageList[index];
//                 final isActive = _villageIndex == index;
//                 return GestureDetector(
//                   behavior: HitTestBehavior.translucent,
//                   onTap: () {
//                     setState(() {
//                       _villageIndex = index;
//                     });
//                     widget.onChanged?.call(_regionIndex, _villageIndex);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 16,
//                     ),
//                     child: Text(
//                       item.name ?? '',
//                       style: TextStyle(
//                         color: isActive ? const Color(0xFFFF0000) : null,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               itemCount: _villageList.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomDropdownMenuActionBar extends StatelessWidget {
//   final EdgeInsetsGeometry? padding;
//   final void Function()? onReset;
//   final void Function()? onConfirm;

//   const CustomDropdownMenuActionBar({
//     super.key,
//     this.padding,
//     this.onReset,
//     this.onConfirm,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding ?? const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: onReset,
//             child: Container(
//               width: 120,
//               height: 44,
//               decoration: const ShapeDecoration(
//                 shape: StadiumBorder(
//                   side: BorderSide(width: 1, color: Color(0xFFDDDDDD)),
//                 ),
//               ),
//               alignment: Alignment.center,
//               child: const Text(
//                 '重置',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color(0xff666666),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: GestureDetector(
//               onTap: onConfirm,
//               child: Container(
//                 height: 44,
//                 decoration: const ShapeDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xffFE0000),
//                       Color(0xffEB2254),
//                     ],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   shape: StadiumBorder(),
//                 ),
//                 alignment: Alignment.center,
//                 child: const Text(
//                   '重置',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Color(0xffffffff),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }