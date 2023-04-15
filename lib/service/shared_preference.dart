// ignore_for_file: avoid_print
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';


class SharedPrefs {
  
  void saveUser(Users users) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userName', users.userName);
    pref.setString('password', users.password);
    pref.setString('email', users.email);
    pref.setString('userID', users.userID);
    pref.setString('address', users.address!);
    pref.setString('mobile', users.mobile!);
  }

  setLoginStatus(bool isCheck) async{
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isCheck', isCheck);    
  }

  getLoginStatus() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('isCheck') ?? false;  
  }


  

  readUser() async{
    final pref = await SharedPreferences.getInstance();
    String? username = pref.getString('username');
    String? password = pref.getString('password');
    String? email = pref.getString('email');
    String? userID = pref.getString('userID');
    String? address= pref.getString('address');
    String? mobile = pref.getString('mobile');
    print(username);
    return Users(userName: username!, password: password!, email: email!, userID: userID!, address: address, mobile: mobile);
  }
}