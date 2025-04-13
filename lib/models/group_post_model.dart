

class GroupPostModel {
  final String? id;
  final String? text;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final Group? group;
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

  factory GroupPostModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return GroupPostModel();
    }
    return GroupPostModel(
      id: json['_id'] as String?,
      text: json['text'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>?)
          : null,
      group: json['group'] != null
          ? Group.fromJson(json['group'] as Map<String, dynamic>?)
          : null,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>?))
          .toList(),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => Like.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'text': text,
      'image': image,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'user': user?.toJson(),
      'group': group?.toJson(),
      'comments': comments?.map((e) => e.toJson()).toList(),
      'likes': likes?.map((e) => e.toJson()).toList(),
    };
  }
}

class User {
  final String? id;
  final String? email;
  final String? image;
  final Name? name;

  User({
    this.id,
    this.email,
    this.image,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return User();
    }
    return User(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      name: json['name'] != null
          ? Name.fromJson(json['name'] as Map<String, dynamic>?)
          : null,
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

class Name {
  final String? firstName;
  final String? lastName;

  Name({
    this.firstName,
    this.lastName,
  });

  factory Name.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Name();
    }
    return Name(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}

class Group {
  final String? id;
  final String? name;
  final String? image;

  Group({
    this.id,
    this.name,
    this.image,
  });

  factory Group.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Group();
    }
    return Group(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
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
  final DateTime? createdAt;

  Comment({
    this.id,
    this.comment,
    this.userId,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Comment();
    }
    return Comment(
      id: json['_id'] as String?,
      comment: json['comment'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'comment': comment,
      'userId': userId,
      'createdAt': createdAt?.toIso8601String(),
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

  factory Like.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Like();
    }
    return Like(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
    };
  }
}
