import './trick_step_model.dart';

class TrickModel {
  final String id;
  final String name;
  final String idUser;
  final bool isFavorite;
  final List<TrickStepModel> steps;

  TrickModel({
    required this.id,
    required this.name,
    required this.idUser,
    this.isFavorite = false,
    this.steps = const <TrickStepModel>[],
  });
}
