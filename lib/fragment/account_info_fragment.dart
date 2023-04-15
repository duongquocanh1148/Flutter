import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  late FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference reference =
      firebaseDatabase.ref("users").child(firebaseAuth.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(10),
      child: StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref("users")
            .child(firebaseAuth.currentUser!.uid)
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            
            var user = snapshot.data!.snapshot;
            return Column(         
              children: [
                Text(
                  "UserName: ${user.child("userName").value}",
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Email: ${user.child("email").value}",
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Mobile: ${user.child("mobile").value}",
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Address: ${user.child("address").value}",
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                 const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Container(
                    // ignore: sort_child_properties_last
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () async {
                        firebaseAuth.signOut;
                        nextScreenRemove(context, const SignIn());
                      },
                      child: const Text(
                        "Log out",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
              ],
            );
          } else {
            return const Text("data");
          }
        },
      ),
    );
  }
}

Future<String> getUserDataSP(String key) async {
  // ignore: no_leading_underscores_for_local_identifiers
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs = await _prefs;
  String a = prefs.get('key').toString();
  return a;
}
