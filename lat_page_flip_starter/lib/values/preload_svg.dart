import 'package:flutter_svg/flutter_svg.dart';

Future<void> preloadSvg() async {
  final svgList = [
    'assets/forest-day.svg',
    'assets/forest-night.svg',
    'assets/man.svg',
  ];

  for (var asset in svgList) {
    final loader = SvgAssetLoader(asset);
    await svg.cache.putIfAbsent(
      loader.cacheKey(null),
      () => loader.loadBytes(null),
    );
  }
}
