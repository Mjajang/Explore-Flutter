// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'dark_home_screen.dart';
import 'light_home_sceen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final pageFlipKey = GlobalKey<PageFlipBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PageFlipBuilder(
      key: pageFlipKey,
      frontWidget: (_) => LightHomePage(
        onFlip: () => pageFlipKey.currentState?.flip(),
      ),
      backWidget: (_) => DarkHomePage(
        onFlip: () => pageFlipKey.currentState?.flip(),
      ),
    );
  }
}

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder({
    super.key,
    required this.frontWidget,
    required this.backWidget,
  });
  final WidgetBuilder frontWidget;
  final WidgetBuilder backWidget;

  @override
  State<PageFlipBuilder> createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  bool _showFrontSide = true;
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.addStatusListener((_updateStatus));
    // _controller.addListener(() {
    //   print('value: ${_controller.value}');
    // });
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_updateStatus);
    _controller.dispose();
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      setState(() => _showFrontSide = !_showFrontSide);
    }
  }

  void flip() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPageFlipBuilder(
      animation: _controller,
      showFrontSide: _showFrontSide,
      frontWidget: widget.frontWidget,
      backWidget: widget.backWidget,
    );
  }
}

class AnimatedPageFlipBuilder extends StatelessWidget {
  const AnimatedPageFlipBuilder({
    super.key,
    required this.animation,
    required this.showFrontSide,
    required this.frontWidget,
    required this.backWidget,
  });

  final Animation<double> animation;
  final bool showFrontSide;
  final WidgetBuilder frontWidget;
  final WidgetBuilder backWidget;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final isAnimationFirstHalf = animation.value.abs() < 0.5;
        final child =
            isAnimationFirstHalf ? frontWidget(context) : backWidget(context);
        final rotationValue = animation.value * pi;
        final rotationAngle =
            animation.value > 0.5 ? pi - rotationValue : rotationValue;
        var tilt = (animation.value - 0.5).abs() - 0.5;
        tilt *= isAnimationFirstHalf ? -0.003 : 0.003;

        return Transform(
          transform: Matrix4.rotationY(rotationAngle)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
