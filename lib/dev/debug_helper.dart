import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Flutter控件调试工具
class DebugHelper {
  /// 显示控件边界
  static void showWidgetBorders() {
    debugPaintSizeEnabled = true;
  }

  /// 隐藏控件边界
  static void hideWidgetBorders() {
    debugPaintSizeEnabled = false;
  }

  /// 显示性能覆盖层
  static void showPerformanceOverlay(BuildContext context) {
    // 需要在MaterialApp中启用
    // debugShowMaterialGrid = true;
  }

  /// 打印控件树
  static void printWidgetTree(BuildContext context) {
    debugDumpApp();
  }

  /// 打印渲染树
  static void printRenderTree(BuildContext context) {
    debugDumpRenderTree();
  }
}

/// 调试面板控件
class DebugPanel extends StatefulWidget {
  final Widget child;

  const DebugPanel({Key? key, required this.child}) : super(key: key);

  @override
  _DebugPanelState createState() => _DebugPanelState();
}

class _DebugPanelState extends State<DebugPanel> {
  bool _showBorders = false;
  bool _showPanel = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        // 调试按钮
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 10,
          child: FloatingActionButton.small(
            onPressed: () {
              setState(() {
                _showPanel = !_showPanel;
              });
            },
            child: const Icon(Icons.bug_report),
            backgroundColor: Colors.red,
          ),
        ),

        // 调试面板
        if (_showPanel)
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            right: 10,
            child: Container(
              width: 250,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '调试工具',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 10),

                  // 显示边界开关
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('显示边界', style: TextStyle(color: Colors.white)),
                      Switch(
                        value: _showBorders,
                        onChanged: (value) {
                          setState(() {
                            _showBorders = value;
                            if (value) {
                              DebugHelper.showWidgetBorders();
                            } else {
                              DebugHelper.hideWidgetBorders();
                            }
                          });
                        },
                      ),
                    ],
                  ),

                  // 调试按钮
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => DebugHelper.printWidgetTree(context),
                    child: const Text('打印控件树'),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () => DebugHelper.printRenderTree(context),
                    child: const Text('打印渲染树'),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      // 显示当前页面信息
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('屏幕尺寸: ${MediaQuery.of(context).size}'),
                        ),
                      );
                    },
                    child: const Text('显示屏幕信息'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// 可视化容器，用于突出显示控件边界
class DebugContainer extends StatelessWidget {
  final Widget child;
  final String? label;
  final Color borderColor;

  const DebugContainer({
    Key? key,
    required this.child,
    this.label,
    this.borderColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Stack(
        children: [
          child,
          if (label != null)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                color: borderColor,
                child: Text(
                  label!,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 尺寸信息显示控件
class SizeInfo extends StatelessWidget {
  final Widget child;

  const SizeInfo({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            child,
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                color: Colors.black54,
                child: Text(
                  '${constraints.maxWidth.toInt()} x ${constraints.maxHeight.toInt()}',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
