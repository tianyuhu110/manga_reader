import 'package:flutter/material.dart';
import 'package:manga_reader/pages/setting.dart';
import 'package:manga_reader/servers/comic.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:manga_reader/tools/route_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:manga_reader/pages/homepage.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/drawer_menu.dart';
<<<<<<< Updated upstream
import 'package:flutter/services.dart';
=======
import '../servers/comic.dart';
import "../widgets/comic_card.dart";
import 'package:permission_handler/permission_handler.dart';


>>>>>>> Stashed changes

class HomeScreen extends StatefulWidget {

  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
<<<<<<< Updated upstream
=======



>>>>>>> Stashed changes
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Comic>> _comicsFuture;
  //调用fromJson获取数据
  final Repository _repository = Repository();
  // final Repository _repository = Repository();
// final List<Comic> comics = [
//     Comic('Comic 1', ""),
//     Comic('Comic 2', ""),
//     Comic('Comic 3',"" ),
//   ];
  @override
  void initState() {
    super.initState();
    _loadComics();
  }

  void _loadComics() {
    setState(() {
      _comicsFuture = _repository.loadComics();
    });
  }

  void _filterComics(String filter) {
<<<<<<< Updated upstream
    setState(() {});
=======
    setState(() {
 
    });
>>>>>>> Stashed changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildSearchField(),
      ),
      drawer: DrawerMenu(onMenuSelected: _filterComics),
<<<<<<< Updated upstream

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          debugPrint("按下");
          print(RouteUtil.appRoute);
          Repository res = Repository();
          if (await Permission.manageExternalStorage.request().isGranted) {
            debugPrint("用户授予了权限");
            await res.selectRoute();
            await res.thoroughScan();
            await res.saveToJsonFile();
          }
          else{
            debugPrint("用户未授予权限");
          }
        },
=======
      // body: ListView.builder(
      //   itemCount: comics.length,
      //   itemBuilder: (context, index) {
      //     return ComicCard(
      //       comic: comics[index],
      //       onTap: () {
      //         // 点击事件处理
      //         print('点击了漫画: ${comics[index].name}');
      //       },
      //     );
      //   },
      // ),
      body: FutureBuilder<List<Comic>>(
        future: _comicsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('加载失败: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('暂无漫画，请添加资源'));
          }
          
          final comics = snapshot.data!;
          return ListView.builder(
            itemCount: comics.length,
            itemBuilder: (context, index) {
              return ComicCard(
                comic: comics[index],
                onTap: () {
                  print('点击了漫画: ${comics[index].name}');
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{

      debugPrint("按下");
      print(RouteUtil.appRoute);
      Repository res = Repository();
      await res.selectRoute();
      await res.thoroughScan();
      await res.saveToJsonFile();
      _loadComics();
      }
      ,
>>>>>>> Stashed changes
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: '搜索',
        prefixIcon: Builder(
          // 使用 Builder 包裹
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Settingpage()),
            );
            // 设置功能

            // showDialog(
            //   context: context,
            //   builder: (ctx) => AlertDialog(
            //     title: const Text('设置'),
            //     content: const Text('这里可以添加阅读设置选项'),
            //     actions: [
            //       TextButton(
            //         onPressed: () => Navigator.pop(ctx),
            //         child: const Text('确定'),
            //       )
            //     ],
            //   ),
            // );
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void show_comic(Repository repo) {
    debugPrint("展示漫画于主页面");
    for (Comic comic in repo.comics) {}
  }
}
