import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/util.dart';

class LoginController {
  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe seu nome';
    }

    return null;
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe o e-mail';
    } else if (text.length < 6 || !text.contains('@')) {
      return 'Informe um e-mail válido';
    }

    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe a senha';
    }

    return null;
  }

  String? validateConfirmPassword(String? text, textPassword) {
    if (text == null || text.isEmpty) {
      return 'Informe a confirmação da senha';
    } else if (text != textPassword) {
      return 'As senhas devem ser iguais';
    }

    return null;
  }

  login(context, email, senha) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then(
      (value) {
        Navigator.pushReplacementNamed(context, '/principal');
      },
    ).catchError((e) {
      switch (e.code) {
        case 'invalid-credential':
          erro(context, 'Email e/ou senha inválida');
        case 'invalid-email':
          erro(context, 'O formato do email é inválido');
        case 'missing-password':
          erro(context, 'Informe a sua senha');
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  criarConta(context, nome, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      sucesso(context, 'Usuário criado com sucesso!');
      Navigator.pop(context);
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.');
          break;
        case 'weak-password':
          erro(context, 'Sua senha é fraca.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  esqueceuSenha(context, String email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .catchError((e) => erro(context, 'Não foi possível enviar o e-mail'))
          .then((value) => Navigator.pop(context))
          .then((value) => sucesso(context, 'Email enviado com sucesso!'));
    }
  }

  logout() {
    FirebaseAuth.instance.signOut();
  }

  idUsuario() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
