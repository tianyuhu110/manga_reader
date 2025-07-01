import 'package:flutter/material.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:manga_reader/tools/route_util.dart';
import 'package:path_provider/path_provider.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () async{
      debugPrint("按下");
      print(RouteUtil.appRoute);
      Repository res = Repository();
      await res.selectRoute();
      await res.thoroughScan();
      await res.saveToJsonFile();
      }, child: Text("按钮1"));
  }
}