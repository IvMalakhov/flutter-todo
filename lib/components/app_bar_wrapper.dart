import 'package:flutter/material.dart';
import 'package:flutter_todo/const/routs.dart';
import 'package:flutter_todo/services/auth.dart';

class AppBarWrapper extends StatelessWidget {
  String title;

  AppBarWrapper({Key? key, this.title = 'Menu'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          TextButton.icon(
              onPressed: () {
                _authService.signOut();
                Navigator.pushReplacementNamed(context, Routs.landing);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text('logout'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routs.landing, (route) => false);
                        },
                        child: const Text('Home')),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routs.todoOnState, (route) => false);
                        },
                        child: const Text('ToDo on state')),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routs.todoOnState, (route) => false);
                        },
                        child: const Text('ToDo on FireBase')),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
