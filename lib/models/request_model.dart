class RequestModel {
  final List<RequestedUser>? requestedList;

  RequestModel({
    this.requestedList,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      requestedList: (json['requestedList'] as List<dynamic>?)
          ?.map((e) => RequestedUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestedList': requestedList?.map((e) => e.toJson()).toList(),
    };
  }
}

class RequestedUser {
  final String? id;
  final String? email;
  final String? image;
  final UserName? name;

  RequestedUser({
    this.id,
    this.email,
    this.image,
    this.name,
  });

  factory RequestedUser.fromJson(Map<String, dynamic> json) {
    return RequestedUser(
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
