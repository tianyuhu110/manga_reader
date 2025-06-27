import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:manga_reader/servers/chapter.dart';

class Comic {
  String name;
  String route;
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
        String chapterPath = file.path;
        String chapterName = chapterPath.split('/').last;
        chapters.add(Chapter(chapterName, chapterPath));
      }
    }
  }

  ///生成自己的json
  Map<String, dynamic> toJson() {
    return {'name': name, 'route': route, 'chapters': chapters};
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
