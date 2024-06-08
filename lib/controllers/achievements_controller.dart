import 'package:skatequest_app/models/achievements_model.dart';

class AchievementsController {
  List<AchievementModel> achievements = [];

  void initState() {
    achievements = [
      AchievementModel(
        id: '1',
        name: 'Andar de skate por 1 dia',
        category: 'roles',
        hasDone: true,
      ),
      AchievementModel(
        id: '2',
        name: 'Andar de skate por 7 dias',
        category: 'roles',
        hasDone: true,
      ),
      AchievementModel(
        id: '3',
        name: 'Andar de skate por 7 dias seguidos',
        category: 'roles',
      ),
      AchievementModel(
        id: '4',
        name: 'Andar de skate por 30 dias',
        category: 'roles',
      ),
      AchievementModel(
        id: '5',
        name: 'Aprender 1 nova trick',
        category: 'tricks',
        hasDone: true,
      ),
      AchievementModel(
        id: '6',
        name: 'Aprender 3 novas tricks',
        category: 'tricks',
      ),
      AchievementModel(
        id: '5',
        name: 'Aprimorar 5 vezes uma trick aprendida',
        category: 'tricks',
      ),
    ];
  }

  List<AchievementModel> getAllByCategory(String category) {
    return achievements.where((a) => a.category == category).toList();
  }
}
