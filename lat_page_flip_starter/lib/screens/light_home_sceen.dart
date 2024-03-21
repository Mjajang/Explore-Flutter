import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/bottom_flip_icon_button.dart';
import '../widgets/profile_header.dart';

class LightHomePage extends StatelessWidget {
  const LightHomePage({
    super.key,
    this.onFlip,
  });

  final VoidCallback? onFlip;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          displaySmall: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 5),
          ),
          child: Column(
            children: [
              const ProfileHeader(
                prompt: 'Hello,\nsunshine!',
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/forest-day.svg',
                semanticsLabel: 'Forest',
                width: 300,
                height: 300,
              ),
              const Spacer(),
              const BottomFlipIconButton(),
            ],
          ),
        ),
      ),
    );
  }
}
