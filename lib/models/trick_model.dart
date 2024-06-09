import './trick_step_model.dart';

class TrickModel {
  final String uid;
  final String name;
  final String idUser;
  final bool isFavorite;
  final List<TrickStepModel> steps;

  TrickModel({
    required this.uid,
    required this.name,
    required this.idUser,
    this.isFavorite = false,
    this.steps = const <TrickStepModel>[],
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "idUser": idUser,
      "isFavorite": isFavorite,
    };
  }

  factory TrickModel.fromJson(Map<String, dynamic> json) {
    return TrickModel(
      uid: json["uid"],
      name: json["name"],
      idUser: json["idUser"],
      isFavorite: json["isFavorite"],
    );
  }
}
