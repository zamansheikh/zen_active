class UserListModel {
  final String? id;
  final String? email;
  final String? image;
  final bool? isProfileUpdated;
  final bool? isDeleted;
  final bool? isBlocked;
  final bool? isVerified;
  final String? role;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final UserName? name;
  final String? appData;
  final String? fcmToken; // Only present in some users
  final String? activityLevel; // Only present in some users
  final String? dateOfBirth; // Only present in some users
  final String? diet; // Only present in some users
  final String? gender; // Only present in some users
  final int? height; // Only present in some users
  final String? injury; // Only present in some users
  final String? medicalCondition; // Only present in some users
  final String? movementDifficulty; // Only present in some users
  final String? primaryGoal; // Only present in some users,
  final String? mobile;
  final int? weight; // Only present in some users
  final String? restriction; // Only present in some users

  UserListModel({
    this.id,
    this.email,
    this.image,
    this.isProfileUpdated,
    this.isDeleted,
    this.isBlocked,
    this.isVerified,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.name,
    this.appData,
    this.fcmToken,
    this.activityLevel,
    this.dateOfBirth,
    this.diet,
    this.gender,
    this.height,
    this.injury,
    this.medicalCondition,
    this.movementDifficulty,
    this.primaryGoal,
    this.mobile,
    this.weight,
    this.restriction,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      id: json['_id'],
      email: json['email'],
      image: json['image'],
      isProfileUpdated: json['isProfileUpdated'],
      isDeleted: json['isDeleted'],
      isBlocked: json['isBlocked'],
      isVerified: json['isVerified'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      name: json['name'] != null ? UserName.fromJson(json['name']) : null,
      appData: json['appData'],
      fcmToken: json['fcmToken'],
      activityLevel: json['activityLevel'],
      dateOfBirth: json['dateOfBirth'],
      diet: json['diet'],
      gender: json['gender'],
      height: json['height'],
      injury: json['injury'],
      medicalCondition: json['medicalCondition'],
      movementDifficulty: json['movementDifficulty'],
      primaryGoal: json['primaryGoal'],
      mobile: json['mobile'],
      weight: json['weight'],
      restriction: json['restriction'],
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
