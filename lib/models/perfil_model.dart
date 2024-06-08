import './trick_model.dart';
import './achievements_model.dart';

class Perfil {
  final String id;
  final String idUser;
  final String username;
  final String description;
  final int skateDays;
  final List<TrickModel> tricks;
  final List<AchievementModel> achievements;

  Perfil({
    required this.id,
    required this.idUser,
    required this.username,
    this.description = '',
    this.skateDays = 0,
    this.tricks = const <TrickModel>[],
    this.achievements = const <AchievementModel>[],
  });
}
