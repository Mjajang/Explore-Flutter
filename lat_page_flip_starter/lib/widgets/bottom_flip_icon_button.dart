// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BottomFlipIconButton extends StatelessWidget {
  const BottomFlipIconButton({
    super.key,
    this.onFlip,
  });
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onFlip,
          icon: const Icon(Icons.flip),
        ),
      ],
    );
  }
}
