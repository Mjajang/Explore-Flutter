import 'package:flutter/material.dart';
import 'package:ui_twitter_embed_card/persentations/widgets/ink_well.dart';
import 'package:ui_twitter_embed_card/persentations/widgets/tool_tip.dart';

import '../../values/values.dart';

Widget actionTweet({
  required SvgAsset icon,
  required String title,
  VoidCallback? onTap,
  VoidCallback? onTriggered,
  ValueChanged<bool>? onHover,
  EdgeInsetsGeometry? margin,
  Color? backgroundColor,
  Color? textColor,
  required String message,
  required bool isHovered,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 28.0),
    child: ReusableInkWell(
      onTap: onTap,
      onHover: onHover,
      child: ReusableTooltip(
        message: message,
        verticalOffset: 20,
        onTriggered: onTriggered,
        margin: margin,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isHovered
                    ? backgroundColor!.withOpacity(0.25)
                    : Colors.transparent,
              ),
              child: SvgIcon(
                asset: icon,
                height: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isHovered ? textColor : Colors.black,
                decoration:
                    isHovered ? TextDecoration.underline : TextDecoration.none,
                decorationColor: textColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
