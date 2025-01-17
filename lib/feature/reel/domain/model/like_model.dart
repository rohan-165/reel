// ignore_for_file: public_member_api_docs, sort_constructors_first
class LikeModel {
  int? likeCount;
  bool? isLike;

  LikeModel({
    this.likeCount,
    this.isLike,
  });

  LikeModel.fromJson(Map<String, dynamic> json) {
    likeCount = json['likeCount'];
    isLike = json['isLike'];
  }

  Map<String, dynamic> toJson() {
    return {
      'likeCount': likeCount,
      'isLike': isLike,
    };
  }

  LikeModel copyWith({
    int? likeCount,
    bool? isLike,
  }) {
    return LikeModel(
      likeCount: likeCount ?? this.likeCount,
      isLike: isLike ?? this.isLike,
    );
  }
}
