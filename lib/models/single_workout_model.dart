class SingleWorkoutModel {
  final String? id;
  final String? userId;
  final WorkoutPlan? workoutPlanId;
  final int? currentWorkoutIndex;
  final int? currentExerciseIndex;
  final String? startedAt;
  final String? endAt;
  final String? isCompleted; // Consider using an enum
  final List<dynamic>?
      completedExercises; // Could be more specific if you know the structure
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  SingleWorkoutModel({
    this.id,
    this.userId,
    this.workoutPlanId,
    this.currentWorkoutIndex,
    this.currentExerciseIndex,
    this.startedAt,
    this.endAt,
    this.isCompleted,
    this.completedExercises,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SingleWorkoutModel.fromJson(Map<String, dynamic> json) {
    return SingleWorkoutModel(
      id: json['_id'],
      userId: json['userId'],
      workoutPlanId: json['workoutPlanId'] != null
          ? WorkoutPlan.fromJson(json['workoutPlanId'])
          : null,
      currentWorkoutIndex: json['currentWorkoutIndex'],
      currentExerciseIndex: json['currentExerciseIndex'],
      startedAt: json['startedAt'],
      endAt: json['endAt'],
      isCompleted: json['isCompleted'],
      completedExercises: json['completedExercises'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class WorkoutPlan {
  final String? id;
  final int? duration;
  final List<Workout>? workouts;

  WorkoutPlan({
    this.id,
    this.duration,
    this.workouts,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
      id: json['_id'],
      duration: json['duration'],
      workouts: (json['workouts'] as List<dynamic>?)
          ?.map((e) => Workout.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
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

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
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

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['_id'],
      name: json['name'],
      sets: json['sets'],
      reps: json['reps'],
      restTime: json['restTime'],
      video: json['video'],
      points: json['points'],
      description: json['description'],
      image: json['image'],
      goal: json['goal'],
      duration: json['duration'],
      isDeleted: json['isDeleted'],
      v: json['__v'],
      about: json['about'],
    );
  }
}
