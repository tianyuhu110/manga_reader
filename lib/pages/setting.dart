import 'package:flutter/material.dart';
import 'package:manga_reader/pages/software_setting.dart';
class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}
class _SettingpageState extends State<Settingpage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: ListView(
        children: [
          _buildSectionHeader("仓库管理"),
          ListTile(
          leading: Icon(Icons.folder_open),
          title: Text('本地仓库管理'),
          
          
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text('远程仓库管理'),
          ),
          const Divider(height:1),
          _buildSectionHeader("漫画管理"),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('书架管理'),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('阅读配置管理'),
          ),
          const Divider(height:1),
          _buildSectionHeader("其他"),  
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('软件设置'),
            //点击跳转到软件设置界面
            onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => SoftwareSettingPage()),
               );
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('隐私政策'),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('关于软件'),
          ),
        ],
      )
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

}