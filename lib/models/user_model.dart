class UserModel {
  String? id;
  String? email;
  String? role;
  bool? isVerified;
  String? image;
  bool? isProfileUpdated;
  bool? isDeleted;
  bool? isBlocked;
  String? fcmToken;
  String? activityLevel;
  DateTime? dateOfBirth;
  String? diet;
  String? gender;
  int? height;
  Name? name;
  String? primaryGoal;
  String? injury;
  String? movementDifficulty;
  int? weight;
  String? restriction;
  UserAppData? userAppData;
  List<UserMealDatum>? userMealData;
  UserBadgeData? userBadgeData;

  UserModel({
    this.id,
    this.email,
    this.role,
    this.isVerified,
    this.image,
    this.isProfileUpdated,
    this.isDeleted,
    this.isBlocked,
    this.fcmToken,
    this.activityLevel,
    this.dateOfBirth,
    this.diet,
    this.gender,
    this.height,
    this.name,
    this.primaryGoal,
    this.injury,
    this.movementDifficulty,
    this.weight,
    this.restriction,
    this.userAppData,
    this.userMealData,
    this.userBadgeData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      isVerified: json['isVerified'] as bool?,
      image: json['image'] as String?,
      isProfileUpdated: json['isProfileUpdated'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isBlocked: json['isBlocked'] as bool?,
      fcmToken: json['fcmToken'] as String?,
      activityLevel: json['activityLevel'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      diet: json['diet'] as String?,
      gender: json['gender'] as String?,
      height: json['height'] as int?,
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      primaryGoal: json['primaryGoal'] as String?,
      injury: json['injury'] as String?,
      movementDifficulty: json['movementDifficulty'] as String?,
      weight: json['weight'] as int?,
      restriction: json['restriction'] as String?,
      userAppData: json['userAppData'] != null
          ? UserAppData.fromJson(json['userAppData'])
          : null,
      userMealData: json['userMealData'] != null
          ? (json['userMealData'] as List)
              .map((i) => UserMealDatum.fromJson(i))
              .toList()
          : null,
      userBadgeData: json['userBadgeData'] != null
          ? UserBadgeData.fromJson(json['userBadgeData'])
          : null,
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? role,
    bool? isVerified,
    String? image,
    bool? isProfileUpdated,
    bool? isDeleted,
    bool? isBlocked,
    String? fcmToken,
    String? activityLevel,
    DateTime? dateOfBirth,
    String? diet,
    String? gender,
    int? height,
    Name? name,
    String? primaryGoal,
    String? injury,
    String? movementDifficulty,
    int? weight,
    String? restriction,
    UserAppData? userAppData,
    List<UserMealDatum>? userMealData,
    UserBadgeData? userBadgeData,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        role: role ?? this.role,
        isVerified: isVerified ?? this.isVerified,
        image: image ?? this.image,
        isProfileUpdated: isProfileUpdated ?? this.isProfileUpdated,
        isDeleted: isDeleted ?? this.isDeleted,
        isBlocked: isBlocked ?? this.isBlocked,
        fcmToken: fcmToken ?? this.fcmToken,
        activityLevel: activityLevel ?? this.activityLevel,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        diet: diet ?? this.diet,
        gender: gender ?? this.gender,
        height: height ?? this.height,
        name: name ?? this.name,
        primaryGoal: primaryGoal ?? this.primaryGoal,
        injury: injury ?? this.injury,
        movementDifficulty: movementDifficulty ?? this.movementDifficulty,
        weight: weight ?? this.weight,
        restriction: restriction ?? this.restriction,
        userAppData: userAppData ?? this.userAppData,
        userMealData: userMealData ?? this.userMealData,
        userBadgeData: userBadgeData ?? this.userBadgeData,
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

class UserAppData {
  String? id;
  String? userId;
  int? v;
  DateTime? createdAt;
  int? gainedCalories;
  int? points;
  double? tdee;
  int? workoutTime;

  DateTime? updatedAt;

  UserAppData({
    this.id,
    this.userId,
    this.v,
    this.createdAt,
    this.gainedCalories,
    this.points,
    this.tdee,
    this.workoutTime,
    this.updatedAt,
  });

  factory UserAppData.fromJson(Map<String, dynamic> json) {
    return UserAppData(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      v: json['v'] as int?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      gainedCalories: json['gainedCalories'] as int?,
      points: json['points'] as int?,
      tdee: (json['tdee'] as num?)?.toDouble(),
      workoutTime: json['workoutTime'] as int?,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  UserAppData copyWith({
    String? id,
    String? userId,
    int? v,
    DateTime? createdAt,
    int? gainedCalories,
    int? points,
    double? tdee,
    int? workoutTime,
    DateTime? updatedAt,
  }) =>
      UserAppData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        v: v ?? this.v,
        createdAt: createdAt ?? this.createdAt,
        gainedCalories: gainedCalories ?? this.gainedCalories,
        points: points ?? this.points,
        tdee: tdee ?? this.tdee,
        updatedAt: updatedAt ?? this.updatedAt,
        workoutTime: workoutTime ?? this.workoutTime,
      );
}

class UserBadgeData {
  String? id;
  String? name;
  String? image;
  int? points;
  bool? isDeleted;
  int? v;

  UserBadgeData({
    this.id,
    this.name,
    this.image,
    this.points,
    this.isDeleted,
    this.v,
  });

  factory UserBadgeData.fromJson(Map<String, dynamic> json) {
    return UserBadgeData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      points: json['points'] as int?,
      isDeleted: json['isDeleted'] as bool?,
      v: json['v'] as int?,
    );
  }

  UserBadgeData copyWith({
    String? id,
    String? name,
    String? image,
    int? points,
    bool? isDeleted,
    int? v,
  }) =>
      UserBadgeData(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        points: points ?? this.points,
        isDeleted: isDeleted ?? this.isDeleted,
        v: v ?? this.v,
      );
}

class UserMealDatum {
  String? id;
  String? mealName;
  String? image;
  String? category;
  List<String>? suitableFor;
  NutritionalInfo? nutritionalInfo;
  bool? isDeleted;
  String? mealTime;
  int? amount;
  int? v;

  UserMealDatum({
    this.id,
    this.mealName,
    this.image,
    this.category,
    this.suitableFor,
    this.nutritionalInfo,
    this.isDeleted,
    this.mealTime,
    this.amount,
    this.v,
  });

  factory UserMealDatum.fromJson(Map<String, dynamic> json) {
    return UserMealDatum(
      id: json['id'] as String?,
      mealName: json['mealName'] as String?,
      image: json['image'] as String?,
      category: json['category'] as String?,
      suitableFor: json['suitableFor'] != null
          ? List<String>.from(json['suitableFor'])
          : null,
      nutritionalInfo: json['nutritionalInfo'] != null
          ? NutritionalInfo.fromJson(json['nutritionalInfo'])
          : null,
      isDeleted: json['isDeleted'] as bool?,
      mealTime: json['mealTime'] as String?,
      amount: json['amount'] as int?,
      v: json['v'] as int?,
    );
  }

  UserMealDatum copyWith({
    String? id,
    String? mealName,
    String? image,
    String? category,
    List<String>? suitableFor,
    NutritionalInfo? nutritionalInfo,
    bool? isDeleted,
    String? mealTime,
    int? amount,
    int? v,
  }) =>
      UserMealDatum(
        id: id ?? this.id,
        mealName: mealName ?? this.mealName,
        image: image ?? this.image,
        category: category ?? this.category,
        suitableFor: suitableFor ?? this.suitableFor,
        nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
        isDeleted: isDeleted ?? this.isDeleted,
        mealTime: mealTime ?? this.mealTime,
        amount: amount ?? this.amount,
        v: v ?? this.v,
      );
}

class NutritionalInfo {
  int? calories;
  int? carbs;
  int? proteins;
  int? fats;

  NutritionalInfo({
    this.calories,
    this.carbs,
    this.proteins,
    this.fats,
  });

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {
    return NutritionalInfo(
      calories: json['calories'] as int?,
      carbs: json['carbs'] as int?,
      proteins: json['proteins'] as int?,
      fats: json['fats'] as int?,
    );
  }

  NutritionalInfo copyWith({
    int? calories,
    int? carbs,
    int? proteins,
    int? fats,
  }) =>
      NutritionalInfo(
        calories: calories ?? this.calories,
        carbs: carbs ?? this.carbs,
        proteins: proteins ?? this.proteins,
        fats: fats ?? this.fats,
      );
}
