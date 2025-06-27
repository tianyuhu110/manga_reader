import 'package:flutter/material.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manga_reader/servers/repository.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () async{
      debugPrint("按下");
      Repository res = Repository();
      await res.getRoute();
      print(res.name);
      print(res.route);
      res.scanRoute();
      }, child: Text("按钮1"));
  }
}