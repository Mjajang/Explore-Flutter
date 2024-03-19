// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';

import 'package:ui_twitter_embed_card/persentations/widgets/ink_well.dart';
import 'package:ui_twitter_embed_card/persentations/widgets/tool_tip.dart';

import '../../data/tweet_data.dart';
import '../../values/values.dart';
import '../widgets/action_tweet.dart';

class TwitterEmbedCard extends StatefulWidget {
  const TwitterEmbedCard({
    Key? key,
    required this.data,
  }) : super(key: key);
  final TweetData data;

  @override
  State<TwitterEmbedCard> createState() => _TwitterEmbedCardState();
}

class _TwitterEmbedCardState extends State<TwitterEmbedCard> {
  bool isAvatarHover = false;
  bool isInfoHover = false;
  bool isTimelineHover = false;
  bool isLikeHover = false;
  bool isReplyHover = false;
  bool isCopyLinkHover = false;
  bool isNameHover = false;
  bool isUsernameHover = false;
  bool isFollowHover = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUser(
            displayName: widget.data.displayName,
            username: widget.data.username,
            linkProfile: widget.data.linkProfile,
          ),
          const SpaceHeight(16),
          buildTweet(body: widget.data.body),
          buildBanner(bannerImage: widget.data.image),
          const SpaceHeight(8.0),
          buildMetaDataTweet(
            linkProfile: widget.data.linkProfile,
            linkInfo: widget.data.linkInfo,
            time: widget.data.time,
            date: widget.data.date,
          ),
          const Divider(),
          buildActionTweet(
            likesCount: widget.data.likesCount.toString(),
            linkLike: widget.data.linkLike,
            linkReply: widget.data.linkReply,
          ),
          const SpaceHeight(10),
          buildTweetReadRepliesButton(
            repliesCount: widget.data.repliesCount.toString(),
          )
        ],
      ),
    );
  }

  Widget buildTweetReadRepliesButton({required String repliesCount}) {
    return SizedBox(
      height: 33,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        child: Text(
          'Read $repliesCount replies',
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildActionTweet({
    required String likesCount,
    required String linkLike,
    required String linkReply,
  }) {
    return Row(
      children: [
        actionTweet(
          icon: SvgAsset.heartRed,
          title: likesCount,
          message: 'Like this post',
          isHovered: isLikeHover,
          textColor: Colors.redAccent,
          backgroundColor: Colors.redAccent,
          onTap: () {
            js.context.callMethod('open', [linkLike]);
          },
          onHover: (value) {
            setState(() {
              isLikeHover = value;
            });
          },
          onTriggered: () {
            isLikeHover = true;
          },
        ),
        actionTweet(
          icon: SvgAsset.comment,
          title: 'Reply',
          message: 'Reply to this post',
          isHovered: isReplyHover,
          textColor: Colors.blueAccent,
          backgroundColor: Colors.blueAccent,
          onTap: () {
            js.context.callMethod('open', [linkReply]);
          },
          onHover: (value) {
            setState(() {
              isReplyHover = value;
            });
          },
          onTriggered: () {
            isReplyHover = true;
          },
        ),
        actionTweet(
          icon: SvgAsset.link,
          title: 'Copy link',
          message: 'Share this post',
          isHovered: isCopyLinkHover,
          textColor: Colors.greenAccent,
          backgroundColor: Colors.greenAccent,
          onTap: () {},
          onHover: (value) {
            setState(() {
              isCopyLinkHover = value;
            });
          },
          onTriggered: () {
            isCopyLinkHover = true;
          },
        ),
      ],
    );
  }

  Widget buildMetaDataTweet({
    required String linkProfile,
    required String linkInfo,
    required String time,
    required String date,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ReusableInkWell(
              onTap: () {
                js.context.callMethod('open', [linkProfile]);
              },
              onHover: (value) {
                setState(() {
                  isTimelineHover = value;
                });
              },
              child: ReusableTooltip(
                message: "$time · $date",
                verticalOffset: 8,
                onTriggered: () {
                  isTimelineHover = true;
                },
                child: Text(
                  "$time · $date",
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
            js.context.callMethod('open', [linkInfo]);
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
    );
  }

  Widget buildBanner({required String bannerImage}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(bannerImage),
    );
  }

  Widget buildTweet({required String body}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: RichText(
        text: TextSpan(
          text: body,
          style: const TextStyle(
            fontSize: 18,
            height: 1.25,
          ),
        ),
      ),
    );
  }

  Widget buildUser({
    required String displayName,
    required String username,
    required String linkProfile,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ReusableInkWell(
              onTap: () {
                js.context.callMethod('open', [linkProfile]);
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
                        js.context.callMethod('open', [linkProfile]);
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
                          displayName,
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
                        js.context.callMethod('open', [linkProfile]);
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
                        child: Text(
                          username,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text('·', style: TextStyle(color: Colors.grey)),
                    ),
                    ReusableInkWell(
                      onTap: () {
                        js.context.callMethod('open', [linkProfile]);
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
