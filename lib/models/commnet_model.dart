class CommentModel {
  final String? id;
  final String? postId;
  final String? comment;
  final UserInfo? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  CommentModel({
    this.id,
    this.postId,
    this.comment,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      postId: json['postId'],
      comment: json['comment'],
      userId: json['userId'] != null ? UserInfo.fromJson(json['userId']) : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'postId': postId,
      'comment': comment,
      'userId': userId?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class UserInfo {
  final String? id;
  final String? email;
  final String? image;
  final UserName? name;

  UserInfo({
    this.id,
    this.email,
    this.image,
    this.name,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
      email: json['email'],
      image: json['image'],
      name: json['name'] != null ? UserName.fromJson(json['name']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'image': image,
      'name': name?.toJson(),
    };
  }
}

class UserName {
  final String? firstName;
  final String? lastName;

  UserName({
    this.firstName,
    this.lastName,
  });
  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
