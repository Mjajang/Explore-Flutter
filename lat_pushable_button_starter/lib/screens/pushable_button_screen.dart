// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PushableButtonPage extends StatefulWidget {
  const PushableButtonPage({super.key});

  @override
  State<PushableButtonPage> createState() => _PushableButtonPageState();
}

class _PushableButtonPageState extends State<PushableButtonPage> {
  String _selection = 'none';

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
    final shadow = BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 4,
      offset: const Offset(0, 2),
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PushableButton(
                hslColor: const HSLColor.fromAHSL(1.0, 356, 1.0, 0.43),
                height: 60,
                elevation: 8,
                shadow: shadow,
                onPressed: () => setState(() => _selection = '1'),
                child: const Text('PUSH ME', style: textStyle),
              ),
              const SizedBox(height: 32),
              PushableButton(
                hslColor: const HSLColor.fromAHSL(1.0, 120, 1.0, 0.37),
                height: 60,
                elevation: 8,
                shadow: shadow,
                onPressed: () => setState(() => _selection = '2'),
                child: const Text('ENROLL NOW', style: textStyle),
              ),
              const SizedBox(height: 32),
              PushableButton(
                hslColor: const HSLColor.fromAHSL(1.0, 195, 1.0, 0.43),
                height: 60,
                elevation: 8,
                shadow: shadow,
                onPressed: () => setState(() => _selection = '3'),
                child: const Text('ADD TO BASKET', style: textStyle),
              ),
              const SizedBox(height: 32),
              Text(
                "Pushed: $_selection",
                style: textStyle.copyWith(color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PushableButton extends StatefulWidget {
  const PushableButton({
    super.key,
    this.child,
    required this.hslColor,
    required this.height,
    required this.elevation,
    this.shadow,
    this.onPressed,
  });

  /// child widget (normally a Text or Icon)
  final Widget? child;

  /// Color of the top layer
  /// The color of the bottom layer is derived by decreasing the luminosity by 0.15
  final HSLColor hslColor;

  /// height of the top layer
  final double height;

  /// elevation or "gap" between the top and bottom layer
  final double elevation;

  /// An optional shadow to make the button look better
  /// This is added to the bottom layer only
  final BoxShadow? shadow;

  /// button pressed callback
  final VoidCallback? onPressed;

  @override
  State<PushableButton> createState() => _PushableButtonState();
}

class _PushableButtonState extends State<PushableButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  static const animationDuration = Duration(milliseconds: 50);
  bool _isDragInProgress = false;
  Offset _gestureLocation = Offset.zero;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _gestureLocation = details.localPosition;
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    Future.delayed(animationDuration, () {
      _animationController.reverse();
    });
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_isDragInProgress && mounted) {
        _animationController.reverse();
      }
    });
  }

  void _handleDragStart(DragStartDetails details) {
    _gestureLocation = details.localPosition;
    _isDragInProgress = true;
    _animationController.forward();
  }

  void _handleDragEnd(Size buttonSize) {
    if (_isDragInProgress) {
      _isDragInProgress = false;
      _animationController.reverse();
    }

    if (_gestureLocation.dx >= 0 &&
        _gestureLocation.dx < buttonSize.width &&
        _gestureLocation.dy >= 0 &&
        _gestureLocation.dy < buttonSize.height) {
      widget.onPressed?.call();
    }
  }

  void _handleDragCancel() {
    if (_isDragInProgress) {
      _isDragInProgress = false;
      _animationController.reverse();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _gestureLocation = details.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = widget.height + widget.elevation;

    return SizedBox(
      height: totalHeight,
      child: LayoutBuilder(builder: (context, constraints) {
        final buttonSize = Size(constraints.maxWidth, constraints.maxHeight);

        return GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onHorizontalDragStart: (_) => _handleDragEnd(buttonSize),
          onHorizontalDragCancel: _handleDragCancel,
          onHorizontalDragUpdate: _handleDragUpdate,
          onVerticalDragStart: _handleDragStart,
          onVerticalDragEnd: (_) => _handleDragEnd(buttonSize),
          onVerticalDragCancel: _handleDragCancel,
          onVerticalDragUpdate: _handleDragUpdate,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final scale = 1.0 + (_animationController.value * 0.1);
              final top = _animationController.value * widget.elevation;
              final hslColor = widget.hslColor;
              final bottomHslColor =
                  hslColor.withLightness(hslColor.lightness - 0.15);

              return Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: totalHeight - top,
                      decoration: BoxDecoration(
                        color: bottomHslColor.toColor(),
                        borderRadius: BorderRadius.circular(widget.height / 2),
                        boxShadow:
                            widget.shadow != null ? [widget.shadow!] : [],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: top,
                    child: Container(
                      height: widget.height,
                      decoration: ShapeDecoration(
                        color: hslColor.toColor(),
                        shape: const StadiumBorder(),
                      ),
                      child: Transform.scale(
                        scale: scale,
                        child: Center(
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
