// 创建 lib/tools/storage_permission_manager.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class StoragePermissionManager {
  static final StoragePermissionManager _instance =
      StoragePermissionManager._internal();
  factory StoragePermissionManager() => _instance;
  StoragePermissionManager._internal();

  // 存储授权的根目录
  String? _authorizedRootPath;

  // 设置授权根目录（由Repository调用）
  void setAuthorizedPath(String path) {
    _authorizedRootPath = path;
    debugPrint("设置授权路径: $path");
  }

  // 检查路径是否在授权范围内
  bool isPathAuthorized(String path) {
    if (_authorizedRootPath == null) return false;
    return path.startsWith(_authorizedRootPath!);
  }

  // 为其他模块提供安全的目录扫描
  Future<List<FileSystemEntity>> listDirectory(String path) async {
    if (!isPathAuthorized(path)) {
      debugPrint("路径未授权: $path");
      return [];
    }

    try {
      Directory dir = Directory(path);
      if (!await dir.exists()) {
        debugPrint("目录不存在: $path");
        return [];
      }

      return await dir.list(recursive: false).toList();
    } catch (e) {
      debugPrint("扫描目录失败: $e");
      return [];
    }
  }

  // 清除授权（应用退出时调用）
  void clearAuthorization() {
    _authorizedRootPath = null;
    debugPrint("清除存储授权");
  }
}
