import 'dart:async';

import 'package:flutter/widgets.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    unawaited(_runAfterLayout());
  }

  Future<void> _runAfterLayout() async {
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) {
      return;
    }
    afterFirstLayout();
  }

  @protected
  void afterFirstLayout();
}
