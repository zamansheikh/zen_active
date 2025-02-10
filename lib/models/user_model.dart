class UserModel {
  Name? name;
  String? id;
  String? image;
  String? email;
  bool? isProfileUpdated;
  bool? isDeleted;
  bool? isBlocked;
  bool? isVerified;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? activityLevel;
  DateTime? dateOfBirth;
  String? diet;
  String? gender;
  int? height;
  String? injury;
  String? medicalCondition;
  String? movementDifficulty;
  String? primaryGoal;
  int? weight;
  AppData? appData;

  UserModel({
    this.name,
    this.id,
    this.image,
    this.email,
    this.isProfileUpdated,
    this.isDeleted,
    this.isBlocked,
    this.isVerified,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.activityLevel,
    this.dateOfBirth,
    this.diet,
    this.gender,
    this.height,
    this.injury,
    this.medicalCondition,
    this.movementDifficulty,
    this.primaryGoal,
    this.weight,
    this.appData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      id: json['id'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
      isProfileUpdated: json['isProfileUpdated'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isBlocked: json['isBlocked'] as bool?,
      isVerified: json['isVerified'] as bool?,
      role: json['role'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['v'] as int?,
      activityLevel: json['activityLevel'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      diet: json['diet'] as String?,
      gender: json['gender'] as String?,
      height: json['height'] as int?,
      injury: json['injury'] as String?,
      medicalCondition: json['medicalCondition'] as String?,
      movementDifficulty: json['movementDifficulty'] as String?,
      primaryGoal: json['primaryGoal'] as String?,
      weight: json['weight'] as int?,
      appData:
          json['appData'] != null ? AppData.fromJson(json['appData']) : null,
    );
  }

  UserModel copyWith({
    Name? name,
    String? id,
    String? image,
    String? email,
    bool? isProfileUpdated,
    bool? isDeleted,
    bool? isBlocked,
    bool? isVerified,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? activityLevel,
    DateTime? dateOfBirth,
    String? diet,
    String? gender,
    int? height,
    String? injury,
    String? medicalCondition,
    String? movementDifficulty,
    String? primaryGoal,
    int? weight,
    AppData? appData,
  }) =>
      UserModel(
        name: name ?? this.name,
        id: id ?? this.id,
        image: image ?? this.image,
        email: email ?? this.email,
        isProfileUpdated: isProfileUpdated ?? this.isProfileUpdated,
        isDeleted: isDeleted ?? this.isDeleted,
        isBlocked: isBlocked ?? this.isBlocked,
        isVerified: isVerified ?? this.isVerified,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        activityLevel: activityLevel ?? this.activityLevel,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        diet: diet ?? this.diet,
        gender: gender ?? this.gender,
        height: height ?? this.height,
        injury: injury ?? this.injury,
        medicalCondition: medicalCondition ?? this.medicalCondition,
        movementDifficulty: movementDifficulty ?? this.movementDifficulty,
        primaryGoal: primaryGoal ?? this.primaryGoal,
        weight: weight ?? this.weight,
        appData: appData ?? this.appData,
      );
}

class AppData {
  String? id;
  double? tdee;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AppData({
    this.id,
    this.tdee,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      id: json['id'] as String?,
      tdee: (json['tdee'] as num?)?.toDouble(),
      userId: json['userId'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['v'] as int?,
    );
  }

  AppData copyWith({
    String? id,
    double? tdee,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      AppData(
        id: id ?? this.id,
        tdee: tdee ?? this.tdee,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
}

class Name {
  String? firstName;
  String? lastName;

  Name({
    this.firstName,
    this.lastName,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );
  }

  Name copyWith({
    String? firstName,
    String? lastName,
  }) =>
      Name(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );
}
