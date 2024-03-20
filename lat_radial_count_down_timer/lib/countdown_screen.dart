// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CountdownAndRestart extends StatefulWidget {
  const CountdownAndRestart({super.key});

  @override
  CountdownAndRestartState createState() => CountdownAndRestartState();
}

class CountdownAndRestartState extends State<CountdownAndRestart>
    with SingleTickerProviderStateMixin {
  static const maxWidth = 300.0;
  static const initialValue = 10;
  Duration _elapsed = Duration.zero;

  int get _remainingTime => max(0, initialValue - _elapsed.inSeconds);
  double get _countdownProgress =>
      _elapsed.inMilliseconds / (1000 * initialValue.toDouble());
  late final Ticker _ticker;

  void restartTimer() {
    _ticker.stop();
    _ticker.start();
  }

  void startTimer() {
    _ticker = createTicker((elapsed) {
      setState(() => _elapsed = elapsed);
      if (_elapsed.inSeconds >= initialValue) {
        _ticker.stop();
      }
    });

    _ticker.start();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CountDownRenderer(
          progress: _countdownProgress,
          remainingTime: _remainingTime,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () => restartTimer(),
          child: const Text(
            'Restart',
            style: TextStyle(fontSize: 32),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class CountDownRenderer extends StatelessWidget {
  const CountDownRenderer({
    Key? key,
    required this.progress,
    required this.remainingTime,
  }) : super(key: key);
  final double progress;
  final int remainingTime;

  final color = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        children: [
          Center(
            child: RingWithoutCustomPainter(
              progress: progress,
              foregroundColor: color.shade700,
              backgroundColor: color.shade400,
            ),
          ),
          Center(
            child: RemainingTimeText(
              remaining: remainingTime,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class RemainingTimeText extends StatelessWidget {
  const RemainingTimeText({
    Key? key,
    required this.remaining,
    required this.color,
  }) : super(key: key);
  final int remaining;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Text(
        remaining.toString(),
        style: TextStyle(
          fontSize: width / 3,
          color: color,
        ),
      );
    });
  }
}

class RingWithoutCustomPainter extends StatelessWidget {
  const RingWithoutCustomPainter({
    Key? key,
    required this.progress,
    required this.foregroundColor,
    required this.backgroundColor,
  }) : super(key: key);
  final double progress;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final strokeWidth = constraints.maxWidth / 15.0;
      return AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: EdgeInsets.all(strokeWidth / 2.0),
          child: Transform.rotate(
            angle: -2 * pi * progress,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(backgroundColor),
              backgroundColor: foregroundColor,
            ),
          ),
        ),
      );
    });
  }
}
