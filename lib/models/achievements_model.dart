class AchievementsModel {
  final String id;
  final String name;
  final String idUser;
  final bool hasDone;

  AchievementsModel({
    required this.id,
    required this.name,
    required this.idUser,
    this.hasDone = false,
  });
}
