

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_now/models/restaurant.dart';
import 'package:food_now/pages/detail_product_page.dart';
import 'package:food_now/widget/textfield.dart';

import '../models/food.dart';
import '../widget/appbar_home.dart';
import '../widget/widget.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant; 
  const DetailRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarHome(),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            
            cover(context),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              //color: Colors.green,
              child: const Text(
                "Menu",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            menu(context),
          ]),
        ),
      ),
    );
  }

  cover(context) {
    return Container(
      color: Colors.green,
      child: Row(
        children: [
          Image.asset("asset/image/${restaurant.logo}"
            ,
            fit: BoxFit.fill,
          ),
          Expanded(
              child:                 
                      Column(
                        children: [
                          TextWidget.white(text: restaurant.name),
                          TextWidget.white(text: "Open Hours: ${restaurant.openHours}"),
                          TextWidget.white(text: "Address: ${restaurant.address}"),
                          TextWidget.white(text: "Rate: ${restaurant.rate}"),
                        ],
                      )
          )                
        ],
      ),
    );
  }

  menu(context) {
   late FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference =
      firebaseDatabase.ref("restaurants").child(restaurant.resKey).child("menu");
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 237,
          child: Row(
            children: [
              Expanded(
                  child: FutureBuilder(
                future: databaseReference.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.children.length,
                        itemBuilder: (context, index) {
                          var value = snapshot.data!.children.elementAt(index);
                          Food food = Food(
                            name: value.child("name").value.toString(),
                            image: value.child("image").value.toString(),
                            description: value.child("description").value.toString(),
                            price: value.child("price").value as int,
                            rate: value.child("rate").value as int,
                            resKey: value.child("resKey").value.toString(),
                            foodKey: value.child("foodKey").value.toString());
                          return Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                width: 150,
                                child: GestureDetector(
                                  child: Image.asset(
                                      "asset/image/${value.child("image").value.toString()}",
                                      fit: BoxFit.fill),
                                  onTap: () {
                                    nextScreen(
                                        context, DetailProduct(food: food));
                                  },
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                      "${value.child("name").value}"),
                                  Text(
                                      "${value.child("price").value}"),
                                  Text(
                                      "rate: ${value.child("rate").value}*"),
                                ],
                              )
                            ],
                          );
                        });
                  } else {
                    return const Text("data");
                  }
                },
              ))
            ],
          ),
        ));
  }
}
