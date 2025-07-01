import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
class RouteUtil {
  RouteUtil._();

  static String? appRoute;

  static void init() async{
    Directory directory = await getApplicationDocumentsDirectory();
    appRoute = directory.path;
  }
}