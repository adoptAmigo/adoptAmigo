import 'package:flutter/material.dart';
import "login/login_screen.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdoptAmigo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 65, 34, 122),
          ),
          scaffoldBackgroundColor: Colors.green),
      home: LoginScreen(),
    );
  }
}
