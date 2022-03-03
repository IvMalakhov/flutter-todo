import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/auth.dart';
import 'package:flutter_todo/pages/home.dart';
import 'package:flutter_todo/pages/home_on_state.dart';
import 'package:flutter_todo/pages/main_screen.dart';
import 'package:flutter_todo/const/routs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    // home: const MainScreen(),
    initialRoute: Routs.auth,
    routes: {
      Routs.auth : (context) => const Auth(),
      Routs.main : (context) => const MainScreen(),
      Routs.todoFB : (context) => const Home(),
      Routs.todoOnState: (context) => const HomeOnState(),
    },
  ));
}
