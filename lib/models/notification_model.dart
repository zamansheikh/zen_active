class NotificationModel {
  final String? id;
  final UserInfo? receiverId;
  final UserInfo? senderId;
  final String? type;
  final String? postId;
  final String? groupId;
  final String? message;
  final bool? isRead;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  NotificationModel({
    this.id,
    this.receiverId,
    this.senderId,
    this.type,
    this.postId,
    this.groupId,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      receiverId: json['receiverId'] != null
          ? UserInfo.fromJson(json['receiverId'])
          : null,
      senderId:
          json['senderId'] != null ? UserInfo.fromJson(json['senderId']) : null,
      type: json['type'],
      postId: json['postId'],
      groupId: json['groupId'],
      message: json['message'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
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
}
