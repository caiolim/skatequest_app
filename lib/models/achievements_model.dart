class AchievementModel {
  final String id;
  final String name;
  final String category;
  final bool hasDone;

  AchievementModel({
    required this.id,
    required this.name,
    required this.category,
    this.hasDone = false,
  });
}
