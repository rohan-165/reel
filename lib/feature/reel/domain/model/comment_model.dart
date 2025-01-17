class CommentModel {
  String? id;
  String? comment;
  String? userProfilePic;
  String? userName;
  String? commentTime;

  CommentModel({
    this.id,
    this.comment,
    this.userProfilePic,
    this.userName,
    this.commentTime,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    userProfilePic = json['userProfilePic'];
    userName = json['userName'];
    commentTime = json['commentTime'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comment': comment,
      'userProfilePic': userProfilePic,
      'userName': userName,
      'commentTime': commentTime,
    };
  }
}
