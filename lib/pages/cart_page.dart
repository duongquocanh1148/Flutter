import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_now/pages/add_to_cart_page.dart';
import 'package:food_now/pages/order_page.dart';
import 'package:food_now/widget/widget.dart';

import '../models/cart.dart';
import '../widget/textfield.dart';

class CartPage extends StatefulWidget {
  final Cart? cart;
  const CartPage({super.key, this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  

  @override
  Widget build(BuildContext context) {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference = firebaseDatabase.ref('carts');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    Cart cart;    
    listItem() {
      return StreamBuilder(
          stream: databaseReference.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var d = snapshot.data!.snapshot.child(uid);
              cart = Cart.fromMap(d.value as Map);
              return Column(
                children: [
                  SizedBox(
                    height: 530,
                    child: ListView.builder(
                        itemCount: d
                            .child('cartItems')
                            .children
                            .length,
                        itemBuilder: (context, index) {
                          var c = cart.cartItems!.elementAt(index);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      color: Colors.white,
                                      width: 100,
                                      height: 100,
                                      child: Image.asset(
                                          "asset/image/${c.food.image}",
                                          fit: BoxFit.contain)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(c.food.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.green)),
                                        TextWidget().priceBasket(
                                            text: c.food.price.toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    iconSize: 15,
                                    splashRadius: 15,
                                    color: Colors.green,
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {                                      
                                      showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight:
                                                      Radius.circular(16))),
                                          builder: (BuildContext context) =>
                                              AddToCart(
                                                cartItem: cart.cartItems![index],                                               
                                              ));
                                    },
                                  ),
                                  Text(
                                    "Qty: ${c.quantity}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  
                                  IconButton(
                                    iconSize: 15,
                                    splashRadius: 15,
                                    color: Colors.green,
                                    onPressed: (){
                                    d.child('cartItems').child(index.toString()).ref.remove();
                                    d.child('cartItems').child((index+1).toString()).ref.set(index);
                                  }, icon: const Icon(Icons.delete))
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Total Quantity: ",
                            style: TextStyle(color: Colors.green, fontSize: 21),
                          ),
                          Text(
                            cart.totalQuantity.toString(),
                            style: const TextStyle(
                                fontSize: 21, color: Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Total Price: ",
                            style: TextStyle(color: Colors.green, fontSize: 21),
                          ),
                          TextWidget().price(text: cart.totalPrice.toString()),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
            return const Text("Hiện không có món hàng nào!");
          });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          listItem(),
          ElevatedButton(
            onPressed: () {
              nextScreen(context, OrderPage());
            },
            child: const Text("Order"),
          )
        ]),
      ),
    );
  }
}
