import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_now/models/restaurant.dart';
import 'package:food_now/pages/detail_product_page.dart';
import 'package:food_now/widget/widget.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

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
                            return Container(
                              padding: const EdgeInsets.all(5),
                              width: 140,
                              
                              child: GestureDetector(
                                child: Image.asset(
                                    "asset/image/${snapshot.data!.children.elementAt(index).child("logo").value.toString()}", fit: BoxFit.fill),
                                onTap: () {
                                  // nextScreen(
                                  //     context, const DetailProduct());
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
                                      "asset/image/${snapshot.data!.children.elementAt(index).child("image").value.toString()}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  onTap: () {
                                    nextScreen(
                                        context, const DetailProduct());
                                  },
                                ),
                              ),
                              Text(snapshot.data!.children.elementAt(index).child("name").value.toString(),
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 18)),
                              Text("${snapshot.data!.children.elementAt(index).child("price").value} VND",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 16))
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
