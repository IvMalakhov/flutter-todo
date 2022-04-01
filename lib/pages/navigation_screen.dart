import 'package:flutter/material.dart';
import 'package:flutter_todo/const/routs.dart';
import 'package:flutter_todo/services/auth.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
        actions: [
          TextButton.icon(
              onPressed: () {
                _authService.signOut();
                Navigator.pushReplacementNamed(context, Routs.landing);
              },
              icon: const Icon(Icons.logout , color: Colors.white,),
              label: const Text('logout')
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          const Text(
            'This simple todo app for test flutter and dart. Auth implement on Firebase Authentication',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          const Text('This todo screen works on state and loose data if we reload page or rerun application:'),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          OutlinedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context,  Routs.todoOnState);
              },
              child: const Text('Go to todo on state')
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          const Divider(
            height: 5,
            color: Colors.black,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          const Text('This todo screen save data to Firebase-Firestore'),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          OutlinedButton(
              onPressed: (){
                // Navigator.pushNamed(context, '/todo'); // have back button
                // Navigator.pushNamedAndRemoveUntil(context, '/todo', (route)=>false); // if false haven't back button
                Navigator.pushReplacementNamed(context, Routs.todoFB);
              },
              child: const Text('go to todo with FB')
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          const Divider(
            height: 5,
            color: Colors.black,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          const Text('This sandbox screen for experiments'),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          OutlinedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context,  Routs.test);
              },
              child: const Text('go to sandbox')
          ),
        ],
      ),
    );
  }
}
