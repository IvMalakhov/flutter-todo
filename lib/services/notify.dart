import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Notify {
  void show({String text = '', Color bgColor =  Colors.white, Color textColor = Colors.black }){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: bgColor,
        textColor: textColor,
        timeInSecForIosWeb: 5,
        webPosition: "center",
        webBgColor: '#${bgColor.value.toRadixString(16)}',
        fontSize: 16.0
    );
  }
}