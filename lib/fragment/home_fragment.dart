import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_now/models/food.dart';
import 'package:food_now/models/restaurant.dart';
import 'package:food_now/pages/detail_product_page.dart';
import 'package:food_now/pages/detail_restaurant_page.dart';
import 'package:food_now/widget/widget.dart';

import '../widget/textfield.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      children: const [CatetgoryStore(), ProductPopular()],
    ));
  }
}

class CatetgoryStore extends StatefulWidget {
  const CatetgoryStore({super.key});

  @override
  State<CatetgoryStore> createState() => _CatetgoryStoreState();
}

class _CatetgoryStoreState extends State<CatetgoryStore> {
  late FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference =
      firebaseDatabase.ref("restaurants");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              children: const [
                Expanded(
                    child: Text(
                  "Restaurants",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                )),
                Text(
                  "See more",
                  style: TextStyle(fontSize: 16, color: Colors.lightGreen),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Row(
              children: [
                Expanded(
                    child: FutureBuilder(
                  future: databaseReference.get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.children.length,
                          itemBuilder: (context, index) {
                            var value =
                                snapshot.data!.children.elementAt(index);
                            Restaurant restaurant = Restaurant(
                              resKey: value.child("resKey").value.toString(),
                              name: value.child("name").value.toString(),
                              logo: value.child("logo").value.toString(),
                              cover: value.child("cover").value.toString(),
                              address: value.child("address").value.toString(),
                              openHours:
                                  value.child("openHours").value.toString(),
                              rate: value.child("rate").value as int,
                            );
                            return Container(
                              padding: const EdgeInsets.all(5),
                              width: 140,
                              child: GestureDetector(
                                child: Image.asset(
                                    "asset/image/${restaurant.logo}",
                                    fit: BoxFit.fill),
                                onTap: () {
                                  nextScreen(
                                      context,
                                      DetailRestaurant(
                                        restaurant: restaurant,
                                      ));
                                },
                              ),
                            );
                          });
                    } else {
                      return const Text("data");
                    }
                  },
                ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class ProductPopular extends StatefulWidget {
  const ProductPopular({super.key});

  @override
  State<ProductPopular> createState() => _ProductPopularState();
}

class _ProductPopularState extends State<ProductPopular> {
  late FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref("foods");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Row(
            children: const [
              Expanded(
                  child: Text("Popular Products",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
              Text(
                'See more',
                style: TextStyle(fontSize: 16, color: Colors.lightGreen),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: FutureBuilder(
                future: databaseReference.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data!.children.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.65,
                        ),
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
                          return Column(
                            children: [
                              Container(
                                height: 130,
                                padding: const EdgeInsets.all(2),
                                color: Colors.green,
                                child: GestureDetector(
                                  child: SizedBox(
                                    width: 120,
                                    child: Image.asset(
                                      "asset/image/${food.image}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  onTap: () {
                                    nextScreen(
                                        context,
                                        DetailProduct(
                                          food: food,
                                        ));
                                  },
                                ),
                              ),
                              Text(
                                  food.name,
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 18)),
                              TextWidget().priceHome(text:
                                  food.price.toString(),
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
        )
      ]),
    );
  }
}
