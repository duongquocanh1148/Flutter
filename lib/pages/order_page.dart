import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_now/pages/home_page.dart';

import '../models/cart.dart';
import '../widget/textfield.dart';
import '../widget/widget.dart';

class OrderPage extends StatefulWidget {
  final Cart? cart;
  const OrderPage({super.key, this.cart});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference = firebaseDatabase.ref('carts');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    Cart cart;
    info() {
      return SizedBox(
        height: 140,
        child: FutureBuilder(
          future: FirebaseDatabase.instance.ref('users').get(),
          builder: (context, snapshot) {
          if(snapshot.hasData){
            var d = snapshot.data!.child(uid);
          return Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const Text("User Infomation", style: TextStyle(fontSize: 21),),
                TextWidget.info(text: "Name: ${d.child('userName').value}"),
                TextWidget.info(text: "Email: ${d.child('email').value}"),
                TextWidget.info(text: "Mobile: ${d.child('mobile').value}"),
                TextWidget.info(text: "Address: ${d.child('address').value}")
              ],),
            ),
          );
          }
          else{
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator());
          }
          
        },),
      );
    }
    listItem() {
      return StreamBuilder(
          stream: databaseReference.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cart =
                  Cart.fromMap(snapshot.data!.snapshot.child(uid).value as Map);
              return Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                        itemCount: snapshot.data!.snapshot
                            .child(uid)
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
                                  Text(
                                    "Số lượng: ${c.quantity}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
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
            return const Text("No items found!");
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          info(),
          listItem(),
          ElevatedButton(
            onPressed: () {
              //Add data Order

              //Delete Cart
              
              nextScreen(context, const HomePage());
            },
            child: const Text("Check Out"),
          )
        ]),
      ),
    );
  }
}
