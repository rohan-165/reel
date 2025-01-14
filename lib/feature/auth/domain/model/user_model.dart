// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;

  UserModel({
    this.displayName,
    this.email,
    this.id,
    this.photoUrl,
  });

  UserModel.fromJsom(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    id = json['id'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['id'] = id;
    data['photoUrl'] = photoUrl;
    return data;
  }

  UserModel copyWith({
    String? displayName,
    String? email,
    String? id,
    String? photoUrl,
  }) {
    return UserModel(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
