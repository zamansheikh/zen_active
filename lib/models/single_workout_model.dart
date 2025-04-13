class SingleWorkoutModel {
  final String? id;
  final String? userId;
  final WorkoutPlan? workoutPlan;
  final int? currentWorkoutIndex;
  final int? currentExerciseIndex;
  final DateTime? startedAt;
  final DateTime? endAt;
  final String? isCompleted;
  final List<CompletedExercise>? completedExercises;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<String>? missedDays;

  SingleWorkoutModel({
    this.id,
    this.userId,
    this.workoutPlan,
    this.currentWorkoutIndex,
    this.currentExerciseIndex,
    this.startedAt,
    this.endAt,
    this.isCompleted,
    this.completedExercises,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.missedDays,
  });

  factory SingleWorkoutModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SingleWorkoutModel();
    }
    return SingleWorkoutModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      workoutPlan: json['workoutPlanId'] != null
          ? WorkoutPlan.fromJson(json['workoutPlanId'] as Map<String, dynamic>?)
          : null,
      currentWorkoutIndex: json['currentWorkoutIndex'] as int?,
      currentExerciseIndex: json['currentExerciseIndex'] as int?,
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'] as String)
          : null,
      endAt: json['endAt'] != null
          ? DateTime.parse(json['endAt'] as String)
          : null,
      isCompleted: json['isCompleted'] as String?,
      completedExercises: (json['completedExercises'] as List<dynamic>?)
          ?.map((e) => CompletedExercise.fromJson(e as Map<String, dynamic>?))
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      v: json['__v'] as int?,
      missedDays: (json['missedDays'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'workoutPlanId': workoutPlan?.toJson(),
      'currentWorkoutIndex': currentWorkoutIndex,
      'currentExerciseIndex': currentExerciseIndex,
      'startedAt': startedAt?.toIso8601String(),
      'endAt': endAt?.toIso8601String(),
      'isCompleted': isCompleted,
      'completedExercises': completedExercises?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
      'missedDays': missedDays,
    };
  }
}

class WorkoutPlan {
  final String? id;
  final String? name;
  final String? description;
  final int? duration;
  final List<Workout>? workouts;
  final String? image;
  final String? about;

  WorkoutPlan({
    this.id,
    this.name,
    this.description,
    this.duration,
    this.workouts,
    this.image,
    this.about,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return WorkoutPlan();
    }
    return WorkoutPlan(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] as int?,
      workouts: (json['workouts'] as List<dynamic>?)
          ?.map((e) => Workout.fromJson(e as Map<String, dynamic>?))
          .toList(),
      image: json['image'] as String?,
      about: json['about'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'workouts': workouts?.map((e) => e.toJson()).toList(),
      'image': image,
      'about': about,
    };
  }
}

class Workout {
  final String? id;
  final String? name;
  final String? description;
  final List<Exercise>? exercises;

  Workout({
    this.id,
    this.name,
    this.description,
    this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Workout();
    }
    return Workout(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'exercises': exercises?.map((e) => e.toJson()).toList(),
    };
  }
}

class Exercise {
  final String? id;
  final String? name;
  final int? sets;
  final int? reps;
  final int? restTime;
  final String? video;
  final int? points;
  final String? description;
  final String? image;
  final String? goal;
  final int? duration;
  final bool? isDeleted;
  final int? v;
  final String? about;

  Exercise({
    this.id,
    this.name,
    this.sets,
    this.reps,
    this.restTime,
    this.video,
    this.points,
    this.description,
    this.image,
    this.goal,
    this.duration,
    this.isDeleted,
    this.v,
    this.about,
  });

  factory Exercise.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Exercise();
    }
    return Exercise(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      sets: json['sets'] as int?,
      reps: json['reps'] as int?,
      restTime: json['restTime'] as int?,
      video: json['video'] as String?,
      points: json['points'] as int?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      goal: json['goal'] as String?,
      duration: json['duration'] as int?,
      isDeleted: json['isDeleted'] as bool?,
      v: json['__v'] as int?,
      about: json['about'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'sets': sets,
      'reps': reps,
      'restTime': restTime,
      'video': video,
      'points': points,
      'description': description,
      'image': image,
      'goal': goal,
      'duration': duration,
      'isDeleted': isDeleted,
      '__v': v,
      'about': about,
    };
  }
}

class CompletedExercise {
  final int? workoutIndex;
  final int? exerciseIndex;
  final DateTime? completedAt;
  final String? id;

  CompletedExercise({
    this.workoutIndex,
    this.exerciseIndex,
    this.completedAt,
    this.id,
  });

  factory CompletedExercise.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return CompletedExercise();
    }
    return CompletedExercise(
      workoutIndex: json['workoutIndex'] as int?,
      exerciseIndex: json['exerciseIndex'] as int?,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workoutIndex': workoutIndex,
      'exerciseIndex': exerciseIndex,
      'completedAt': completedAt?.toIso8601String(),
      '_id': id,
    };
  }
}
