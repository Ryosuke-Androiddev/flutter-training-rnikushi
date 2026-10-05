import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/ui/screen/launch/after_layout_mixin.dart';

class _TestWidget extends StatefulWidget {
  const _TestWidget(this._onAfterFirstLayout, [this._onBuild]);

  final void Function(Size? size) _onAfterFirstLayout;
  final void Function()? _onBuild;

  @override
  State<_TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget>
    with AfterLayoutMixin<_TestWidget> {
  @override
  void afterFirstLayout() => widget._onAfterFirstLayout(context.size);

  @override
  Widget build(BuildContext context) {
    widget._onBuild?.call();
    return const SizedBox(width: 100, height: 50);
  }
}

class _LayoutTwice extends SingleChildRenderObjectWidget {
  const _LayoutTwice({super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderLayoutTwice();
}

class _RenderLayoutTwice extends RenderProxyBox {
  @override
  void performLayout() {
    child!
      ..layout(
        const BoxConstraints.tightFor(width: 200, height: 50),
        parentUsesSize: true,
      )
      ..layout(
        const BoxConstraints.tightFor(width: 50, height: 50),
        parentUsesSize: true,
      );
    size = constraints.constrain(child!.size);
  }
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
    var buildCount = 0;
    void onBuild() => buildCount++;

    await tester.pumpWidget(Center(child: _TestWidget(sizes.add, onBuild)));
    await tester.pumpWidget(Center(child: _TestWidget(sizes.add, onBuild)));
    await tester.pump();

    expect(buildCount, 2);
    expect(sizes, hasLength(1));
  });

  testWidgets('レイアウトが完了する前に破棄されたら afterFirstLayout は呼ばれない', (tester) async {
    final sizes = <Size?>[];
    var buildCount = 0;
    void onBuild() => buildCount++;

    await tester.pumpWidget(
      Center(
        child: _LayoutTwice(
          child: LayoutBuilder(
            builder: (context, constraints) => constraints.maxWidth > 100
                ? _TestWidget(sizes.add, onBuild)
                : const SizedBox(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(buildCount, 1);
    expect(find.byType(_TestWidget), findsNothing);
    expect(sizes, isEmpty);
  });
}
