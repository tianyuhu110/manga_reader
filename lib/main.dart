import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga_reader/pages/homepage.dart';
import 'package:manga_reader/tools/route_util.dart';
import 'package:manga_reader/widgets/repository_card.dart';
import 'package:manga_reader/pages/local_repository_manager.dart';
import 'package:manga_reader/tools/screen_util.dart';

import 'package:manga_reader/widgets/test_widget.dart';
import 'package:manga_reader/tools/AppPreferences.dart';
import 'package:provider/provider.dart'; // 添加Provider
import 'package:manga_reader/tools/theme_provider.dart'; // 添加ThemeProvide

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await RouteUtil.init();       // 初始化路径
  await AppPreferences.init(); 
 
  runApp(
    // 使用ChangeNotifierProvider包裹整个应用
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ScreenUtil.init(context);
      final themeProvider = Provider.of<ThemeProvider>(context);
      
      return MaterialApp(
        home: HomeScreen(), // 直接使用 HomeScreen
        scrollBehavior: NoGlowScrollBehavior(),
        themeMode: themeProvider.themeMode,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
      );
    });
  }
}