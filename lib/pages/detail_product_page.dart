// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_now/models/cart_item.dart';
import 'package:food_now/pages/add_to_cart_page.dart';
import 'package:food_now/widget/textfield.dart';
import 'package:food_now/widget/widget.dart';

import '../models/food.dart';

class DetailProduct extends StatefulWidget {
  final Food food;
  const DetailProduct({super.key, required this.food});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  late String uid = FirebaseAuth.instance.currentUser!.uid;
  late FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('carts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.food.name),
                    // Stack(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: (){},
                    //       child: const Icon(Icons.shopping_cart)),
                    //     Container(
                    //       margin: const EdgeInsets.fromLTRB(18, 0, 0, 10),
                    //       alignment: Alignment.center,
                    //       width: 12,
                    //       height: 12,
                    //       decoration: const BoxDecoration(
                    //           color: Colors.white, shape: BoxShape.circle),
                    //       child: const Text(
                    //         "0",
                    //         style: TextStyle(color: Colors.red, fontSize: 12),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    color: Colors.white,
                    child: Image.asset(
                      "asset/image/${widget.food.image}",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.contain,
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextWidget.name(text: widget.food.name),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextWidget().price(
                          text: widget.food.price.toString(),
                        ),
                      ),
                      TextWidget.description(
                          text: widget.food.description ?? ""),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 200),
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                CartItem cartItem = await loadData();               
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    builder: (BuildContext context) => AddToCart(
                          cartItem: cartItem,
                        ));
              },
              child: const Text("Add to cart"),
            ),
          )
        ]));
  }
  Future<CartItem> loadData() async {
    DataSnapshot snapshot = await databaseReference.get();
    CartItem cartItem =
        CartItem(quantity: 1, sum: widget.food.price, food: widget.food, id: generateRandomString());
    bool flag = false;
    if (snapshot.exists) {  
      if (!snapshot.child(uid).hasChild('cartItems')) {       
        cartItem = CartItem(
            quantity: 1,
            sum: widget.food.price,
            food: widget.food,
            id: generateRandomString());
      } else {        
        var c = snapshot.child(uid).child('cartItems');
        for (int i = 0; i < c.children.length; i++) {
          var q = c.child(i.toString());
          if (q.child('food').child('foodKey').value ==
              widget.food.foodKey) {               
            cartItem = CartItem.fromMap(q.value as Map);           
            flag = true;
          }
        }
        if (!flag) {         
          cartItem = CartItem(
              quantity: 1,
              sum: widget.food.price,
              food: widget.food,
              id: generateRandomString());
        }
      }
    }  
    return cartItem;
  }
}


