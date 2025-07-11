import 'package:flutter/material.dart';

/// 开发预览页面，用于查看和调试各种控件
class DevPreviewPage extends StatelessWidget {
  const DevPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('控件预览'), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('自定义按钮', _buildButtonExamples()),
            const SizedBox(height: 20),
            _buildSection('图片滑动控件', _buildImagesSliverExamples()),
            const SizedBox(height: 20),
            _buildSection('其他控件', _buildOtherExamples()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: content,
        ),
      ],
    );
  }

  Widget _buildButtonExamples() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(text: '正常按钮', onPressed: () {}),
            CustomButton(text: '禁用按钮', onPressed: null),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              text: '红色按钮',
              backgroundColor: Colors.red,
              onPressed: () {},
            ),
            CustomButton(
              text: '绿色按钮',
              backgroundColor: Colors.green,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImagesSliverExamples() {
    return Column(
      children: [
        const Text('图片滑动控件示例（需要导入ImagesSliver）'),
        const SizedBox(height: 8),
        Container(
          height: 150,
          color: Colors.grey[300],
          child: const Center(child: Text('ImagesSliver 预览区域\n（需要正确导入组件）')),
        ),
        const SizedBox(height: 16),
        Container(
          height: 150,
          color: Colors.grey[200],
          child: const Center(child: Text('另一个 ImagesSliver 示例')),
        ),
      ],
    );
  }

  Widget _buildOtherExamples() {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.book),
            title: const Text('示例漫画'),
            subtitle: const Text('第123话'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: const Text('收藏的漫画'),
            subtitle: const Text('已更新'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

// 自定义按钮组件（如果还没有的话）
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(text),
    );
  }
}
