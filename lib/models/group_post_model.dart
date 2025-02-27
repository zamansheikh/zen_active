class GroupPostModel {
  final String? id;
  final String? text;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final UserInfo? user;
  final GroupInfo? group;
  final List<Comment>? comments;
  final List<Like>? likes;

  GroupPostModel({
    this.id,
    this.text,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.group,
    this.comments,
    this.likes,
  });

  factory GroupPostModel.fromJson(Map<String, dynamic> json) {
    return GroupPostModel(
      id: json['_id'],
      text: json['text'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: json['user'] != null ? UserInfo.fromJson(json['user']) : null,
      group: json['group'] != null ? GroupInfo.fromJson(json['group']) : null,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => Like.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'text': text,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user?.toJson(),
      'group': group?.toJson(),
      'comments': comments?.map((e) => e.toJson()).toList(),
      'likes': likes?.map((e) => e.toJson()).toList(),
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

class GroupInfo {
  final String? id;
  final String? name;
  final String? image;

  GroupInfo({
    this.id,
    this.name,
    this.image,
  });

  factory GroupInfo.fromJson(Map<String, dynamic> json) {
    return GroupInfo(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
    };
  }
}

class Comment {
  final String? id;
  final String? comment;
  final String? userId;
  final String? createdAt;

  Comment({
    this.id,
    this.comment,
    this.userId,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      comment: json['comment'],
      userId: json['userId'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'comment': comment,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}

class Like {
  final String? id;
  final String? userId;

  Like({
    this.id,
    this.userId,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['_id'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
    };
  }
}
