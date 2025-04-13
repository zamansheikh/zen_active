class LastMessageModel {
  final String friendId;
  final FriendDetails friendDetails;
  final String lastMessage;
  final DateTime? time;
  final String? connectionId;
  LastMessageModel({
    required this.friendId,
    required this.friendDetails,
    required this.lastMessage,
    required this.time,
    this.connectionId,
  });

  factory LastMessageModel.fromJson(Map<String, dynamic> json) {
    return LastMessageModel(
      friendId: json['friendId'] as String,
      friendDetails:
          FriendDetails.fromJson(json['friendDetails'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'] as String,
      time: DateTime.tryParse(json['time'] as String),
      connectionId: json['connectionId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'friendId': friendId,
      'friendDetails': friendDetails.toJson(), // Convert FriendDetails to JSON
      'lastMessage': lastMessage,
      'time': time?.toIso8601String(),
      'connectionId': connectionId,
    };
  }
}

class FriendDetails {
  final Name name;
  final String email;
  final String image;
  final String id;

  FriendDetails({
    required this.name,
    required this.email,
    required this.image,
    required this.id,
  });

  factory FriendDetails.fromJson(Map<String, dynamic> json) {
    return FriendDetails(
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      email: json['email'] as String,
      image: json['image'] as String,
      id: json['_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.toJson(), // Convert Name to JSON
      'email': email,
      'image': image,
      '_id': id,
    };
  }
}

class Name {
  final String firstName;
  final String lastName;

  Name({
    required this.firstName,
    required this.lastName,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
