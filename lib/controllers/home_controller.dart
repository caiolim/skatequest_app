// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../views/util.dart';
import '../models/skate_day_model.dart';
import '../controllers/login_controller.dart';

class HomeController {
  listSkateDays() {
    return FirebaseFirestore.instance
        .collection('skateDays')
        .where('idUser', isEqualTo: LoginController().idUsuario());
  }

  listSkateDaysOnWeek() {
    final today = DateTime.now();
    return FirebaseFirestore.instance
        .collection('skateDays')
        .where(
          'date',
          isGreaterThanOrEqualTo: DateTime(
            today.year,
            today.month,
            today.day - 7,
          ),
        )
        .where(
          'idUser',
          isEqualTo: LoginController().idUsuario(),
        )
        .limit(7);
  }

  favoriteTricks() {
    return FirebaseFirestore.instance
        .collection('tricks')
        .where('idUser', isEqualTo: LoginController().idUsuario())
        .where('isFavorite', isEqualTo: true);
  }

  hasSkateToday(BuildContext context) {
    try {
      return FirebaseFirestore.instance
          .collection('skateDays')
          .where('idUser', isEqualTo: LoginController().idUsuario())
          .orderBy('date', descending: true)
          .limit(1);
    } catch (e) {
      erro(context, 'Não foi possível adicionar o rolê de hoje');
    }
  }

  void addDaySkate({required BuildContext context}) {
    FirebaseFirestore.instance
        .collection('skateDays')
        .add(
          SkateDayModel(
            uid: '',
            idUser: LoginController().idUsuario(),
            date: DateTime.now(),
          ).toJson(),
        )
        .catchError(
            (e) => erro(context, 'Não foi possível adicionar o rolê de hoje'));
  }
}
