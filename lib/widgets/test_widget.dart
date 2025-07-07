import 'package:flutter/material.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:manga_reader/tools/route_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:manga_reader/pages/homepage.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});


   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,),
      ),
      home:HomeScreen(),
    );
  }
}