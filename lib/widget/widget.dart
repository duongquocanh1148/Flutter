
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(        
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,       
      )
  );
}
void cupertino(context, title, message){
  showDialog(context: context, builder: (context){
      return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                })
          ],
        );
  });
}
String generateRandomString() {
  var r = Random();
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(10, (index) => chars[r.nextInt(chars.length)]).join();
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
void nextScreenRemove(context, page){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>page), (route) => false);
}
bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (regex.hasMatch(value)) ? true : false;
}

// void showSnackbar(context, color, message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         message,
//         style: const TextStyle(fontSize: 14),
//       ),
//       backgroundColor: color,
//       duration: const Duration(seconds: 2),
//       action: SnackBarAction(
//         label: "OK",z
//         onPressed: () {},
//         textColor: Colors.white,
//       ),
//     ),
//   );
// }
