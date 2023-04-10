

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_now/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Future<SharedPreferences> fPrefs = SharedPreferences.getInstance();
Future<Map<String, dynamic>?> getUserData(String uid) async{
    Map<String, dynamic>? userData;
    await FirebaseFirestore.instance.collection('users')
        .doc(uid).get().then((value) async{
         userData = value.data();
    });
    return userData;
  }
saveUserDataSP() async {
  Users user = Users.fromMap(getUserData(FirebaseAuth.instance.currentUser!.uid) as Map<String, dynamic>);
  SharedPreferences prefs = await fPrefs;
  prefs.setString('userID', user.userID);
  prefs.setString('email', user.email);
  prefs.setString('userName', user.userName);
  prefs.setString('moblie', user.mobile!);
  prefs.setString('address', user.address!);
}




