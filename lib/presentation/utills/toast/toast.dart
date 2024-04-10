
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String text){
  Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade100,
        textColor: Colors.black,
        fontSize: 16.0
    );
}