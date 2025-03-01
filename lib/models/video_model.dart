class VideoModel {
  final String? id;
  final String? video;
  final String? name;
  final String? image;
  final String? duration;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  VideoModel({
    this.id,
    this.video,
    this.name,
    this.image,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['_id'],
      video: json['video'],
      name: json['name'],
      image: json['image'],
      duration: json['duration'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'video': video,
      'name': name,
      'image': image,
      'duration': duration,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
