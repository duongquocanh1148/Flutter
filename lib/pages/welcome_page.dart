import 'package:flutter/material.dart';
import 'package:food_now/pages/sign_in_page.dart';

class WelcomePage
 extends StatelessWidget {
  static String route = '/welcome';
  const WelcomePage
  ({super.key});
  
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushNamedAndRemoveUntil(context, SignIn.route, (route) => false);
    });
    return Container(
      color: Colors.green,
      child: const Center(
            child:
              CircularProgressIndicator(color: Colors.white,),           
        ),             
    );
  }
}