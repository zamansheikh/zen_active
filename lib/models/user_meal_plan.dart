class UserMealPlan {
  String? id;
  String? mealName;
  String? image;
  String? category;
  List<String>? suitableFor;
  NutritionalInfo? nutritionalInfo;
  bool? isDeleted;
  String? mealTime;
  int? amount;
  bool? isCompleted;
  int? v;

  UserMealPlan({
    this.id,
    this.mealName,
    this.image,
    this.category,
    this.suitableFor,
    this.nutritionalInfo,
    this.isDeleted,
    this.mealTime,
    this.amount,
    this.isCompleted,
    this.v,
  });

  UserMealPlan copyWith({
    String? id,
    String? mealName,
    String? image,
    String? category,
    List<String>? suitableFor,
    NutritionalInfo? nutritionalInfo,
    bool? isDeleted,
    String? mealTime,
    int? amount,
    bool? isCompleted,
    int? v,
  }) =>
      UserMealPlan(
        id: id ?? this.id,
        mealName: mealName ?? this.mealName,
        image: image ?? this.image,
        category: category ?? this.category,
        suitableFor: suitableFor ?? this.suitableFor,
        nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
        isDeleted: isDeleted ?? this.isDeleted,
        mealTime: mealTime ?? this.mealTime,
        amount: amount ?? this.amount,
        isCompleted: isCompleted ?? this.isCompleted,
        v: v ?? this.v,
      );

  factory UserMealPlan.fromJson(Map<String, dynamic> json) => UserMealPlan(
        id: json['_id'],
        mealName: json['mealName'],
        image: json['image'],
        category: json['category'],
        suitableFor: json['suitableFor'] != null
            ? List<String>.from(json['suitableFor'])
            : null,
        nutritionalInfo: json['nutritionalInfo'] != null
            ? NutritionalInfo.fromJson(json['nutritionalInfo'])
            : null,
        isDeleted: json['isDeleted'],
        mealTime: json['mealTime'],
        amount: json['amount'],
        isCompleted: json['isComplete'] ?? false,
        v: json['v'],
      );
}

class NutritionalInfo {
  int? calories;
  int? carbs;
  int? proteins;
  int? fats;

  NutritionalInfo({
    this.calories,
    this.carbs,
    this.proteins,
    this.fats,
  });

  NutritionalInfo copyWith({
    int? calories,
    int? carbs,
    int? proteins,
    int? fats,
  }) =>
      NutritionalInfo(
        calories: calories ?? this.calories,
        carbs: carbs ?? this.carbs,
        proteins: proteins ?? this.proteins,
        fats: fats ?? this.fats,
      );

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) =>
      NutritionalInfo(
        calories: json['calories'],
        carbs: json['carbs'],
        proteins: json['proteins'],
        fats: json['fats'],
      );
}
