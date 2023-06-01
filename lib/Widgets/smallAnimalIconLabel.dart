import 'package:flutter/material.dart';

import '../styles.dart';

class SmallAnimalIconLabel extends StatelessWidget {
  final bool isVulture;
  final bool showLine;

  const SmallAnimalIconLabel(
      {Key? key, required this.isVulture, required this.showLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (showLine && isVulture)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: 16,
            height: 1,
            color: white,
          ),
        const SizedBox(width: 24),
        Column(
          children: <Widget>[
            Image.asset(
              isVulture ? 'images/vultures.png' : 'images/leopards.png',
              width: 28,
              height: 28,
            ),
            SizedBox(height: showLine ? 16 : 0),
            Text(
              isVulture ? 'Vultures' : 'Leopards',
              style: TextStyle(fontSize: showLine ? 14 : 12),
            )
          ],
        ),
        const SizedBox(width: 24),
        if (showLine && !isVulture)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: 16,
            height: 1,
            color: white,
          ),
      ],
    );
  }
}
