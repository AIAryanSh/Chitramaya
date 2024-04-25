import 'package:cinebuddy/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.fromARGB(255, 179, 211, 237),
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}