import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga_reader/tools/route_util.dart';
import 'package:manga_reader/widgets/repository_card.dart';
import 'package:manga_reader/pages/local_repository_manager.dart';
import 'package:manga_reader/tools/screen_util.dart';

import 'package:manga_reader/widgets/test_widget.dart';


class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

void main() {
  print("应用启动");
  ///debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
       ScreenUtil.init(context);
       RouteUtil.init();
        return MyHome();
      }),
      scrollBehavior: NoGlowScrollBehavior(),
      );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return TestApp();
  }
}
