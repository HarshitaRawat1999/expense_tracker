import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility{
  static toast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff0066b3),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}