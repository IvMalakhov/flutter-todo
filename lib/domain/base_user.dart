import 'package:firebase_auth/firebase_auth.dart';

class BaseUser {
  late String id;
  BaseUser.fromFirebase(User user){
    id = user.uid;
  }
}