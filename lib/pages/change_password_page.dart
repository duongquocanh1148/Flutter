import 'package:flutter/material.dart';

import 'package:food_now/pages/sign_in_page.dart';

import '../fragment/account_info_fragment.dart';
import '../widget/widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(child: Column(children: [
        Text(getUserDataSP('email').toString()),
        const TextField(
                  obscureText: true,                  
                  decoration: InputDecoration(
                    hintText: "Old Password",                                   
                    suffixIcon: Icon(Icons.remove_red_eye_sharp),
                    border: OutlineInputBorder(),
                    ),              
                ),
                const SizedBox(height: 20),
        const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",                
                    suffixIcon: Icon(Icons.remove_red_eye_sharp),
                    border: OutlineInputBorder(),
                    ),              
                ),
                const SizedBox(height: 20),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",                
                    suffixIcon: Icon(Icons.remove_red_eye_sharp),
                    border: OutlineInputBorder(),
                    ),       
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Container(               
                  // ignore: sort_child_properties_last
                  child: 
                  ElevatedButton( 
                    style: ElevatedButton.styleFrom(                   
                    ),                                                                             
                    onPressed: (){
                      nextScreenReplace(context, const SignIn());
                    },
                    child:  
                      const Text(
                      "Change",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),                   
                    ),               
                  ),
                  color: Colors.green,                              
                  ),
                ),
      ],)),
    ); 
  }
}