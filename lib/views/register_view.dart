// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';
import '../widgets/textformfield_widget.dart';
import '../widgets/button_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _controller = LoginController();
  final formKeyPageOne = GlobalKey<FormState>();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();
  final txtName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          centerTitle: true,
          title: Text(
            'Criar conta',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              SizedBox(height: 32.0),
              Image.asset(
                'assets/images/sls-logo_thumb-detail.png',
                width: 80.0,
              ),
              Expanded(
                child: Form(
                  key: formKeyPageOne,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      SizedBox(height: 16.0),
                      TextFormFieldWidget(
                        label: 'nome',
                        controller: txtName,
                        validator: (value) => _controller.validateName(value),
                      ),
                      SizedBox(height: 16.0),
                      TextFormFieldWidget(
                        label: 'e-mail',
                        controller: txtEmail,
                        validator: (value) => _controller.validateEmail(value),
                      ),
                      SizedBox(height: 16.0),
                      TextFormFieldWidget(
                        label: 'senha',
                        obscureText: true,
                        controller: txtPassword,
                        validator: (value) =>
                            _controller.validatePassword(value),
                      ),
                      SizedBox(height: 16.0),
                      TextFormFieldWidget(
                        label: 'confirmar senha',
                        obscureText: true,
                        controller: txtConfirmPassword,
                        validator: (value) => _controller
                            .validateConfirmPassword(value, txtPassword.text),
                      ),
                      Spacer(),
                      ButtonWidget(
                        text: 'Criar nova conta',
                        color: Colors.red[700]!,
                        textColor: Colors.white,
                        onPressed: () {
                          if (formKeyPageOne.currentState!.validate()) {
                            _controller.criarConta(context, txtName.text,
                                txtEmail.text, txtPassword.text);
                          }
                        },
                      ),
                      SizedBox(height: 56.0)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
