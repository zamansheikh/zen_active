class GroupModel {
  final String? id;
  final String? name;
  final String? type;
  final String? goal;
  final String? admin;
  final bool? isDeleted;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final int? totalMembers;

  GroupModel({
    this.id,
    this.name,
    this.type,
    this.goal,
    this.admin,
    this.isDeleted,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalMembers,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      goal: json['goal'],
      admin: json['admin'],
      isDeleted: json['isDeleted'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      totalMembers: json['totalMembers'],
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
      '__v': v,
      'totalMembers': totalMembers
    };
  }
}
