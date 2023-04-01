import 'package:flutter/material.dart';
import 'package:food_now/fragment/account_info_fragment.dart';
import 'package:food_now/fragment/favorite_fragment.dart';
import 'package:food_now/fragment/home_fragment.dart';
import 'package:food_now/fragment/notification_fragment.dart';
import 'package:food_now/widget/appbar_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectIndex = 0;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    List<Widget> screen = const [
      HomeFragment(),
      FavoriteFragment(),
      NotificationFragment(),
      AccountInfoFragment()
    ];
    return Scaffold(     
      appBar: AppBar(   
        automaticallyImplyLeading: false,             
        title: flag ?
        const AppBarHome() : const AcountBar(),         
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
            if(selectIndex!=3){
              flag = true;
            }else {flag = false;}
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            ),
        ]),
        body: SafeArea(
          child: Column(children: [
            const SizedBox(height: 10),
            screen[selectIndex],
          ],)
        ),
    );
  }
}