import './trick_step_model.dart';

class TrickModel {
  final String id;
  final String name;
  final String idUser;
  final List<TrickStepModel> steps;

  TrickModel({
    required this.id,
    required this.name,
    required this.idUser,
    this.steps = const <TrickStepModel>[],
  });
}
