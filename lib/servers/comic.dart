import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:manga_reader/servers/chapter.dart';

class Comic {
  String name;
  String route;
  String cover = '';
  List<Chapter> chapters = [];
  Comic(this.name, this.route);

  void pickCover() {
    try {
      cover = chapters[0].imgRoutes[0];
    } catch (e) {
      throw ("获取封面失败：$e");
    }
  }

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

    ///设置封面
    pickCover();
  }

  ///生成自己的json
  Map<String, dynamic> toJson() {
    return {'name': name, 'route': route, 'cover': cover, 'chapters': chapters};
  }

  ///解析一个json
  static Comic fromJson(Map<String, dynamic> json) {
    Comic comic = Comic(json['name'], json['route']);
    if (json['chapters'] != null) {
      comic.chapters = json['chapters'];
    }
    return comic;
  }
}
