import 'package:skatequest_app/models/trick_model.dart';

import '../models/trick_step_model.dart';

class TricksController {
  var tricks = [
    // Ollie
    TrickModel(
      id: '123',
      name: 'Ollie',
      idUser: '1',
      steps: <TrickStepModel>[
        TrickStepModel(
          id: '1',
          name: 'Aprender o pop',
          idTrick: '123',
          isChecked: true,
        ),
        TrickStepModel(
          id: '2',
          name: 'Aprender o chute',
          idTrick: '123',
          isChecked: true,
        ),
        TrickStepModel(
          id: '3',
          name: 'Aplicar ollie parado',
          idTrick: '123',
          isChecked: true,
        ),
        TrickStepModel(
          id: '4',
          name: 'Aplicar ollie em movimento',
          idTrick: '123',
          isChecked: true,
        ),
        TrickStepModel(
          id: '5',
          name: 'Pular 1 carrinho',
          idTrick: '123',
          isChecked: true,
        ),
        TrickStepModel(
          id: '6',
          name: 'Pular 2 carrinhos',
          idTrick: '123',
          isChecked: false,
        ),
        TrickStepModel(
          id: '7',
          name: 'Pular 3 carrinhos',
          idTrick: '123',
          isChecked: false,
        ),
      ],
    ),

    // Flip
    TrickModel(
      id: '123',
      name: 'Flip',
      idUser: '1',
      isFavorite: true,
    ),
  ];
}
