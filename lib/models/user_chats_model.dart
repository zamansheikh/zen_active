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

  // Add a message to the chat list.  Crucially, returns a *new* UserChatsModel.
  UserChatsModel addMessage({
    required String message,
    required String senderId,
    required String receiverId,
  }) {
    // Find sender and receiver info.  Important: We're making the assumption here
    // that the sender and receiver *already exist* in either the existing
    // userChat list or the userFriendShipStatus.  If they don't, we need to
    // handle that case (see below).
    UserInfo? senderInfo;
    UserInfo? receiverInfo;

    // Check existing chats first
    for (final chat in userChat ?? <UserChat>[]) {
      if (chat.senderId?.id == senderId) {
        senderInfo = chat.senderId;
      }
      if (chat.receiverId?.id == senderId) {
        // Corrected: Check *receiverId*
        senderInfo = chat.receiverId;
      }
      if (chat.senderId?.id == receiverId) {
        // Corrected
        receiverInfo = chat.senderId;
      }

      if (chat.receiverId?.id == receiverId) {
        receiverInfo = chat.receiverId;
      }
    }

    // If not found in chats, check friendship status (less efficient, but necessary)
    senderInfo ??= userFriendShipStatus?.senderId?.id == senderId
        ? userFriendShipStatus?.senderId
        : userFriendShipStatus?.receiverId?.id == senderId
            ? userFriendShipStatus?.receiverId
            : null;

    receiverInfo ??= userFriendShipStatus?.senderId?.id == receiverId
        ? userFriendShipStatus?.senderId
        : userFriendShipStatus?.receiverId?.id == receiverId
            ? userFriendShipStatus?.receiverId
            : null;

    // Create a new UserChat object.
    final newUserChat = UserChat(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
      senderId: senderInfo, // Use the found UserInfo objects
      receiverId: receiverInfo,
      message: message,
      createdAt: DateTime.now()
          .toUtc()
          .toIso8601String(), // Use current time in UTC, ISO 8601 format
      updatedAt: DateTime.now()
          .toUtc()
          .toIso8601String(), // Same as createdAt initially
      v: 0, // You might want to handle __v differently in a real app.
    );

    // Create a *new* list containing the existing chats plus the new chat.
    // This is important for immutability, which is good practice in Flutter.
    final updatedUserChatList = List<UserChat>.from(userChat ?? [])
      ..add(newUserChat);

    // Return a *new* UserChatsModel with the updated chat list.
    return UserChatsModel(
      userChat: updatedUserChatList,
      userFriendShipStatus: userFriendShipStatus,
    );
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
  final String? connectionId;

  UserFriendShipStatus({
    this.id,
    this.senderId,
    this.receiverId,
    this.isAccepted,
    this.status,
    this.statusChangeBy,
    this.connectionId,
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
      connectionId: json['connectionId'],
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
