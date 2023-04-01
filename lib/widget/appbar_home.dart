import 'package:flutter/material.dart';

import 'package:food_now/widget/widget.dart';

import '../pages/cart_page.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: TextField(         
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)), borderSide: BorderSide.none),   
              hintText: "Search product",
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search,color: Colors.grey)
              ),
            ),          
        ),
        GestureDetector(
          onTap: (){
            nextScreen(context, const CartPage());
          },
          child: Container(
            height:40, 
            width: 40,
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.shopping_cart,color: Colors.white),),
        )
      ],
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
