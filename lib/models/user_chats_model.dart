class UserChatsModel {
  final List<UserChat>? userChat;
  final UserFriendShipStatus? userFriendShipStatus;

  UserChatsModel({
    this.userChat,
    this.userFriendShipStatus,
  });

  factory UserChatsModel.fromJson(Map<String, dynamic> json) {
    return UserChatsModel(
      userChat: (json['userChat'] as List<dynamic>?)
          ?.map((e) => UserChat.fromJson(e as Map<String, dynamic>))
          .toList(),
      userFriendShipStatus: json['userFriendShipStatus'] != null
          ? UserFriendShipStatus.fromJson(json['userFriendShipStatus'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userChat': userChat?.map((e) => e.toJson()).toList(),
      'userFriendShipStatus': userFriendShipStatus?.toJson(),
    };
  }
}

class UserChat {
  final String? id;
  final UserInfo? senderId;
  final UserInfo? receiverId;
  final String? message;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  UserChat({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserChat.fromJson(Map<String, dynamic> json) {
    return UserChat(
      id: json['_id'],
      senderId:
          json['senderId'] != null ? UserInfo.fromJson(json['senderId']) : null,
      receiverId: json['receiverId'] != null
          ? UserInfo.fromJson(json['receiverId'])
          : null,
      message: json['message'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'senderId': senderId?.toJson(),
      'receiverId': receiverId?.toJson(),
      'message': message,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class UserFriendShipStatus {
  final String? id;
  final UserInfo? senderId;
  final UserInfo? receiverId;
  final bool? isAccepted;
  final dynamic status; // Can be null, so using dynamic
  final dynamic statusChangeBy; // Can be null

  UserFriendShipStatus({
    this.id,
    this.senderId,
    this.receiverId,
    this.isAccepted,
    this.status,
    this.statusChangeBy,
  });

  factory UserFriendShipStatus.fromJson(Map<String, dynamic> json) {
    return UserFriendShipStatus(
      id: json['_id'],
      senderId:
          json['senderId'] != null ? UserInfo.fromJson(json['senderId']) : null,
      receiverId: json['receiverId'] != null
          ? UserInfo.fromJson(json['receiverId'])
          : null,
      isAccepted: json['isAccepted'],
      status: json['status'],
      statusChangeBy: json['statusChangeBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'senderId': senderId?.toJson(),
      'receiverId': receiverId?.toJson(),
      'isAccepted': isAccepted,
      'status': status,
      'statusChangeBy': statusChangeBy,
    };
  }
}

class UserInfo {
  final String? id;
  final String? image;
  final String? email;
  final UserName? name;

  UserInfo({
    this.id,
    this.image,
    this.email,
    this.name,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
      image: json['image'],
      email: json['email'],
      name: json['name'] != null ? UserName.fromJson(json['name']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'email': email,
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
