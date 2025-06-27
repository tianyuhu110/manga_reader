import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:manga_reader/servers/comic.dart';
import 'package:file_picker/file_picker.dart';

class Repository {
  String name = "";
  String route = "";
  List<Comic> comics = [];

  Repository(this.name,this.route);

  ///返回的是一个Promise对象
  Future<void> getRoute() async {
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
    if (!await routeDir.exists()) {
      print("目录不存在!");
      return;
    }
    Stream<FileSystemEntity> routeFiles = routeDir.list(recursive: false);
    await for (FileSystemEntity file in routeFiles) {
      if (file is Directory) {
        String comicPath = file.path;
        String comicName = comicPath.split('/').last;
        comics.add(Comic(comicName, comicPath));
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'route': route, 'comics': comics};
  }

  static Repository fromJson(Map<String,dynamic> json){
    Repository repository = Repository(json['name'], json['route']);
    if(json['comics']!=null){
      repository.comics = json['comics'];
    }
    return repository;
  }
}
