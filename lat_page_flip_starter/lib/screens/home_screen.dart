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
      lowerBound: -1.0,
      upperBound: 1.0,
    );
    _controller.value = 0.0;
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
      _controller.value = 0.0;
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

  void _handleDragUpdate(DragUpdateDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    _controller.value += details.primaryDelta! / screenWidth;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed ||
        _controller.status == AnimationStatus.dismissed) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final currentVelocity = details.velocity.pixelsPerSecond.dx / screenWidth;

    if (_controller.value == 0.0 && currentVelocity == 0.0) {
      return;
    }

    const flingVelocity = 2.0;
    if (_controller.value > 0.5 ||
        _controller.value > 0.0 && currentVelocity > flingVelocity) {
      _controller.fling(velocity: flingVelocity);
    } else if (_controller.value < -0.5 ||
        _controller.value < 0.0 && currentVelocity < -flingVelocity) {
      _controller.fling(velocity: -flingVelocity);
    } else if (_controller.value > 0.0 ||
        _controller.value > 0.5 && currentVelocity < -flingVelocity) {
      _controller.value -= 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: -flingVelocity);
    } else if (_controller.value > -0.5 ||
        _controller.value < -0.5 && currentVelocity > flingVelocity) {
      _controller.value += 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: flingVelocity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: AnimatedPageFlipBuilder(
        animation: _controller,
        showFrontSide: _showFrontSide,
        frontWidget: widget.frontWidget,
        backWidget: widget.backWidget,
      ),
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
  bool get _isAnimationFirstHalf => animation.value.abs() < 0.5;

  double _getTilt() {
    var tilt = (animation.value - 0.5).abs() - 0.5;
    if (animation.value < -0.5) {
      tilt = 1.0 + animation.value;
    }
    return tilt * (_isAnimationFirstHalf ? -0.003 : 0.003);
  }

  double _rotationAngel() {
    final rotationValue = animation.value * pi;
    if (animation.value > 0.5) {
      return pi - rotationValue;
    } else if (animation.value > -0.5) {
      return rotationValue;
    } else {
      return -pi - rotationValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final child = _isAnimationFirstHalf ^ showFrontSide
            ? frontWidget(context)
            : backWidget(context);
        return Transform(
          transform: Matrix4.rotationY(_rotationAngel())
            ..setEntry(3, 0, _getTilt()),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
