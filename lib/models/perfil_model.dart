import 'package:skatequest_app/models/achievements_model.dart';
import 'package:skatequest_app/models/trick_model.dart';

class Perfil {
  final String id;
  final String idUser;
  final String username;
  final String description;
  final int skateDays;
  final List<AchievementsModel> achievements;
  final List<TrickModel> tricks;

  Perfil({
    required this.id,
    required this.idUser,
    required this.username,
    this.description = '',
    this.skateDays = 0,
    this.achievements = const <AchievementsModel>[],
    this.tricks = const <TrickModel>[],
  });
}
