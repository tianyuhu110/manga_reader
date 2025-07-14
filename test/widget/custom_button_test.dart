import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// 创建一个简单的自定义按钮组件用于测试
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
      ),
      child: Text(text),
    );
  }
}

void main() {
  group('CustomButton 组件测试', () {
    testWidgets('按钮正常显示', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(text: '阅读漫画', onPressed: () {}),
          ),
        ),
      );

      // 验证按钮文本
      expect(find.text('阅读漫画'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('按钮点击事件', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: '点击测试',
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      // 点击按钮
      await tester.tap(find.byType(CustomButton));

      // 验证点击事件是否触发
      expect(wasPressed, true);
    });

    testWidgets('禁用状态按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: '禁用按钮',
              onPressed: null, // 传入null使按钮禁用
            ),
          ),
        ),
      );

      final elevatedButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      // 验证按钮是否禁用
      expect(elevatedButton.onPressed, isNull);
    });

    testWidgets('自定义背景色', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: '红色按钮',
              backgroundColor: Colors.red,
              onPressed: () {},
            ),
          ),
        ),
      );

      final elevatedButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      // 验证背景色
      expect(elevatedButton.style?.backgroundColor?.resolve({}), Colors.red);
    });

    testWidgets('控件视觉快照测试', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: CustomButton(
                text: '视觉测试按钮',
                backgroundColor: Colors.green,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      // 生成Golden文件，可以在test/goldens/目录下查看
      await expectLater(
        find.byType(CustomButton),
        matchesGoldenFile('goldens/custom_button.png'),
      );
    });

    testWidgets('不同状态的按钮快照', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                CustomButton(text: '正常按钮', onPressed: () {}),
                SizedBox(height: 10),
                CustomButton(text: '禁用按钮', onPressed: null),
                SizedBox(height: 10),
                CustomButton(
                  text: '红色按钮',
                  backgroundColor: Colors.red,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(Column),
        matchesGoldenFile('goldens/button_states.png'),
      );
    });
  });
}
