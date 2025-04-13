class DiscoverGroupModel {
  final String? id;
  final String? name;
  final String? type;
  final String? goal;
  final String? admin;
  final bool? isDeleted;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final int? totalMembers;
  final int? v;

  DiscoverGroupModel({
    this.id,
    this.name,
    this.type,
    this.goal,
    this.admin,
    this.isDeleted,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.totalMembers,
    this.v,
  });

  factory DiscoverGroupModel.fromJson(Map<String, dynamic> json) {
    return DiscoverGroupModel(
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      goal: json['goal'],
      admin: json['admin'],
      isDeleted: json['isDeleted'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      totalMembers: json['totalMembers'],
      v: json['__v'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'type': type,
      'goal': goal,
      'admin': admin,
      'isDeleted': isDeleted,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'totalMembers': totalMembers,
      '__v': v,
    };
  }
}
