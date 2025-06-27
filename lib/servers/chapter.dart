import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class Chapter {
  String name;
  String route;
  List<String> imgRoutes = [];
  Chapter(this.name, this.route);

  ///Chapter:[]

  Future<void> scanRoute() async {
    Directory routeDir = Directory(route);
    if (!await routeDir.exists()) {
      print("目录不存在!");
      return;
    }
    Stream<FileSystemEntity> routeFiles = routeDir.list(recursive: false);
    await for (FileSystemEntity file in routeFiles) {
      if (file is File && isImageFile(file)) {
        imgRoutes.add(file.path);
      }
    }
    imgRoutes.sort();
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
