// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:reel/feature/reel/domain/model/comment_model.dart';
import 'package:reel/feature/reel/domain/model/like_model.dart';

class ItemReelModel {
  String? reelUrl;
  LikeModel? likeUrl;
  List<CommentModel>? commentUrl;

  ItemReelModel({
    this.reelUrl,
    this.likeUrl,
    this.commentUrl,
  });

  ItemReelModel.fromJson(Map<String, dynamic> json) {
    reelUrl = json['url'];
    likeUrl =
        json['like_url'] != null ? LikeModel.fromJson(json['like_url']) : null;

    commentUrl = json['comment_url'] != null
        ? List<CommentModel>.from(json['comment_url']
            .map((comment) => CommentModel.fromJson(comment)))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'url': reelUrl,
      'like_url': likeUrl?.toJson(),
      if (commentUrl != null) ...{
        'comment_url': commentUrl?.map((comment) => comment.toJson()).toList(),
      }
    };
  }

  ItemReelModel copyWith({
    String? reelUrl,
    LikeModel? likeUrl,
    List<CommentModel>? commentUrl,
  }) {
    return ItemReelModel(
      reelUrl: reelUrl ?? this.reelUrl,
      likeUrl: likeUrl ?? this.likeUrl,
      commentUrl: commentUrl ?? this.commentUrl,
    );
  }
}
