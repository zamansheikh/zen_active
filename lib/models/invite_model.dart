class InviteModel {
  final Name name;
  final String id;
  final String email;
  final String image;
  final bool isInvited;

  InviteModel({
    required this.name,
    required this.id,
    required this.email,
    required this.image,
    required this.isInvited,
  });

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      id: json['_id'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      isInvited: json['isInvited'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.toJson(),
      '_id': id,
      'email': email,
      'image': image,
      'isInvited': isInvited,
    };
  }

  InviteModel copyWith({
    Name? name,
    String? id,
    String? email,
    String? image,
    bool? isInvited,
  }) {
    return InviteModel(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      image: image ?? this.image,
      isInvited: isInvited ?? this.isInvited,
    );
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