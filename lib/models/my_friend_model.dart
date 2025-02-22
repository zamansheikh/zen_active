class MyFriendModel {
  final String? id;
  final String? image;
  final String? email;
  final UserName? name;

  MyFriendModel({
    this.id,
    this.image,
    this.email,
    this.name,
  });

  factory MyFriendModel.fromJson(Map<String, dynamic> json) {
    return MyFriendModel(
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
