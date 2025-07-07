import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Chapter {
  String name;
  String route;
  List<String> imgRoutes = [];
  Chapter(this.name, this.route);

  ///Chapter:[]

  Future<void> scanRoute() async {
    ///print("正在扫描$route");
    imgRoutes.clear();
    final routeDir = Directory(route);
    if (!await routeDir.exists()) {
      debugPrint("目录不存在!");
      return;
    }
    try {
      List<FileSystemEntity> allEntities = await routeDir
          .list(recursive: false)
          .toList();
      debugPrint("扫描到${allEntities.length}个文件或目录");
      

      for (FileSystemEntity entity in allEntities) {
        debugPrint("扫描路径:${entity.path}");
        if (entity is File && isImageFile(entity)) {
          imgRoutes.add(entity.path);
          debugPrint("添加$entity.path");
        }
      }
    } catch (e) {
      print("扫描出错$e");
    }
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'route': route, 'imgRoutes': imgRoutes};
  }

  static Chapter fromJson(Map<String, dynamic> json) {
    Chapter chapter = Chapter(json['name'], json['route']);
    if (json['imgRoutes'] != null) {
      chapter.imgRoutes = (json['imgRoutes'] as List).cast<String>();
    }
    return chapter;
  }

  bool isImageFile(File file) {
    final ext = file.path.split('.').last.toLowerCase();
    const imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'bmp',
      'webp',
      'tiff',
      'tif',
      'heic',
      'heif',
    ];

    return imageExtensions.contains(ext);
  }
}
