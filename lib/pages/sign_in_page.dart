import 'package:flutter/material.dart';
import 'package:food_now/form/sign_in_form.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_now/pages/sign_up_page.dart';
import 'package:food_now/widget/widget.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  static String route = '/signIn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          alignment: Alignment.topRight,
          child: Image.asset("asset/image/dish.png"),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: const [
              Text(
                "Food Now",
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sign in with your emmail and password \n or continue with social media",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SignInForm(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("asset/svg/facebook.svg"),
            const SizedBox(
                width: 10),
            SvgPicture.asset("asset/svg/google.svg"),
             const SizedBox(
                width: 10),
            SvgPicture.asset("asset/svg/twitter.svg"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have account?",
              style: TextStyle(color: Colors.green),
            ),
            TextButton(
                onPressed: () {
                  nextScreen(context, const SignUp());
                },
                child: const Text("Sign Up!", style: TextStyle(color: Colors.red),)),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomLeft,
          child: Image.asset("asset/image/dish_2.png"),
        )
      ]),
    )));
  }

  
}
