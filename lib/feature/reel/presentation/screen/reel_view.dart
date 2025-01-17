import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reels_viewer/reels_viewer.dart';

class ReelView extends StatefulWidget {
  const ReelView({super.key});

  @override
  State<ReelView> createState() => _ReelViewState();
}

class _ReelViewState extends State<ReelView> {
  List<ReelModel> reelsList = [
    ReelModel(
        'https://cdn.pixabay.com/video/2016/04/18/2849-163375551_large.mp4',
        'Darshan Patil',
        likeCount: 2000,
        isLiked: true,
        musicName: 'In the name of Love',
        reelDescription: "Life is better when you're laughing.",
        profileUrl:
            'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
        commentList: [
          ReelCommentModel(
            comment: 'Nice...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
          ReelCommentModel(
            comment: 'Superr...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
          ReelCommentModel(
            comment: 'Great...',
            userProfilePic:
                'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
            userName: 'Darshan',
            commentTime: DateTime.now(),
          ),
        ]),
    ReelModel(
      'https://assets.mixkit.co/videos/34487/34487-720.mp4',
      'Rahul',
      musicName: 'In the name of Love',
      reelDescription: "Life is better when you're laughing.",
      profileUrl:
          'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
    ),
    ReelModel(
      'https://assets.mixkit.co/videos/34404/34404-720.mp4',
      'Rahul',
    ),
    ReelModel(
      'https://cdn.pixabay.com/video/2021/04/13/70962-536644240_large.mp4',
      'Rahul',
    ),
    ReelModel(
      'https://videos.pexels.com/video-files/30156031/12931118_1080_1920_30fps.mp4',
      'Rahul',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ReelsViewer(
      reelsList: reelsList,
      appbarTitle: 'Instagram Reels',
      onShare: (url) {
        log('Shared reel url ==> $url');
      },
      onLike: (url) {
        log('Liked reel url ==> $url');
      },
      onFollow: () {
        log('======> Clicked on follow <======');
      },
      onComment: (comment) {
        log('Comment on reel ==> $comment');
      },
      onClickMoreBtn: () {
        log('======> Clicked on more option <======');
      },
      onClickBackArrow: () {
        log('======> Clicked on back arrow <======');
      },
      onIndexChanged: (index) {
        log('======> Current Index ======> $index <========');
      },
      showProgressIndicator: true,
      showVerifiedTick: false,
      showAppbar: false,
    );
  }
}
