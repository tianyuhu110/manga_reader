import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final Function(String) onMenuSelected;

  const DrawerMenu({super.key, required this.onMenuSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            
            title: Text('mh'),
            
          ),
          _buildMenuItem(Icons.folder_open, '全部', 'all'),
          _buildMenuItem(Icons.favorite_border, '收藏', 'favorites'),
          _buildMenuItem(Icons.history, '历史', 'history'),
        ],
      ),
    );
  }

  ListTile _buildMenuItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => onMenuSelected(value),
    );
  }
}