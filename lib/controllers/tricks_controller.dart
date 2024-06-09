// ignore_for_file: invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../views/util.dart';
import '../models/trick_model.dart';
import '../models/trick_step_model.dart';

class TricksController {
  listarTricks() {
    return FirebaseFirestore.instance.collection('tricks').where(
          'idUser',
          isEqualTo: '1',
        );
  }

  listarStepTricks(String idTrick) {
    return FirebaseFirestore.instance.collection('trickStep').where(
          'idTrick',
          isEqualTo: idTrick,
        );
  }

  void addTrick({
    required BuildContext context,
    required TrickModel trick,
    required GlobalKey<FormState> formKey,
  }) async {
    if (formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection('tricks')
          .add(trick.toJson())
          .catchError(
              (e) => erro(context, 'Não foi possível adicionar a trick'))
          .whenComplete(() => Navigator.pop(context));
    }
  }

  void addTrickStep({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required TrickStepModel trickStep,
  }) async {
    if (formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection('trickStep')
          .add(trickStep.toJson())
          .catchError(
              (e) => erro(context, 'Não foi possível favoritar a trick'))
          .whenComplete(() => Navigator.pop(context));
    }
  }

  void updateFavoriteTrick({
    required BuildContext context,
    required String idTrick,
    required bool isFavorite,
  }) {
    FirebaseFirestore.instance
        .collection('tricks')
        .doc(idTrick)
        .update({"isFavorite": isFavorite}).catchError(
            (e) => erro(context, 'Não foi possível favoritar a trick'));
  }

  void updateCheckTrickStep({
    required BuildContext context,
    required String idTrickStep,
    required bool isChecked,
  }) {
    FirebaseFirestore.instance
        .collection('trickStep')
        .doc(idTrickStep)
        .update({"isChecked": isChecked}).catchError(
            (e) => erro(context, 'Não foi possível concluir sua etapa'));
  }

  void excluir({
    required BuildContext context,
    required String id,
  }) async {
    final trickSteps = await FirebaseFirestore.instance
        .collection('trickStep')
        .where(
          'idTrick',
          isEqualTo: id,
        )
        .get();

    for (var trickStep in trickSteps.docs) {
      FirebaseFirestore.instance
          .collection('trickStep')
          .doc(trickStep.id)
          .delete()
          .catchError(
            (e) => erro(context, 'Não foi possível excluir as etapas da trick'),
          );
    }

    FirebaseFirestore.instance
        .collection('tricks')
        .doc(id)
        .delete()
        .whenComplete(
          () => Navigator.pop(context),
        )
        .catchError((e) => erro(context, 'Não foi possível excluir a trick'));
  }

  String? validateTrickName({String? name}) {
    if (name == null || name.isEmpty) {
      return 'Informe o nome da nova trick';
    }

    return null;
  }

  String? validateNameTrickStep({String? name}) {
    if (name == null || name.isEmpty) {
      return 'Informe o nome da nova etapa da trick';
    }

    return null;
  }
}
