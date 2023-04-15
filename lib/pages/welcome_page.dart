import 'package:flutter/material.dart';
import 'package:food_now/pages/home_page.dart';
import 'package:food_now/pages/sign_in_page.dart';
import 'package:food_now/widget/widget.dart';

import '../service/shared_preference.dart';

class WelcomePage
 extends StatelessWidget {
  static String route = '/welcome';
  const WelcomePage
  ({super.key});
  
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2),(){
      SharedPrefs().getLoginStatus().then((data) {
        print(data);
        if(data) {

          nextScreenRemove(context, const HomePage());
        } else {
          Navigator.pushNamedAndRemoveUntil(context, SignIn.route, (route) => false);
        }
      });


      
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