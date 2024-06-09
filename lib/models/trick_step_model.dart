class TrickStepModel {
  final String uid;
  final String name;
  final String idTrick;
  final bool isChecked;

  TrickStepModel({
    required this.uid,
    required this.name,
    required this.idTrick,
    this.isChecked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "idTrick": idTrick,
      "isChecked": isChecked,
    };
  }

  factory TrickStepModel.fromJson(Map<String, dynamic> json) {
    return TrickStepModel(
      uid: json["uid"],
      name: json["name"],
      idTrick: json["idTrick)"],
      isChecked: json["isChecked"],
    );
  }
}
