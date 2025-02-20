class WorkoutModel {
  final String? id;
  final String? name;
  final String? description;
  final int? duration;
  final List<Workout>? workouts;
  final int? points;
  final bool? isDeleted;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final bool? isEnrolled;
  final String? about;

  WorkoutModel({
    this.id,
    this.name,
    this.description,
    this.duration,
    this.workouts,
    this.points,
    this.isDeleted,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isEnrolled,
    this.about,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      workouts: (json['workouts'] as List<dynamic>?)
          ?.map((e) => Workout.fromJson(e as Map<String, dynamic>))
          .toList(),
      points: json['points'],
      isDeleted: json['isDeleted'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      isEnrolled: json['isEnrolled'],
      about: json['about'],
    );
  }
}

class Workout {
  final String? id;
  final String? name;
  final String? description;
  final int? points;
  final bool? isDeleted;
  final List<Exercise>? exercises;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Workout({
    this.id,
    this.name,
    this.description,
    this.points,
    this.isDeleted,
    this.exercises,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      points: json['points'],
      isDeleted: json['isDeleted'],
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
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
