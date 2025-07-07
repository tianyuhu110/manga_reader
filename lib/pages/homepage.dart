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
import 'package:flutter/services.dart';
import "../widgets/comic_card.dart";





class HomeScreen extends StatefulWidget {

  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Comic>> _comicsFuture;
  
  final Repository _repository = Repository();

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildSearchField(),
      ),
      drawer: DrawerMenu(onMenuSelected: _filterComics),


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
                    return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 每行显示2个项目
              childAspectRatio: 0.65, // 宽高比
              crossAxisSpacing: 8, // 横向间距
              mainAxisSpacing: 8, // 纵向间距
            ),
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
      if (await Permission.manageExternalStorage.request().isGranted) {
            debugPrint("用户授予了权限");
      await res.selectRoute();
      await res.thoroughScan();
      await res.saveToJsonFile();
      _loadComics();
      }
          else{
            debugPrint("用户未授予权限");
          }
      }
      ,
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
