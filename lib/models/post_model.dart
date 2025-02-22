class PostModel {
  final String? id;
  final String? text;
  final String? userId;
  final String? groupId;
  final bool? isGroup;
  final bool? isDelete;
  final String? createdAt;
  final String? updatedAt;
  final UserInfo? userInfo;
  final List<Comment>? comments;
  final List<Like>? likes;
  final bool? isLiked;
  final int? v;

  PostModel({
    this.id,
    this.text,
    this.userId,
    this.groupId,
    this.isGroup,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
    this.userInfo,
    this.comments,
    this.likes,
    this.isLiked,
    this.v,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['_id'],
        text: json['text'],
        userId: json['userId'],
        groupId: json['groupId'],
        isGroup: json['isGroup'],
        isDelete: json['isDelete'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        userInfo: json['userInfo'] != null
            ? UserInfo.fromJson(json['userInfo'])
            : null,
        comments: (json['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
            .toList(),
        likes: (json['likes'] as List<dynamic>?)
            ?.map((e) => Like.fromJson(e as Map<String, dynamic>))
            .toList(),
        isLiked: json['isLiked'],
        v: json['__v'] //  handle potential missing __v
        );
  }
}

class UserInfo {
  final String? id;
  final String? email;
  final String? image;
  final Name? name;

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
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
    );
  }
}

class Name {
  final String? firstName;
  final String? lastName;

  Name({
    this.firstName,
    this.lastName,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class Comment {
  final String? id;
  final String? postId;
  final String? comment;
  final String? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Comment({
    this.id,
    this.postId,
    this.comment,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      postId: json['postId'],
      comment: json['comment'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class Like {
  final String? id;
  final String? postId;
  final String? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Like({
    this.id,
    this.postId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['_id'],
      postId: json['postId'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
