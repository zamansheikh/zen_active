class RewardModel {
  final String? id;
  final String? name;
  final String? image;
  final int? price;
  final bool? isCentered;
  final bool? isDeleted;
  final bool? isEligibleToClaim;

  RewardModel({
    required this.name,
    required this.image,
    required this.price,
    this.isCentered = false,
    this.id,
    this.isDeleted,
    this.isEligibleToClaim,
  });



  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: json['points'] as int?,
      isDeleted: json['isDeleted'] as bool?,
      isEligibleToClaim: json['isEligibleToClaim'] as bool?,
    );
  }
}
