import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/home.dart';
import 'package:flutter_todo/pages/home_on_state.dart';
import 'package:flutter_todo/pages/main_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    // home: const MainScreen(),
    initialRoute: '/',
    routes: {
      '/' : (context) => const MainScreen(),
      '/todo': (context) => const Home(),
      '/todo_state': (context) => const HomeOnState(),
    },
  ));
}
