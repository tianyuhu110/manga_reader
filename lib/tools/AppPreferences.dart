import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static SharedPreferences? _prefs;

  // 初始化方法（必须在应用启动时调用）
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
 
  }

  // 仓库名的getter和setter
  ///获取仓库名方法为：AppPreferences.repositoryName
  static String? get repositoryName => _prefs?.getString('repo_name');
  /// 设置仓库名方法为：AppPreferences.setRepositoryName("仓库名")
  static Future<bool> setRepositoryName(String name) async {
    return _prefs?.setString('repo_name', name) ?? false;
  }

  // 仓库路径的getter和setter
  static String? get themeMode => _prefs?.getString('theme_mode');

  static Future<bool> setThemeMode(String mode) async {
    return _prefs?.setString('theme_mode', mode) ?? false;
  }



}