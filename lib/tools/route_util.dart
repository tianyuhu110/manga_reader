import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
class RouteUtil {
  RouteUtil._();
//设置appRoute的默认值为/data/user/0/com.example.manga_reader/app_flutter
  static String appRoute = "/data/user/0/com.example.manga_reader/app_flutter";


  
  static String? repositoryRoute;
  static String? repositoryName = "漫画";
  static void init() async{
    Directory directory = await getApplicationDocumentsDirectory();
    appRoute = directory.path;
  }
}