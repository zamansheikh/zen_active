class RewardModel {
  final String name;
  final String iconPath;
  final int price;
  final bool isCentered;

  RewardModel({
    required this.name,
    required this.iconPath,
    required this.price,
    this.isCentered = false,
  });
}
