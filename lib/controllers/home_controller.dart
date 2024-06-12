// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/skate_day_model.dart';
import '../views/util.dart';

class HomeController {
  listSkateDays() {
    return FirebaseFirestore.instance
        .collection('skateDays')
        .where('idUser', isEqualTo: '1');
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
        .limit(7);
  }

  favoriteTricks() {
    return FirebaseFirestore.instance
        .collection('tricks')
        .where('idUser', isEqualTo: '1')
        .where('isFavorite', isEqualTo: true);
  }

  hasSkateToday(BuildContext context) {
    try {
      return FirebaseFirestore.instance
          .collection('skateDays')
          .where('idUser', isEqualTo: '1')
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
            idUser: '1',
            date: DateTime.now(),
          ).toJson(),
        )
        .catchError(
            (e) => erro(context, 'Não foi possível adicionar o rolê de hoje'));
  }
}
