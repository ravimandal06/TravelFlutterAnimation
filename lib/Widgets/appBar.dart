import 'package:flutter/material.dart';

class AppBarStatus extends StatelessWidget {
  const AppBarStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: <Widget>[
            const Text(
              'R',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Spacer(),
            Transform.rotate(angle: 55, child: const Icon(Icons.more_horiz)),
          ],
        ),
      ),
    );
  }
}
