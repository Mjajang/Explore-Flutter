import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CountdownAndRestart extends StatefulWidget {
  const CountdownAndRestart({super.key});

  @override
  CountdownAndRestartState createState() => CountdownAndRestartState();
}

class CountdownAndRestartState extends State<CountdownAndRestart>
    with SingleTickerProviderStateMixin {
  static const maxWidth = 300.0;
  static const initialValue = 10;
  int seconds = initialValue;
  late Timer timer;
  late AnimationController controller;

  void restartTimer() {
    timer.cancel();
    controller.reset();
    setState(() {
      seconds = initialValue;
    });
    controller.forward();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: initialValue),
    )..forward();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: -2 * pi * controller.value,
                      child: CircularProgressIndicator(
                        value: controller.value,
                        strokeWidth: 23,
                        backgroundColor: Colors.deepPurple.shade600,
                      ),
                    );
                  }),
              buildTime(context),
            ],
          ),
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

  Widget buildTime(BuildContext context) {
    return Center(
      child: Text(
        "$seconds",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 100,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
