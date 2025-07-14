import 'package:flutter/material.dart';
import 'debug_helper.dart';
import 'dev_preview_page.dart';

/// 调试应用入口
class DebugApp extends StatelessWidget {
  const DebugApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '控件调试工具',
      debugShowCheckedModeBanner: false,
      // 启用性能覆盖层（可选）
      // showPerformanceOverlay: true,
      home: const DebugHomePage(),
    );
  }
}

class DebugHomePage extends StatelessWidget {
  const DebugHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DebugPanel(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('控件调试示例'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '调试工具使用指南：',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 1. 基础调试容器示例
              const Text('1. 基础调试容器：'),
              const SizedBox(height: 8),
              DebugContainer(
                label: '按钮容器',
                borderColor: Colors.red,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('示例按钮'),
                ),
              ),
              const SizedBox(height: 16),

              // 2. 尺寸信息显示
              const Text('2. 尺寸信息显示：'),
              const SizedBox(height: 8),
              SizeInfo(
                child: Container(
                  width: 200,
                  height: 100,
                  color: Colors.blue[100],
                  child: const Center(child: Text('200x100 容器')),
                ),
              ),
              const SizedBox(height: 16),

              // 3. 多层嵌套调试
              const Text('3. 多层嵌套调试：'),
              const SizedBox(height: 8),
              DebugContainer(
                label: '外层容器',
                borderColor: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DebugContainer(
                    label: '内层容器',
                    borderColor: Colors.orange,
                    child: Container(
                      width: 150,
                      height: 80,
                      color: Colors.yellow[100],
                      child: const Center(child: Text('嵌套内容')),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4. 导航到预览页面
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DebugPanel(child: const DevPreviewPage()),
                    ),
                  );
                },
                child: const Text('打开控件预览页面'),
              ),
              const SizedBox(height: 16),

              // 5. 使用说明
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '使用说明：',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('1. 点击右上角红色bug图标打开调试面板'),
                    Text('2. 开启"显示边界"可以看到所有控件的边界线'),
                    Text('3. 使用DebugContainer包装控件可以显示自定义边界'),
                    Text('4. 使用SizeInfo可以显示控件的具体尺寸'),
                    Text('5. 点击调试面板中的按钮可以在控制台查看控件树'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 在main.dart中使用示例：
///
/// void main() {
///   runApp(DebugApp()); // 调试模式
///   // runApp(MyApp()); // 正常模式
/// }
