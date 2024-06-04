class TrickStepModel {
  final String id;
  final String name;
  final String idTrick;
  final bool isChecked;

  TrickStepModel({
    required this.id,
    required this.name,
    required this.idTrick,
    this.isChecked = false,
  });
}
