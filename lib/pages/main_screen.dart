import 'package:flutter/material.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Welcome'),
      ),
      body: Column(
        children: [
          Text('main screen'),
          ElevatedButton(
              onPressed: (){
                // Navigator.pushNamed(context, '/todo'); // have back button
                // Navigator.pushNamedAndRemoveUntil(context, '/todo', (route)=>false); // if false haven't back button
                Navigator.pushReplacementNamed(context, '/todo');
              },
              child: Text('go to todo with FB')
          ),
          ElevatedButton(
              onPressed: (){
                // Navigator.pushNamed(context, '/todo'); // have back button
                // Navigator.pushNamedAndRemoveUntil(context, '/todo', (route)=>false); // if false haven't back button
                Navigator.pushReplacementNamed(context, '/todo_state');
              },
              child: Text('go to todo on state')
          ),
        ],
      ),
    );
  }
}
