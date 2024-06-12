class SkateDayModel {
  final String uid;
  final String idUser;
  final DateTime date;

  SkateDayModel({required this.uid, required this.idUser, required this.date});

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "idUser": idUser,
      "date": date,
    };
  }

  factory SkateDayModel.fromJson(Map<String, dynamic> json) {
    return SkateDayModel(
      uid: json["uid"],
      idUser: json["idUser"],
      date: json["date"],
    );
  }
}
