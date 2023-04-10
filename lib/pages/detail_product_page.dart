import 'package:flutter/material.dart';
import 'package:food_now/models/food_basket.dart';
import 'package:food_now/pages/cart_page.dart';
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
              onPressed: () {
                var food = widget.food;
                FoodBasket foodBasket = FoodBasket(
                    quantity: 1,
                    sum: 1,
                    food: food,
                    name: food.name,
                    image: food.image,
                    price: food.price,
                    rate: food.rate,
                    resKey: food.resKey,
                    foodKey: food.foodKey);               
                nextScreen(context, CartPage(foodBasket: foodBasket,));
              },
              child: const Text("Add to cart"),
            ),
          )
        ]));
  }
}
