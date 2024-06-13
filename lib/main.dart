import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './firebase_options.dart';
import './views/login_view.dart';
import './views/register_view.dart';
import './views/about_view.dart';
import './views/principal_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      color: Colors.red[900],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red[900]!,
        ),
      ),
      title: 'skatequest app',
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/principal':
            return MaterialPageRoute(
              builder: (context) => const PrincipalView(),
            );
          case '/login':
            return MaterialPageRoute(
              builder: (context) => const LoginView(),
            );
          case '/register':
            return MaterialPageRoute(
              builder: (context) => const RegisterView(),
            );
          case '/about':
            return MaterialPageRoute(
              builder: (context) => const AboutView(),
            );
          default:
            return null;
        }
      },
    );
  }
}
