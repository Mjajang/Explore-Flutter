// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ReusableInkWell extends StatelessWidget {
  final VoidCallback? onTap;
  final ValueChanged<bool>? onHover;
  final Widget child;

  const ReusableInkWell({
    Key? key,
    this.onTap,
    this.onHover,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: onHover,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
    );
  }
}
