// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_now/widget/textfield.dart';
import 'package:food_now/widget/widget.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';

// ignore: must_be_immutable
class AddToCart extends StatefulWidget {
  CartItem cartItem;
  Function? onClickAction; 
  AddToCart({super.key, required this.cartItem, this.onClickAction});

  @override
  State<AddToCart> createState() => _AddToCartState();
}
class _AddToCartState extends State<AddToCart> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference =
      firebaseDatabase.ref('carts'); 
  
  setUpCart() async {
    DataSnapshot snapshot = await databaseReference.get();
    bool flag = false;    
    if (snapshot.exists) {
      if (!snapshot.child(uid).hasChild('cartItems')) {
        List<CartItem>? cartItems = List.empty(growable: true);         
        widget.cartItem.sum = widget.cartItem.quantity * widget.cartItem.food.price;         
        cartItems.add(widget.cartItem);      
        Cart cart = Cart(
          totalQuantity: widget.cartItem.quantity,
          totalPrice: widget.cartItem.food.price * widget.cartItem.quantity,
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
            setState(() {
              
            });

            
            cupertino(context, "Notification", "Added Complete!");
            // Navigator.of(context).pop();              
            // showSnackBar(context, Colors.green, "Add complete!");
          });
        } on FirebaseException catch (e) {
         
          showSnackBar(context, Colors.red, e.message.toString());
        }
      } else {
        Cart cart = Cart.fromMap(snapshot.child(uid).value as Map);
        int totalQuantity=0;
        int totalPrice=0;
        for (int j = 0;
            j < snapshot.child(uid).child('cartItems').children.length;
            j++) {
          var d = snapshot.child(uid).child('cartItems').child(j.toString());          
          int quantity = int.parse(d.child('quantity').value.toString());
          int sum = int.parse(d.child('sum').value.toString());             
          totalPrice += sum;
          totalQuantity += quantity;           
        }
        cart.totalPrice = totalPrice;
        cart.totalQuantity = totalQuantity;
        for (int j = 0;
            j < snapshot.child(uid).child('cartItems').children.length;
            j++) {
          var q = snapshot.child(uid).child('cartItems').child(j.toString());
          var c = cart.cartItems![j];         
          
          if (q.child('food').child('foodKey').value.toString() ==
              widget.cartItem.food.foodKey) {           
            flag = true;                     
            q.child('quantity').ref.set(widget.cartItem.quantity);
            q.child('sum').ref.set(widget.cartItem.quantity * c.food.price);
            cart.totalQuantity -= int.parse(q.child('quantity').value.toString());
            cart.totalQuantity += widget.cartItem.quantity;
            cart.totalPrice -= int.parse(q.child('sum').value.toString());
            cart.totalPrice += widget.cartItem.quantity * widget.cartItem.food.price;           
            snapshot.child(uid).child('totalPrice').ref.set(cart.totalPrice);
            snapshot.child(uid).child('totalQuantity').ref.set(cart.totalQuantity);                                                
            cupertino(context, "Notification", "Added Complete!");
            // Navigator.of(context).pop();  
            //  showSnackBar(context, Colors.green, "Add complete!");
          }
        }
        if (!flag) {          
          CartItem cartItem = CartItem(
              quantity: widget.cartItem.quantity,
              sum: widget.cartItem.food.price * widget.cartItem.quantity,
              food: widget.cartItem.food,
              id: generateRandomString());
          cart.cartItems!.add(cartItem);
          // print(cart.totalPrice);
          // print(cart.totalQuantity);
          cart.totalQuantity += widget.cartItem.quantity;
          cart.totalPrice += widget.cartItem.quantity * widget.cartItem.food.price;
          snapshot.child(uid).child('totalPrice').ref.set(cart.totalPrice);
          snapshot.child(uid).child('totalQuantity').ref.set(cart.totalQuantity);
          // print(cart.totalPrice);
          // print(cart.totalQuantity);
          Map<String, dynamic> map = cart.toMap();        
          try {
            await FirebaseDatabase.instance
                .ref('carts')
                .child(uid)
                .set(map)
                .then((value) => {
                  cupertino(context, "Notification", "Added Complete!"),
                  // Navigator.pop(context)
                      //showSnackBar(context, Colors.green, "Add complete!")
                    });
          } on FirebaseAuthException catch (e) {           
             Navigator.of(context).pop();  
            showSnackBar(context, Colors.red, e.message.toString());
          }
        }
      }
    } else {
      return const Text("No data");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300,
        child: Column(children: [
          const Text(
            "Add to Cart",
            style: TextStyle(fontSize: 21, color: Colors.green),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "asset/image/${widget.cartItem.food.image}",
                height: 140,
                width: 140,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.cartItem.food.name,
                      style: const TextStyle(fontSize: 21, color: Colors.green),
                    ),
                    TextWidget()
                        .priceAdd2Cart(text: widget.cartItem.food.price.toString()),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    iconSize: 20,
                    splashRadius: 20,
                    color: Colors.green,
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (widget.cartItem.quantity <= 1) {
                          widget.cartItem.quantity = 1;
                        } else {
                          widget.cartItem.quantity--;
                        }
                      });
                    },
                  ),
                  Text(
                    widget.cartItem.quantity.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    iconSize: 20,
                    splashRadius: 20,
                    color: Colors.green,
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        widget.cartItem.quantity++;
                      });
                    },
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Total Price: ",
                style: TextStyle(color: Colors.green, fontSize: 21),
              ),
              TextWidget().price(text: (widget.cartItem.food.price * widget.cartItem.quantity).toString())
            ],
          ),
          ElevatedButton(onPressed: () {            
            setUpCart();            
          }, child: const Text("Add to Cart")),
        ]),
      ),
    );
  }
}
