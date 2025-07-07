//这是一个漫画阅读器的卡片组件，显示漫画的封面、标题和作者信息。
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manga_reader/servers/comic.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:manga_reader/tools/route_util.dart';
import 'package:manga_reader/servers/chapter.dart';


class ComicCard extends StatelessWidget {
  final Comic comic;
  final VoidCallback onTap;

  const ComicCard({Key? key, required this.comic, required this.onTap}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    String coverPath = comic.getCoverRoute();
   Widget coverImage = coverPath.isNotEmpty
      ? Image.file(
          File(coverPath),
          fit: BoxFit.cover,
          
          height: 150,
          width: double.infinity,
        )
      : Container(
          color: Colors.grey[200],
          height: 150,
          width: double.infinity,
          child: Icon(Icons.image, size: 50, color: Colors.grey),
        );
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:coverImage,
            ),
            

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                comic.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),


          ],
        ),
      ),
    );
  }
}