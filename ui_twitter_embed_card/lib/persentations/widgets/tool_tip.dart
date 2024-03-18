// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ReusableTooltip extends StatelessWidget {
  final String message;
  final double verticalOffset;
  final VoidCallback? onTriggered;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  const ReusableTooltip({
    Key? key,
    required this.message,
    this.verticalOffset = 33.5,
    this.onTriggered,
    this.margin,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 3,
      ),
      margin: margin,
      verticalOffset: verticalOffset,
      waitDuration: const Duration(milliseconds: 200),
      showDuration: const Duration(milliseconds: 200),
      textStyle: const TextStyle(fontSize: 10, color: Colors.white),
      onTriggered: onTriggered,
      child: child,
    );
  }
}
