class ExerciseModel {
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
  bool? isCompleted;

  ExerciseModel({
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
    this.isCompleted,
  });

  ExerciseModel copyWith({
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
    bool? isCompleted,
  }) =>
      ExerciseModel(
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
        isCompleted: isCompleted ?? this.isCompleted,
      );

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
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
      isCompleted: json['isCompleted'],
    );
  }
}
