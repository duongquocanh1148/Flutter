import 'package:flutter/material.dart';
import 'package:food_now/form/sign_up_form.dart';



class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(    
        elevation: 0,
        centerTitle: true,   
        title: const Text("Sign Up", style: TextStyle(color: Colors.white)),
        //backgroundColor: Colors.white,       
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
          //nextScreenReplace(context, const SignIn());            
        },
        icon: const Icon(Icons.arrow_back_ios), color: Colors.white,),
      ),  
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SignUpForm(),  
            
      )            
    );
  }
}