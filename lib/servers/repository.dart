import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:manga_reader/servers/comic.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manga_reader/tools/route_util.dart';
import 'package:path/path.dart' as path;
import '../tools/route_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manga_reader/tools/AppPreferences.dart';

class Repository {
  String name = "";
  String route = "";
  List<Comic> comics = [];




  //增加了对是否选择文件夹的判断
  Future<bool> selectRoute() async {
  String? result = await FilePicker.platform.getDirectoryPath();
  if (result != null) {
    route = result;
    List<String> results = result.split("/");
    name = results[results.length - 1];
    return true; 
  }
  return false; 
}

  void setName(String newName) {
    name = newName;
  }


///该函数用于扫描仓库路径下的所有直接子目录（不递归）。
///每个子目录被视为一个漫画（Comic）并添加到`comics`列表中。
///它会检查仓库路径是否存在，如果不存在则打印错误信息。
///遍历过程中，如果遇到文件（而不是目录），则打印该文件路径（表示忽略文件）
  Future<void> scanRoute() async {
    Directory routeDir = Directory(route);

    ///print("根路径${routeDir.path}");
    if (!(await routeDir.exists())) {
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



/// 这是一个深度扫描函数。它首先调用`scanRoute()`扫描仓库根目录下的漫画目录。
/// 然后，对于每个漫画，调用其`scanRoute()`方法（扫描漫画目录下的章节），
/// 再对每个章节调用`scanRoute()`（扫描章节目录下的图片）。这样整个仓库的结构就被构建出来了。
  Future<void> thoroughScan() async {
    await scanRoute();
    //将仓库名称存储到AppPreferences中
    await AppPreferences.setRepositoryName(name); 
    debugPrint("appRoute:${RouteUtil.appRoute}");
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
        path.join(RouteUtil.appRoute, '${name}_repository.json'),
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
    // 添加类型转换
    repository.comics = (json['comics'] as List)
        .map((comicJson) => Comic.fromJson(comicJson))
        .toList();
  }
  return repository;
}

  static Future<Map<String, dynamic>> loadRepository(String name) async {
    final jsonFile = File(
      path.join(RouteUtil.appRoute , '${name}_repository.json'),//$前删掉一个/
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
  Future<List<Comic>> loadComics() async {
  try {
    Map<String, dynamic> json = await loadRepository(AppPreferences.repositoryName ?? '');
    Repository repository = Repository.fromJson(json);
    return repository.comics;
  } catch (e) {
    debugPrint("加载漫画失败: $e");
    //debug输出仓库名称
    //debugPrint("仓库名称: ${RouteUtil.repositoryName}");
    return [];
  }
}


}