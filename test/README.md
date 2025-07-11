# Flutter 测试管理指南

## 测试类型

### 1. 单元测试 (Unit Tests)
- **位置**: `test/unit/`
- **用途**: 测试单个函数、方法或类
- **运行**: `flutter test test/unit/`

### 2. 组件测试 (Widget Tests)
- **位置**: `test/widget/`
- **用途**: 测试UI组件的渲染和交互
- **运行**: `flutter test test/widget/`

### 3. 集成测试 (Integration Tests)
- **位置**: `integration_test/`
- **用途**: 测试完整的应用流程
- **运行**: `flutter test integration_test/`

## 测试命令

### 运行所有测试
```bash
flutter test
```

### 运行特定测试文件
```bash
flutter test test/widget_test.dart
```

### 运行特定测试组
```bash
flutter test --plain-name "单元测试"
```

### 生成测试覆盖率报告
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### 在特定设备上运行集成测试
```bash
flutter test integration_test/app_test.dart -d chrome
```

## 测试最佳实践

### 1. 测试文件命名
- 单元测试: `功能名_test.dart`
- 组件测试: `组件名_test.dart`
- 集成测试: `flow_name_test.dart`

### 2. 测试组织
```dart
void main() {
  group('功能模块名', () {
    setUpAll(() {
      // 所有测试前的一次性设置
    });
    
    setUp(() {
      // 每个测试前的设置
    });
    
    tearDown(() {
      // 每个测试后的清理
    });
    
    test('具体测试描述', () {
      // 测试逻辑
    });
  });
}
```

### 3. 测试数据管理
- 创建 `test/fixtures/` 目录存放测试数据
- 使用模拟数据而不是真实API
- 保持测试独立性

### 4. 常用测试匹配器
```dart
expect(actual, equals(expected));
expect(actual, isTrue);
expect(actual, isFalse);
expect(actual, isNull);
expect(actual, isNotNull);
expect(actual, greaterThan(5));
expect(actual, lessThan(10));
expect(actual, contains('text'));
expect(() => function(), throwsException);
```

### 5. Widget测试技巧
```dart
// 查找组件
find.byType(Widget)
find.byKey(Key('key'))
find.text('文本内容')
find.byIcon(Icons.add)

// 交互操作
await tester.tap(finder);
await tester.drag(finder, offset);
await tester.enterText(finder, 'text');

// 等待操作
await tester.pump(); // 触发一帧
await tester.pumpAndSettle(); // 等待所有动画完成
```

## 持续集成配置

### GitHub Actions 示例
```yaml
name: Flutter Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      - run: flutter test --coverage
```

## 性能测试

### 测试应用启动时间
```dart
testWidgets('应用启动性能', (tester) async {
  final stopwatch = Stopwatch()..start();
  await tester.pumpWidget(MyApp());
  await tester.pumpAndSettle();
  stopwatch.stop();
  
  expect(stopwatch.elapsedMilliseconds, lessThan(2000));
});
```

### 测试滚动性能
```dart
testWidgets('列表滚动性能', (tester) async {
  await tester.pumpWidget(MyListView());
  
  final stopwatch = Stopwatch()..start();
  await tester.fling(find.byType(ListView), Offset(0, -500), 1000);
  await tester.pumpAndSettle();
  stopwatch.stop();
  
  expect(stopwatch.elapsedMilliseconds, lessThan(1000));
});
```

## 测试覆盖率目标
- 单元测试: 90%+
- 组件测试: 80%+
- 集成测试: 主要用户流程覆盖

## 调试测试
```bash
# 在调试模式下运行测试
flutter test --start-paused

# 查看详细输出
flutter test --verbose
```
