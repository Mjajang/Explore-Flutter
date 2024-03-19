// ignore_for_file: public_member_api_docs, sort_constructors_first
class TweetData {
  final String displayName;
  final String username;
  final String body;
  final String image;
  final String time;
  final String date;
  final int likesCount;
  final int repliesCount;
  final String linkProfile;
  final String linkInfo;
  final String linkLike;
  final String linkReply;

  TweetData({
    required this.displayName,
    required this.username,
    required this.body,
    required this.image,
    required this.time,
    required this.date,
    required this.likesCount,
    required this.repliesCount,
    required this.linkProfile,
    required this.linkInfo,
    required this.linkLike,
    required this.linkReply,
  });
}

TweetData tweetData = TweetData(
  displayName: 'Andrea Bizzotto',
  username: '@biz84',
  body: '''
Did you know?

When you call `MediaQuery.of(context)` inside a build method, the widget will rebuild when *any* of the MediaQuery properties change.

But there's a better way that lets you depend only on the properties you care about (and minimize unnecessary rebuilds). 👇
''',
  image: 'assets/media-query-banner.jpg',
  time: '10:21 AM',
  date: 'Jun 20, 2023',
  linkProfile:
      'https://twitter.com/biz84?ref_src=twsrc%5Etfw%7Ctwcamp%5Etweetembed%7Ctwterm%5E1671085759858606081%7Ctwgr%5Ecc7f61f4d1b5764f1d603238f0d994439e782178%7Ctwcon%5Es1_&ref_url=https%3A%2F%2Fpro.codewithandrea.com%2Fflutter-ui-challenges%2F001-twitter-embed-card%2F01-intro',
  linkInfo: 'https://help.twitter.com/en/x-for-websites-ads-info-and-privacy',
  linkLike:
      'https://twitter.com/intent/like?ref_src=twsrc%5Etfw%7Ctwcamp%5Etweetembed%7Ctwterm%5E1671085759858606081%7Ctwgr%5E5df0f7f91a450e0b3642ad6d23e10c2c2bbfbdc1%7Ctwcon%5Es1_&ref_url=https%3A%2F%2Fpro.codewithandrea.com%2Fflutter-ui-challenges%2F001-twitter-embed-card%2F01-intro&tweet_id=1671085759858606081',
  linkReply:
      'https://twitter.com/intent/tweet?ref_src=twsrc%5Etfw%7Ctwcamp%5Etweetembed%7Ctwterm%5E1671085759858606081%7Ctwgr%5E5df0f7f91a450e0b3642ad6d23e10c2c2bbfbdc1%7Ctwcon%5Es1_&ref_url=https%3A%2F%2Fpro.codewithandrea.com%2Fflutter-ui-challenges%2F001-twitter-embed-card%2F01-intro&in_reply_to=1671085759858606081',
  likesCount: 997,
  repliesCount: 12,
);
