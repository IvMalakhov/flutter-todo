import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo/domain/base_user.dart';
import 'package:flutter_todo/services/notify.dart';

class AuthService {
  final Notify _notify = Notify();
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  Future<BaseUser?> signInWithEmail(String email , String password) async{
    try{
      UserCredential userCred = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCred.user;
      return BaseUser.fromFirebase(user!);
    } catch(error) {
      return null;
    }
  }
  Future<BaseUser?> signUpWithEmail(String email , String password) async{
    try{
      UserCredential userCred = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCred.user;
      return BaseUser.fromFirebase(user!);
    } catch(error) {
      _notify.show(text: error.toString(), textColor: Colors.red);
      return null;
    }
  }
  Future signOut() async{
      await _fAuth.signOut();
  }
  Stream<BaseUser?> get currentUser{
    Stream<User?> st = _fAuth.authStateChanges();
    return st.map((User? user)=> user != null ? BaseUser.fromFirebase(user): null);
  }
}