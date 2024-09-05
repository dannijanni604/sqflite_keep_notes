import 'package:flutter/material.dart';
import 'package:sqflite_keep_notes/views/home_view.dart';

import 'config/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(), home: const HomeView());
  }
}
