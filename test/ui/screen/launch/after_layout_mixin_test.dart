import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/ui/screen/launch/after_layout_mixin.dart';

class _TestWidget extends StatefulWidget {
  const _TestWidget(this._onAfterFirstLayout);

  final void Function(Size? size) _onAfterFirstLayout;

  @override
  State<_TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget>
    with AfterLayoutMixin<_TestWidget> {
  @override
  void afterFirstLayout() => widget._onAfterFirstLayout(context.size);

  @override
  Widget build(BuildContext context) => const SizedBox(width: 100, height: 50);
}

void main() {
  testWidgets('レイアウトが完了した後に afterFirstLayout が呼ばれる', (tester) async {
    final sizes = <Size?>[];

    await tester.pumpWidget(
      Center(child: _TestWidget(sizes.add)),
    );

    expect(sizes, [const Size(100, 50)]);
  });

  testWidgets('再ビルドされても afterFirstLayout は 1 回だけ呼ばれる', (tester) async {
    final sizes = <Size?>[];
    final widget = Center(child: _TestWidget(sizes.add));

    await tester.pumpWidget(widget);
    await tester.pumpWidget(widget);
    await tester.pump();

    expect(sizes, hasLength(1));
  });
}
