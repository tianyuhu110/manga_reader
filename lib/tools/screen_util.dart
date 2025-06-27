import 'package:flutter/material.dart';

/// 屏幕尺寸工具类
class ScreenUtil {
  // 私有构造函数，防止被实例化
  ScreenUtil._();
  
  // 静态变量
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double statusBarHeight;
  static late double bottomBarHeight;
  static late double appBarHeight;
  static late double pixelRatio;
  static late bool isLandscape;
  
  // 初始化方法
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    statusBarHeight = _mediaQueryData.padding.top;
    bottomBarHeight = _mediaQueryData.padding.bottom;
    appBarHeight = kToolbarHeight + statusBarHeight;
    pixelRatio = _mediaQueryData.devicePixelRatio;
    isLandscape = _mediaQueryData.orientation == Orientation.landscape;
  }
}