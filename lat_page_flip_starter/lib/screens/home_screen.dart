// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'dark_home_screen.dart';
import 'light_home_sceen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final pageFlipKey = GlobalKey<_PageFlipBuilderState>();

  @override
  Widget build(BuildContext context) {
    return PageFlipBuilder(
      key: pageFlipKey,
      frontWidget: const LightHomePage(),
      backWidget: const DarkHomePage(),
    );
  }
}

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder({
    super.key,
    required this.frontWidget,
    required this.backWidget,
  });
  final Widget frontWidget;
  final Widget backWidget;

  @override
  State<PageFlipBuilder> createState() => _PageFlipBuilderState();
}

class _PageFlipBuilderState extends State<PageFlipBuilder> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
