// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_now/models/cart_item.dart';
import 'package:food_now/pages/cart_page.dart';
import 'package:food_now/widget/textfield.dart';
import 'package:food_now/widget/widget.dart';

import '../models/cart.dart';
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
                setUpCart();
              },
              child: const Text("Add to cart"),
            ),
          )
        ]));
  }

  setUpCart() async {
    DataSnapshot snapshot = await databaseReference.get();
    bool flag = false;
    if (snapshot.exists) {
      if (!snapshot.child(uid).hasChild('cartItems')) {
        List<CartItem>? cartItems = List.empty(growable: true);
        CartItem cartItem = CartItem(
            quantity: 1,
            sum: widget.food.price,
            food: widget.food,
            id: generateRandomString());
        cartItems.add(cartItem);
        Cart cart = Cart(
          totalQuantity: cartItem.quantity,
          totalPrice: cartItem.sum,
          cartItems: cartItems,
          userID: uid,
        );
        Map<String, dynamic> map = cart.toMap();
        try {
          await FirebaseDatabase.instance
              .ref('carts')
              .child(uid)
              .set(map)
              .then((value) {
            print("new");
            nextScreen(
                context,
                CartPage(
                  cart: cart,
                  food: widget.food,
                ));
          });
        } on FirebaseException catch (e) {
          showSnackBar(context, Colors.red, e.message.toString());
        }
      } else {
        Cart cart = Cart.fromMap(snapshot.child(uid).value as Map);
        int totalPrice = 0;
        int totalQuantity = 0;
        for (int j = 0;
            j < snapshot.child(uid).child('cartItems').children.length;
            j++) {
          var c = cart.cartItems![j];
          totalPrice += c.sum;
          totalQuantity += c.quantity;
        }
        for (int j = 0;
            j < snapshot.child(uid).child('cartItems').children.length;
            j++) {
          var q = snapshot.child(uid).child('cartItems').child(j.toString());
          var c = cart.cartItems![j];
          print(widget.food.foodKey);
          print(
              "firebase: " + q.child('food').child('foodKey').value.toString());
          if (q.child('food').child('foodKey').value.toString() ==
              widget.food.foodKey) {
            print("trung");
            flag = true;
            totalPrice += c.food.price;
            totalQuantity++;
            q.child('quantity').ref.set(c.quantity + 1);
            q.child('sum').ref.set(c.food.price * (c.quantity + 1));
            snapshot.child(uid).child('totalPrice').ref.set(totalPrice);
            snapshot.child(uid).child('totalQuantity').ref.set(totalQuantity);
            nextScreen(
                context,
                CartPage(
                  cart: cart,
                  food: widget.food,
                ));
          }
        }
        if (!flag) {
          print("khong trung");
          CartItem cartItem = CartItem(
              quantity: 1,
              sum: widget.food.price,
              food: widget.food,
              id: generateRandomString());
          cart.cartItems!.add(cartItem);
          cart.totalQuantity = totalQuantity + 1;
          cart.totalPrice = totalPrice + widget.food.price;
          print(cart.totalPrice);
          print(cart.totalQuantity);
          Map<String, dynamic> map = cart.toMap();        
          try {
            await FirebaseDatabase.instance
                .ref('carts')
                .child(uid)
                .set(map)
                .then((value) => {
                      nextScreen(
                          context,
                          CartPage(
                            cart: cart,
                            food: widget.food,
                          ))
                    });
          } on FirebaseAuthException catch (e) {
            showSnackBar(context, Colors.red, e.message.toString());
          }
        }
      }
    } else {
      return const Text("No data");
    }
  }
}
