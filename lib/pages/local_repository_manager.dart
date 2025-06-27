import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manga_reader/widgets/repository_card.dart';

import 'package:manga_reader/tools/screen_util.dart';
///Icons.notifications_outlined
///Icons.help_outline

class LocalRepositoryManager extends StatefulWidget {
  const LocalRepositoryManager({super.key});

  @override
  State<LocalRepositoryManager> createState() => _LocalRepositoryManagerState();
}

class _LocalRepositoryManagerState extends State<LocalRepositoryManager> {
  ScrollController _controller = ScrollController();
  double controllerOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        controllerOffset = _controller.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(actions: _buildAppBarActions(),leading: Icon(Icons.abc),title: Text("本地仓库管理",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),);
    double appBarHeight = appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarTitleTransparent = 0;
    double bodyTitleTransparent = 0;

    return Scaffold(
      appBar: appBar,
      body: _buildBody(appBarHeight, screenHeight, controllerOffset),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // 释放控制器
    super.dispose();
  }

  List<Widget> _buildAppBarActions() {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(Icons.notifications_outlined),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(Icons.help_outline),
      ),
    ];
  }

  Widget _buildBody(double appBarHeight, double screenHeight, double offset) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("本地仓库管理", style: TextStyle(fontSize: 30,color: Color.fromARGB(255, 0,0,0))),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: screenHeight - appBarHeight,
            child: Text(offset.toString(),style: TextStyle(fontSize: 90),),
          ),
        ),
      ],
    );
  }
}
