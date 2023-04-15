import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/food.dart';
import '../widget/textfield.dart';

class CartPage extends StatelessWidget {
  final Cart? cart;
  final Food? food;
  const CartPage({super.key, this.cart, this.food});

  @override
  Widget build(BuildContext context) {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference = firebaseDatabase.ref('carts');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    Cart cart;
    listItem() {         
        return FutureBuilder(
            future: databaseReference.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                
                cart =
                    Cart.fromMap(snapshot.data!.child(uid).value as Map);
                return Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: snapshot.data!
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
                                    SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.asset(
                                            "asset/image/${c.food.image}", fit: BoxFit.cover,)),
                                    Column(
                                      children: [
                                        Text(c.food.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.green)),
                                        TextWidget().priceBasket(
                                            text: c.sum.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      iconSize: 15,
                                      splashRadius: 15,
                                      color: Colors.green,
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {},
                                    ),
                                    Text(
                                      "${c.quantity}",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    IconButton(
                                      iconSize: 15,
                                      splashRadius: 15,
                                      color: Colors.green,
                                      icon: const Icon(Icons.add),
                                      onPressed: () {},
                                    )
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
                            const Text("Total Quantity: ", style: TextStyle(color: Colors.green, fontSize: 21),),
                            Text(cart.totalQuantity.toString(), style: const TextStyle(fontSize: 21, color: Colors.red),),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("Total Price: ", style: TextStyle(color: Colors.green, fontSize: 21),),
                            TextWidget()
                                .price(text: cart.totalPrice.toString()),
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
          map(),
          listItem(),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Order"),
          )
        ]),
      ),
    );
  }

  map() {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Container(color: Colors.amber),
    );
  }
}
