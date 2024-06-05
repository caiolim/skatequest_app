import 'package:flutter/material.dart';

import './views/home_view.dart';
import './views/principal_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      color: Colors.red[900],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red[900]!,
        ),
      ),
      title: 'skatequest app',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const PrincipalView(),
            );
          case '/home':
            return MaterialPageRoute(
              builder: (context) => const HomeView(),
            );

          default:
            return null;
        }
      },
    );
  }
}
