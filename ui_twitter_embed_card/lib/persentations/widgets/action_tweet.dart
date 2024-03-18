import 'package:flutter/material.dart';

import '../../values/values.dart';

Widget actionTweet({required SvgAsset icon, required String title}) {
  return Padding(
    padding: const EdgeInsets.only(right: 28.0),
    child: Row(
      children: [
        SvgIcon(
          asset: icon,
          height: 20,
        ),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold))
      ],
    ),
  );
}
