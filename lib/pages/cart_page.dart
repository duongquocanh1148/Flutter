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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: Column(children: [
            map(),
            //listItem(context),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Order"),
            )
          ]),
        ),
      ),
    );
  }

  map() {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Container(color: Colors.amber),
    );
  }

  listItem(BuildContext context) {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference = firebaseDatabase.ref('carts');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    if (cart == null && food == null) {
      return const Text("Hiện không có món hàng nào!");
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: databaseReference.get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("a");
                  Cart cart =
                      Cart.fromMap(snapshot.data!.child(uid).value as Map);
                  return ListView.builder(
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
                                        "asset/image/${c.food.image}")),
                                Column(
                                  children: [
                                    Text(c.food.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.green)),
                                    TextWidget().priceBasket(
                                        text: c.food.price.toString()),
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
                                const Text(
                                  "1",
                                  style: TextStyle(fontSize: 15),
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
                            Container(
            
              child: Row(
              children: [
                const Text("Tổng tiền: "),
                TextWidget().price(text: food!.price.toString()),
              ],
            ),
          ),
                          ],
                        );
                      });
                }
                return const Text("Hiện không có món hàng nào!");
              }),
        ),
      );
    }
  }
}
