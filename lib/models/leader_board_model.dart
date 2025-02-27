class LeaderboardModel {
  final String? id;
  final UserInfo? userId;
  final int? v;
  final String? createdAt;
  final double? gainedCalories;
  final double? points;
  final double? tdee;
  final String? updatedAt;
  final int? workoutTime;
  final int? completedWorkoutTime;

  LeaderboardModel({
    this.id,
    this.userId,
    this.v,
    this.createdAt,
    this.gainedCalories,
    this.points,
    this.tdee,
    this.updatedAt,
    this.workoutTime,
    this.completedWorkoutTime,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      id: json['_id'],
      userId: json['userId'] != null ? UserInfo.fromJson(json['userId']) : null,
      v: json['__v'],
      createdAt: json['createdAt'],
      gainedCalories: (json['gainedCalories'] as num?)?.toDouble(),
      points: (json['points'] as num?)?.toDouble(),
      tdee: (json['tdee'] as num?)?.toDouble(),
      updatedAt: json['updatedAt'],
      workoutTime: json['workoutTime'],
      completedWorkoutTime: json['completedWorkoutTime'],
    );
  }
}

class UserInfo {
  final String? id;
  final String? email;
  final String? image;
  final UserName? name;

  UserInfo({
    this.id,
    this.email,
    this.image,
    this.name,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
      email: json['email'],
      image: json['image'],
      name: json['name'] != null ? UserName.fromJson(json['name']) : null,
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
