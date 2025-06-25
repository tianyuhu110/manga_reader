import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga_reader/widgets/repository_card.dart';

void main() {
  ///debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: RepositoryCard(title: "漫画")),
    );
  }
}
