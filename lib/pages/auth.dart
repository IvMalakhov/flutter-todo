import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/base_user.dart';
import 'package:flutter_todo/services/auth.dart';
import 'package:flutter_todo/services/notify.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_todo/const/routs.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  String _email = '';
  String _password = '';
  final Notify _notify = Notify();

  final AuthService _authService = AuthService();

  void _onLogin() async {
    final bool isEmailValid = EmailValidator.validate(_email);

    if (isEmailValid && _password.isNotEmpty) {
      BaseUser? user = await _authService.signInWithEmail(_email.trim(), _password.trim());
      if(user != null ) {
        Navigator.pushReplacementNamed(context, Routs.navigationScreen);
      }
      else {
        _notify.show(text: "Can't sign in. Please check email and password.", textColor: Colors.red);
      }
    } else {
      _notify.show(text: "Please check email and password.", textColor: Colors.amber);
    }
  }

  void _onSignUp() async {
    final bool isEmailValid = EmailValidator.validate(_email);

    if (isEmailValid && _password.isNotEmpty) {
      BaseUser? user = await _authService.signUpWithEmail(_email.trim(), _password.trim());
      if(user == null ) {
        // error will be shown from auth service and fireBase
      } else {
        _notify.show(text: "User was created. Please logged in.", textColor: Colors.green);
      }
    } else {
      _notify.show(text: "Please check email and password.", textColor: Colors.amber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in or Sign up'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          margin: const EdgeInsets.all(50),
          child: Column(
            children: [
              TextField(
                onChanged: (String value) => _email = value,
                decoration: const InputDecoration(
                  label: Text('Email'),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.email_outlined, size: 20,),
                  ),
                ),
                
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              TextField(
                onChanged: (String value) => _password = value,
                onSubmitted: (String value) => _onLogin(),
                decoration: const InputDecoration(
                  label: Text('Password'),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.vpn_key_outlined, size: 20,),
                  ),
                ),
                obscureText: true,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => _onLogin(),
                    child: const Text('Login', style: TextStyle(fontSize: 20),),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              const Text('or sign up with this password and email'),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _onSignUp(),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 20),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
