import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
class RouteUtil {
  RouteUtil._();

  // static String appRoute = "/data/user/0/com.example.manga_reader/app_flutter";
  //现在使用AppPreferences.repositoryName获取仓库名
  static String appRoute="";
    static Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    appRoute = directory.path;
  }
}