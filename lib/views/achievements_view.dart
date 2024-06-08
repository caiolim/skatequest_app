// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../controllers/achievements_controller.dart';
import '../models/achievements_model.dart';

class AchievementsView extends StatefulWidget {
  const AchievementsView({super.key});

  @override
  State<AchievementsView> createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
  final achievementsController = AchievementsController();

  @override
  void initState() {
    achievementsController.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/sls-logo_thumb-detail.png',
                  width: 32.0,
                  height: 32.0,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _achievementsSection(
                  title: 'Rolês',
                  achievements:
                      achievementsController.getAllByCategory('roles'),
                ),
                _achievementsSection(
                  title: 'Tricks',
                  achievements:
                      achievementsController.getAllByCategory('tricks'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _achievementsSection({
    String title = 'Conquistas',
    required List<AchievementModel> achievements,
  }) {
    final isOpenNotify = ValueNotifier(true);

    return ValueListenableBuilder(
      valueListenable: isOpenNotify,
      builder: (context, isOpen, child) => Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () => isOpenNotify.value = !isOpen,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      isOpen
                          ? Icons.keyboard_arrow_up_sharp
                          : Icons.keyboard_arrow_down_sharp,
                    ),
                  ],
                ),
              ),
            ),
            isOpen ? gridAchievements(achievements) : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget gridAchievements(List<AchievementModel> achievements) {
    return Container(
      height: achievements.isEmpty ? 80.0 : 480.0,
      padding: const EdgeInsets.all(16.0),
      child: achievements.isEmpty
          ? Container(
              padding: const EdgeInsets.all(16.0),
              child: Text('Não encontramos nenhuma conquista disponível'),
            )
          : GridView.builder(
              itemCount: achievements.length,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 1 / 2,
                mainAxisExtent: 200.0,
                maxCrossAxisExtent: 200.0,
                crossAxisSpacing: 24.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      achievements[index].hasDone
                          ? 'assets/images/achievement.png'
                          : 'assets/images/unlock-achievement.png',
                      width: 110.0,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      achievements[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
