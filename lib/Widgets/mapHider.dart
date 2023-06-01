import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class MapHider extends StatelessWidget {
  final Widget child;

  const MapHider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        return Opacity(
          opacity: math.max(0, 1 - (2 * notifier.value)),
          child: child,
        );
      },
      child: child,
    );
  }
}
