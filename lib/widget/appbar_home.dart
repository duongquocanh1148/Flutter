import 'package:flutter/material.dart';
import 'package:food_now/fragment/notification_fragment.dart';

import 'package:food_now/widget/widget.dart';


class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(           
            child: TextField(         
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: UnderlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(8.0))),
                hintText: "Search product",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search,color: Colors.grey)
                ),
              ),          
          ),
          GestureDetector(
            onTap: (){
              nextScreen(context, const NotificationFragment());
            },
            child: Container(
              height:30, 
              width: 15,             
              margin: const EdgeInsets.only(left: 15),
              child: const Icon(Icons.notifications,color: Colors.white),),
          )
        ],
      ),
    );
  }
}

class AcountBar extends StatelessWidget {
  const AcountBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Colors.green),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [          
            const Expanded(child: Text("Account Info", 
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
            ),
            GestureDetector(
              onTap: (){
              },
              child: const Text("Save", 
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
            )
          ]),
          ),
    );
  }
}
