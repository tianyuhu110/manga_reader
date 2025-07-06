import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:manga_reader/servers/comic.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manga_reader/tools/route_util.dart';
import 'package:path/path.dart' as path;

class Repository {
  String name = "";
  String route = "";
  List<Comic> comics = [];

  ///返回的是一个Promise对象
  Future<void> selectRoute() async {
    String? result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      route = result;
      List<String> results = result.split("/");
      name = results[results.length - 1];
    }
  }

  void setName(String newName) {
    name = newName;
  }

  Future<void> scanRoute() async {
    Directory routeDir = Directory(route);

    ///print("根路径${routeDir.path}");
    if (!await routeDir.exists()) {
      print("目录不存在!");
      return;
    }
    Stream<FileSystemEntity> routeFiles = routeDir.list(recursive: false);
    await for (FileSystemEntity file in routeFiles) {
      print(file.path);
      if (file is Directory) {
        String comicPath = file.path;
        String comicName = comicPath.split('/').last;
        comics.add(Comic(comicName, comicPath));
      } else {
        print("不是文件夹：${file.path}");
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'route': route, 'comics': comics};
  }

  Future<void> thoroughScan() async {
    await scanRoute();
    for (var comic in comics) {
      await comic.scanRoute();
      for (var chapter in comic.chapters) {
        await chapter.scanRoute();
      }
    }
  }

  Future<bool> saveToJsonFile() async {
    try {
      String jsonData = JsonEncoder.withIndent('  ').convert(toJson());

      ///这里有点问题，没有appRoute为空的判断
      File configFile = File(
        path.join(RouteUtil.appRoute ?? '', '${name}_repository.json'),
      );
      await configFile.writeAsString(jsonData);

      debugPrint("仓库配置保存成功${configFile.path}");
      return true;
    } catch (e) {
      debugPrint("仓库配置保存失败：$e");
      return false;
    }
  }

  static Repository fromJson(Map<String, dynamic> json) {
    Repository repository = Repository();
    repository.name = json['name'];
    repository.route = json['route'];
    if (json['comics'] != null) {
      repository.comics = json['comics'];
    }
    return repository;
  }

  static Future<Map<String, dynamic>> loadRepository(String name) async {
    final jsonFile = File(
      path.join(RouteUtil.appRoute ?? '', '/${name}_repository.json'),
    );
    if (await jsonFile.exists()) {
      String jsonString = await jsonFile.readAsString();
      return jsonDecode(jsonString);
    }
    throw FileSystemException('文件不存在');
  }

  void addComic(Comic comic){
    comics.add(comic);
    thoroughScan();
    saveToJsonFile();
  }
}
