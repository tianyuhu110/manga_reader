import 'package:flutter_test/flutter_test.dart';

// 模拟一个字符串工具类
class StringUtils {
  static String formatChapterTitle(int chapterNumber) {
    return '第${chapterNumber}话';
  }

  static bool isValidUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  static String extractFileName(String path) {
    return path.split('/').last;
  }
}

void main() {
  group('StringUtils 单元测试', () {
    test('格式化章节标题', () {
      expect(StringUtils.formatChapterTitle(1), '第1话');
      expect(StringUtils.formatChapterTitle(100), '第100话');
    });

    test('验证URL格式', () {
      expect(StringUtils.isValidUrl('https://example.com'), true);
      expect(StringUtils.isValidUrl('http://example.com'), true);
      expect(StringUtils.isValidUrl('ftp://example.com'), false);
      expect(StringUtils.isValidUrl('invalid-url'), false);
    });

    test('提取文件名', () {
      expect(StringUtils.extractFileName('/path/to/file.jpg'), 'file.jpg');
      expect(StringUtils.extractFileName('image.png'), 'image.png');
      expect(
        StringUtils.extractFileName('/complex/path/manga_cover.webp'),
        'manga_cover.webp',
      );
    });
  });
}
