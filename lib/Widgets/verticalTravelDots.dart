import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constraints.dart';
import '../home.dart';
import '../styles.dart';

class VerticalTravelDots extends StatelessWidget {
  const VerticalTravelDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AnimationController, MapAnimationNotifier>(
      builder: (context, animation, notifier, child) {
        if (animation.value < 1 / 6 || notifier.value > 0) {
          return Container();
        }
        double startTop = dotsTopMargin(context);
        double endTop = topMargin(context) + 32 + 16 + 8;

        double top = endTop +
            (1 - (1.2 * (animation.value - 1 / 6))) *
                (mainSquareSize(context) + 32 - 4);

        double oneThird = (startTop - endTop) / 3;

        return Positioned(
          top: top,
          bottom: bottom(context) - mediaPadding!.vertical,
          child: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  width: 2,
                  height: double.infinity,
                  color: white,
                ),
                Positioned(
                  top: top > oneThird + endTop ? 0 : oneThird + endTop - top,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: white, width: 2.5),
                      color: mainBlack,
                    ),
                    height: 8,
                    width: 8,
                  ),
                ),
                Positioned(
                  top: top > 2 * oneThird + endTop
                      ? 0
                      : 2 * oneThird + endTop - top,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: white, width: 2.5),
                      color: mainBlack,
                    ),
                    height: 8,
                    width: 8,
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 1),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: white, width: 1),
                      color: mainBlack,
                    ),
                    height: 8,
                    width: 8,
                  ),
                ),
                Align(
                  alignment: const Alignment(0, -1),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    height: 8,
                    width: 8,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
