import 'package:flutter/material.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manga_reader/servers/repository.dart';
import 'package:manga_reader/tools/route_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:manga_reader/pages/homepage.dart';
import '../widgets/drawer_menu.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _searchController = TextEditingController();

  void _filterComics(String filter) {
    setState(() {
      
      
 
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildSearchField(),
      ),
      drawer: DrawerMenu(onMenuSelected: _filterComics),
     
       floatingActionButton: FloatingActionButton(
        onPressed: () async{
      debugPrint("按下");
      print(RouteUtil.appRoute);
      Repository res = Repository();
      await res.selectRoute();
      await res.thoroughScan();
      await res.saveToJsonFile();
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
        prefixIcon: Builder( // 使用 Builder 包裹
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // 设置功能
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('设置'),
                content: const Text('这里可以添加阅读设置选项'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('确定'),
                  )
                ],
              ),
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
}