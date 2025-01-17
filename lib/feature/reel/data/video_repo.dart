import 'package:reels_viewer/reels_viewer.dart';

class VideoRepository {
  List<ReelModel> reelsList({
    bool isLiked = false,
    int likeCount = 0,
    List<ReelCommentModel>? comments,
  }) =>
      [
        ReelModel(
          'https://cdn.pixabay.com/video/2016/04/18/2849-163375551_large.mp4',
          'Darshan Patil',
          likeCount: 800 + likeCount,
          isLiked: isLiked,
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/34487/34487-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 500 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://cdn.pixabay.com/video/2021/04/13/70962-536644240_large.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 400 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/39767/39767-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 100 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/52082/52082-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 20 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/48600/48600-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 200 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/42313/42313-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 20 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/43392/43392-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 200 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/43648/43648-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 10 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/49911/49911-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 2 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/40068/40068-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 2 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/43785/43785-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 20 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
        ReelModel(
          'https://assets.mixkit.co/videos/40159/40159-720.mp4',
          'Rahul',
          musicName: 'In the name of Love',
          reelDescription: "Life is better when you're laughing.",
          profileUrl:
              'https://opt.toiimg.com/recuperator/img/toi/m-69257289/69257289.jpg',
          likeCount: 20 + likeCount,
          isLiked: isLiked,
          commentList: comments,
        ),
      ];
}
