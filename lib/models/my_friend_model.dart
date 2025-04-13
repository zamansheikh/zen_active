import 'package:get/get.dart';

class MyFriendModel {
  final String? id;
  final String? image;
  final String? email;
  final UserName? name;
  final String? connectionId;
  RxBool isOnline = false.obs;
  MyFriendModel({
    this.id,
    this.image,
    this.email,
    this.name,
    this.connectionId,
    bool isOnline = false
  }): isOnline = isOnline.obs;

  factory MyFriendModel.fromJson(Map<String, dynamic> json) {
    return MyFriendModel(
      id: json['_id'],
      image: json['image'],
      email: json['email'],
      name: json['name'] != null ? UserName.fromJson(json['name']) : null,
      connectionId: json['connectionId'],
      isOnline: json['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'email': email,
      'name': name?.toJson(),
      'connectionId': connectionId,
      'isOnline': isOnline,
    };
  }

  MyFriendModel copyWith({
    String? id,
    String? image,
    String? email,
    UserName? name,
    String? connectionId,
    bool? isOnline,
  }) {
    return MyFriendModel(
      id: id ?? this.id,
      image: image ?? this.image,
      email: email ?? this.email,
      name: name ?? this.name,
      connectionId: connectionId ?? this.connectionId,
       isOnline: isOnline ?? this.isOnline.value, 
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

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}