//写一个软件设置界面（由设置里的一项跳转过来的
import 'package:flutter/material.dart';


class SoftwareSettingPage extends StatefulWidget {
  const SoftwareSettingPage({super.key});

  @override
  State<SoftwareSettingPage> createState() => _SoftwareSettingPageState();
  

}
class _SoftwareSettingPageState extends State<SoftwareSettingPage>  {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("软件设置"),
        ),
        body: ListView(
          children: [
            _buildSectionHeader("显示设置"),
            ListTile(
            // leading: Icon(Icons.folder_open),
            title: Text('主题样式'),
            
            
            ),
            
            const Divider(height:1),
            _buildSectionHeader("漫画设置"),
            ListTile(
              
              title: Text('跳过漫画详情'),
            ),
            
            const Divider(height:1),
            _buildSectionHeader("其他设置"),  
            ListTile(
              
              title: Text('触摸震动反馈'),
              //点击跳转到软件设置界面
      
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
