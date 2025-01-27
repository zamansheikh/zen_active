class AchievementModel {
  final String title;
  final String subTitle;
  final String iconPath;
  final bool isCentered;

  AchievementModel({
    required this.title,
    required this.subTitle,
    required this.iconPath,
    this.isCentered = false,
  });
}
