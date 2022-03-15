import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/base_user.dart';
import 'package:flutter_todo/pages/auth.dart';
import 'package:flutter_todo/pages/navigation_screen.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BaseUser? user = Provider.of<BaseUser?>(context);
    return user != null ? const NavigationScreen() : const Auth();
  }
}

