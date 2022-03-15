import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/base_user.dart';
import 'package:flutter_todo/pages/auth.dart';
import 'package:flutter_todo/pages/list_on_fb.dart';
import 'package:flutter_todo/pages/list_on_state.dart';
import 'package:flutter_todo/pages/landing.dart';
import 'package:flutter_todo/pages/test.dart';
import 'package:flutter_todo/pages/navigation_screen.dart';
import 'package:flutter_todo/const/routs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_todo/services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(StreamProvider<BaseUser?>.value(
    value: AuthService().currentUser,
    initialData: null,
    child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home: const MainScreen(),
      initialRoute: Routs.landing,
      routes: {
        Routs.landing : (context) => const Landing(),
        Routs.auth : (context) => const Auth(),
        Routs.navigationScreen : (context) => const NavigationScreen(),
        Routs.todoFB : (context) => const ListOnFB(),
        Routs.todoOnState: (context) => const ListOnState(),
        Routs.test: (context) => const Test(),
      },
    ),
  ));
}
