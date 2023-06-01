import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelanimation/pages/leopard_page.dart';

import 'Widgets/BaseTimeLabel.dart';
import 'Widgets/LeopardIconLabel.dart';
import 'Widgets/StartCampLabel.dart';
import 'Widgets/VultureImage.dart';
import 'Widgets/appBar.dart';
import 'Widgets/arrowIcon.dart';
import 'Widgets/baseCampLabel.dart';
import 'Widgets/curvedRoute.dart';
import 'Widgets/distanceLabel.dart';
import 'Widgets/horizontalTravelDots.dart';
import 'Widgets/mapBaseCamp.dart';

import 'Widgets/mapImage.dart';
import 'Widgets/mapLeopards.dart';
import 'Widgets/mapStartCamp.dart';
import 'Widgets/mapVultures.dart';
import 'Widgets/pageIndicator.dart';
import 'Widgets/startTimeLabel.dart';
import 'Widgets/travelDetailsLabel.dart';
import 'Widgets/verticalTravelDots.dart';
import 'Widgets/vultureIconLabel.dart';
import 'Widgets/vulturePage.dart';
import 'constraints.dart';
import 'notifier/pageOffsetNotifier.dart';

//TODO: Shoud be a field passed in constructor but this weak is quicker...
EdgeInsets? mediaPadding;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController? _animationController;
  AnimationController? _mapAnimationController;
  final PageController _pageController = PageController();

  double get maxHeight => mainSquareSize(context) + 32 + 24;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _mapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _mapAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaPadding = MediaQuery.of(context).padding;
    return ChangeNotifierProvider(create: (BuildContext context) {
      return PageOffsetNotifier(_pageController);
    }, builder: (context, child) {
      // PageOffsetNotifier(_pageController);
      return ListenableProvider.value(
        value: _animationController,
        child: ChangeNotifierProvider(
          create: (_) => MapAnimationNotifier(_mapAnimationController!),
          builder: (context, child) => Scaffold(
            body: Stack(
              children: <Widget>[
                const MapImage(),
                SafeArea(
                  child: GestureDetector(
                    onVerticalDragUpdate: _handleDragUpdate,
                    onVerticalDragEnd: _handleDragEnd,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        PageView(
                          controller: _pageController,
                          physics: const ClampingScrollPhysics(),
                          children: const <Widget>[
                            LeopardPage(),
                            VulturePage(),
                          ],
                        ),
                        const AppBarStatus(),
                        const LeopardImage(),
                        const VultureImage(),
                        const PageIndicator(),
                        const ArrowIcon(),
                        const TravelDetailsLabel(),
                        const StartCampLabel(),
                        const StartTimeLabel(),
                        const BaseCampLabel(),
                        const BaseTimeLabel(),
                        const DistanceLabel(),
                        const HorizontalTravelDots(),
                        const MapButton(),
                        const VerticalTravelDots(),
                        const VultureIconLabel(),
                        const LeopardIconLabel(),
                        const CurvedRoute(),
                        const MapBaseCamp(),
                        const MapLeopards(),
                        const MapVultures(),
                        const MapStartCamp(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _animationController!.value -= details.primaryDelta! / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_animationController!.isAnimating ||
        _animationController!.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0) {
      _animationController!.fling(velocity: math.max(2.0, -flingVelocity));
    } else if (flingVelocity > 0.0) {
      _animationController!.fling(velocity: math.min(-2.0, -flingVelocity));
    } else {
      _animationController!
          .fling(velocity: _animationController!.value < 0.5 ? -2.0 : 2.0);
    }
  }
}

class MapAnimationNotifier with ChangeNotifier {
  final AnimationController _animationController;

  MapAnimationNotifier(this._animationController) {
    _animationController.addListener(_onAnimationControllerChanged);
  }

  double get value => _animationController.value;

  void forward() => _animationController.forward();

  void _onAnimationControllerChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _animationController.removeListener(_onAnimationControllerChanged);
    super.dispose();
  }
}

class MapButton extends StatelessWidget {
  const MapButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      bottom: 0,
      child: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          double opacity = math.max(0, 4 * notifier.page - 3);
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: TextButton(
          child: const Text(
            'ON MAP',
            style: TextStyle(fontSize: 12, color: Color(0xffeeeeee)),
          ),
          onPressed: () {
            final notifier =
                Provider.of<MapAnimationNotifier>(context, listen: false);
            notifier.value == 0
                ? notifier.forward()
                : notifier._animationController.reverse();
            print(notifier.value);
          },
        ),
      ),
    );
  }
}
