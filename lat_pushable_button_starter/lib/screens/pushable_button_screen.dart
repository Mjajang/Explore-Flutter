// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  final Widget? child;
  final HSLColor hslColor;
  final double height;
  final double elevation;
  final BoxShadow? shadow;
  final VoidCallback? onPressed;

  @override
  State<PushableButton> createState() => _PushableButtonState();
}

class _PushableButtonState extends State<PushableButton> {
  double? position;
  double scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          position = widget.elevation;
          scaleFactor = 1.0;
        });
      },
      onTapDown: (_) {
        setState(() {
          position = 0;
          scaleFactor = 1.1;
        });

        widget.onPressed?.call();
      },
      onTapCancel: () {
        setState(() {
          position = widget.elevation;
          scaleFactor = 1.0;
        });
      },
      child: SizedBox(
        height: 66,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: widget.height,
                width: 300,
                decoration: BoxDecoration(
                  color: widget.hslColor
                      .withLightness(widget.hslColor.lightness - 0.15)
                      .toColor(),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [widget.shadow ?? const BoxShadow()],
                ),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeIn,
              bottom: position,
              duration: const Duration(milliseconds: 70),
              child: Container(
                height: widget.height,
                width: 300,
                decoration: BoxDecoration(
                  color: widget.hslColor.toColor(),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Transform.scale(
                  scale: scaleFactor,
                  child: SizedBox(
                    height: widget.height * scaleFactor,
                    width: 300 * scaleFactor,
                    child: Center(
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
