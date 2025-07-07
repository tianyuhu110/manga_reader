import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:manga_reader/servers/chapter.dart';

class Comic {
  String name;
  String route;
  String cover = '';
  List<Chapter> chapters = [];
  Comic(this.name, this.route);


  Future<void> scanRoute() async {
    Directory routeDir = Directory(route);
    if (!await routeDir.exists()) {
      print("目录不存在!");
      return;
    }
    Stream<FileSystemEntity> routeFiles = routeDir.list(recursive: false);
    await for (FileSystemEntity file in routeFiles) {
      if (file is Directory) {
        ///设置路径
        String chapterPath = file.path;

        ///设置名称
        String chapterName = chapterPath.split('/').last;

        ///设置章节对象
        chapters.add(Chapter(chapterName, chapterPath));
      }
    }


  }

  ///生成自己的json
  Map<String, dynamic> toJson() {
    return {'name': name, 'route': route, 'cover': cover, 'chapters': chapters};
  }


  static Comic fromJson(Map<String, dynamic> json) {
  Comic comic = Comic(json['name'], json['route']);
  if (json['chapters'] != null) {
    // 添加类型转换
    comic.chapters = (json['chapters'] as List)
        .map((chapterJson) => Chapter.fromJson(chapterJson))
        .toList();
  }
  return comic;
}

  //getCoverRoute方法，返回封面图片的路径，路径为漫画目录下第一个章节的第一张图片
  String getCoverRoute() {
    if (chapters.isNotEmpty && chapters[0].imgRoutes.isNotEmpty) {
      debugPrint("获取封面图片路径:${chapters[0].imgRoutes[0]}");
      return chapters[0].imgRoutes[0];
      
    }
    debugPrint("没有封面图片");
    return '';
  }
}
