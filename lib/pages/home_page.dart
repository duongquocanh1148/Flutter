import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_now/fragment/account_info_fragment.dart';
import 'package:food_now/fragment/favorite_fragment.dart';
import 'package:food_now/fragment/home_fragment.dart';
import 'package:food_now/fragment/order_fragment_page.dart';
import 'package:food_now/pages/cart_page.dart';
import 'package:food_now/widget/appbar_home.dart';
import 'package:food_now/widget/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('carts');
  String uid = FirebaseAuth.instance.currentUser!.uid;
  int selectIndex = 0;
  bool flag = true;
  String ans = "0";


  count() async{
    await databaseReference.get().then((value) {
      setState(() {
        ans = value.child(uid).child('totalQuantity').value.toString();      
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = const [
      HomeFragment(),
      FavoriteFragment(),
      OrderFragment(),     
      AccountInfoFragment()
    ];
    count();
    // ignore: unnecessary_null_comparison
    int c = int.parse(ans.replaceAll("+", ""));
    if(c>9){
      ans = "9+";
    }

    
     
     
    
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: flag ? const AppBarHome() : const AcountBar(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectIndex,
          onTap: (index) {
            setState(() {
              selectIndex = index;
              if (selectIndex != 3) {
                flag = true;
              } else {
                flag = false;
              }
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
              icon: Icon(Icons.shopping_basket),
              label: 'Order',
            ),            
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ]),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 10),
          screen[selectIndex],
        ],
      )),
      floatingActionButton: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            FloatingActionButton(onPressed: (){
                nextScreen(context, const CartPage());
            }, child: const Icon(Icons.shopping_cart),),
            Container(      
              margin: const EdgeInsets.only(left: 38),    
              alignment: Alignment.center,
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              
              child: Text(ans, style: const TextStyle(color: Colors.red),),
            )
          ],
        )),
    );    
  }
}