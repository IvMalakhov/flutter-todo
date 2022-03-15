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
        title: const Text('Welcome!!!'),
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
          const Text('main screen'),
          ElevatedButton(
              onPressed: (){
                // Navigator.pushNamed(context, '/todo'); // have back button
                // Navigator.pushNamedAndRemoveUntil(context, '/todo', (route)=>false); // if false haven't back button
                Navigator.pushReplacementNamed(context, Routs.todoFB);
              },
              child: const Text('go to todo with FB')
          ),
          ElevatedButton(
              onPressed: (){
                // Navigator.pushNamed(context, '/todo'); // have back button
                // Navigator.pushNamedAndRemoveUntil(context, '/todo', (route)=>false); // if false haven't back button
                Navigator.pushReplacementNamed(context,  Routs.todoOnState);
              },
              child: const Text('go to todo on state')
          ),
          ElevatedButton(
              onPressed: (){
                // Navigator.pushNamed(context, '/todo'); // have back button
                // Navigator.pushNamedAndRemoveUntil(context, '/todo', (route)=>false); // if false haven't back button
                Navigator.pushReplacementNamed(context,  Routs.test);
              },
              child: const Text('go to test')
          ),
        ],
      ),
    );
  }
}
