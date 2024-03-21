// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.prompt,
  });
  final String prompt;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        children: [
          Text(
            prompt,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const Spacer(),
          SvgPicture.asset(
            'assets/man.svg',
            semanticsLabel: 'Profile',
            width: 50,
            height: 50,
          )
        ],
      ),
    );
  }
}
