class SingleExerciseModel {
  Exercise? exercise;
  int? participant;

  SingleExerciseModel({
    this.exercise,
    this.participant,
  });

  SingleExerciseModel copyWith({
    Exercise? exercise,
    int? participant,
  }) =>
      SingleExerciseModel(
        exercise: exercise ?? this.exercise,
        participant: participant ?? this.participant,
      );

  factory SingleExerciseModel.fromJson(Map<String, dynamic> json) {
    return SingleExerciseModel(
      exercise:
          json['exercise'] != null ? Exercise.fromJson(json['exercise']) : null,
      participant: json['participant'],
    );
  }
}

class Exercise {
  String? id;
  String? name;
  int? sets;
  int? reps;
  int? restTime;
  String? video;
  int? points;
  String? description;
  String? image;
  String? goal;
  int? duration;
  bool? isDeleted;
  int? v;
  String? about;

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

  Exercise copyWith({
    String? id,
    String? name,
    int? sets,
    int? reps,
    int? restTime,
    String? video,
    int? points,
    String? description,
    String? image,
    String? goal,
    int? duration,
    bool? isDeleted,
    int? v,
    String? about,
  }) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        sets: sets ?? this.sets,
        reps: reps ?? this.reps,
        restTime: restTime ?? this.restTime,
        video: video ?? this.video,
        points: points ?? this.points,
        description: description ?? this.description,
        image: image ?? this.image,
        goal: goal ?? this.goal,
        duration: duration ?? this.duration,
        isDeleted: isDeleted ?? this.isDeleted,
        v: v ?? this.v,
        about: about ?? this.about,
      );

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
      v: json['v'],
      about: json['about'],
    );
  }
}
