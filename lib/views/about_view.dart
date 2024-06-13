// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Sobre'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32.0),
            Text(
              'Flutter Developers',
              style: TextStyle(
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 64.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoDeveloper(
                  name: 'Caio Lima',
                  photo: 'assets/images/caio.jpg',
                ),
                _infoDeveloper(
                  name: 'Audrey Francezi',
                  photo: 'assets/images/audrey.jpg',
                ),
              ],
            ),
            SizedBox(height: 64.0),
            Text(
              'Informações do app',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'O app tem o objetivo incentivar a pratica diária do skate e gamificar o processo de aprendizagem das manobras.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 14.0),
            Spacer(),
            Text(
              'Material Theme Dark',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoDeveloper({required String name, required String photo}) {
    return Column(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(photo),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
