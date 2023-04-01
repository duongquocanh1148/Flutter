import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../pages/sign_in_page.dart';
import '../widget/widget.dart';

class AccountInfoFragment extends StatefulWidget {
  const AccountInfoFragment({super.key});

  @override
  State<AccountInfoFragment> createState() => _AccountInfoFragmentState();
}

class _AccountInfoFragmentState extends State<AccountInfoFragment> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(child: Column(children: [
        Text(getUserDataSP('email').toString()),
        SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Container(               
                  // ignore: sort_child_properties_last
                  child: 
                  ElevatedButton( 
                    style: ElevatedButton.styleFrom(                   
                    ),                                                                             
                    onPressed: () async{
                      firebaseAuth.signOut;
                      nextScreenRemove(context, const SignIn());
                    },
                    child:  
                      const Text(
                      "Log out",
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
Future<String> getUserDataSP(String key) async{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs = await _prefs;
  String a = prefs.get('key').toString();
  return a;
}

