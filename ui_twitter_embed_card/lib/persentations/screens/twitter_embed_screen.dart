// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:ui_twitter_embed_card/persentations/widgets/ink_well.dart';
import 'package:ui_twitter_embed_card/persentations/widgets/tool_tip.dart';

import '../../values/values.dart';
import '../widgets/action_tweet.dart';

class TwitterEmbedCard extends StatefulWidget {
  const TwitterEmbedCard({super.key});

  @override
  State<TwitterEmbedCard> createState() => _TwitterEmbedCardState();
}

class _TwitterEmbedCardState extends State<TwitterEmbedCard> {
  bool isAvatarHover = false;
  bool isInfoHover = false;
  bool isTimelineHover = false;
  bool isNameHover = false;
  bool isUsernameHover = false;
  bool isFollowHover = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 623,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUser(),
            const SpaceHeight(16),
            buildTweet(),
            const SpaceHeight(20),
            buildBanner(),
            buildTimelineTweet(),
            const Divider(),
            buildActionTweet(),
            const SpaceHeight(10),
            SizedBox(
              height: 33,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text(
                  'Read ${Strings.repliesNumber} replies',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildActionTweet() {
    return Row(
      children: [
        actionTweet(icon: SvgAsset.heartRed, title: Strings.likesNumber),
        actionTweet(icon: SvgAsset.comment, title: 'Reply'),
        actionTweet(icon: SvgAsset.link, title: 'Copy link'),
      ],
    );
  }

  Widget buildTimelineTweet() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ReusableInkWell(
                onTap: () {
                  js.context.callMethod('open', [Strings.linkProfile]);
                },
                onHover: (value) {
                  setState(() {
                    isTimelineHover = value;
                  });
                },
                child: ReusableTooltip(
                  message: "${Strings.dateHour} · ${Strings.date}",
                  verticalOffset: 8,
                  onTriggered: () {
                    isTimelineHover = true;
                  },
                  child: Text(
                    "${Strings.dateHour} · ${Strings.date}",
                    style: TextStyle(
                      color: Colors.black54,
                      decoration: isTimelineHover
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ReusableInkWell(
            onTap: () {
              js.context.callMethod('open', [Strings.linkInfo]);
            },
            onHover: (value) {
              setState(() {
                isInfoHover = value;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isInfoHover
                    ? Colors.blue.withOpacity(0.25)
                    : Colors.transparent,
              ),
              child: const SvgIcon(
                asset: SvgAsset.info,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(Images.banner),
    );
  }

  Widget buildTweet() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: RichText(
        text: const TextSpan(
          text: Strings.tweet,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget buildUser() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ReusableInkWell(
              onTap: () {
                js.context.callMethod('open', [Strings.linkProfile]);
              },
              onHover: (value) {
                setState(() {
                  isAvatarHover = value;
                });
              },
              child: ReusableTooltip(
                message: 'View profile on X',
                verticalOffset: 26,
                margin: const EdgeInsets.only(left: 36),
                onTriggered: () {
                  isAvatarHover = true;
                },
                child: Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(Images.avatar),
                      radius: 25.0,
                      backgroundColor: Colors.transparent,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isAvatarHover
                              ? Colors.black.withOpacity(0.2)
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SpaceWidth(5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ReusableInkWell(
                      onTap: () {
                        js.context.callMethod('open', [Strings.linkProfile]);
                      },
                      onHover: (value) {
                        setState(() {
                          isNameHover = value;
                        });
                      },
                      child: ReusableTooltip(
                        message: 'View profile on X',
                        onTriggered: () {
                          isNameHover = true;
                        },
                        margin: const EdgeInsets.only(left: 30),
                        child: Text(
                          Strings.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: isNameHover
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SpaceWidth(5),
                    const Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: SvgIcon(asset: SvgAsset.heartBlue, height: 20),
                    ),
                    const SvgIcon(asset: SvgAsset.verified, height: 20),
                  ],
                ),
                Row(
                  children: [
                    ReusableInkWell(
                      onTap: () {
                        js.context.callMethod('open', [Strings.linkProfile]);
                      },
                      onHover: (value) {
                        setState(() {
                          isUsernameHover = value;
                        });
                      },
                      child: ReusableTooltip(
                        message: 'View profile on X',
                        onTriggered: () {
                          isUsernameHover = true;
                        },
                        verticalOffset: 12,
                        margin: const EdgeInsets.only(left: 94),
                        child: const Text(
                          '@${Strings.username}',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text('·', style: TextStyle(color: Colors.grey)),
                    ),
                    ReusableInkWell(
                      onTap: () {
                        js.context.callMethod('open', [Strings.linkProfile]);
                      },
                      onHover: (value) {
                        setState(() {
                          isFollowHover = value;
                        });
                      },
                      child: ReusableTooltip(
                        message: 'View profile on X',
                        margin: const EdgeInsets.only(right: 20),
                        verticalOffset: 12,
                        onTriggered: () {
                          isFollowHover = true;
                        },
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: isFollowHover
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            decorationColor: Colors.blue,
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        const SvgIcon(asset: SvgAsset.x),
      ],
    );
  }
}
