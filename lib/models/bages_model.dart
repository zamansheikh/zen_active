class BadgesModel {
  final String? id;
  final String? name;
  final String? image;
  final int? points;
  final bool? isDeleted;
  final int? v; //  __v might be int or null
  final bool? isEligibleToClaim;

  BadgesModel({
    this.id,
    this.name,
    this.image,
    this.points,
    this.isDeleted,
    this.v,
    this.isEligibleToClaim,
  });

  factory BadgesModel.fromJson(Map<String, dynamic> json) {
    return BadgesModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      points: json['points'] as int?,
      isDeleted: json['isDeleted'] as bool?,
      v: json['__v'] as int?,
      isEligibleToClaim: json['isEligibleToClaim'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'points': points,
      'isDeleted': isDeleted,
      '__v': v,
      'isEligibleToClaim': isEligibleToClaim,
    };
  }

  @override
  String toString() {
    return 'Badges{id: $id, name: $name, image: $image, points: $points, isDeleted: $isDeleted, v: $v, isEligibleToClaim: $isEligibleToClaim}';
  }
}
